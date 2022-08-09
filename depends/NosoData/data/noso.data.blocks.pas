unit Noso.Data.Blocks;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, Contnrs
, fpjson
, jsonparser
, Noso.Data.Block
;

resourcestring
  rsEBlocksWrongJSONObject = 'JSON data is not an array';

type
{ EBlocksWrongJSONObject }
  EBlocksWrongJSONObject = class(Exception);

  TBlocksEnumerator =  class; // Forward
{ TBlocks }
  TBlocks = class(TObject)
  private
    FBlocks: TFPObjectList;
    // Compressed JSON field to mimic TJSON one
    FCompressedJSON: Boolean;

    function GetCount: Integer;
    function GetBlock(Index: Integer): TBlock;
    procedure SetBlock(Index: Integer; AValue: TBlock);

    procedure setFromJSON(const AJSON: TJSONStringType);
    procedure setFromJSONData(const AJSONData: TJSONData);
    procedure setFromJSONArray(const AJSONArray: TJSONArray);
    procedure setFromStream(const AStream: TStream);

    function getAsJSON: TJSONStringType;
    function getAsJSONData: TJSONData;
    function getAsJSONArray: TJSONArray;
    function getAsStream: TStream;

  protected
  public
    constructor Create; overload;
    constructor Create(const AJSON: TJSONStringType); overload;
    constructor Create(const AJSONData: TJSONData); overload;
    constructor Create(const AJSONArray: TJSONArray); overload;
    constructor Create(const AStream: TStream); overload;

    destructor Destroy; override;

    procedure Clear;

    function Add(const ABlock: TBlock): Integer;

    procedure Delete(const AIndex: Integer); overload;
    procedure Delete(const ABlock: TBlock); overload;

    procedure SaveToFile(const AFileName: String);

    function FormatJSON(
      AOptions : TFormatOptions = DefaultFormat;
      AIndentsize : Integer = DefaultIndentSize
    ): TJSONStringType;

    function GetEnumerator: TBlocksEnumerator;

    property Count: Integer
      read GetCount;
    property Items[Index: Integer]: TBlock
      read GetBlock
      write SetBlock; default;

    property AsJSON: TJSONStringType
      read getAsJSON;
    property AsJSONData: TJSONData
      read getAsJSONData;
    property AsJSONArray: TJSONArray
      read getAsJSONArray;
    property AsStream: TStream
      read getAsStream;

    property CompressedJSON: Boolean
      read FCompressedJSON
      write FCompressedJSON;

  published
  end;

{ TBlocksEnumerator }
  TBlocksEnumerator = class(TObject)
  private
    FBlocks: TBlocks;
    FPosition: Integer;
  protected
  public
    constructor Create(const ABlocks: TBlocks);
    function GetCurrent: TBlock;
    function MoveNext: Boolean;

    property Current: TBlock
      read GetCurrent;
  published
  end;

implementation

{ TBlocks }

function TBlocks.GetCount: Integer;
begin
  Result:= FBlocks.Count;
end;

function TBlocks.GetBlock(Index: Integer): TBlock;
begin
  Result:= FBlocks.Items[Index] as TBlock;
end;

procedure TBlocks.SetBlock(Index: Integer; AValue: TBlock);
begin
  if FBlocks.Items[Index] = AValue then exit;
  FBlocks.Items[Index]:= AValue;
end;

procedure TBlocks.setFromJSON(const AJSON: TJSONStringType);
var
  jData: TJSONData = nil;
begin
  jData:= GetJSON(AJSON);
  try
    setFromJSONData(jData);
  finally
    jData.Free;
  end;
end;

procedure TBlocks.setFromJSONData(const AJSONData: TJSONData);
begin
  if AJSONData.JSONType <> jtArray then
  begin
    raise EBlocksWrongJSONObject.Create(rsEBlocksWrongJSONObject);
  end;
  setFromJSONArray(AJSONData as TJSONArray);
end;

procedure TBlocks.setFromJSONArray(const AJSONArray: TJSONArray);
var
  index: Integer;
  operation: TBlock = nil;
begin
  for index:= 0 to Pred(AJSONArray.Count) do
  begin
    operation:= TBlock.Create(AJSONArray[index]);
    FBlocks.Add(operation);
  end;
end;

procedure TBlocks.setFromStream(const AStream: TStream);
var
  jData: TJSONData = nil;
begin
  jData:= GetJSON(AStream);
  try
    setFromJSONData(jData);
  finally
    jData.Free;
  end;
end;

function TBlocks.getAsJSON: TJSONStringType;
var
  jArray: TJSONArray = nil;
begin
  Result:= EmptyStr;
  jArray:= getAsJSONArray;
  jArray.CompressedJSON:= FCompressedJSON;
  Result:= jArray.AsJSON;
  jArray.Free;
end;

function TBlocks.getAsJSONData: TJSONData;
begin
  Result:= getAsJSONArray as TJSONData;
end;

function TBlocks.getAsJSONArray: TJSONArray;
var
  index: Integer;
  jData: TJSONData = nil;
begin
  Result:= TJSONArray.Create;
  for index := 0 to Pred(FBlocks.Count) do
  begin
    jData:= TBlock(FBlocks.Items[index]).AsJSONData;
    Result.Add(jData);
  end;
end;

function TBlocks.getAsStream: TStream;
begin
  Result:= TStringStream.Create(getAsJSON, TEncoding.UTF8);
end;

procedure TBlocks.Clear;
begin
  FBlocks.Clear;
end;

function TBlocks.Add(const ABlock: TBlock): Integer;
begin
  Result:= FBlocks.Add(ABlock);
end;

procedure TBlocks.Delete(const AIndex: Integer);
begin
  FBlocks.Delete(AIndex);
end;

procedure TBlocks.Delete(const ABlock: TBlock);
var
  index: Integer;
begin
  index:= FBlocks.IndexOf(ABlock);
  FBlocks.Delete(index);
end;

procedure TBlocks.SaveToFile(const AFileName: String);
var
  fileStream: TFileStream;
  jsonStream: TStream;
begin
  fileStream:= TFileStream.Create(AFileName, fmCreate);
  try
    jsonStream:= getAsStream;
    try
      fileStream.CopyFrom(jsonStream, jsonStream.Size);
    finally
      jsonStream.Free;
    end;
  finally
    fileStream.Free;
  end;
end;

function TBlocks.FormatJSON(
  AOptions: TFormatOptions;
  AIndentsize: Integer
): TJSONStringType;
var
  arrayJSON: TJSONArray;
begin
  arrayJSON:= getAsJSONArray;
  Result:= arrayJSON.FormatJSON(AOptions, AIndentsize);
  arrayJSON.Free;
end;

function TBlocks.GetEnumerator: TBlocksEnumerator;
begin
  Result:= TBlocksEnumerator.Create(Self);
end;

constructor TBlocks.Create;
begin
  FCompressedJSON:= True;
  FBlocks:= TFPObjectList.Create(True);
end;

constructor TBlocks.Create(const AJSON: TJSONStringType);
begin
  Create;
  setFromJSON(AJSON);
end;

constructor TBlocks.Create(const AJSONData: TJSONData);
begin
  Create;
  setFromJSONData(AJSONData);
end;

constructor TBlocks.Create(const AJSONArray: TJSONArray);
begin
  Create;
  setFromJSONArray(AJSONArray);
end;

constructor TBlocks.Create(const AStream: TStream);
begin
  Create;
  setFromStream(AStream);
end;

destructor TBlocks.Destroy;
begin
  FBlocks.Free;
  inherited Destroy;
end;

{ TBlocksEnumerator }

constructor TBlocksEnumerator.Create(const ABlocks: TBlocks);
begin
  FBlocks := ABlocks;
  FPosition := -1;
end;

function TBlocksEnumerator.GetCurrent: TBlock;
begin
  Result:= FBlocks.Items[FPosition] as TBlock;
end;

function TBlocksEnumerator.MoveNext: Boolean;
begin
  Inc(FPosition);
  Result := FPosition < FBlocks.Count;
end;

end.

