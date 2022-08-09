unit NosoDataTool.Blocks;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils
, NosoDataTool.Constants
, Noso.Data.Block
, Noso.Data.Legacy.Block
, Noso.Data.Legacy.Transaction
;

procedure DisplayBlock(ABlockFilename: String; ADispalyJSON: Boolean = False);

implementation

procedure DisplayBlock(ABlockFilename: String; ADispalyJSON: Boolean);
var
  blockLegacy: TLegacyBlock;
  transactionLegacy: TLegacyTransaction;
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
      WriteLn(#9'Time Start: ', blockLegacy.TimeStart);
      WriteLn(#9'Time End: ', blockLegacy.TimeEnd);
      WriteLn(#9'Time Total: ', blockLegacy.TimeTotal);
      WriteLn(#9'Time Last 20: ', blockLegacy.TimeLast20);
      WriteLn(#9'Time Total: ', blockLegacy.TimeTotal);
      WriteLn(#9'Difficulty: ', blockLegacy.Difficulty);
      WriteLn(#9'Target Hash: ', blockLegacy.TargetHash);
      WriteLn(#9'Solution: ', blockLegacy.Solution);
      WriteLn(#9'Last Block Hash: ', blockLegacy.LastBlockHash);
      WriteLn(#9'Next Difficulty: ', blockLegacy.NextBlockDifficulty);
      WriteLn(#9'Miner: ', blockLegacy.Miner);
      WriteLn(#9'Fee: ', blockLegacy.Fee);
      WriteLn(#9'Reward: ', blockLegacy.Reward);
      // Operations/Orders/Transfers
      WriteLn('Transactions');
      if blockLegacy.Transactions.Count > 0 then
      begin
        for transactionLegacy in blockLegacy.Transactions do
        begin
          WriteLn(#9'OrderId: ', transactionLegacy.OrderID);
          WriteLn(#9'TransfId: ', transactionLegacy.TrfrID);
          WriteLn(#9#9'Type: ', transactionLegacy.OrderType);
          WriteLn(#9#9'Timestamp: ', transactionLegacy.TimeStamp);
          WriteLn(#9#9'Reference: ', transactionLegacy.Reference);
          WriteLn(#9#9'Sender: ', transactionLegacy.Sender);
          WriteLn(#9#9'Account: ', transactionLegacy.Address);
          WriteLn(#9#9'Receiver: ', transactionLegacy.Receiver);
          WriteLn(#9#9'Signature: ', transactionLegacy.Signature);
          WriteLn(#9#9'Fee: ', transactionLegacy.AmountFee);
          WriteLn(#9#9'Amount: ', transactionLegacy.AmountTrf);
        end;
      end
      else
      begin
        WriteLn(#9'No transactions to display');
      end;
      // PoS
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
      // MNs
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
      WriteLn;
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

