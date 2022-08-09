unit Noso.Data.Legacy.Blocks;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
, SysUtils
, Noso.Data.Legacy.Block
;

type
{ TLegacyBlocks }
  TLegacyBlocks = class
  private
    FFolder: String;
    FCount: Int64;

    function GetBlock(Index: Int64): TLegacyBlock;
  protected
  public
    constructor Create; overload;
    constructor Create(const AFolder: String); overload;

    destructor Destroy; override;

    procedure Refresh;

    property Folder: String
      read FFolder
      write FFolder;
    property Count: Int64
      read FCount;
    property Items[Index: Int64]: TLegacyBlock
      read GetBlock; default;
  published
  end;

implementation

const
  cDataFolderName = 'NOSODATA';
  cBlocksFolderName = 'BLOCKS';
  cFilenameFormat =
    '%s'+DirectorySeparator+
    '%s'+DirectorySeparator+
    '%s'+DirectorySeparator+
    '%d.blk'
  ;

{ TLegacyBlocks }

function TLegacyBlocks.GetBlock(Index: Int64): TLegacyBlock;
var
  filename: String;
begin
  Result:= nil;
  if (Index < 0) or (Index > FCount) then exit;
  filename:= Format(cFilenameFormat,[
    ExcludeTrailingPathDelimiter(FFolder),
    cDataFolderName,
    cBlocksFolderName,
    Index
    ]);
  if not FileExists(filename) then exit;
  Result:= TLegacyBlock.Create(filename);
end;

procedure TLegacyBlocks.Refresh;
var
  filename: String;
begin
  FCount:= -1;
  repeat
    Inc(FCount);
    filename:= Format(cFilenameFormat,[
      ExcludeTrailingPathDelimiter(FFolder),
      cDataFolderName,
      cBlocksFolderName,
      Fcount
      ]);
  until not FileExists(filename);
end;

constructor TLegacyBlocks.Create;
begin
  FFolder:= '';
  FCount:= 0;
end;

constructor TLegacyBlocks.Create(const AFolder: String);
begin
  Create;
  FFolder:= AFolder;
  Refresh;
end;

destructor TLegacyBlocks.Destroy;
begin
  inherited Destroy;
end;

end.

