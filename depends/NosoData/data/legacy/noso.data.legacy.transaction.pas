unit Noso.Data.Legacy.Transaction;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
, SysUtils
, Noso.Data.Legacy.Types
;

type

  { TLegacyTransaction }

  TLegacyTransaction = class(TObject)
  private
    FBlock      : Integer; // Will go boom at MAXINT = 2'147'483'647
    FOrderID    : TString64;
    FOrderLines : Integer;
    FOrderType  : TString6;
    FTimeStamp  : Int64;
    FReference  : TString64;
    FTrxLine    : Integer;
    FSender     : TString120;
    FAddress    : TString40;
    FReceiver   : TString40;
    FAmountFee  : Int64;
    FAmountTrf  : Int64;
    FSignature  : TString120;
    FTrfrID     : TString64;
  protected
  public
    constructor Create;

    function LoadFromStream(const AStream: TStream): Int64;
    function SaveToStream(const AStream: TStream): Int64;

    property Block: Integer
      read FBlock
      write FBlock;
    property OrderID: TString64
      read FOrderID
      write FOrderID;
    property OrderLines: Integer
      read FOrderLines
      write FOrderLines;
    property OrderType: TString6
      read FOrderType
      write FOrderType;
    property TimeStamp: Int64
      read FTimeStamp
      write FTimeStamp;
    property Reference: TString64
      read FReference
      write FReference;
    property TrxLine: Integer
      read FTrxLine
      write FTrxLine;
    property Sender: TString120
      read FSender
      write FSender;
    property Address: TString40
      read FAddress
      write FAddress;
    property Receiver: TString40
      read FReceiver
      write FReceiver;
    property AmountFee: Int64
      read FAmountFee
      write FAmountFee;
    property AmountTrf: Int64
      read FAmountTrf
      write FAmountTrf;
    property Signature: TString120
      read FSignature
      write FSignature;
    property TrfrID: TString64
      read FTrfrID
      write FTrfrID;

  published
  end;

implementation

{ TLegacyTransaction }

constructor TLegacyTransaction.Create;
begin
  FBlock:= -1;
  FOrderID:= EmptyStr;
  FOrderLines:= -1;
  FOrderType:= EmptyStr;
  FTimeStamp:= -1;
  FReference:= EmptyStr;
  FTrxLine:= -1;
  FSender:= EmptyStr;
  FAddress:= EmptyStr;
  FReceiver:= EmptyStr;
  FAmountFee:= 0;
  FAmountTrf:= 0;
  FSignature:= EmptyStr;
  FTrfrID:= EmptyStr;
end;

function TLegacyTransaction.LoadFromStream(const AStream: TStream): Int64;
var
  bytesRead: Int64 = 0;
begin
  Result:= 0;
  bytesRead:= AStream.Read(FBlock, SizeOf(FBlock));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FOrderID, SizeOf(FOrderID));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FOrderLines, SizeOf(FOrderLines));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FOrderType, SizeOf(FOrderType));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FTimeStamp, SizeOf(FTimeStamp));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FReference, SizeOf(FReference));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FTrxLine, SizeOf(FTrxLine));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FSender, SizeOf(FSender));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FAddress, SizeOf(FAddress));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FReceiver, SizeOf(FReceiver));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FAmountFee, SizeOf(FAmountFee));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FAmountTrf, SizeOf(FAmountTrf));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FSignature, SizeOf(FSignature));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FTrfrID, SizeOf(FTrfrID));
  Inc(Result, bytesRead);
end;

function TLegacyTransaction.SaveToStream(const AStream: TStream): Int64;
var
  bytesWritten: Int64 = 0;
begin
  Result:= 0;
  bytesWritten:= AStream.Write(FBlock, SizeOf(FBlock));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FOrderID, SizeOf(FOrderID));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FOrderLines, SizeOf(FOrderLines));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FOrderType, SizeOf(FOrderType));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FTimeStamp, SizeOf(FTimeStamp));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FReference, SizeOf(FReference));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FTrxLine, SizeOf(FTrxLine));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FSender, SizeOf(FSender));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FAddress, SizeOf(FAddress));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FReceiver, SizeOf(FReceiver));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FAmountFee, SizeOf(FAmountFee));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FAmountTrf, SizeOf(FAmountTrf));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FSignature, SizeOf(FSignature));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FTrfrID, SizeOf(FTrfrID));
  Inc(Result, bytesWritten);
end;

end.

