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

unit Duds.Common.Classes;

interface

uses
  System.Classes, System.IniFiles, System.SysUtils, System.Generics.Collections,

  Duds.Common.Helper.IniFile,
  Duds.Common.Interfaces,
  Duds.Common.Types;

type
  TNodeData = record
    ID: Integer;
    Index: Cardinal;
  end;
  PNodeData = ^TNodeData;

  TLogEntry = record
    Text: String;
    Severity: Integer;
  end;
  TLogEntries = TList<TLogEntry>;

  TDelphiFile = class(TObject)
  strict private
    FUnitInfo: IUnitInfo;
    FUsedCount: Integer;
    FInSearchPath: Boolean;
    FBaseNode: Pointer;
  public
    property UnitInfo: IUnitInfo read FUnitInfo write FUnitInfo;
    property UsedCount: Integer read FUsedCount write FUsedCount;
    property InSearchPath: Boolean read FInSearchPath write FInSearchPath;
    property BaseNode: Pointer read FBaseNode write FBaseNode;
  end;

  TNodeObject = class(TObject)
  strict private
    FDelphiFile: TDelphiFile;
    FLink: Pointer;
    FCircularReference: TCircularRelationshipType;
    FSearchTermInChildren: Boolean;
  public
    property Link: Pointer read FLink write FLink;
    property CircularReference: TCircularRelationshipType read FCircularReference write FCircularReference;
    property DelphiFile: TDelphiFile read FDelphiFile write FDelphiFile;
    property SearchTermInChildren: Boolean read FSearchTermInChildren write FSearchTermInChildren;
  end;

  TFileInfo = class(TObject)
  private
    FFilename: UnicodeString;
    FFilesize: Int64;
    FModifiedDate: TDateTime;
    FCreatedDate: TDateTime;
    FIsDir: Boolean;
  public
    property Filename: UnicodeString read FFilename write FFilename;
    property Filesize: Int64 read FFilesize write FFilesize;
    property ModifiedDate: TDateTime read FModifiedDate write FModifiedDate;
    property CreatedDate: TDateTime read FCreatedDate write FCreatedDate;
    property IsDir: Boolean read FIsDir write FIsDir;
  end;

  TBaseSettings = class
  protected
    procedure DoSaveToIniFile(const IniFile: TIniFile); virtual; abstract;
    procedure DoLoadFromIniFile(const IniFile: TIniFile); virtual; abstract;
  public
    procedure SaveToFile(const Filename: String);
    function LoadFromFile(const Filename: String): Boolean;
  end;

  TProjectSettings = class(TBaseSettings)
  strict private
    FRootFiles: TStringList;
    FSearchPaths: TStringList;
    FUnitScopeNames: TStringList;
    FLinkUnits: Boolean;
  private
    procedure SetRootFiles(const Value: TStringList);
    procedure SetSearchPaths(const Value: TStringList);
    procedure SetUnitScopeNames(const Value: TStringList);
  protected
    procedure DoSaveToIniFile(const IniFile: TIniFile); override;
    procedure DoLoadFromIniFile(const IniFile: TIniFile); override;
  public
    constructor Create;
    destructor Destroy; override;

    property RootFiles: TStringList read FRootFiles write SetRootFiles;
    property SearchPaths: TStringList read FSearchPaths write SetSearchPaths;
    property UnitScopeNames: TStringList read FUnitScopeNames write SetUnitScopeNames;
    property LinkUnits: Boolean read FLinkUnits write FLinkUnits;
  end;

  TEnvironmentSettings = class(TBaseSettings)
  strict private
    FStatusLogHeight: Integer;
    FTreeWidth: Integer;
    FListWidth: Integer;
    FShowUnitsNotInPath: Boolean;
    FProjectFilename: String;
    FLoadLastProject: Boolean;
    FRunScanOnLoad: Boolean;
    FWindowState: Integer;
    FWindowLeft: Integer;
    FWindowTop: Integer;
    FWindowWidth: Integer;
    FWindowHeight: Integer;
    FPromptBeforeUpdate: Boolean;
    FDummyRun: Boolean;
    FRenameHistoryFiles: Boolean;
  protected
    procedure DoSaveToIniFile(const IniFile: TIniFile); override;
    procedure DoLoadFromIniFile(const IniFile: TIniFile); override;
  public
    constructor Create;
    destructor Destroy; override;

    property StatusLogHeight: Integer read FStatusLogHeight write FStatusLogHeight;
    property TreeWidth: Integer read FTreeWidth write FTreeWidth;
    property ListWidth: Integer read FListWidth write FListWidth;
    property ShowUnitsNotInPath: Boolean read FShowUnitsNotInPath write FShowUnitsNotInPath;
    property ProjectFilename: String read FProjectFilename write FProjectFilename;
    property LoadLastProject: Boolean read FLoadLastProject write FLoadLastProject;
    property RunScanOnLoad: Boolean read FRunScanOnLoad write FRunScanOnLoad;
    property WindowState: Integer read FWindowState write FWindowState;
    property WindowLeft: Integer read FWindowLeft write FWindowLeft;
    property WindowTop: Integer read FWindowTop write FWindowTop;
    property WindowWidth: Integer read FWindowWidth write FWindowWidth;
    property WindowHeight: Integer read FWindowHeight write FWindowHeight;
    property PromptBeforeUpdate: Boolean read FPromptBeforeUpdate write FPromptBeforeUpdate;
    property DummyRun: Boolean read FDummyRun write FDummyRun;
    property RenameHistoryFiles: Boolean read FRenameHistoryFiles write FRenameHistoryFiles;
  end;

implementation

{ TBaseSettings }

function TBaseSettings.LoadFromFile(const Filename: String): Boolean;
var
  IniFile: TIniFile;
begin
  Result := (Filename <> '') and (FileExists(Filename));

  if Result then
  begin
    IniFile := TIniFile.Create(Filename);
    try
      DoLoadFromIniFile(IniFile);
    finally
      FreeAndNil(IniFile);
    end;
  end;
end;

procedure TBaseSettings.SaveToFile(const Filename: String);
var
  IniFile: TIniFile;
begin
  if Filename <> '' then
  begin
    IniFile := TIniFile.Create(Filename);
    try
      DoSaveToIniFile(IniFile);
    finally
      FreeAndNil(IniFile);
    end;
  end;
end;


{ TProjectSettings }

constructor TProjectSettings.Create;
begin
  FRootFiles := TStringList.Create;
  FSearchPaths := TStringList.Create;
  FUnitScopeNames := TStringList.Create;
  FLinkUnits := True;

  FUnitScopeNames.Sorted := TRUE;
  FUnitScopeNames.Add('Windows');
end;

destructor TProjectSettings.Destroy;
begin
  FreeAndNil(FRootFiles);
  FreeAndNil(FUnitScopeNames);
  FreeAndNil(FSearchPaths);

  inherited;
end;

procedure TProjectSettings.DoLoadFromIniFile(const IniFile: TIniFile);
begin
  IniFile.ReadStrings('RootFiles', FRootFiles);
  IniFile.ReadStrings('SearchPaths', FSearchPaths);
  IniFile.ReadStrings('UnitScopeNames', FUnitScopeNames);

  FLinkUnits := IniFile.ReadBool('Settings', 'LinkUnits', FLinkUnits);
end;

procedure TProjectSettings.DoSaveToIniFile(const IniFile: TIniFile);
begin
  IniFile.WriteStrings('RootFiles', FRootFiles);
  IniFile.WriteStrings('SearchPaths', FSearchPaths);
  IniFile.WriteStrings('UnitScopeNames', FUnitScopeNames);

  IniFile.WriteBool('Settings', 'LinkUnits', FLinkUnits);
end;

procedure TProjectSettings.SetRootFiles(const Value: TStringList);
begin
  FRootFiles.Assign(Value);
end;

procedure TProjectSettings.SetSearchPaths(const Value: TStringList);
begin
  FSearchPaths.Assign(Value);
end;

procedure TProjectSettings.SetUnitScopeNames(const Value: TStringList);
begin
  FUnitScopeNames.Assign(Value);
end;

{ TEnvironmentSettings }

const
  ControlSection = 'Control';
  WindowSection = 'Window';
  ProjectSection = 'Projects';
  DialogsSection = 'Dialogs';

constructor TEnvironmentSettings.Create;
begin

end;

destructor TEnvironmentSettings.Destroy;
begin

  inherited;
end;

procedure TEnvironmentSettings.DoLoadFromIniFile(const IniFile: TIniFile);
begin
  FStatusLogHeight := IniFile.ReadInteger(ControlSection, 'StatusLogHeight', FStatusLogHeight);
  FTreeWidth := IniFile.ReadInteger(ControlSection, 'TreeWidth', FTreeWidth);
  FListWidth := IniFile.ReadInteger(ControlSection, 'ListWidth', FListWidth);

  FShowUnitsNotInPath := IniFile.ReadBool(ProjectSection, 'ShowUnitsNotInPath', FShowUnitsNotInPath);
  FProjectFilename := IniFile.ReadString(ProjectSection, 'ProjectFilename', FProjectFilename);
  FLoadLastProject := IniFile.ReadBool(ProjectSection, 'LoadLastProject', FLoadLastProject);
  FRunScanOnLoad := IniFile.ReadBool(ProjectSection, 'RunScanOnLoad', FRunScanOnLoad);

  FWindowState := IniFile.ReadInteger(WindowSection, 'WindowState', FWindowState);
  FWindowLeft := IniFile.ReadInteger(WindowSection, 'WindowLeft', FWindowLeft);
  FWindowTop := IniFile.ReadInteger(WindowSection, 'WindowTop', FWindowTop);
  FWindowWidth := IniFile.ReadInteger(WindowSection, 'WindowWidth', FWindowWidth);
  FWindowHeight := IniFile.ReadInteger(WindowSection, 'WindowHeight', FWindowHeight);

  FPromptBeforeUpdate := IniFile.ReadBool(DialogsSection, 'PromptBeforeUpdate', FPromptBeforeUpdate);
  FDummyRun := IniFile.ReadBool(DialogsSection, 'DummyRun', FDummyRun);
  FRenameHistoryFiles := IniFile.ReadBool(DialogsSection, 'RenameHistoryFiles', FRenameHistoryFiles);
end;

procedure TEnvironmentSettings.DoSaveToIniFile(const IniFile: TIniFile);
begin
  IniFile.WriteInteger(ControlSection, 'StatusLogHeight', FStatusLogHeight);
  IniFile.WriteInteger(ControlSection, 'TreeWidth', FTreeWidth);
  IniFile.WriteInteger(ControlSection, 'ListWidth', FListWidth);

  IniFile.WriteBool(ProjectSection, 'ShowUnitsNotInPath', FShowUnitsNotInPath);
  IniFile.WriteString(ProjectSection, 'ProjectFilename', FProjectFilename);
  IniFile.WriteBool(ProjectSection, 'LoadLastProject', FLoadLastProject);
  IniFile.WriteBool(ProjectSection, 'RunScanOnLoad', FRunScanOnLoad);

  IniFile.WriteInteger(WindowSection, 'WindowState', FWindowState);
  IniFile.WriteInteger(WindowSection, 'WindowLeft', FWindowLeft);
  IniFile.WriteInteger(WindowSection, 'WindowTop', FWindowTop);
  IniFile.WriteInteger(WindowSection, 'WindowWidth', FWindowWidth);
  IniFile.WriteInteger(WindowSection, 'WindowHeight', FWindowHeight);

  IniFile.WriteBool(DialogsSection, 'PromptBeforeUpdate', FPromptBeforeUpdate);
  IniFile.WriteBool(DialogsSection, 'DummyRun', FDummyRun);
  IniFile.WriteBool(DialogsSection, 'RenameHistoryFiles', FRenameHistoryFiles);
end;

end.
