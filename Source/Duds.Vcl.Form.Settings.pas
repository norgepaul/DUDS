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

unit Duds.Vcl.Form.Settings;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  System.Types, System.UITypes,

  Xml.XmlDoc, Xml.XmlIntf,

  Winapi.Windows, Winapi.Messages, System.Win.Registry,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  {$WARN UNIT_PLATFORM OFF}Vcl.FileCtrl,{$WARN UNIT_PLATFORM ON}

  Duds.Common.Delphi,
  Duds.Common.Strings,
  Duds.Common.Files,
  Duds.Common.Interfaces,
  Duds.Common.Classes,

  Duds.Vcl.Utils;

type
  TfrmDependencyScannerSetting = class(TForm)
    pcSettings: TPageControl;
    Panel1: TPanel;
    tabRootFiles: TTabSheet;
    tabSearchPaths: TTabSheet;
    OpenDialog1: TOpenDialog;
    popDelphiPaths: TPopupMenu;
    miWindowsPaths: TMenuItem;
    N2: TMenuItem;
    miDelphiXE1: TMenuItem;
    miDelphiXE2: TMenuItem;
    miDelphiXE3: TMenuItem;
    Panel4: TPanel;
    btnAddFile: TButton;
    chkIncludeProjectSearchPaths: TCheckBox;
    Panel2: TPanel;
    btnAddPath: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    pnlFTSInfo: TPanel;
    Panel14: TPanel;
    tabEnvironment: TTabSheet;
    chkLoadLastProject: TCheckBox;
    tabScan: TTabSheet;
    chkLinkUnits: TCheckBox;
    chkRecursive: TCheckBox;
    tabUnitScopes: TTabSheet;
    btnScanForProjects: TButton;
    chkRunScanOnLoad: TCheckBox;
    memRootFiles: TRichEdit;
    memSearchPaths: TRichEdit;
    memUnitScopeNames: TRichEdit;
    lblStatus: TLabel;
    miDelphiXE41: TMenuItem;
    DelphiXE51: TMenuItem;
    DelphiXE61: TMenuItem;
    DelphiXE71: TMenuItem;
    lnkFTSInfo: TLabel;
    procedure btnAddFileClick(Sender: TObject);
    procedure btnAddPathClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miWindowsPathsClick(Sender: TObject);
    procedure miDelphiXE3Click(Sender: TObject);
    procedure OnSettingChange(Sender: TObject);
    procedure btnScanForProjectsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FEnvironmentSettings: TEnvironmentSettings;
    FProjectSettings: TProjectSettings;
    FSearchPathBrowseDir: String;
    FModified: Boolean;
    FProjectScanBrowseDir: String;
    FBusy: Boolean;
    FCancelled: Boolean;
    FIgnoreAllErrors: Boolean;

    procedure SettingsToGUI;
    procedure GUIToSettings;
    function AddGroupProjectRootFiles(const Filename: string): Boolean;
    procedure AddProjectLibraryPaths(const Filename: String);
    function AddRootProjectFile(const Filename: String): Boolean;
    function AddSearchPath(const SearchPath: String): Boolean;
    procedure AddDelphiSearchPaths(SearchPaths: TStrings; Version: Integer);
    procedure SetDelphiMenuItemVisibility;
    procedure EnableControls(DoEnable: Boolean);
  public
    function Execute(const EnvironmentSettings: TEnvironmentSettings; const ProjectSettings: TProjectSettings): Boolean;
  end;

var
  frmDependencyScannerSetting: TfrmDependencyScannerSetting;

implementation

resourcestring
  StrSelectAPath = 'Select a Path';
  StrPleaseEnterAtLeas = 'Please enter at least one root file.';
  StrFindingFilesAndDirs = 'Finding files and directories...';
  StrFound = 'Found ';
  StrAnErrorOccurredLoading = 'An error occurred loading "%s".';

{$R *.dfm}

procedure TfrmDependencyScannerSetting.btnAddFileClick(Sender: TObject);
var
  i: Integer;
begin
  if OpenDialog1.Execute then
  begin
    EnableControls(FALSE);
    memRootFiles.Lines.BeginUpdate;
    try
      for i := 0 to pred(OpenDialog1.Files.Count) do
        if not FCancelled then
          AddRootProjectFile(OpenDialog1.Files[i]);
    finally
      memRootFiles.Lines.EndUpdate;

      EnableControls(TRUE);
    end;
  end;
end;

procedure TfrmDependencyScannerSetting.btnAddPathClick(Sender: TObject);
var
  aScrPt, aClientPt: TPoint ;
begin
  // Display the popup menu at the lower left of the button
  aClientPt := Point(0, btnAddPath.height) ;
  aScrPt := btnAddPath.ClientToScreen(aClientpt) ;
  popDelphiPaths.Popup(aScrPt.X, aScrPt.Y) ;
end;

procedure TfrmDependencyScannerSetting.btnOKClick(Sender: TObject);
begin
  if memRootFiles.Text = '' then
    ShowMessage(StrPleaseEnterAtLeas)
  else
    ModalResult := mrOK;
end;

procedure TfrmDependencyScannerSetting.btnScanForProjectsClick(Sender: TObject);
var
  ScannedFiles: TObjectList<TFileInfo>;
  i: Integer;
begin
  if SelectDirectory(StrSelectAPath, '', FProjectScanBrowseDir, [sdNewFolder, sdNewUI], Self) then
  begin
    EnableControls(FALSE);
    try
      lblStatus.Caption := StrFindingFilesAndDirs;

      Application.ProcessMessages;

      ScannedFiles := ScanFiles(FProjectScanBrowseDir, '*.*', TRUE, TRUE, TRUE);
      try
        for i := 0 to pred(ScannedFiles.Count) do
        begin
          if FCancelled then
            Break;

          if not ScannedFiles[i].IsDir then
          begin
            if i mod 20 = 0 then
              lblStatus.Caption := ScannedFiles[i].Filename;

            if ((SameText(ExtractFileExt(ScannedFiles[i].Filename), '.dpr') or
                (SameText(ExtractFileExt(ScannedFiles[i].Filename), '.dpk')))) then
            begin
              lblStatus.Caption := StrFound + ScannedFiles[i].Filename;

              AddRootProjectFile(ScannedFiles[i].Filename);
            end;
          end;

          Application.ProcessMessages;
        end;
      finally
        FreeAndNil(ScannedFiles);
      end;
    finally
      EnableControls(TRUE);
    end;
  end;
end;

procedure TfrmDependencyScannerSetting.btnCancelClick(Sender: TObject);
begin
  if FBusy then
    FCancelled := TRUE
  else
    ModalResult := mrCancel;
end;

procedure TfrmDependencyScannerSetting.miDelphiXE3Click(Sender: TObject);
begin
  AddDelphiSearchPaths(memSearchPaths.Lines, TMenuItem(Sender).Tag);
end;

procedure TfrmDependencyScannerSetting.EnableControls(DoEnable: Boolean);
begin
  FCancelled := FALSE;
  FIgnoreAllErrors := FALSE;

  EnableControlAndChildren(pcSettings, DoEnable);

  btnOK.Enabled := DoEnable;

  FBusy := not DoEnable;

  lblStatus.Caption := '';
end;

function TfrmDependencyScannerSetting.Execute(
  const EnvironmentSettings: TEnvironmentSettings; const ProjectSettings: TProjectSettings): Boolean;
begin
  FEnvironmentSettings := EnvironmentSettings;
  FProjectSettings := ProjectSettings;

  SettingsToGUI;

  FModified := FALSE;

  Result := (ShowModal = mrOK) and (FModified);

  if Result then
    GUIToSettings;
end;

procedure TfrmDependencyScannerSetting.SettingsToGUI;
begin
  (*chkLoadLastProject.Checked := FEnvironmentSettings.ReadBoolean('LoadLastProject', chkLoadLastProject.Checked);
  chkRunScanOnLoad.Checked := FEnvironmentSettings.ReadBoolean('RunScanOnLoad', chkLoadLastProject.Checked);

  FSearchPathBrowseDir := FEnvironmentSettings.ReadString('SearchPathBrowseDir', FSearchPathBrowseDir);
  FProjectScanBrowseDir := FEnvironmentSettings.ReadString('ProjectScanBrowseDir', FProjectScanBrowseDir);
    *)
  chkLinkUnits.Checked := FProjectSettings.LinkUnits;
  memRootFiles.Lines.Assign(FProjectSettings.RootFiles);
  memSearchPaths.Lines.Assign(FProjectSettings.SearchPaths);
  memUnitScopeNames.Lines.Assign(FProjectSettings.UnitScopeNames);
end;

procedure TfrmDependencyScannerSetting.GUIToSettings;
begin
  (*FEnvironmentSettings.WriteBoolean('LoadLastProject', chkLoadLastProject.Checked);
  FEnvironmentSettings.WriteBoolean('RunScanOnLoad', chkLoadLastProject.Checked);

  FEnvironmentSettings.WriteString('SearchPathBrowseDir', FSearchPathBrowseDir);
  FEnvironmentSettings.WriteString('ProjectScanBrowseDir', FProjectScanBrowseDir);
    *)
  FProjectSettings.LinkUnits := chkLinkUnits.Checked;
  FProjectSettings.RootFiles.Assign(memRootFiles.Lines);
  FProjectSettings.SearchPaths.Assign(memSearchPaths.Lines);
  FProjectSettings.UnitScopeNames.Assign(memUnitScopeNames.Lines);
end;

procedure TfrmDependencyScannerSetting.miWindowsPathsClick(Sender: TObject);
begin
  if SelectDirectory(StrSelectAPath, '', FSearchPathBrowseDir, [sdNewFolder, sdNewUI], Self) then
    AddSearchPath(FSearchPathBrowseDir);
end;

procedure TfrmDependencyScannerSetting.OnSettingChange(Sender: TObject);
begin
  FModified := TRUE;
end;

procedure TfrmDependencyScannerSetting.FormCreate(Sender: TObject);
begin
  pcSettings.ActivePageIndex := 0;

  SetDelphiMenuItemVisibility;
end;

function TfrmDependencyScannerSetting.AddSearchPath(const SearchPath: String): Boolean;

  procedure AddSearchPathRec(const RecSearchPath: String; var Added: Boolean);
  var
    ScannedFiles: TObjectList<TFileInfo>;
    i: Integer;
  begin
    Added := (memSearchPaths.Lines.IndexOf(RecSearchPath) = -1) and
             (System.SysUtils.DirectoryExists(RecSearchPath));

    if Added then
      memSearchPaths.Lines.Add(RecSearchPath);

    if chkRecursive.Checked then
    begin
      ScannedFiles := ScanFiles(RecSearchPath, '*.*', FALSE, TRUE, TRUE);
      try
        for i := 0 to pred(ScannedFiles.Count) do
        begin
          if FCancelled then
            Break;

          if ScannedFiles[i].IsDir then
            AddSearchPathRec(ScannedFiles[i].Filename, Added);
        end;
      finally
        FreeAndNil(ScannedFiles);
      end;
    end;
  end;

begin
  memSearchPaths.Lines.BeginUpdate;
  try
    AddSearchPathRec(SearchPath, Result);
  finally
    memSearchPaths.Lines.EndUpdate;
  end;
end;

procedure TfrmDependencyScannerSetting.AddDelphiSearchPaths(SearchPaths: TStrings; Version: Integer);
var
  DelphiPaths: TStringList;
  i: Integer;
begin
  DelphiPaths := TStringList.Create;
  try
    GetDelphiLibraryPaths(Version, DelphiPaths);

    SearchPaths.BeginUpdate;
    try
      // Add the paths that exist
      for i := 0 to pred(DelphiPaths.Count) do
      begin
        if (SearchPaths.IndexOf(DelphiPaths[i]) = -1) and (System.SysUtils.DirectoryExists(DelphiPaths[i])) then
          AddSearchPath(DelphiPaths[i]);
      end;
    finally
      SearchPaths.EndUpdate;
    end;
  finally
    FreeAndNil(DelphiPaths);
  end;
end;

procedure TfrmDependencyScannerSetting.SetDelphiMenuItemVisibility;
var
  i: Integer;
begin
  for i := 0 to pred(popDelphiPaths.Items.Count) do
    if popDelphiPaths.Items[i].Tag > 0 then
      popDelphiPaths.Items[i].Visible := IsDelphiVersionInstalled(popDelphiPaths.Items[i].Tag);
end;

function TfrmDependencyScannerSetting.AddGroupProjectRootFiles(const Filename: string): Boolean;
var
  XML: IXMLDocument;
  XMLNode: IXMLNode;
  i: Integer;
  ProjectFilename: String;
begin
  Result := FALSE;

  try
    XML := TXMLDocument.Create(Self);

    XML.LoadFromFile(Filename);

    XMLNode := XML.DocumentElement.ChildNodes.FindNode('ItemGroup');

    if XMLNode <> nil then
    begin
      for i := 0 to pred(XMLNode.ChildNodes.Count) do
        if (SameText(XMLNode.ChildNodes[i].NodeName, 'Projects')) and
           (XMLNode.ChildNodes[i].Attributes['Include'] <> NULL) then
        begin
          ProjectFilename := IncludeTrailingPathDelimiter(ExtractFileDir(Filename)) + XMLNode.ChildNodes[i].Attributes['Include'];

          ProjectFilename := ChangeFileExt(ProjectFilename, '.dpr');

          if AddRootProjectFile(ProjectFilename) then
            Result := TRUE;
        end;
    end;
  except
    on e: Exception do
    begin
      if not FIgnoreAllErrors then
        case MessageDlg(format(StrAnErrorOccurredLoading, [Filename]), mtError, [mbIgnore, mbAll, mbCancel], 0) of
          mrAll: FIgnoreAllErrors := TRUE;
          mrCancel: FCancelled := TRUE;
        end;
    end;
  end;
end;

function TfrmDependencyScannerSetting.AddRootProjectFile(const Filename: String): Boolean;
var
  Extension: String;
begin
  if SameText(ExtractFileExt(Filename), '.groupproj') then
    Result := AddGroupProjectRootFiles(Filename)
  else
  begin
    Result := (FileExists(Filename)) and (memRootFiles.Lines.IndexOf(FileName) = -1);

    if Result then
      memRootFiles.Lines.Add(ExpandFileName(FileName));

    Extension := ExtractFileExt(Filename);

    if chkIncludeProjectSearchPaths.Checked then
    begin
      if SameText(Extension, '.dpr') then
        AddProjectLibraryPaths(ChangeFileExt(Filename, '.dproj')) else
      if SameText(Extension, '.dproj') then
        AddProjectLibraryPaths(Filename);
    end;
  end;
end;

procedure TfrmDependencyScannerSetting.AddProjectLibraryPaths(const Filename: String);
var
  XML: IXMLDocument;
  XMLNode, PathNode: IXMLNode;
  i: Integer;
  LibraryPath, LibraryPaths: String;
begin
  try
    XML := TXMLDocument.Create(Self);

    XML.LoadFromFile(Filename);

    XMLNode := XML.DocumentElement;

    if XMLNode <> nil then
    begin
      for i := 0 to pred(XMLNode.ChildNodes.Count) do
        if SameText(XMLNode.ChildNodes[i].NodeName, 'PropertyGroup') then
        begin
          PathNode := XMLNode.ChildNodes[i].ChildNodes.FindNode('DCC_UnitSearchPath');

          if PathNode <> nil then
          begin
            LibraryPaths := PathNode.NodeValue;

            while LibraryPaths <> '' do
            begin
              LibraryPath := Trim(NextBlock(LibraryPaths, ';'));

              LibraryPath := IncludeTrailingPathDelimiter(ExtractFileDir(Filename)) + LibraryPath;

              AddSearchPath(ExpandFileNameRelBaseDir(LibraryPath, ExtractFileDir(Filename)));
            end;
          end;
        end;
    end;
  except
    on e: Exception do
    begin
      if not FIgnoreAllErrors then
        case MessageDlg(format(StrAnErrorOccurredLoading, [Filename]), mtError, [mbIgnore, mbAll, mbCancel], 0) of
          mrAll: FIgnoreAllErrors := TRUE;
          mrCancel: FCancelled := TRUE;
        end;
    end;
  end;
end;

end.
