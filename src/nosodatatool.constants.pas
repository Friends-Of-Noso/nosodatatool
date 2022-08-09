unit NosoDataTool.Constants;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils;

const
  cVersionMajor = 0;
  cVersionMinor = 1;
  cVersionPatch = 2;

  cVersionFormat = 'v%d.%d.%d';

  cFolderNosodata = 'NOSODATA';
  cFolderBlocks   = 'BLOCKS';

  cFileBlockFormat = '%d.blk';

  cPoSFirstBlock: Int64 = 8425;
  cMNsFirstBlock: Int64 = 48010;

implementation

end.

