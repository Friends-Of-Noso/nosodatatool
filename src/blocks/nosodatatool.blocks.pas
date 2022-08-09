unit NosoDataTool.Blocks;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils
, NosoDataTool.Constants
, Noso.Data.Block
, Noso.Data.Legacy.Block
;

procedure DisplayBlock(ABlockFilename: String; ADispalyJSON: Boolean = False);

implementation

procedure DisplayBlock(ABlockFilename: String; ADispalyJSON: Boolean);
var
  blockLegacy: TLegacyBlock;
  block: TBlock;
  address: String;
begin
  blockLegacy:= TLegacyBlock.Create(ABlockFilename);
  try
    if not ADispalyJSON then
    begin
      WriteLn('Header');
      WriteLn(#9'Block: ', blockLegacy.Number);
      WriteLn(#9'Hash: ', blockLegacy.Hash);
      WriteLn('Transactions');
      if blockLegacy.Transactions.Count > 0 then
      begin
        //Loop
        WriteLn(#9'OrderId: ', blockLegacy.Transactions[0].OrderID);
      end
      else
      begin
        WriteLn(#9'No transactions to display');
      end;
      if blockLegacy.Number >= cPoSFirstBlock then
      begin
        WriteLn('Proof of Stake');
        if blockLegacy.PoSReward > 0 then
        begin
          WriteLn(#9'Amount: ', blockLegacy.PoSReward);
          for address in blockLegacy.PoSAddresses do
          begin
            WriteLn(#9'Address: ', address);
          end;
        end
        else
        begin
          WriteLn(#9'No entries to display');
        end;
      end;
      if blockLegacy.Number >= cMNsFirstBlock then
      begin
        WriteLn('Master Nodes');
        if blockLegacy.MNReward > 0 then
        begin
          WriteLn(#9'Amount: ', blockLegacy.MNReward);
          // Loop
          for address in blockLegacy.MNAddresses do
          begin
            WriteLn(#9'Address: ', address);
          end;
        end
        else
        begin
          WriteLn(#9'No entries to display');
        end;
      end;
    end
    else
    begin
      block:= tblock.Create(blockLegacy);
      try
        WriteLn(block.AsJSON);
      finally
        block.Free;
      end;
    end;
  finally
    blockLegacy.Free;
  end;
end;

end.

