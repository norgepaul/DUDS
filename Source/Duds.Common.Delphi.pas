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

unit Duds.Common.Delphi;

interface

uses
  System.Classes, System.SysUtils,

  WinApi.Windows, System.Win.Registry,

  Duds.Common.Utils;

function DelphiIDERunning: Boolean;
function GetDelphiVersionRegistryKey(Version: Integer): String;
function GetDelphiRootDirectory(Version: Integer): String;
function IsDelphiVersionInstalled(Version: Integer): Boolean;
function GetDelphiEnvironmentVariables(Version: Integer; const EnvironmentVariables: TStrings): Boolean;
function GetDelphiLibraryPaths(Version: Integer; const LibraryPaths: TStrings; EvaluateMacros: Boolean = TRUE; CheckPaths: Boolean = TRUE): Boolean;

implementation

function DelphiIDERunning: Boolean;
begin
  Result := FindWindow('TAppBuilder', nil) <> 0;
end;

function GetDelphiVersionRegistryKey(Version: Integer): String;
begin
  Result := '';

  case Version of
    15: Result := '\Software\Embarcadero\BDS\8.0';
    16: Result := '\Software\Embarcadero\BDS\9.0';
    17: Result := '\Software\Embarcadero\BDS\10.0';
  end;
end;

function GetDelphiRootDirectory(Version: Integer): String;
var
  Reg: TRegistry;
  DelphiKey: String;
begin
  Result := '';

  DelphiKey := GetDelphiVersionRegistryKey(Version);

  if DelphiKey <> '' then
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;

      // Find the Delphi root directory
      if (Reg.OpenKey(DelphiKey, FALSE)) and
         (Reg.ValueExists('RootDir')) then
        Result := Reg.ReadString('RootDir');

      Reg.CloseKey;
    finally
      FreeAndNil(Reg);
    end;
  end;
end;

function IsDelphiVersionInstalled(Version: Integer): Boolean;
begin
  Result := GetDelphiRootDirectory(Version) <> '';
end;

function GetDelphiEnvironmentVariables(Version: Integer; const EnvironmentVariables: TStrings): Boolean;
var
  Reg: TRegistry;
  DelphiKey: String;
  i: Integer;
begin
  Result := FALSE;

  DelphiKey := GetDelphiVersionRegistryKey(Version);

  if DelphiKey <> '' then
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;

      // Open the key that contains all the delphi library paths
      if (Reg.OpenKey(DelphiKey + '\Environment Variables', FALSE)) then
      begin
        Reg.GetValueNames(EnvironmentVariables);

        for i := 0 to pred(EnvironmentVariables.Count) do
          EnvironmentVariables[i] := EnvironmentVariables[i] + '=' + Reg.ReadString(EnvironmentVariables[i]);

        Result := TRUE;
      end;

      Reg.CloseKey;
    finally
      FreeAndNil(Reg);
    end;
  end;
end;

function GetDelphiLibraryPaths(Version: Integer; const LibraryPaths: TStrings; EvaluateMacros, CheckPaths: Boolean): Boolean;
var
  Reg: TRegistry;
  DelphiKey, DelphiPath, KeyName, TempPath, SearchPath: String;
  i, n: Integer;
  EnvironmentVariables, DelphiPaths: TStringList;
begin
  Result := FALSE;

  DelphiKey := GetDelphiVersionRegistryKey(Version);

  if DelphiKey <> '' then
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;

      EnvironmentVariables := TStringList.Create;
      DelphiPaths := TStringList.Create;
      try
        if EvaluateMacros then
          GetDelphiEnvironmentVariables(Version, EnvironmentVariables);

        KeyName := 'Search Path';
        DelphiPath := GetDelphiRootDirectory(Version);

        // Open the key that contains all the delphi library paths
        if (Reg.OpenKey(DelphiKey + '\Library\Win32', FALSE)) and
           (Reg.ValueExists(KeyName)) then
        begin
          SearchPath := Reg.ReadString(KeyName);
          SearchPath := concat('"', StringReplace(SearchPath, ';', '","', [rfReplaceAll, rfIgnoreCase]), '"');

          // if we have a delphi root directory, replace all the $(DELPHI) macros
          if DelphiPath <> '' then
            SearchPath := StringReplace(SearchPath, '$(DELPHI)', DelphiPath, [rfReplaceAll, rfIgnoreCase]);

          DelphiPaths.CommaText := SearchPath;

          LibraryPaths.BeginUpdate;
          try
            // Add the paths that exist
            for i := 0 to pred(DelphiPaths.Count) do
              for n := 0 to pred(EnvironmentVariables.Count) do
              begin
                TempPath := DelphiPaths[i];

                if EvaluateMacros then
                  TempPath := StringReplace(TempPath, format('$(%s)',
                                            [EnvironmentVariables.Names[n]]),
                                             EnvironmentVariables.Values[EnvironmentVariables.Names[n]],
                                            [rfReplaceAll, rfIgnoreCase]);

                if (not CheckPaths) or
                   ((CheckPaths) and (DirectoryExists(TempPath))) then
                  LibraryPaths.Add(TempPath);
              end;

            Result := TRUE;
          finally
            LibraryPaths.EndUpdate;
          end;
        end;
      finally
        FreeAndNil(EnvironmentVariables);
        FreeAndNil(DelphiPaths);
      end;

      Reg.CloseKey;
    finally
      FreeAndNil(Reg);
    end;
  end;
end;

end.
