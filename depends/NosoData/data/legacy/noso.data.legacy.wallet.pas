unit Noso.Data.Legacy.Wallet;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
, SysUtils
, Noso.Data.Legacy.Addresses
, Noso.Data.Legacy.Address
;

type
{ TLegacyWallet }
  TLegacyWallet = class(TObject)
  private
    FAddresses: TLegacyAddresses;
  protected
  public
    constructor Create;
    destructor Destroy; override;

    property Addresses: TLegacyAddresses
      read FAddresses;
  published
  end;

implementation

{ TLegacyWallet }

constructor TLegacyWallet.Create;
begin
  FAddresses:= TLegacyAddresses.Create;
end;

destructor TLegacyWallet.Destroy;
begin
  FAddresses.Free;
  inherited Destroy;
end;

end.

