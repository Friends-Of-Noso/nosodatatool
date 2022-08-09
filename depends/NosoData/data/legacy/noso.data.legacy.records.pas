unit Noso.Data.Legacy.Records;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
, SysUtils
;

type

{ TLegacyBlockHeaderData }
  TLegacyBlockHeaderData = packed record
    Number         : Int64;
    TimeStart      : Int64;
    TimeEnd        : Int64;
    TimeTotal      : Integer;
    TimeLast20     : Integer;
    TrxTotales     : Integer;
    Difficult      : Integer;
    TargetHash     : String[32];
    Solution       : String[200];
    LastBlockHash  : String[32];
    NxtBlkDiff     : Integer;
    AccountMiner   : String[40];
    MinerFee       : Int64;
    Reward         : Int64;
  end;

{ TLegacyOrderData }
  TLegacyOrderData = packed record
    Block      : integer; //  MAXINT = 2'147'483'647
    OrderID    : String[64];
    OrderLines : Integer;
    OrderType  : String[6];
    TimeStamp  : Int64;
    Concept    : String[64];
    TrxLine    : integer;
    Sender     : String[120];
    Address    : String[40];
    Receiver   : String[40];
    AmountFee  : Int64;
    AmountTrf  : Int64;
    Signature  : String[120];
    TrfrID     : String[64];
  end;

{ TLegacyWalletData }
  TLegacyWalletData = packed record
    Hash       : String[40]; // El hash publico o direccion
    Custom     : String[40]; // En caso de que la direccion este personalizada
    PublicKey  : String[255]; // clave publica
    PrivateKey : String[255]; // clave privada
    Balance    : Int64; // el ultimo saldo conocido de la direccion
    Pending    : Int64; // el ultimo saldo de pagos pendientes
    Score      : Int64; // estado del registro de la direccion.
    LastOP     : Int64;// tiempo de la ultima operacion en UnixTime.
  end;

{ TLegacySummaryData }
  TLegacySummaryData = Packed Record
     Hash    : String[40]; // El hash publico o direccion
     Custom  : String[40]; // En caso de que la direccion este personalizada
     Balance : int64; // el ultimo saldo conocido de la direccion
     Score   : int64; // estado del registro de la direccion.
     LastOP  : int64;// tiempo de la ultima operacion en UnixTime.
     end;

{ TLegacyMyTrxData }
  TLegacyMyTrxData = packed record
    Block     : integer;
    Time      : int64;
    Tipo      : string[6];
    Receiver  : string[64];
    Amount    : int64;
    TrfrID    : string[64];
    OrderID   : String[64];
    Reference : String[64];
  end;

implementation

end.

