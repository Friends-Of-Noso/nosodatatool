unit Noso.Data.Legacy.Addresses;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
, SysUtils
, Contnrs
, Noso.Data.Legacy.Address
;

type
  TLegacyAddressesEnumerator = class; // Forward
{ TLegacyAddresses }
  TLegacyAddresses = class(TObject)
  private
    FAddresses: TFPObjectList;

    function GetCount: Integer;
    function GetItem(Index: Integer): TLegacyAddress;
    procedure SetItem(Index: Integer; AValue: TLegacyAddress);
  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function Add(const AAddress: TLegacyAddress): Integer;
    procedure Delete(const AAddress: TLegacyAddress);

    { #todo 100 -ogcarreno : Add Load and Save with filename and stream }

    function GetEnumerator: TLegacyAddressesEnumerator;

    property Count: Integer
      read GetCount;
    property Items[Index: Integer]: TLegacyAddress
      read GetItem
      write SetItem;
  published
  end;


{ TLegacyAddressesEnumerator }
  TLegacyAddressesEnumerator = class
  private
    FLegacyAddresses: TLegacyAddresses;
    FPosition: Integer;
  protected
  public
    constructor Create(const ALegacyAddresses: TLegacyAddresses);
    function GetCurrent: TLegacyAddress;
    function MoveNext: Boolean;

    property Current: TLegacyAddress
      read GetCurrent;
  published
  end;

implementation

{ TLegacyAddresses }

function TLegacyAddresses.GetItem(Index: Integer): TLegacyAddress;
begin
  Result:= FAddresses.Items[Index] as TLegacyAddress;
end;

function TLegacyAddresses.GetCount: Integer;
begin
  Result:= FAddresses.Count;
end;

procedure TLegacyAddresses.SetItem(Index: Integer; AValue: TLegacyAddress);
begin
  if FAddresses.Items[Index] = AValue then exit;
  FAddresses.Items[Index]:= AValue;
end;

procedure TLegacyAddresses.Clear;
begin
  FAddresses.Clear;
end;

function TLegacyAddresses.Add(const AAddress: TLegacyAddress): Integer;
begin
  Result:= FAddresses.Add(AAddress);
end;

procedure TLegacyAddresses.Delete(const AAddress: TLegacyAddress);
begin
  FAddresses.Delete(FAddresses.IndexOf(AAddress));
end;

function TLegacyAddresses.GetEnumerator: TLegacyAddressesEnumerator;
begin
  Result:= TLegacyAddressesEnumerator.Create(Self);
end;

constructor TLegacyAddresses.Create;
begin
  FAddresses:= TFPObjectList.Create(True);
end;

destructor TLegacyAddresses.Destroy;
begin
  FAddresses.Free;
  inherited Destroy;
end;

{ TLegacyAddressesEnumerator }

constructor TLegacyAddressesEnumerator.Create(const ALegacyAddresses: TLegacyAddresses);
begin
  FLegacyAddresses:= ALegacyAddresses;
  FPosition:= -1;
end;

function TLegacyAddressesEnumerator.GetCurrent: TLegacyAddress;
begin
  Result:= FLegacyAddresses.Items[FPosition];
end;

function TLegacyAddressesEnumerator.MoveNext: Boolean;
begin
  Inc(FPosition);
  Result := FPosition < FLegacyAddresses.Count;
end;

end.

