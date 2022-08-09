program nosodatatool;

{$mode ObjFPC}{$H+}

uses
  SysUtils
, NosoDataTool.Constants
, NosoDataTool.Blocks
;

procedure Version;
begin
  WriteLn('Noso Data Tool ', Format(cVersionFormat, [cVersionMajor, cVersionMinor, cVersionPatch]));
end;

procedure Usage;
begin
  Version;
  WriteLn('usage:');
  WriteLn(#9'nosodatatool block <block#> [-j|--json]');
  WriteLn(#9'nosodatatool -h|--help');
  WriteLn(#9'nosodatatool -v|--version');
  WriteLn;
  WriteLn('Commands:');
  WriteLn(#9'block'#9'displays the content of <block#>');
  WriteLn;
  WriteLn('Options:');
  WriteLn(#9'-j|--json'#9'displays the data in JSON');
  WriteLn(#9'-h|--help'#9'displays this message');
  WriteLn(#9'-v|--version'#9'displays the version');
end;


{$R *.res}

var
  blockFilename: String = '';
  blockNumber: Int64 = -1;
  displayJSON: Boolean = False;

begin
  if ParamCount > 0 then
  begin
    if (ParamStr(1) = '-h') or (ParamStr(1) = '--help') then
    begin
      Usage;
    end;
    if (ParamStr(1) = '-v') or (ParamStr(1) = '--version') then
    begin
      Version;
    end;
    if ParamStr(1) = 'block' then
    begin
      if DirectoryExists(cFolderNosodata) then
      begin
        if DirectoryExists(cFolderNosodata+DirectorySeparator+cFolderBlocks) then
        begin
          try
            blockNumber:= ParamStr(2).ToInt64;
          except
            // Eat the exception if conversion fails
          end;
          if blockNumber >= 0 then
          begin
            blockFilename:= Format(cFileBlockFormat, [blockNumber]);
            blockFilename:= Format('%s%s%s%s%s', [
              cFolderNosodata,
              DirectorySeparator,
              cFolderBlocks,
              DirectorySeparator,
              blockFilename
            ]);
            if FileExists(blockFilename) then
            begin
              displayJSON:= ((ParamStr(3) = '-j') or (ParamStr(3) = '--json'));
              DisplayBlock(blockFilename, displayJSON);
            end;
          end
          else
          begin
            Version;
            WriteLn;
            WriteLn('ERROR: Block number must be an integer greater than or equal to 0(zero)');
          end;
        end
        else
        begin
          Version;
          WriteLn;
          WriteLn('ERROR: There should be a folder "',cFolderNosodata+DirectorySeparator+cFolderBlocks,'" in the current path.');
        end;
      end
      else
      begin
        Version;
        WriteLn;
        WriteLn('ERROR: There should be a folder "',cFolderNosodata,'" in the current path.');
      end;
    end;
  end
  else
  begin
    Usage;
  end;
end.

