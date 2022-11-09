//------------------------------------------------------------------------------
//
// The contents of this file are subject to the Mozilla Public License
// Version 2.0 (the "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Alternatively, you may redistribute this library, use and/or modify it under
// the terms of the GNU Lesser General Public License as published by the
// Free Software Foundation; either version 2.1 of the License, or (at your
// option) any later version. You may obtain a copy of the LGPL at
// http://www.gnu.org/copyleft/.
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
// the specific language governing rights and limitations under the License.
//
// Orginally released as freeware then open sourced in July 2017.
//
// The initial developer of the original code is Easy-IP AS
// (Oslo, Norway, www.easy-ip.net), written by Paul Spencer Thornton -
// paul.thornton@easy-ip.net.
//
// (C) 2017 Easy-IP AS. All Rights Reserved.
//
//------------------------------------------------------------------------------

unit Duds.Vcl.Form.Main;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.ImageList,
  System.Actions, System.DateUtils, System.RegularExpressions,
  System.Generics.Collections, System.UITypes, System.IOUtils,

  Xml.XMLDoc, Xml.XMLIntf,

  Winapi.Windows, Winapi.Messages, WinAPI.ShellAPI,
  System.Win.Registry,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ImgList, Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Mask,
  Vcl.Menus, Vcl.WinXCtrls,

  VirtualTrees,

  SynEditHighlighter, SynHighlighterPas, SynEdit,

  Duds.Common.Types,
  Duds.Common.Classes,
  Duds.Common.Files,
  Duds.Common.Strings,
  Duds.Common.Utils,
  Duds.Common.Interfaces,
  Duds.Common.Parser.Pascal,

  Duds.Vcl.HourGlass,
  Duds.Vcl.Utils,
  Duds.Vcl.VirtualTreeview;

type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    SynPasSyn1: TSynPasSyn;
    ActionManager1: TActionManager;
    actStartScan: TAction;
    actShowUnitsNotInPath: TAction;
    actSaveChanges: TAction;
    actRename: TAction;
    popTree: TPopupMenu;
    Rename1: TMenuItem;
    ShowUnitsnotinPath1: TMenuItem;
    N1: TMenuItem;
    actExpandAll: TAction;
    actExpand: TAction;
    actCollapseAll: TAction;
    actCollapse: TAction;
    N3: TMenuItem;
    Expand1: TMenuItem;
    ExpandAll1: TMenuItem;
    Collapse1: TMenuItem;
    CollapseAll1: TMenuItem;
    N4: TMenuItem;
    actStopScan: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    actSettings: TAction;
    Settings1: TMenuItem;
    N5: TMenuItem;
    actExit: TAction;
    Exit1: TMenuItem;
    Scan1: TMenuItem;
    View1: TMenuItem;
    Scan2: TMenuItem;
    Stop1: TMenuItem;
    ShowUnitsnotinPath2: TMenuItem;
    N6: TMenuItem;
    ExpandAll2: TMenuItem;
    CollapseAll2: TMenuItem;
    Edit1: TMenuItem;
    Rename2: TMenuItem;
    SaveChanges1: TMenuItem;
    N7: TMenuItem;
    actLoadProject: TAction;
    actSaveProject: TAction;
    actSaveProjectAs: TAction;
    LoadProject1: TMenuItem;
    SaveProject1: TMenuItem;
    SaveProjectAs1: TMenuItem;
    N2: TMenuItem;
    N8: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ActionToolBar1: TActionToolBar;
    pnlBackground: TPanel;
    pnlMain: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    pcView: TPageControl;
    tabTree: TTabSheet;
    Splitter2: TSplitter;
    pnlTree: TPanel;
    Panel5: TPanel;
    pcSource: TPageControl;
    tabParentFile: TTabSheet;
    memParentFile: TSynEdit;
    tabSelectedFile: TTabSheet;
    memSelectedFile: TSynEdit;
    tabList: TTabSheet;
    Splitter3: TSplitter;
    pnlList: TPanel;
    Panel10: TPanel;
    pnlLog: TPanel;
    Panel9: TPanel;
    pcList: TPageControl;
    tabUsedBy: TTabSheet;
    tabSource: TTabSheet;
    memListFile: TSynEdit;
    Image1: TImage;
    tmrClose: TTimer;
    tabUsesList: TTabSheet;
    actNewProject: TAction;
    actCloseProject: TAction;
    New1: TMenuItem;
    N10: TMenuItem;
    Close1: TMenuItem;
    N9: TMenuItem;
    actSearchAndReplace: TAction;
    SearchandReplace1: TMenuItem;
    tmrLoaded: TTimer;
    actShowFile: TAction;
    ShowfileinWindowsExplorer1: TMenuItem;
    N11: TMenuItem;
    actSaveToXML: TAction;
    SaveDialog2: TSaveDialog;
    actSaveToGephiCSV: TAction;
    N12: TMenuItem;
    SavetoXML1: TMenuItem;
    SavetoGephiCSV1: TMenuItem;
    SaveDialog3: TSaveDialog;
    actSaveToGraphML: TAction;
    SaveDialog4: TSaveDialog;
    edtSearch: TSearchBox;
    edtListSearch: TSearchBox;
    edtSearchUsedByList: TSearchBox;
    edtSearchUsesList: TSearchBox;
    vtUnitsList: TVirtualStringTree;
    vtUnits: TVirtualStringTree;
    vtUsedUnits: TVirtualStringTree;
    vtUsesUnits: TVirtualStringTree;
    vtStats: TVirtualStringTree;
    ImageList1: TImageList;
    vtLog: TVirtualStringTree;
    SearchandReplace2: TMenuItem;
    N13: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtUnitsGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtUnitsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure edtSearchEditChange(Sender: TObject);
    procedure vtUnitsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure vtUnitsBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtUnitsFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure vtUnitsGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: TImageIndex);
    procedure vtUnitsDblClick(Sender: TObject);
    procedure actStartScanExecute(Sender: TObject);
    procedure actShowUnitsNotInPathExecute(Sender: TObject);
    procedure ActionManager1Update(Action: TBasicAction; var Handled: Boolean);
    procedure vtUnitsFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
    procedure memParentFileChange(Sender: TObject);
    procedure memSelectedFileChange(Sender: TObject);
    procedure actSaveChangesExecute(Sender: TObject);
    procedure actRenameExecute(Sender: TObject);
    procedure edtSearchEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSearchEditKeyPress(Sender: TObject; var Key: Char);
    procedure actExpandAllExecute(Sender: TObject);
    procedure actExpandExecute(Sender: TObject);
    procedure actCollapseAllExecute(Sender: TObject);
    procedure actCollapseExecute(Sender: TObject);
    procedure vtUnitsListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtStatsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtStatsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure vtUnitsListFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtUnitsListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtUnitsListSearchComparison(Sender: TObject; Node: PVirtualNode;
      const SearchTerms: TStrings; var IsMatch: Boolean);
    procedure edtListSearchEditChange(Sender: TObject);
    procedure vtUnitsListDblClick(Sender: TObject);
    procedure vtUnitsListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure actStopScanExecute(Sender: TObject);
    procedure memListFileChange(Sender: TObject);
    procedure vtUnitsListCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure vtUnitsCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure actExitExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actLoadProjectExecute(Sender: TObject);
    procedure actSaveProjectExecute(Sender: TObject);
    procedure actSaveProjectAsExecute(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
    procedure edtSearchUsedByListEditChange(Sender: TObject);
    procedure edtSearchUsesListEditChange(Sender: TObject);
    procedure actNewProjectExecute(Sender: TObject);
    procedure actCloseProjectExecute(Sender: TObject);
    procedure actSearchAndReplaceExecute(Sender: TObject);
    procedure edtSearchSearchClick(Sender: TObject);
    procedure tmrLoadedTimer(Sender: TObject);
    procedure actShowFileExecute(Sender: TObject);
    procedure actSaveToXMLExecute(Sender: TObject);
    procedure actSaveToGephiCSVExecute(Sender: TObject);
    procedure actSaveToGraphMLExecute(Sender: TObject);
    procedure vtLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtCommonHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vtLogGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: TImageIndex);
    procedure vtCommonGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
  private
    FLogEntries: TLogEntries;
    FFiles: TDictionary<String, String>;
    FDelphiFiles: TObjectDictionary<String, TDelphiFile>;
    FNodeObjects: TObjectList<TNodeObject>;
    FSearchText: String;
    FPascalUnitExtractor: TPascalUnitExtractor;
    FLineCount: Integer;
    FDelphiFileList: TObjectList<TDelphiFile>;
    FStats: TStringList;
    FScannedFiles: Integer;
    FScanDepth: Integer;
    FCancelled: Boolean;
    FStartTime: TDateTime;
    FBusy: Boolean;
    FpnlLogHeight: Integer;
    FEnvironmentSettings: TEnvironmentSettings;
    FProjectSettings: TProjectSettings;
    FProjectFilename: String;
    FLoadLastProject: Boolean;
    FModified: Boolean;
    FParsedFileCount: Integer;
    FFMXFormCount: Integer;
    FVCLFormCount: Integer;
    FNextStatusUpdate: TDateTime;
    FDeppestScanDepth: Integer;
    FLastScanNode: PVirtualNode;
    FClosing: Boolean;
    FShowTermParents: Boolean;
    FRunScanOnLoad: Boolean;

    procedure LoadFilesInSearchPaths(NoLog: Boolean = FALSE);
    procedure BuildDependencyTree(NoLog: Boolean = FALSE);
    procedure SearchTree(const SearchText: String; FromFirstNode: Boolean);
    function IsSearchHitNode(Node: PVirtualNode): Boolean;
    function GetNodePath(Node: PVirtualNode): String;
    function GetUnitFilename(const DelphiUnitName: String): String;
    procedure ShowUnitsNotInPath;
    procedure SetNodeVisibility(VT: TVirtualStringTree; Node: PVirtualNode; DelphiFile: TDelphiFile);
    function GetLinkedNode(Node: PVirtualNode): PVirtualNode;
    procedure UpdateTreeControls(Node: PVirtualNode);
    procedure RenameDelphiFile(const SearchString, ReplaceString: String; UpdateUsesClasues, PromptBeforeUpdate, DummyRun, RenameHistoryFiles, ExactMatch: Boolean);
    function FindParsedDelphiUnit(const DelphiUnitName: string): TDelphiFile;
    function CreateDelphiFile(const DelphiUnitName: String): TDelphiFile;
    procedure UpdateStats(ForceUpdate: Boolean);
    procedure UpdateListControls(Node: PVirtualNode);
    procedure ShowHideControls;
    procedure LoadSettings;
    procedure SaveSettings;
    function LoadProjectSettings(const Filename: String = ''; RunScanAfterLoad: Boolean = TRUE): Boolean;
    procedure SaveProjectSettings(const Filename: String = '');
    function GetSettingsFilename: String;
    procedure ExpandAll;
    procedure UpdateControls;
    procedure SetFormCaption;
    procedure SetModified(const Value: Boolean);
    function CheckSaveProject: Boolean;
    function SaveProject: Boolean;
    function SaveProjectAs: Boolean;
    function IsUnitUsed(const DelphiUnitName: String; DelphiFile: TDelphiFile): Boolean;
    function TryGetSearchUnit(const DelphiUnitName: String; var UnitFilename: String; UseScopes: Boolean): Boolean;
    function RenameDelphiFileWithDialog(RenameType: TRenameType): Boolean; overload;
    function RenameDelphiFileWithDialog(const DelphiFile: TDelphiFile; RenameType: TRenameType): Boolean; overload;
    procedure SearchList(VT: TVirtualStringTree; const SearchText: String);
    procedure SearchUnitsListChildList(VT: TVirtualStringTree; const SearchText: String; UsedBy: Boolean);
    procedure CloseControls;
    function CheckNotRunning: Boolean;
    procedure ResetSettings;
    procedure ClearStats;
    function GetFocusedDelphiFile: TDelphiFile;
    procedure ExportToXML(const VT: TVirtualStringTree; const Filename: String);
    procedure ExportToGephi(const Filename: String);
    procedure ExportToGraphML(const Filename: String);
    procedure Log(const Msg: String; const Severity: Integer = LogInfo); overload;
    procedure Log(const Msg: String; const Args: array of const; const Severity: Integer = LogInfo); overload;
    function GetID(const Node: PVirtualNode): Integer;
    procedure SetID(const Node: PVirtualNode; const ID: Integer);
    function GetFocusedID(const VT: TVirtualStringTree): Integer;
    function GetNodeIndex(const Node: PVirtualNode): Integer;
    procedure UpdateLogEntries;
    procedure ClearLog;
    procedure FixDPI;

    property Modified: Boolean read FModified write SetModified;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Duds.Vcl.Form.Rename,
  Duds.Vcl.Form.Settings,
  Duds.Vcl.Form.FindReplace;

resourcestring
  StrYes = 'Yes';
  StrNo = 'No';
  StrSHasBeenModifi = '"%s" has been modified. Would you like to save the changes?';
  StrScanningDSearchD = 'Scanning %d search directories';
  StrDFilesFound = '%d matching file(s) found in the search paths';
  StrParsingFiles = 'Parsing files';
  StrDFilesWithATo = '%d used unit(s) found and a total of %d lines parsed';
  StrUpdateTheUsesClauseIn = 'Update the uses clause in "%s"?';
  StrUnableToFindFile = 'Unable to find file "%s"';
  StrUsesClauseIn = '"%s" not updated as the text has been changed from "%s" to "%s"';
  StrTHISISADUMMYRUN = 'THIS IS A DUMMY RUN. NO FILES WILL BE UPDATED!';
  StrTHISWASADUMMYRUN = 'THIS WAS A DUMMY RUN. NO FILES WERE UPDATED!';
  StrFinishedUpdated = 'Finished - Updated %d uses clauses';
  StrUnableToRenameS = 'Unable to rename "%s" as the unit name was not found';
  StrUpdatedDelphiUnitNameIn = 'Updated unit name in "%s" from "%s" to "%s"';
  StrUpdatedUsesClause = 'Replaced "%s" with "%s" the uses clause of "%s"';
  StrScannedFiles = 'Processed Files';
  StrParsedFiles = 'Unique Parsed Files';
  StrFilesFound = 'Total Used Units';
  StrTotalLines = 'Total Lines of Code';
  StrSearchPathFiles = 'Search Path Files';
  StrScanDepth = 'Current Scan Depth';
  StrSFoundInMultip = '"%s" found in multiple search paths. "%s" will be used and "%s" ignored';
  StrTime = 'Elapsed Time';
  StrUnitDependencyScan = 'Delphi Unit Dependency Scanner';
  StrHistory = 'History ';
  StrTheProjectHasBeen = 'The project has been modified. Would you like to save it now?';
  StrYouNeedToAddAtLeastOne = 'You need to add at least one root file before you can scan the dependencies. Would you like to add a root file now?';
  StrDeepestScanDepth = 'Deepest Scan Depth';
  StrRenameS = 'Rename "%s"';
  StrPleaseStopTheCurr = 'Please stop the current scan first.';
  StrFileSRenamedTo = 'File "%s" renamed to "%s"';
  StrRootFileNotFound = 'Root file not found: "%s"';
  StrUnableToParseS = 'Unable to parse "%s": %s';
  StrVCLFormCount = 'VCL Form Count';
  StrFMXFormCount = 'FMX Form Count';

{$R *.dfm}

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FClosing then
  begin
    CloseControls;
  end else
  begin
    CanClose := FALSE;

    if CheckSaveProject then
    begin
      actStopScan.Execute;

      tmrClose.Enabled := TRUE;
    end;
  end;
end;

function TfrmMain.CheckSaveProject: Boolean;
begin
  Result := not Modified;

  if not Result then
  begin
    case MessageDlg(StrTheProjectHasBeen, mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: Result := SaveProject;
      mrNo: Result := TRUE;
      mrCancel: Abort;
    end;
  end;
end;

function TfrmMain.GetID(const Node: PVirtualNode): Integer;
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    Result := NodeData.ID;
  end
  else
  begin
    raise Exception.Create('No node data found');
  end;
end;

procedure TfrmMain.SetID(const Node: PVirtualNode; const ID: Integer);
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    NodeData.ID := ID;
    NodeData.Index := Node.Index;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  pcSource.ActivePageIndex := 0;
  pcView.ActivePageIndex := 0;
  pcList.ActivePageIndex := 0;

  vtUnitsList.NodeDataSize := SizeOf(TNodeData);
  vtUnits.NodeDataSize := SizeOf(TNodeData);
  vtUsedUnits.NodeDataSize := SizeOf(TNodeData);
  vtUsesUnits.NodeDataSize := SizeOf(TNodeData);
  vtStats.NodeDataSize := SizeOf(TNodeData);

  FLogEntries := TLogEntries.Create;
  FFiles := TDictionary<String, String>.Create;
  FDelphiFiles := TObjectDictionary<String, TDelphiFile>.Create([doOwnsValues]);
  FDelphiFileList := TObjectList<TDelphiFile>.Create(FALSE);
  FNodeObjects := TObjectList<TNodeObject>.Create(True);
  FStats := TStringList.Create;

  FEnvironmentSettings := TEnvironmentSettings.Create;
  FProjectSettings := TProjectSettings.Create;

  FPascalUnitExtractor := TPascalUnitExtractor.Create(Self);

  UpdateTreeControls(nil);
  UpdateListControls(nil);

  FLoadLastProject := TRUE;
  FShowTermParents := FALSE;
  FRunScanOnLoad := TRUE;

  FixDPI;

  LoadSettings;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  SaveSettings;

  FreeAndNil(FFiles);
  FreeAndNil(FDelphiFiles);
  FreeAndNil(FDelphiFileList);
  FreeAndNil(FStats);
  FreeAndNil(FEnvironmentSettings);
  FreeAndNil(FProjectSettings);
  FreeAndNil(FLogEntries);
  FreeAndNil(FNodeObjects);
end;

procedure TfrmMain.Log(const Msg: String; const Severity: Integer);
var
  LogEntry: TLogEntry;
begin
  LogEntry.Text := Msg;
  LogEntry.Severity := Severity;
  FLogEntries.Add(LogEntry);

  UpdateLogEntries;
end;

procedure TfrmMain.Log(const Msg: String; const Args: Array of const; const Severity: Integer);
begin
  Log(Format(Msg, Args), Severity);
end;

procedure TfrmMain.LoadFilesInSearchPaths;

  procedure ScanPasFiles(Dirs: TStrings);
  var
    ScannedFiles: TObjectList<TFileInfo>;
    i, n: Integer;
    Extension, Dir, DelphiUnitName, ExistingFilename: String;
  begin
    for n := 0 to pred(Dirs.Count) do
    begin
      Application.ProcessMessages;

      Dir := Dirs[n];

      if FileExists(Dir) then
        Dir := ExtractFileDir(Dir);

      if DirectoryExists(Dir) then
      begin
        ScannedFiles := ScanFiles(Dir, '*.*', FALSE, FALSE, TRUE);
        try
          for i := 0 to pred(ScannedFiles.Count) do
          begin
            if FCancelled then
              Break;

            UpdateStats(FALSE);

            Extension := LowerCase(ExtractFileExt(ScannedFiles[i].Filename));

            if ((Extension = '.pas') or
                (Extension = '.dpk') or
                (Extension = '.dpr')) then
            begin
              DelphiUnitName := UpperCase(ExtractFilenameNoExt(ScannedFiles[i].Filename));

              if TryGetSearchUnit(DelphiUnitName, ExistingFilename, TRUE) then
              begin
                if not SameText(ExistingFilename, ScannedFiles[i].Filename) then
                  Log(StrSFoundInMultip,
                               [ExtractFilenameNoExt(ScannedFiles[i].Filename),
                                ExistingFilename,
                                ScannedFiles[i].Filename],
                              LogWarning);
              end
              else
                FFiles.Add(DelphiUnitName, ScannedFiles[i].Filename);
            end;
          end;
        finally
          FreeAndNil(ScannedFiles);
        end;
      end;
    end;
  end;

begin
  if not NoLog then
    Log(StrScanningDSearchD, [FProjectSettings.RootFiles.Count + FProjectSettings.SearchPaths.Count]);

  ScanPasFiles(FProjectSettings.RootFiles);
  ScanPasFiles(FProjectSettings.SearchPaths);

  if not NoLog then
    Log(StrDFilesFound, [FFiles.Count]);
end;

function TfrmMain.TryGetSearchUnit(const DelphiUnitName: String; var UnitFilename: String; UseScopes: Boolean): Boolean;
var
  i: Integer;
  UpperDelphiUnitName: String;
begin
  UpperDelphiUnitName := UpperCase(DelphiUnitName);

  Result := FFiles.TryGetValue(UpperDelphiUnitName, UnitFilename);

  // Try the scopes
  if (not Result) and (UseScopes) then
  begin
    for i := 0 to pred(FProjectSettings.UnitScopeNames.Count) do
    begin
      Result := FFiles.TryGetValue(UpperCase(FProjectSettings.UnitScopeNames[i]) + '.' + UpperDelphiUnitName, UnitFilename);

      if Result then
        Break;
    end;
  end;
end;

function TfrmMain.LoadProjectSettings(const Filename: String; RunScanAfterLoad: Boolean): Boolean;
begin
  Result := FALSE;

  if FProjectSettings.LoadFromFile(Filename) then
  begin
    if (FProjectFilename <> '') and
       (RunScanAfterLoad) and
       (FRunScanOnLoad) and
       (FProjectSettings.RootFiles.Count > 0) then
      actStartScan.Execute;

    SetFormCaption;

    Result := TRUE;
  end;
end;

function TfrmMain.GetSettingsFilename: String;
begin
  Result := IncludeTrailingPathDelimiter(TPath.GetDocumentsPath) + 'DUDS\config.ini';
end;

procedure TfrmMain.LoadSettings;
begin
  if FEnvironmentSettings.LoadFromFile(GetSettingsFilename) then
  begin
    pnlLog.Height := FEnvironmentSettings.StatusLogHeight;
    pnlTree.Width := FEnvironmentSettings.TreeWidth;
    pnlList.Width := FEnvironmentSettings.ListWidth;
    actShowUnitsNotInPath.Checked := FEnvironmentSettings.ShowUnitsNotInPath;
    FLoadLastProject := FEnvironmentSettings.LoadLastProject;
    FProjectFilename := FEnvironmentSettings.ProjectFilename;
    FRunScanOnLoad := FEnvironmentSettings.RunScanOnLoad;

    Left := FEnvironmentSettings.WindowLeft;
    Top := FEnvironmentSettings.WindowTop;
    Width := FEnvironmentSettings.WindowWidth;
    Height := FEnvironmentSettings.WindowHeight;

    WindowState := TWindowState(FEnvironmentSettings.WindowState);
  end;
end;

procedure TfrmMain.memListFileChange(Sender: TObject);
begin
  memListFile.Modified := TRUE;
end;

procedure TfrmMain.memParentFileChange(Sender: TObject);
begin
  memParentFile.Modified := TRUE;
end;

procedure TfrmMain.memSelectedFileChange(Sender: TObject);
begin
  memSelectedFile.Modified := TRUE;
end;

procedure TfrmMain.edtListSearchEditChange(Sender: TObject);
begin
  SearchList(vtUnitsList, edtListSearch.Text);
end;

procedure TfrmMain.edtSearchEditChange(Sender: TObject);
begin
  SearchTree(edtSearch.Text, TRUE);
end;

procedure TfrmMain.edtSearchEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 00;

    if edtSearch.Text <> '' then
      SearchTree(edtSearch.Text, FALSE);
  end;
end;

procedure TfrmMain.ClearLog;
begin
  FLogEntries.Clear;
  UpdateLogEntries;
end;

procedure TfrmMain.edtSearchEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #00;
end;

procedure TfrmMain.edtSearchSearchClick(Sender: TObject);
begin
  SearchTree(edtSearch.Text, FALSE);
end;

procedure TfrmMain.edtSearchUsedByListEditChange(Sender: TObject);
begin
  SearchUnitsListChildList(vtUsedUnits, edtSearchUsedByList.Text, TRUE);
end;

procedure TfrmMain.edtSearchUsesListEditChange(Sender: TObject);
begin
  SearchUnitsListChildList(vtUsesUnits, edtSearchUsesList.Text, FALSE);
end;

function TfrmMain.GetFocusedID(const VT: TVirtualStringTree): Integer;
begin
  Result := GetID(VT.FocusedNode);
end;

procedure TfrmMain.SearchUnitsListChildList(VT: TVirtualStringTree; const SearchText: String; UsedBy: Boolean);
var
  Node: PVirtualNode;
  LowerSearchText, DelphiUnitName: String;
  DelphiFile: TDelphiFile;
begin
  VT.BeginUpdate;
  try
    LowerSearchText := lowercase(SearchText);

    Node := VT.GetFirst;

    while Node <> nil do
    begin
      if UsedBy then
      begin
        DelphiUnitName := FDelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.DelphiUnitName;
        DelphiFile := FDelphiFileList[GetID(Node)];
      end
      else
      begin
        DelphiUnitName := FDelphiFileList[GetID(Node)].UnitInfo.DelphiUnitName;
        DelphiFile := FDelphiFileList[GetFocusedID(vtUnitsList)]
      end;

      VT.IsVisible[Node] := ((SearchText = '') or
                             ((pos(SearchText, LowerCase(FDelphiFileList[GetID(Node)].UnitInfo.DelphiUnitName)) <> 0))) and
                             ((FDelphiFileList[GetID(Node)].InSearchPath) or
                             ((not FDelphiFileList[GetID(Node)].InSearchPath) and (actShowUnitsNotInPath.Checked))) and
                            (IsUnitUsed(DelphiUnitName, DelphiFile));

      Node := Node.NextSibling;
    end;

    VT.Invalidate;
  finally
    VT.EndUpdate;
  end;
end;

procedure TfrmMain.SaveProjectSettings(const Filename: String);
begin
  if Filename <> '' then
  begin
    FProjectSettings.SaveToFile(Filename);

    Modified := FALSE;
  end;
end;

procedure TfrmMain.SaveSettings;
begin
  FEnvironmentSettings.StatusLogHeight := pnlLog.Height;
  FEnvironmentSettings.TreeWidth := pnlTree.Width;
  FEnvironmentSettings.ListWidth := pnlList.Width;
  FEnvironmentSettings.ShowUnitsNotInPath := actShowUnitsNotInPath.Checked;
  FEnvironmentSettings.LoadLastProject := FLoadLastProject;
  FEnvironmentSettings.ProjectFilename := FProjectFilename;
  FEnvironmentSettings.RunScanOnLoad := FRunScanOnLoad;

  FEnvironmentSettings.WindowLeft := Left;
  FEnvironmentSettings.WindowTop := Top;
  FEnvironmentSettings.WindowWidth := Width;
  FEnvironmentSettings.WindowHeight := Height;

  FEnvironmentSettings.WindowState := Integer(WindowState);

  ForceDirectories(ExtractFileDir(GetSettingsFilename));
  FEnvironmentSettings.SaveToFile(GetSettingsFilename);
end;

procedure TfrmMain.SearchList(VT: TVirtualStringTree; const SearchText: String);
var
  Node: PVirtualNode;
  LowerSearchText: String;
  DelphiFile: TDelphiFile;
begin
  VT.BeginUpdate;
  try
    LowerSearchText := lowercase(SearchText);

    Node := VT.GetFirst;

    while Node <> nil do
    begin
      DelphiFile := FDelphiFileList[GetID(Node)];

      VT.IsVisible[Node] := ((SearchText = '') or
                            (((pos(LowerSearchText, LowerCase(DelphiFile.UnitInfo.DelphiUnitName)) <> 0)))) and
                            ((DelphiFile.InSearchPath) or
                             ((not DelphiFile.InSearchPath) and (actShowUnitsNotInPath.Checked)));

      Node := Node.NextSibling;
    end;

    VT.Invalidate;
  finally
    VT.EndUpdate;
  end;
end;

procedure TfrmMain.SearchTree(const SearchText: String; FromFirstNode: Boolean);
var
  Node, EndNode, ParentStepNode: PVirtualNode;
begin
  vtUnits.BeginUpdate;
  try
    FSearchText := lowercase(SearchText);

    if (vtUnits.FocusedNode = nil) or (FromFirstNode) then
    begin
      Node := vtUnits.GetFirst;

      EndNode := nil;
    end
    else
    begin
      Node := vtUnits.GetNext(vtUnits.FocusedNode);

      if Node = nil then
        Node := vtUnits.GetFirst;

      EndNode := vtUnits.GetPrevious(Node);
    end;

    while Node <> EndNode do
    begin
      if IsSearchHitNode(Node) then
      begin
        if vtUnits.IsVisible[Node] then
        begin
          vtUnits.SelectNodeEx(Node, TRUE, TRUE);

          if not FShowTermParents then
            Break;
        end;

        if FShowTermParents then
        begin
          ParentStepNode := Node.Parent;

          while ParentStepNode <> vtUnits.RootNode do
          begin
            if FNodeObjects[GetID(ParentStepNode)].SearchTermInChildren then
              Break
            else
              FNodeObjects[GetID(ParentStepNode)].SearchTermInChildren := TRUE;

            ParentStepNode := ParentStepNode.Parent;
          end;
        end;
      end
      else
        FNodeObjects[GetID(Node)].SearchTermInChildren := FALSE;

      Node := vtUnits.GetNext(Node);

      if (Node = nil) and (EndNode <> nil) then
        Node := vtUnits.GetFirst;
    end;

    vtUnits.Invalidate;
  finally
    vtUnits.EndUpdate;
  end;
end;

procedure TfrmMain.vtLogGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column <= 0) then
  begin
    case FLogEntries[Node.Index].Severity of
      LogWarning: ImageIndex := 4;
      LogError: ImageIndex := 5;
    else
      ImageIndex := 3;
    end;
  end;
end;

procedure TfrmMain.vtLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
  CellText := FLogEntries[Node.Index].Text;
end;

procedure TfrmMain.vtStatsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Stat: String;
begin
  Stat := FStats[Node.Index];

  case Column of
    0: CellText := copy(Stat, 1, pos('=', Stat) - 1);
    1: CellText := copy(Stat, pos('=', Stat) + 1, MaxInt);
  end;
end;

procedure TfrmMain.vtStatsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if Column = 0 then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];
end;

procedure TfrmMain.vtUnitsBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if IsSearchHitNode(Node) then
  begin
    EraseAction := eaColor;
    ItemColor := $008CFFFF;
  end else
  if (FNodeObjects[GetID(Node)].SearchTermInChildren) or
     ((Node.Parent <> Sender.RootNode) and
      (FNodeObjects[GetID(Node.Parent)].SearchTermInChildren)) then
  begin
    EraseAction := eaColor;
    ItemColor := $00CCFFCC;
  end;
end;

procedure TfrmMain.vtUnitsCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeObject1, NodeObject2: TNodeObject;
begin
  NodeObject1 := FNodeObjects[GetID(Node1)];
  NodeObject2 := FNodeObjects[GetID(Node2)];

  case Column of
    0: Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.DelphiUnitName, NodeObject2.DelphiFile.UnitInfo.DelphiUnitName);
    1: Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.PreviousUnitName, NodeObject2.DelphiFile.UnitInfo.PreviousUnitName);
    2: Result := CompareStr(DelphiFileTypeStrings[NodeObject1.DelphiFile.UnitInfo.DelphiFileType], DelphiFileTypeStrings[NodeObject2.DelphiFile.UnitInfo.DelphiFileType]);
    3: Result := CompareInteger(NodeObject1.DelphiFile.UnitInfo.LineCount, NodeObject2.DelphiFile.UnitInfo.LineCount);
    4: Result := CompareInteger(NodeObject1.DelphiFile.UsedCount, NodeObject2.DelphiFile.UsedCount);
    5: Result := CompareInteger(NodeObject1.DelphiFile.UnitInfo.UsedUnits.Count, NodeObject2.DelphiFile.UnitInfo.UsedUnits.Count);
    6: Result := 0;
    7: Result := CompareInteger(Integer(FNodeObjects[GetID(Node1)].CircularReference), Integer(FNodeObjects[GetID(Node2)].CircularReference));
    8: Result := CompareBoolean(FNodeObjects[GetID(Node1)].Link <> nil, FNodeObjects[GetID(Node2)].Link <> nil);
    9: Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.Filename, NodeObject2.DelphiFile.UnitInfo.Filename);
  end;

end;

procedure TfrmMain.vtUnitsDblClick(Sender: TObject);
begin
  if vtUnits.FocusedNode <> nil then
    vtUnits.SelectNodeEx(GetLinkedNode(vtUnits.FocusedNode));
end;

procedure TfrmMain.vtUnitsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdateTreeControls(Node);
end;

procedure TfrmMain.vtUnitsFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if memParentFile.Modified then
    case MessageDlg(format(StrSHasBeenModifi, [tabParentFile.Caption]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: memParentFile.Lines.SaveToFile(FNodeObjects[GetID(OldNode.Parent)].DelphiFile.UnitInfo.Filename);
      mrCancel:
        begin
          Allowed := FALSE;

          Exit;
        end;
    end;

  if memSelectedFile.Modified then
    case MessageDlg(format(StrSHasBeenModifi, [tabSelectedFile.Caption]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: memSelectedFile.Lines.SaveToFile(FNodeObjects[GetID(OldNode)].DelphiFile.UnitInfo.Filename);
      mrCancel: Allowed := FALSE;
    end;
end;

procedure TfrmMain.UpdateTreeControls(Node: PVirtualNode);
begin
  StatusBar1.Panels[0].Text := GetNodePath(Node);

  tabParentFile.TabVisible := (Node <> nil) and (Node.Parent <> vtUnits.RootNode);
  tabSelectedFile.TabVisible := (Node <> nil) and (FNodeObjects[GetID(Node)].DelphiFile.InSearchPath);

  if Node <> nil then
  begin
    pcSource.Visible := TRUE;

    if (FNodeObjects[GetID(Node)].DelphiFile.InSearchPath) and (FileExists(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename)) then
    begin
      tabSelectedFile.Caption := ExtractFileName(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename);
      memSelectedFile.Lines.LoadFromFile(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename);
      memSelectedFile.Modified := FALSE;
    end;

    if (Node.Parent <> vtUnits.RootNode) and (FileExists(FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.Filename)) then
    begin
      tabParentFile.Caption := ExtractFileName(FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.Filename);

      memParentFile.Lines.LoadFromFile(FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.Filename);

      memParentFile.SelStart := FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)].Position;  // Todo: FIX
      memParentFile.SelLength := length(FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)].DelphiUnitName);

      memParentFile.Modified := FALSE;

      pcSource.ActivePageIndex := 0;
    end;
  end
  else
    pcSource.Visible := FALSE;
end;

function TfrmMain.GetNodePath(Node: PVirtualNode): String;
begin
  Result := '';

  while (Node <> nil) and (Node <> vtUnits.RootNode) do
  begin
    if Result <> '' then
      Result := ' -> ' + Result;

    Result := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName + Result;

    Node := Node.Parent;
  end;
end;

function TfrmMain.GetUnitFilename(const DelphiUnitName: String): String;
begin
  TryGetSearchUnit(DelphiUnitName, Result, TRUE);
end;

procedure TfrmMain.vtUnitsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and
     (Column = 0) then
  begin
    case FNodeObjects[GetID(Node)].CircularReference of
      crNone: ImageIndex := 0;
      crSemiCircular: ImageIndex := 1;
      crCircular: ImageIndex := 2;
    end;
  end;
end;

procedure TfrmMain.vtUnitsGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TNodeData);
end;

function TfrmMain.GetLinkedNode(Node: PVirtualNode): PVirtualNode;
begin
  if Node = nil then
    Result := nil
  else
  begin
    Result := FNodeObjects[GetID(Node)].Link;

    if Result = nil then
      Result := Node;
  end;
end;

function TfrmMain.GetNodeIndex(const Node: PVirtualNode): Integer;
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    Result := NodeData.Index;
  end
  else
  begin
    raise Exception.Create('No node data found');
  end;
end;

procedure TfrmMain.vtUnitsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  UnitInfo: IUnitInfo;
  DelphiFile: TDelphiFile;
  ParentUnitFilename: String;
begin
  DelphiFile := FNodeObjects[GetID(Node)].DelphiFile;
  UnitInfo := DelphiFile.UnitInfo;

  if TextType = ttStatic then
  begin
    CellText := '';

    if (Node.Parent <> Sender.RootNode) and
       (Column = 0) and
       (GetNodeIndex(Node) < FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits.Count) then
    begin
      ParentUnitFilename := FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)].DelphiUnitName;

      if not SameText(ParentUnitFilename, UnitInfo.DelphiUnitName) then
        CellText := '(' + ParentUnitFilename + ')';
    end;
  end
  else
  begin
    CellText := '-';

    case Column of
      0: CellText := UnitInfo.DelphiUnitName;

      1: CellText := UnitInfo.PreviousUnitName;

      2: if DelphiFile.InSearchPath then
           CellText := DelphiFileTypeStrings[UnitInfo.DelphiFileType];

      3:  if UnitInfo.LineCount > 0 then
            CellText := IntToStr(UnitInfo.LineCount);

      4: CellText := IntToStr(DelphiFile.UsedCount);

      5: if DelphiFile.UnitInfo.UsedUnits.Count > 0 then
           CellText := IntToStr(DelphiFile.UnitInfo.UsedUnits.Count);

      6: if (DelphiFile.InSearchPath) and
            (Sender.GetNodeLevel(Node) > 0) and
            (FNodeObjects[GetID(Node)] <> nil) and
            (GetNodeIndex(Node) < FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits.Count) then
           CellText := UsesTypeStrings[FNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)].UsesType];

      7: CellText := CircularRelationshipTypeDescriptions[FNodeObjects[GetID(Node)].CircularReference];

      8: if FNodeObjects[GetID(Node)].Link <> nil then
           CellText := StrYes
         else
           CellText := StrNo;

      9: CellText := UnitInfo.Filename;
    end;
  end;
end;

procedure TfrmMain.vtCommonHeaderClick(Sender: TVTHeader;
  HitInfo: TVTHeaderHitInfo);
begin
  inherited;

  // Sort the list
  ShowHourGlass;
  try
    if Sender.SortColumn = HitInfo.Column then
    Begin
      if Sender.SortDirection = sdAscending then
        Sender.SortDirection := sdDescending
      else
        Sender.SortDirection := sdAscending;
    end
    else
    begin
      Sender.SortColumn := HitInfo.Column;
      Sender.SortDirection := sdAscending;
    end;

    Assert(Sender.Treeview.InheritsFrom(TVirtualStringTree));
    TVirtualStringTree(Sender.Treeview).Sort(nil, Sender.SortColumn, Sender.SortDirection);

    Sender.Treeview.Invalidate;
  finally
    HideHourGlass;
  end;
end;

procedure TfrmMain.vtUnitsListCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  idx1, idx2: Integer;
  DelphiFile1, DelphiFile2: TDelphiFile;
begin
  idx1 := GetID(Node1);
  idx2 := GetID(Node2);

  if (idx1 <> -1) and (idx2 <> -1) then
  begin
    DelphiFile1 := FDelphiFileList[idx1];
    DelphiFile2 := FDelphiFileList[idx2];

    case Column of
      0: Result := CompareStr(DelphiFile1.UnitInfo.DelphiUnitName, DelphiFile2.UnitInfo.DelphiUnitName);
      1: Result := CompareStr(DelphiFileTypeStrings[DelphiFile1.UnitInfo.DelphiFileType], DelphiFileTypeStrings[DelphiFile2.UnitInfo.DelphiFileType]);
      2: Result := CompareInteger(DelphiFile1.UnitInfo.LineCount, DelphiFile2.UnitInfo.LineCount);
      3: Result := CompareInteger(DelphiFile1.UsedCount, DelphiFile2.UsedCount);
      4: Result := CompareInteger(DelphiFile1.UnitInfo.UsedUnits.Count, DelphiFile2.UnitInfo.UsedUnits.Count);
      5: Result := CompareStr(DelphiFile1.UnitInfo.Filename, DelphiFile2.UnitInfo.Filename);
    end;
  end;
end;

procedure TfrmMain.vtUnitsListDblClick(Sender: TObject);
begin
  if TVirtualStringTree(Sender).FocusedNode <> nil then
  begin
    pcView.ActivePage := tabTree;

    vtUnits.SelectNodeEx(FDelphiFileList[GetFocusedID(TVirtualStringTree(Sender))].BaseNode);
    vtUnits.SetFocus;
  end;
end;

procedure TfrmMain.vtUnitsListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdateListControls(Node);
end;

function TfrmMain.IsUnitUsed(const DelphiUnitName: String; DelphiFile: TDelphiFile): Boolean;
var
  i: Integer;
begin
  Result := FALSE;

  for i := 0 to Pred(DelphiFile.UnitInfo.UsedUnits.Count) do
    if SameText(DelphiFile.UnitInfo.UsedUnits[i].DelphiUnitName, DelphiUnitName) then
    begin
      Result := TRUE;

      Break;
    end;
end;

procedure TfrmMain.UpdateListControls(Node: PVirtualNode);
var
  DelphiFile: TDelphiFile;
begin
  pcList.Visible := vtUnitsList.FocusedNode <> nil;

  if Node <> nil then
  begin
    DelphiFile := FDelphiFileList[GetFocusedID(vtUnitsList)];

    if (DelphiFile.InSearchPath) and (FileExists(DelphiFile.UnitInfo.Filename)) then
    begin
      memListFile.Lines.LoadFromFile(DelphiFile.UnitInfo.Filename);
      memListFile.Modified := FALSE;
    end;

    SearchUnitsListChildList(vtUsedUnits, edtSearchUsedByList.Text, TRUE);
    SearchUnitsListChildList(vtUsesUnits, edtSearchUsesList.Text, FALSE);
  end;
end;

procedure TfrmMain.vtUnitsListFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if memListFile.Modified then
    case MessageDlg(format(StrSHasBeenModifi, [FDelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: memListFile.Lines.SaveToFile(FDelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename);
      mrCancel: Allowed := FALSE;
    end;
end;

procedure TfrmMain.vtCommonGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column = 0) then
  begin
    ImageIndex := 0;
  end;
end;

procedure TfrmMain.vtUnitsListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  UnitInfo: IUnitInfo;
  DelphiFile: TDelphiFile;
begin
  CellText := '-';

  DelphiFile := FDelphiFileList[GetID(Node)];
  UnitInfo := DelphiFile.UnitInfo;

  case Column of
    0: CellText := UnitInfo.DelphiUnitName;
    1: if DelphiFile.InSearchPath then
         CellText := DelphiFileTypeStrings[UnitInfo.DelphiFileType];
    2:  CellText := IntToStr(UnitInfo.LineCount);
    3:  CellText := IntToStr(DelphiFile.UsedCount);
    4: CellText := IntToStr(DelphiFile.UnitInfo.UsedUnits.Count);
    5: CellText := UnitInfo.Filename;
  end;
end;

procedure TfrmMain.vtUnitsListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if (not Sender.Selected[Node]) and
     (not FDelphiFileList[GetID(Node)].InSearchPath) then
    TargetCanvas.Font.Color := clGray;
end;

procedure TfrmMain.vtUnitsListSearchComparison(Sender: TObject;
  Node: PVirtualNode; const SearchTerms: TStrings; var IsMatch: Boolean);
var
  i: Integer;
begin
  IsMatch := TRUE;

  for i := 0 to pred(SearchTerms.Count) do
    if (pos(LowerCase(SearchTerms[i]), LowerCase(FDelphiFileList[GetID(Node)].UnitInfo.DelphiUnitName)) = 0) or
       ((not actShowUnitsNotInPath.Checked) and (not FDelphiFileList[GetID(Node)].InSearchPath)) then
    begin
      IsMatch := FALSE;

      Break;
    end;
end;

procedure TfrmMain.vtUnitsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if TextType = ttStatic then
  begin
    if not Sender.Selected[Node] then
      TargetCanvas.Font.Color := clGray;
  end
  else
  begin
    if (Column = 0) and (Sender.FocusedNode = Node) and (IsSearchHitNode(Node)) then
      TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];

    if not Sender.Selected[Node] then
    begin
      if not FNodeObjects[GetID(Node)].DelphiFile.InSearchPath then
        TargetCanvas.Font.Color := clGray else
      if FNodeObjects[GetID(GetLinkedNode(Node))].DelphiFile.UnitInfo.DelphiFileType = ftUnknown then
        TargetCanvas.Font.Color := clRed;
    end;

    if Column = 0 then
    begin
      if FNodeObjects[GetID(Node)].Link <> nil then
      begin
        if not Sender.Selected[Node] then
        begin
          if FNodeObjects[GetID(Node)].DelphiFile.InSearchPath  then
            TargetCanvas.Font.Color := clBlue
          else
            TargetCanvas.Font.Color := $00FEC9B1;
        end;

        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline];
      end;
    end;
  end;
end;

function TfrmMain.IsSearchHitNode(Node: PVirtualNode): Boolean;
begin
  Result := (Node <> nil) and (pos(FSearchText, LowerCase(FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName)) > 0);
end;

procedure TfrmMain.actCloseProjectExecute(Sender: TObject);
begin
  if (CheckNotRunning) and (CheckSaveProject) then
  begin
    FProjectFilename := '';

    CloseControls;
  end;
end;

procedure TfrmMain.actCollapseAllExecute(Sender: TObject);
begin
  vtUnits.CollapseAll(nil);
end;

procedure TfrmMain.actCollapseExecute(Sender: TObject);
begin
  vtUnits.Expanded[vtUnits.FocusedNode] := False;
end;

procedure TfrmMain.actExpandExecute(Sender: TObject);
begin
  vtUnits.ExpandAll(vtUnits.FocusedNode);
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actExpandAllExecute(Sender: TObject);
begin
  ExpandAll;
end;

procedure TfrmMain.ExpandAll;
begin
  vtUnits.ExpandAll(nil);

  vtUnits.AutoFitColumns
end;

procedure TfrmMain.ActionManager1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  UpdateControls;

  Handled := TRUE;
end;

procedure TfrmMain.UpdateControls;
var
  DelphiFile: TDelphiFile;
begin
  DelphiFile := GetFocusedDelphiFile;

  actShowUnitsNotInPath.Enabled := (not FBusy) and (vtUnits.RootNodeCount > 0);
  actSaveChanges.Enabled := (not FBusy) and
                            ((memParentFile.Modified) or
                             (memSelectedFile.Modified) or
                             (memListFile.Modified));

  actRename.Enabled := (not FBusy) and
                       (DelphiFile <> nil) and
                       (DelphiFile.InSearchPath);

  actSearchAndReplace.Enabled := (not FBusy) and 
                                 (vtUnits.RootNodeCount > 0);

  actExpandAll.Enabled := (not FBusy) and (pcView.ActivePage = tabTree) and (vtUnits.RootNodeCount > 0);
  actCollapseAll.Enabled := (not FBusy) and (pcView.ActivePage = tabTree) and (vtUnits.RootNodeCount > 0);
  actExpand.Enabled := (not FBusy) and (vtUnits.FocusedNode <> nil);
  actCollapse.Enabled := (not FBusy) and (vtUnits.FocusedNode <> nil);
  actLoadProject.Enabled := not FBusy;
  actSaveProject.Enabled := (not FBusy) and (FProjectFilename <> '');
  actSaveProjectAs.Enabled := not FBusy;
  actSettings.Enabled := not FBusy;
  actCloseProject.Enabled := (pnlMain.Visible) or (FProjectFilename <> '');
  actShowFile.Enabled := DelphiFile <> nil;
  actSaveToXML.Enabled := not FBusy;
  actSaveToGephiCSV.Enabled := not FBusy;
  actSaveToGraphML.Enabled := not FBusy;
end;

procedure TfrmMain.actLoadProjectExecute(Sender: TObject);
begin
  if (OpenDialog1.Execute) and
     (CheckSaveProject) then
  begin
    if LoadProjectSettings(OpenDialog1.FileName) then
    begin
      FProjectFilename := OpenDialog1.FileName;

      SetFormCaption;
    end;
  end;
end;

procedure TfrmMain.actNewProjectExecute(Sender: TObject);
begin
  if (CheckNotRunning) and (CheckSaveProject) then
  begin
    FProjectFilename := '';

    CloseControls;

    ResetSettings;

    actSettings.Execute;
  end;
end;

procedure TfrmMain.ResetSettings;
begin
  FProjectFilename := '';
  FProjectSettings.RootFiles.Clear;
  FProjectSettings.SearchPaths.Clear;
  FProjectSettings.UnitScopeNames.Clear;
  FProjectSettings.LinkUnits := TRUE;
end;

function TfrmMain.CheckNotRunning: Boolean;
begin
  Result := not FBusy;

  if not Result then
    MessageDlg(StrPleaseStopTheCurr, mtInformation, [mbOK], 0);
end;

procedure TfrmMain.UpdateLogEntries;
begin
  vtLog.RootNodeCount := FLogEntries.Count;
  vtLog.Invalidate;

  if not vtLog.Focused then
  begin
    vtLog.ScrollIntoView(vtLog.GetLast, False);
  end;
end;

procedure TfrmMain.CloseControls;
begin
  vtUnits.Clear;
  vtUnitsList.Clear;
  vtUsedUnits.Clear;
  vtUsesUnits.Clear;
  vtStats.Clear;

  vtUnits.Header.Columns[1].Options := vtUnits.Header.Columns[1].Options - [TVTColumnOption.coVisible];

  FDelphiFileList.Clear;
  FDelphiFiles.Clear;
  FStats.Clear;
  FLogEntries.Clear;
  UpdateLogEntries;

  pnlMain.Visible := FALSE;

  SetFormCaption;
end;

procedure TfrmMain.SetFormCaption;
begin
  Caption := StrUnitDependencyScan;

  if FProjectFilename <> '' then
    Caption := Caption + ' - ' + ExtractFilenameNoExt(FProjectFilename);

  if Modified then
    Caption := Caption + '*';
end;

procedure TfrmMain.SetModified(const Value: Boolean);
begin
  FModified := Value;

  SetFormCaption;
end;

procedure TfrmMain.actRenameExecute(Sender: TObject);
begin
  RenameDelphiFileWithDialog(rtRename);
end;

function TfrmMain.GetFocusedDelphiFile: TDelphiFile;
begin
  if (vtUnits.Focused) and
     (vtUnits.FocusedNode <> nil) then
    Result := FNodeObjects[GetID(vtUnits.FocusedNode)].DelphiFile else

  if (vtUnitsList.Focused) and
     (vtUnitsList.FocusedNode <> nil) then
    Result := FDelphiFileList[GetFocusedID(vtUnitsList)] else

  if (vtUsedUnits.Focused) and
     (vtUsedUnits.FocusedNode <> nil) then
    Result := FDelphiFileList[GetFocusedID(vtUsedUnits)] else

  if (vtUsesUnits.Focused) and
     (vtUsesUnits.FocusedNode <> nil) then
    Result := FDelphiFileList[GetFocusedID(vtUsesUnits)]
  else
    Result := nil;
end;

function TfrmMain.RenameDelphiFileWithDialog(RenameType: TRenameType): Boolean;
begin
  Result := RenameDelphiFileWithDialog(GetFocusedDelphiFile, RenameType);
end;

function TfrmMain.RenameDelphiFileWithDialog(const DelphiFile: TDelphiFile; RenameType: TRenameType): Boolean;
begin
  Result := FALSE;

  case RenameType of
    rtRename:
      begin
        if DelphiFile <> nil then
        begin
          With TfrmRenameUnit.Create(Self) do
          try
            edtNewName.Text := DelphiFile.UnitInfo.DelphiUnitName;
            Caption := format(StrRenameS, [edtNewName.Text]);

            chkPromptBeforeUpdate.Checked := FEnvironmentSettings.PromptBeforeUpdate;
            chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
            chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;

            Result := ShowModal = mrOK;

            if Result then
            begin
              FEnvironmentSettings.PromptBeforeUpdate := chkPromptBeforeUpdate.Checked;
              FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
              FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;

              RenameDelphiFile(DelphiFile.UnitInfo.DelphiUnitName,
                               edtNewName.Text,
                               chkUpdateUsesClauses.Checked,
                               chkPromptBeforeUpdate.Checked,
                               chkDummyRun.Checked,
                               chkRenameHistoryFiles.Checked,
                               TRUE);
            end;
          finally
            Release;
          end;
        end;
      end;

    rtSearchAndReplace:
      begin
        With TfrmSearchAndReplace.Create(Self) do
        try
          if DelphiFile <> nil then
          begin
            edtSearch.Text := DelphiFile.UnitInfo.DelphiUnitName;
            edtReplace.Text := DelphiFile.UnitInfo.DelphiUnitName;
            edtTest.Text := DelphiFile.UnitInfo.DelphiUnitName;
          end;

          chkPromptBeforeUpdate.Checked := FEnvironmentSettings.PromptBeforeUpdate;
          chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
          chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;

          Result := ShowModal = mrOK;

          if Result then
          begin
            FEnvironmentSettings.PromptBeforeUpdate := chkPromptBeforeUpdate.Checked;
            FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
            FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;

            RenameDelphiFile(edtSearch.Text,
                             edtReplace.Text,
                             TRUE,
                             chkPromptBeforeUpdate.Checked,
                             chkDummyRun.Checked,
                             chkRenameHistoryFiles.Checked,
                             FALSE);
          end;
        finally
          Release;
        end;
      end;
  end;

  if Result then
    vtUnits.Header.Columns[1].Options := vtUnits.Header.Columns[1].Options + [TVTColumnOption.coVisible];
end;

procedure TfrmMain.RenameDelphiFile(const SearchString, ReplaceString: String; UpdateUsesClasues, PromptBeforeUpdate, DummyRun, RenameHistoryFiles, ExactMatch: Boolean);

var
  PositionOffset: Integer;
  UpdatedCount: Integer;


  function GetDelphiUnitName(Node: PVirtualNode): String;
  begin
    if FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.PreviousUnitName <> '' then
      Result := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.PreviousUnitName
    else
      Result := FNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName;
  end;

  function IsUnitNameMatch(const UnitName: String): Boolean;
  begin
    if ExactMatch then
      Result := SameText(SearchString, UnitName)
    else
      Result := TRegEx.IsMatch(UnitName, SearchString);
  end;

  function SearchAndReplaceUnitName(const UnitName: String): String;
  begin
    if IsUnitNameMatch(UnitName) then
    begin
      if ExactMatch then
        Result := StringReplace(UnitName, SearchString, ReplaceString, [rfReplaceAll, rfIgnoreCase])
      else
        Result := TRegEx.Replace(UnitName, SearchString, ReplaceString);
    end
    else
      Result := UnitName;
  end;

  function RenameMatchingFiles(const OldFilename, NewUnitName: String; const IsHistory: Boolean = FALSE): Boolean;
  var
    ScanFilenames: TObjectList<TFileInfo>;
    i: Integer;
    Filter: String;
    NewFilename, LogMsg: String;
  begin
    Result := FALSE;

    if IsHistory then
      Filter := ExtractFilename(OldFilename) + '.*'
    else
      Filter := ExtractFilenameNoExt(OldFilename) + '.*';

    ScanFilenames := ScanFiles(ExtractFileDir(OldFilename), Filter, FALSE, FALSE, TRUE);
    try
      for i := 0 to pred(ScanFilenames.Count) do
      begin
        if (not ScanFilenames[i].IsDir) and
           (SameText(ExtractFilenameNoExt(OldFilename), ExtractFilenameNoExt(ScanFilenames[i].Filename))) then
        begin
          NewFileName := IncludeTrailingPathDelimiter(ExtractFileDir(ScanFilenames[i].Filename)) + NewUnitName + ExtractFileExt(ScanFilenames[i].Filename);

          if DummyRun then
            Result := TRUE
          else
            Result := RenameFile(ScanFilenames[i].Filename, NewFilename);

          LogMsg := StrFileSRenamedTo;

          if IsHistory then
            LogMsg := StrHistory + LogMsg;

          Log(LogMsg, [ScanFilenames[i].Filename, NewFilename]);

          if (not IsHistory) and (RenameHistoryFiles) then
            RenameMatchingFiles(IncludeTrailingPathDelimiter(ExtractFileDir(OldFilename)) + '__history\' +
                                ExtractFilename(ScanFilenames[i].Filename), NewUnitName + ExtractFileExt(ScanFilenames[i].Filename), TRUE);
        end;
      end;
    finally
      FreeAndNil(ScanFilenames);
    end;
  end;

  function ReplaceUnitText(var FileText: String; const Filename, OldText, NewText: String; Position: Integer): Boolean;
  var
    CurrentText: String;
  begin
    Result := FALSE;

    if Position > 0 then
    begin
      CurrentText := copy(FileText, Position + 1, length(OldText));

      if not SameText(CurrentText, OldText) then
        Log(StrUsesClauseIn, [Filename, OldText, CurrentText], LogWarning)
      else
      begin
        Delete(FileText, Position + 1, length(OldText));

        Insert(NewText, FileText, Position  + 1);

        Result := TRUE;
      end;
    end;
  end;

  function UpdateUsesClause(Filename, OldUnitName, NewUnitName: String; Position, InFilePosition: Integer): Boolean; overload;
  var
    UpdateStrings: TStringList;
    FileText: String;
  begin
    Result := FALSE;

    UpdateStrings := TStringList.Create;
    try
      if FileExists(Filename) then
      begin
        UpdateStrings.LoadFromFile(Filename);

        FileText := UpdateStrings.Text;

        Result := ReplaceUnitText(FileText, Filename, OldUnitName, NewUnitName, InFilePosition);
        Result := ReplaceUnitText(FileText, Filename, OldUnitName, NewUnitName, Position) or Result;

        UpdateStrings.Text := FileText;

        if not DummyRun then
          UpdateStrings.SaveToFile(Filename);
      end
      else
        Log(StrUnableToFindFile, [Filename], LogWarning);
    finally
      FreeAndNil(UpdateStrings);
    end;
  end;

  function UpdateUsesClause(UpdateNode: PVirtualNode): Boolean; overload;
  var
    StepNode: PVirtualNode;
    PosOffset: Integer;
    UsedUnitInfo: IUsedUnitInfo;
    OldUnitName, NewUnitName: String;
  begin
    OldUnitName := GetDelphiUnitName(UpdateNode);
    NewUnitName := SearchAndReplaceUnitName(OldUnitName);

    Result := UpdateUsesClause(FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo.Filename,
                               OldUnitName,
                               NewUnitName,
                               FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo.UsedUnits[GetID(UpdateNode)].Position,
                               FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo.UsedUnits[GetID(UpdateNode)].InFilePosition);

    if Result then
    begin
      Log(StrUpdatedUsesClause, [OldUnitName, NewUnitName, FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo.Filename]);

      if not DummyRun then
      begin
        PosOffset := PositionOffset;

        UsedUnitInfo := FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo.UsedUnits[GetID(UpdateNode)];

        if UsedUnitInfo.InFilePosition > 0 then
        begin
          if UsedUnitInfo.Position > 0 then
            UsedUnitInfo.InFilePosition := UsedUnitInfo.InFilePosition + PosOffset;

          PosOffset := PosOffset * 2;
        end;

        StepNode := UpdateNode.NextSibling;

        while StepNode <> nil do
        begin
          UsedUnitInfo := FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo.UsedUnits[GetID(StepNode)];

          if UsedUnitInfo.Position > 0 then
            UsedUnitInfo.Position := UsedUnitInfo.Position + PosOffset;

          if UsedUnitInfo.InFilePosition > 0 then
            UsedUnitInfo.InFilePosition := UsedUnitInfo.InFilePosition + PosOffset;

          StepNode := StepNode.NextSibling;
        end;

        // Update the DelphiUnitName and positions
        FNodeObjects[GetID(UpdateNode.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(UpdateNode)].DelphiUnitName := NewUnitName;
      end;

      Inc(UpdatedCount);
    end;
  end;

  function RenameDelphiFile(DelphiFile: TDelphiFile): Boolean;
  var
    NewUnitName, NewUnitFilename, OldUnitName, OldFilename: String;
    i: Integer;
  begin
    Result := FALSE;

    // Store the name of the old unit
    OldFilename := DelphiFile.UnitInfo.Filename;
    OldUnitName := DelphiFile.UnitInfo.DelphiUnitName;

    // Generate the new unit name and filename
    NewUnitName := SearchAndReplaceUnitName(DelphiFile.UnitInfo.DelphiUnitName);
    NewUnitFilename := IncludeTrailingPathDelimiter(ExtractFileDir(DelphiFile.UnitInfo.Filename)) + NewUnitName + ExtractFileExt(DelphiFile.UnitInfo.Filename);

    // Calculate the offset for the units in the uses clauses
    PositionOffset := length(NewUnitName) - length(DelphiFile.UnitInfo.DelphiUnitName);

    // Update the unit name in the file to be renamed
    if DelphiFile.UnitInfo.DelphiUnitNamePosition = 0 then
    begin
      // We have no info about the position of the unit name in the source code.
      // Most likely due to a bug in the tokeniser.
      Log(StrUnableToRenameS, [DelphiFile.UnitInfo.DelphiUnitName]);
    end else

    // Try to rename the file
    if RenameMatchingFiles(DelphiFile.UnitInfo.Filename, NewUnitName) then
    begin
      Result := TRUE;

      // If the file was renamed, update the local file info
      if not DummyRun then
        DelphiFile.UnitInfo.Filename := NewUnitFilename;

      // Update the unitname clause
      if (DummyRun) or
         (UpdateUsesClause(DelphiFile.UnitInfo.Filename,
                           DelphiFile.UnitInfo.DelphiUnitName,
                           NewUnitName,
                           DelphiFile.UnitInfo.DelphiUnitNamePosition,
                           0)) then
      begin
        Log(StrUpdatedDelphiUnitNameIn, [DelphiFile.UnitInfo.Filename, OldUnitName, NewUnitName]);

        if not DummyRun then
        begin
          DelphiFile.UnitInfo.DelphiUnitName := NewUnitName;

          // Update the position of all the used units
          for i := 0 to pred(DelphiFile.UnitInfo.UsedUnits.Count) do
          begin
            if DelphiFile.UnitInfo.UsedUnits[i].Position > 0 then
              DelphiFile.UnitInfo.UsedUnits[i].Position :=
                DelphiFile.UnitInfo.UsedUnits[i].Position + PositionOffset;

            if DelphiFile.UnitInfo.UsedUnits[i].InFilePosition > 0 then
              DelphiFile.UnitInfo.UsedUnits[i].InFilePosition :=
                DelphiFile.UnitInfo.UsedUnits[i].InFilePosition + PositionOffset;
          end;
        end;
      end;
    end;
  end;

var
  StepNode: PVirtualNode;
  NodeDelphiUnitName,
  UpdateFilename: String;
  PreviousUnitName: String;
  FocusedNode: PVirtualNode;
begin
  ClearLog;

  // Clear PreviousUnitNames
  StepNode := vtUnits.GetFirst;

  while StepNode <> nil do
  begin
    FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.PreviousUnitName := '';

    StepNode := vtUnits.GetNext(StepNode);
  end;

  if PromptBeforeUpdate then
  begin
    pcView.ActivePage := tabTree;

    FocusedNode := vtUnits.FocusedNode;
  end
  else
    FocusedNode := nil;
  try
    UpdatedCount := 0;

    if DummyRun then
      Log(StrTHISISADUMMYRUN, LogWarning);

    // Update all the uses clauses in the files
    StepNode := vtUnits.GetFirst;

    while StepNode <> nil do
    begin
      NodeDelphiUnitName := GetDelphiUnitName(StepNode);

      // Does this name unit match?
      if IsUnitNameMatch(NodeDelphiUnitName) then
      begin
        // Get the filename for the unit
        UpdateFilename := FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.Filename;

        // Update the filename if this is the original file node
        if FNodeObjects[GetID(StepNode)].DelphiFile.BaseNode = StepNode then
        begin
          PreviousUnitName := FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.DelphiUnitName;

          if RenameDelphiFile(FNodeObjects[GetID(StepNode)].DelphiFile) then
            FNodeObjects[GetID(StepNode)].DelphiFile.UnitInfo.PreviousUnitName := PreviousUnitName;
        end;

        // Only update the uses clasuses for non root nodes
        if vtUnits.GetNodeLevel(StepNode) > 0 then
        begin
          // This is a node that needs changing
          if PromptBeforeUpdate then
          begin
            vtUnits.SelectNodeEx(StepNode);

            case MessageDlg(format(StrUpdateTheUsesClauseIn, [UpdateFilename]), mtWarning, [mbYes, mbNo, mbCancel, mbYesToAll], 0) of
              mrYes: UpdateUsesClause(StepNode);
              mrYesToAll:
                begin
                  UpdateUsesClause(StepNode);

                  PromptBeforeUpdate := FALSE;
                end;
              mrCancel: Exit;
            end;
          end
          else
            UpdateUsesClause(StepNode);
        end;
      end;

      StepNode := vtUnits.GetNext(StepNode);
    end;

    Log(StrFinishedUpdated, [UpdatedCount]);

    if DummyRun then
      Log(StrTHISWASADUMMYRUN, LogWarning);
  finally
    if FocusedNode <> nil then
      vtUnits.SelectNodeEx(FocusedNode);

    UpdateTreeControls(vtUnits.FocusedNode);
    UpdateListControls(vtUnitsList.FocusedNode);

    SearchList(vtUnitsList, edtListSearch.Text);

    vtUsedUnits.Invalidate;
  end;
end;

procedure TfrmMain.ExportToXML(const VT: TVirtualStringTree; const Filename: String);
var
  XMLDoc: TXMLDocument;
  Count: Integer;

  procedure ProcessTreeItem(const ParentNode: PVirtualNode; const ParentXMLNode: IXMLNode);
  var
    Node: PVirtualNode;
    XMLNode: IXMLNode;
    NodeObject: TNodeObject;
    DelphiFile: TDelphiFile;
  begin
    if ParentNode <> nil then
    begin
      Node := ParentNode;

      while Node <> nil do
      begin
        if VT.IsVisible[Node] then
        begin
          DelphiFile := nil;

          if VT = vtUnitsList then
          begin
            DelphiFile := FDelphiFileList[GetID(Node)];

            NodeObject := nil;
          end
          else
          begin
            NodeObject := FNodeObjects[GetID(Node)];

            if NodeObject <> nil then
              DelphiFile := NodeObject.DelphiFile;
          end;

          if DelphiFile <> nil then
          begin
            XMLNode := ParentXMLNode.AddChild('Unit');
            XMLNode.Attributes['Name'] := DelphiFile.UnitInfo.DelphiUnitName;
            XMLNode.Attributes['UsedCount'] := DelphiFile.UsedCount.ToString;
            XMLNode.Attributes['InSearchPath'] := DelphiFile.InSearchPath;
            XMLNode.Attributes['LineCount'] := DelphiFile.UnitInfo.LineCount;
            XMLNode.Attributes['UnitNameCharPosition'] := DelphiFile.UnitInfo.DelphiUnitNamePosition;
            XMLNode.Attributes['FileType'] := DelphiFileTypeStrings[DelphiFile.UnitInfo.DelphiFileType];

            if NodeObject <> nil then
            begin
              XMLNode.Attributes['IsLink'] := NodeObject.Link <> nil;
              XMLNode.Attributes['CircularReferenceType'] := CircularRelationshipTypeDescriptions[NodeObject.CircularReference];
            end;

            XMLNode.Attributes['Filename'] := DelphiFile.UnitInfo.Filename;

            Inc(Count);
          end;

          if Node.FirstChild <> nil then
            ProcessTreeItem(Node.FirstChild, XMLNode);
        end;

        Node := Node.NextSibling;
      end;
    end;
  end;

begin
  ShowHourGlass;
  try
    Count := 0;

    XMLDoc := TXMLDocument.Create(nil);

    XMLDoc.Active := TRUE;

    ProcessTreeItem(VT.GetFirst, XMLDoc.AddChild('DUDS'));

    XMLDoc.SaveToFile(Filename);
  finally
    HideHourGlass;
  end;
end;

procedure TfrmMain.actStartScanExecute(Sender: TObject);
begin
  if FProjectSettings.RootFiles.Count = 0 then
  begin
    if MessageDlg(StrYouNeedToAddAtLeastOne, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      actSettings.Execute
  end
  else
  begin
    ClearLog;
    FFiles.Clear;
    FDelphiFiles.Clear;
    ClearStats;
    FStartTime := now;
    FCancelled := FALSE;

    actStartScan.Visible := FALSE;
    actStopScan.Visible := TRUE;
    actStopScan.Enabled := TRUE;

    FBusy := TRUE;
    try
      UpdateControls;

      ShowHideControls;

      pnlMain.Visible := TRUE;

      UpdateStats(TRUE);

      Refresh;

      LoadFilesInSearchPaths;

      if not FCancelled then
        BuildDependencyTree;
    finally
      FBusy := FALSE;

      actStartScan.Visible := TRUE;
      actStopScan.Visible := FALSE;

      ShowHideControls;

      UpdateStats(TRUE);
      UpdateTreeControls(vtUnits.FocusedNode);
    end;
  end;
end;

procedure TfrmMain.ShowHideControls;
begin
  pcView.Visible := not FBusy;
  Splitter1.Visible := not FBusy;

  if FBusy then
  begin
    FpnlLogHeight := pnlLog.Height;
    pnlLog.Align := alClient;
  end
  else
  begin
    pnlLog.Align := alBottom;
    pnlLog.Height := FpnlLogHeight;
    Splitter1.Top := pnlLog.Top - 1;
  end;
end;

procedure TfrmMain.actStopScanExecute(Sender: TObject);
begin
  FCancelled := TRUE;

  actStopScan.Enabled := FALSE;
end;

procedure TfrmMain.actSaveChangesExecute(Sender: TObject);
begin
  if memParentFile.Modified then
    memParentFile.Lines.SaveToFile(FNodeObjects[GetID(vtUnits.FocusedNode.Parent)].DelphiFile.UnitInfo.Filename);

  if memSelectedFile.Modified then
    memSelectedFile.Lines.SaveToFile(FNodeObjects[GetID(vtUnits.FocusedNode.Parent)].DelphiFile.UnitInfo.Filename);

  if memListFile.Modified then
    memListFile.Lines.SaveToFile(FDelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename);

  memParentFile.Modified := FALSE;
  memSelectedFile.Modified := FALSE;
  memListFile.Modified := FALSE;
end;

procedure TfrmMain.actSaveProjectAsExecute(Sender: TObject);
begin
  SaveProjectAs;
end;

procedure TfrmMain.actSaveProjectExecute(Sender: TObject);
begin
  SaveProject;
end;

procedure TfrmMain.actSaveToGephiCSVExecute(Sender: TObject);
begin
  if SaveDialog3.Execute then
  begin
    ExportToGephi(SaveDialog3.Filename)
  end;
end;

procedure TfrmMain.actSaveToGraphMLExecute(Sender: TObject);
begin
  if SaveDialog4.Execute then
  begin
    ExportToGraphML(SaveDialog4.Filename)
  end;
end;

procedure TfrmMain.ExportToGraphML(const Filename: String);
type
  TUseSection = (
    usInterface,
    usImplementation
  );

const
  COL: array [TUseSection] of Cardinal = ($000000, $808080);

var
  n: Integer;
  xml: IXMLDocument;
  EdgeID, NodeID: Integer;
  EdgeNode1, EdgeNode2: String;
  graphml, key, graph, node, edge, line, data: IXMLNode;
  UnitName, TrimmedUnitName, ColourString: String;
  NodeDictionary: TDictionary<String, String>;
begin
  //Internally GraphML is an XML document
  xml := TXMLDocument.Create(nil);
  xml.Active := True;
  xml.Version := '1.0';
  xml.Encoding := 'UTF-8';
  xml.StandAlone := 'no';
  xml.Options := [doNodeAutoIndent];

  graphml := xml.AddChild('graphml');
  graphml.Attributes['xmlns:y'] := 'http://www.yworks.com/xml/graphml';
  graphml.Attributes['xmlns:yed'] := 'http://www.yworks.com/xml/yed/3';

  key := graphml.AddChild('key');
  key.Attributes['id'] := 'd0';
  key.Attributes['for'] := 'node';
  key.Attributes['yfiles.type'] := 'nodegraphics';

  key := graphml.AddChild('key');
  key.Attributes['id'] := 'd1';
  key.Attributes['for'] := 'edge';
  key.Attributes['yfiles.type'] := 'edgegraphics';

  graph := graphml.AddChild('graph');
  graph.Attributes['edgedefault'] := 'directed';

  EdgeID := 0;
  NodeID := 0;

  NodeDictionary := TDictionary<String, String>.Create;
  try
    // Build Dictionary
    for UnitName in FDelphiFiles.Keys do
    begin
      if (FDelphiFiles[UnitName].InSearchPath) or
         (actShowUnitsNotInPath.Checked) then
      begin
        TrimmedUnitName := Trim(FDelphiFiles[UnitName].UnitInfo.DelphiUnitName);

        node := graph.AddChild('node');
        node.Attributes['id'] := 'n' + IntToStr(NodeID);

        data := node.AddChild('data');
        data.Attributes['key'] := 'd0';
        data.AddChild('y:ShapeNode').AddChild('y:NodeLabel').Text := TrimmedUnitName;

        NodeDictionary.AddOrSetValue(UpperCase(TrimmedUnitName), 'n' + NodeID.ToString);

        Inc(NodeID);
      end;
    end;

    // Build XML
    for UnitName in FDelphiFiles.Keys do
    begin
      if (FDelphiFiles[UnitName].InSearchPath) or
         (actShowUnitsNotInPath.Checked) then
      begin
        TrimmedUnitName := Trim(FDelphiFiles[UnitName].UnitInfo.DelphiUnitName);

        for n := 0 to pred(FDelphiFiles[UnitName].UnitInfo.UsedUnits.Count) do
        begin
          if (FDelphiFiles.ContainsKey(UpperCase(FDelphiFiles[UnitName].UnitInfo.UsedUnits[n].DelphiUnitName))) and
             ((actShowUnitsNotInPath.Checked) or
              (FDelphiFiles[UpperCase(FDelphiFiles[UnitName].UnitInfo.UsedUnits[n].DelphiUnitName)].InSearchPath)) and
             (NodeDictionary.TryGetValue(UpperCase(TrimmedUnitName), EdgeNode1)) and
             (NodeDictionary.TryGetValue(UpperCase(Trim(FDelphiFiles[UnitName].UnitInfo.UsedUnits[n].DelphiUnitName)), EdgeNode2)) then
          begin
            edge := graph.AddChild('edge');
            edge.Attributes['id'] := 'e' + IntToStr(EdgeID);
            edge.Attributes['source'] := EdgeNode1;
            edge.Attributes['target'] := EdgeNode2;

            data := edge.AddChild('data');
            data.Attributes['key'] := 'd1';
            line := data.AddChild('y:PolyLineEdge');

            case FDelphiFiles[UnitName].UnitInfo.UsedUnits[n].UsesType of
              utImplementation: ColourString := '000000'
            else
              ColourString := '808080';
            end;

            line.AddChild('y:LineStyle').Attributes['color'] := '#' + ColourString;
            line.AddChild('y:Arrows').Attributes['target'] := 'standard';

            Inc(EdgeID);
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(NodeDictionary);
  end;

  xml.SaveToFile(Filename);
  xml.Active := False;
end;

procedure TfrmMain.ExportToGephi(const Filename: String);
var
  Lines: TStringList;
  CurrentLine: String;
  UnitName, TrimmedUnitName: String;
  n: Integer;
begin
  Lines := TStringList.Create;
  try
    for UnitName in FDelphiFiles.Keys do
    begin
      if (FDelphiFiles[UnitName].InSearchPath) or
         (actShowUnitsNotInPath.Checked) then
      begin
        TrimmedUnitName := Trim(FDelphiFiles[UnitName].UnitInfo.DelphiUnitName);

        CurrentLine := TrimmedUnitName;

        for n := 0 to pred(FDelphiFiles[UnitName].UnitInfo.UsedUnits.Count) do
        begin
          if (FDelphiFiles.ContainsKey(UpperCase(FDelphiFiles[UnitName].UnitInfo.UsedUnits[n].DelphiUnitName))) and
             ((actShowUnitsNotInPath.Checked) or
              (FDelphiFiles[UpperCase(FDelphiFiles[UnitName].UnitInfo.UsedUnits[n].DelphiUnitName)].InSearchPath)) then
          begin
            AddToken(CurrentLine, Trim(FDelphiFiles[UnitName].UnitInfo.UsedUnits[n].DelphiUnitName), ';');
          end;
        end;

        Lines.Add(CurrentLine);
      end;
    end;

    Lines.SaveToFile(Filename);
  finally
    FreeAndNil(Lines);
  end;
end;

procedure TfrmMain.actSaveToXMLExecute(Sender: TObject);
begin
  if SaveDialog2.Execute then
  begin
    if pcView.ActivePage = tabTree then
      ExportToXML(vtUnits, SaveDialog2.Filename)
    else
      ExportToXML(vtUnitsList, SaveDialog2.Filename)
  end;
end;

function TfrmMain.SaveProject: Boolean;
begin
  if FProjectFilename = '' then
    Result := SaveProjectAs
  else
  begin
    SaveProjectSettings(FProjectFilename);

    Result := TRUE;
  end;
end;

function TfrmMain.SaveProjectAs: Boolean;
begin
  Result := SaveDialog1.Execute;

  if Result then
  begin
    FProjectFilename := SaveDialog1.FileName;

    SaveProjectSettings(FProjectFilename);
  end;
end;

procedure TfrmMain.actSearchAndReplaceExecute(Sender: TObject);
begin
  RenameDelphiFileWithDialog(rtSearchAndReplace);
end;

procedure TfrmMain.actSettingsExecute(Sender: TObject);
begin
  With TfrmDependencyScannerSetting.Create(Self) do
  try
    SaveProjectSettings;

    if Execute(FEnvironmentSettings, FProjectSettings) then
    begin
      LoadProjectSettings('', FALSE);

      Modified := TRUE;
    end;
  finally
    Release;
  end;
end;

procedure TfrmMain.actShowFileExecute(Sender: TObject);
var
  DelphiFile: TDelphiFile;
begin
  DelphiFile := GetFocusedDelphiFile;

  if DelphiFile <> nil then
    ShellExecute(Handle,
                 'OPEN',
                 PChar('explorer.exe'),
                 PChar('/select, "' + DelphiFile.UnitInfo.Filename + '"'),
                 nil,
                 SW_NORMAL) ;
end;

procedure TfrmMain.actShowUnitsNotInPathExecute(Sender: TObject);
begin
  ShowUnitsNotInPath;
end;

procedure TfrmMain.SetNodeVisibility(VT: TVirtualStringTree; Node: PVirtualNode; DelphiFile: TDelphiFile);
begin
  if (Node <> nil) and (DelphiFile <> nil) then
    VT.IsVisible[Node] := (DelphiFile.InSearchPath) or
                          ((not DelphiFile.InSearchPath) and (actShowUnitsNotInPath.Checked));
end;

procedure TfrmMain.ShowUnitsNotInPath;
var
  Node: PVirtualNode;
begin
  vtUnits.BeginUpdate;
  try
    Node := vtUnits.GetFirst;

    while Node <> nil do
    begin
      SetNodeVisibility(vtUnits, Node, FNodeObjects[GetID(Node)].DelphiFile);

      Node := vtUnits.GetNext(Node);
    end;

    if vtUnits.FocusedNode <> nil then
      vtUnits.ScrollIntoView(vtUnits.FocusedNode, TRUE);
  finally
    vtUnits.EndUpdate;
  end;

  vtUnitsList.BeginUpdate;
  try
    Node := vtUnitsList.GetFirst;

    while Node <> nil do
    begin
      SetNodeVisibility(vtUnitsList, Node, FDelphiFileList[GetID(Node)]);

      Node := Node.NextSibling;
    end;

    if vtUnitsList.FocusedNode <> nil then
      vtUnitsList.ScrollIntoView(vtUnitsList.FocusedNode, TRUE);
  finally
    vtUnitsList.EndUpdate;
  end;
end;

procedure TfrmMain.tmrCloseTimer(Sender: TObject);
begin
  tmrClose.Enabled := FALSE;

  if not FBusy then
  begin
    FClosing := TRUE;

    Close;
  end;
end;

procedure TfrmMain.tmrLoadedTimer(Sender: TObject);
begin
  tmrLoaded.Enabled := FALSE;

  if FLoadLastProject then
  begin
    if not LoadProjectSettings(FProjectFilename) then
    begin
      FProjectFilename := '';

      CloseControls;
    end;
  end;

  Show;
end;

function TfrmMain.CreateDelphiFile(const DelphiUnitName: String): TDelphiFile;
begin
  Result := TDelphiFile.Create;

  FDelphiFiles.Add(UpperCase(DelphiUnitName), Result);
  FDelphiFileList.Add(Result);
end;

function TfrmMain.FindParsedDelphiUnit(const DelphiUnitName: string): TDelphiFile;
begin
  FDelphiFiles.TryGetValue(UpperCase(DelphiUnitName), Result);
end;

procedure TfrmMain.FixDPI;

  procedure ScaleVT(const VT: TVirtualStringTree);
  begin
    VT.DefaultNodeHeight := ScaleDimension(VT.DefaultNodeHeight, PixelsPerInch);
    VT.Header.Height := ScaleDimension(VT.Header.Height, PixelsPerInch);
    VT.Header.Font.Size := ScaleDimension(VT.Header.Font.Size, PixelsPerInch);
  end;

begin
  ScaleVT(vtUnits);
  ScaleVT(vtUnitsList);
  ScaleVT(vtUsedUnits);
  ScaleVT(vtUsesUnits);

  StatusBar1.Height := ScaleDimension(StatusBar1.Height, PixelsPerInch);
end;

procedure TfrmMain.BuildDependencyTree(NoLog: Boolean);

  procedure ExtractUnits(var UnitString: String; Units: TStringList);
  var
    UnitList: String;
  begin
    UnitList := NextBlock(UnitString, ';');

    while UnitList <> '' do
      Units.Add(NextBlock(UnitList, ','));
  end;

  function GetParentCircularRelationship(TreeNode: PVirtualNode; const DelphiUnitName: String): TCircularRelationshipType;
  var
    i: Integer;
    UsedUnitType: TUsedUnitType;
  begin
    Result := crNone;

    if TreeNode <> nil then
    begin
      TreeNode := TreeNode.Parent;

      if (TreeNode <> nil) and
         (TreeNode <> vtUnits.RootNode) then
      begin
        UsedUnitType := utImplementation;

        if FNodeObjects[GetID(TreeNode)] <> nil then
        begin
          for i := 0 to pred(FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.UsedUnits.Count) do
          begin
            if SameText(FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.UsedUnits[i].DelphiUnitName, DelphiUnitName) then
            begin
              UsedUnitType := FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.UsedUnits[i].UsesType;

              Break;
            end;
          end;
        end;

        while (TreeNode <> nil) and
              (TreeNode <> vtUnits.RootNode) do
        begin
          if SameText(FNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.DelphiUnitName, DelphiUnitName) then
          begin
            if UsedUnitType = utInterface then
              Result := crCircular
            else
              Result := crSemiCircular;

            Break;
          end
          else
            TreeNode := TreeNode.Parent;
        end;
      end;
    end;
  end;

  function AddUnitNode(Parent: PVirtualNode; UnitInfo: IUnitInfo; InPath: Boolean): PVirtualNode;
  var
    DelphiFile: TDelphiFile;
    ListNode, NewNode: PVirtualNode;
    NodeObject: TNodeObject;
  begin
    NodeObject := TNodeObject.Create;
    Result := vtUnits.AddChild(Parent);
    SetID(Result, FNodeObjects.Add(NodeObject));

    ListNode := nil;

    DelphiFile := FindParsedDelphiUnit(UnitInfo.DelphiUnitName);

    if DelphiFile = nil then
    begin
      DelphiFile := CreateDelphiFile(UnitInfo.DelphiUnitName);

      DelphiFile.UnitInfo := UnitInfo;

      if FScanDepth = 1 then
        DelphiFile.UsedCount := 0
      else
        DelphiFile.UsedCount := 1;

      DelphiFile.InSearchPath := InPath;
      DelphiFile.BaseNode := Result;

      ListNode := vtUnitsList.AddChild(nil);
      SetID(ListNode, pred(FDelphiFiles.Count));

      NewNode := vtUsedUnits.AddChild(nil);
      SetID(NewNode, pred(FDelphiFiles.Count));

      NewNode := vtUsesUnits.AddChild(nil);
      SetID(NewNode, pred(FDelphiFiles.Count));

      FLineCount := FLineCount + UnitInfo.LineCount;
    end
    else
    begin
      DelphiFile.UsedCount := DelphiFile.UsedCount + 1;

      if FProjectSettings.LinkUnits then
        FNodeObjects[GetID(Result)].Link := DelphiFile.BaseNode;
    end;

    FNodeObjects[GetID(Result)].DelphiFile := DelphiFile;
    FNodeObjects[GetID(Result)].CircularReference := GetParentCircularRelationship(Result, UnitInfo.DelphiUnitName);

    SetNodeVisibility(vtUnits, Result, DelphiFile);

    if ListNode <> nil then
      SetNodeVisibility(vtUnitsList, ListNode, DelphiFile);
  end;

  procedure BuildDependencyTreeRec(Parent: PVirtualNode; UsedUnitInfo: IUsedUnitInfo);
  var
    i: Integer;
    Node: PVirtualNode;
    UnitFilename: String;
    InPath: Boolean;
    Parsed: Boolean;
    UnitInfo: IUnitInfo;
    DelphiFile: TDelphiFile;
  begin
    Application.ProcessMessages;

    if not FCancelled then
    begin
      UpdateStats(FALSE);

      Inc(FScannedFiles);
      Inc(FScanDepth);

      if FScanDepth > FDeppestScanDepth then
        FDeppestScanDepth := FScanDepth;
      UnitFilename := GetUnitFilename(UsedUnitInfo.DelphiUnitName);

      InPath := UnitFilename <> '';
      Parsed := FALSE;

      // Parse the unit
      if InPath then
      begin
        DelphiFile := FindParsedDelphiUnit(UsedUnitInfo.DelphiUnitName);

        if DelphiFile = nil then
        begin
          try
            Parsed := FPascalUnitExtractor.GetUsedUnits(UnitFilename, UnitInfo);

            for i := 0 to pred(UnitInfo.UsedUnits.Count) do
              if UnitInfo.UsedUnits[i].Filename <> '' then
                FFiles.AddOrSetValue(UpperCase(UnitInfo.UsedUnits[i].DelphiUnitName), UnitInfo.UsedUnits[i].Filename);

            Inc(FParsedFileCount);

            if FileExists(ChangeFileExt(Unitinfo.Filename, '.dfm')) then
              inc(FVCLFormCount) else
            if FileExists(ChangeFileExt(Unitinfo.Filename, '.fmx')) then
              inc(FFMXFormCount);
          except
            on e: Exception do
            begin
              Log(StrUnableToParseS, [UnitFilename, e.Message], LogError);
            end;
          end;
        end
        else
          UnitInfo := DelphiFile.UnitInfo;
      end
      else
      begin
        UnitInfo := TUnitInfo.Create;
        UnitInfo.DelphiUnitName := UsedUnitInfo.DelphiUnitName;
      end;

      Node := AddUnitNode(Parent, UnitInfo, InPath);

      FLastScanNode := Node;

      if (not FCancelled) and
         (Parsed) and
         (InPath) and
         (FNodeObjects[GetID(Node)].CircularReference = crNone) and
         (FNodeObjects[GetID(Node)].Link = nil) then
      begin
        for i := 0 to pred(UnitInfo.UsedUnits.Count) do
          BuildDependencyTreeRec(Node, UnitInfo.UsedUnits[i]);
      end;
    end;

    if FScanDepth > 0 then
      Dec(FScanDepth);
  end;

var
  RootUnitInfo: IUsedUnitInfo;
  i: Integer;
begin
  vtUnits.Clear;
  vtUnitsList.Clear;
  vtUsedUnits.Clear;
  vtUsesUnits.Clear;
  memParentFile.Clear;
  memSelectedFile.Clear;

  Log(StrParsingFiles);

  vtUnits.BeginUpdate;
  vtUnitsList.BeginUpdate;
  vtUsedUnits.BeginUpdate;
  vtUsesUnits.BeginUpdate;
  try
    FDelphiFiles.Clear;
    FDelphiFileList.Clear;

    for i := 0 to pred(FProjectSettings.RootFiles.Count) do
    begin
      if FCancelled then
        Break;

      if not FileExists(FProjectSettings.RootFiles[i]) then
        Log(StrRootFileNotFound, [FProjectSettings.RootFiles[i]], LogWarning)
      else
      begin
        RootUnitInfo := TUsedUnitInfo.Create;
        RootUnitInfo.DelphiUnitName := ExtractFilenameNoExt(FProjectSettings.RootFiles[i]);

        BuildDependencyTreeRec(nil, RootUnitInfo);
      end;
    end;

   if vtUnits.FocusedNode = nil then
      vtUnits.SelectNodeEx(vtUnits.GetFirst);

   if vtUnitsList.FocusedNode = nil then
      vtUnitsList.SelectNodeEx(vtUnitsList.GetFirst);

    Log(StrDFilesWithATo, [FDelphiFiles.Count, FLineCount]);
  finally
    ExpandAll;

    vtUnits.EndUpdate;
    vtUnitsList.EndUpdate;
    vtUsedUnits.EndUpdate;
    vtUsesUnits.EndUpdate;

    FLastScanNode := nil;

    UpdateListControls(vtUnitsList.FocusedNode);

    UpdateStats(TRUE);
  end;
end;

procedure TfrmMain.ClearStats;
begin
  FScannedFiles := 0;
  FParsedFileCount := 0;
  FLineCount := 0;
  FDeppestScanDepth := 0;
  FScanDepth := 0;
  FFMXFormCount := 0;
  FVCLFormCount := 0;
  FLastScanNode := nil;
end;

procedure TfrmMain.UpdateStats(ForceUpdate: Boolean);

var
  Index: Integer;

  procedure AddStat(const StatName: String; StatValue: Variant);
  begin
    if Index > FStats.Count - 1 then
      FStats.Add('');

    FStats[Index] := StatName + '=' + VarToStr(StatValue);

    Inc(Index);
  end;

begin
  if (not (FClosing)) and
     ((ForceUpdate) or
      (FNextStatusUpdate = 0) or
      (now > FNextStatusUpdate)) then
  begin
    FNextStatusUpdate := now + (50 * OneMilliSecond);

    Index := 0;

    AddStat(StrTime, SecondsToTimeString(SecondsBetween(now, FStartTime)));
    AddStat(StrScannedFiles, FormatCardinal(FScannedFiles));
    AddStat(StrFilesFound, FormatCardinal(FDelphiFiles.Count));
    AddStat(StrParsedFiles, FormatCardinal(FParsedFileCount));
    AddStat(StrVCLFormCount, FormatCardinal(FVCLFormCount));
    AddStat(StrFMXFormCount, FormatCardinal(FFMXFormCount));
    AddStat(StrTotalLines, FormatCardinal(FLineCount));
    AddStat(StrSearchPathFiles, FormatCardinal(FFiles.Count));
    AddStat(StrDeepestScanDepth, FDeppestScanDepth);

    if FBusy then
    begin
      AddStat(StrScanDepth, FScanDepth);

      StatusBar1.Panels[0].Text := GetNodePath(FLastScanNode);
    end;

    while Index < FStats.Count do
      FStats.Delete(pred(FStats.Count));

    vtStats.RootNodeCount := FStats.Count;
    vtStats.Invalidate;
  end;
end;

end.
