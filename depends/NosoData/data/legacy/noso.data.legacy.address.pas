unit Noso.Data.Legacy.Address;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
, SysUtils
, Noso.Data.Legacy.Types
;

type
{ TLegacyAddress }
  TLegacyAddress = class
  private
    FHash: TString40;
    FAlias: TString40;
    FPublicKey : TString255;
    FPrivateKey: TString255;
    FBalance: Int64;
    FPending: Int64;
    FScore: Int64;
    FLastOp: Int64;
  protected
  public
    constructor Create;

    function LoadFromStream(const AStream: TStream): Int64;
    function SaveToStream(const AStream: TStream): Int64;

    property Hash: TString40
      read FHash
      write FHash;
    property Alias: TString40
      read FAlias
      write FAlias;
    property PublicKey: TString255
      read FPublicKey
      write FPublicKey;
    property PrivateKey: TString255
      read FPrivateKey
      write FPrivateKey;
    property Balance: Int64
      read FBalance
      write FBalance;
    property Pending: Int64
      read FPending
      write FPending;
    property Score: Int64
      read FScore
      write FScore;
    property LastOp: Int64
      read FLastOp
      write FLastOp;
  published
  end;

implementation

{ TLegacyAddress }

constructor TLegacyAddress.Create;
begin
  FHash:= EmptyStr;
  FAlias:= EmptyStr;
  FPublicKey:= EmptyStr;
  FPrivateKey:= EmptyStr;
  FBalance:= 0;
  FPending:= 0;
  FScore:= 0;
  FLastOp:= -1;
end;

function TLegacyAddress.LoadFromStream(const AStream: TStream): Int64;
var
  bytesRead: Int64 = 0;
begin
  Result:= 0;
  bytesRead:= AStream.Read(FHash, SizeOf(FHash));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FAlias, SizeOf(FAlias));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FPublicKey, SizeOf(FPublicKey));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FPrivateKey, SizeOf(FPrivateKey));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FBalance, SizeOf(FBalance));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FPending, SizeOf(FPending));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FScore, SizeOf(FScore));
  Inc(Result, bytesRead);
  bytesRead:= AStream.Read(FLastOp, SizeOf(FLastOp));
  Inc(Result, bytesRead);
end;

function TLegacyAddress.SaveToStream(const AStream: TStream): Int64;
var
  bytesWritten: Int64 = 0;
begin
  Result:= 0;
  bytesWritten:= AStream.Write(FHash, SizeOf(FHash));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FAlias, SizeOf(FAlias));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FPublicKey, SizeOf(FPublicKey));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FPrivateKey, SizeOf(FPrivateKey));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FBalance, SizeOf(FBalance));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FPending, SizeOf(FPending));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FScore, SizeOf(FScore));
  Inc(Result, bytesWritten);
  bytesWritten:= AStream.Write(FLastOp, SizeOf(FLastOp));
  Inc(Result, bytesWritten);
end;

end.

