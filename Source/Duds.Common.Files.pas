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

unit Duds.Common.Files;

interface

uses
  System.Classes, System.SysUtils, Generics.Collections,

  WinApi.Windows, Winapi.ShLwApi,

  Duds.Common.Classes,
  Duds.Common.Strings;

function ExpandFileNameRelBaseDir(const FileName, BaseDir: string): string;
function ExtractFilenameNoExt(Filename: String): String;
function ScanFiles(const Path, Filter: String; Recursive: Boolean; IncludeDirectories: Boolean; IncludePaths: Boolean): TObjectList<TFileInfo>;
function FileTime2DateTime(FileTime: TFileTime): TDateTime;

implementation

{$WARNINGS OFF}
function ExpandFileNameRelBaseDir(const FileName, BaseDir: string): string;
var
  Buffer: array [0..MAX_PATH-1] of Char;
begin
  if PathIsRelative(PChar(FileName)) then begin
    Result := IncludeTrailingBackslash(BaseDir)+FileName;
  end else begin
    Result := FileName;
  end;
  if PathCanonicalize(@Buffer[0], PChar(Result)) then begin
    Result := Buffer;
  end;
end;
{$WARNINGS ON}

function ExtractFilenameNoExt(Filename: String): String;
var
  ExtLen: Integer;
begin
  ExtLen := Length(ExtractFileExt(Filename));
  Result := ExtractFileName(Filename);

  if ExtLen > 0 then
    Result := Copy(Result, 1, length(Result) - ExtLen);
end;

function FileTime2DateTime(FileTime: TFileTime): TDateTime;
var
  LocalFileTime: TFileTime;
  SystemTime: TSystemTime;
begin
  FileTimeToLocalFileTime(FileTime, LocalFileTime);
  FileTimeToSystemTime(LocalFileTime, SystemTime);

  Result := SystemTimeToDateTime(SystemTime);
end;

function ScanFiles(const Path, Filter: String; Recursive: Boolean; IncludeDirectories: Boolean; IncludePaths: Boolean): TObjectList<TFileInfo>;

  function IsDirectory(dWin32FD: TWin32FindData): Boolean;
  var
    FName: string;
  begin
    FName := StrPas(dWin32FD.cFileName);

    with dWin32FD do
      Result := (dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY =
                 FILE_ATTRIBUTE_DIRECTORY) and (FName <> '.') and (FName <> '..');
  end;

  procedure AddToResult(Win32FD : TWin32FindData; const Path: String);
  var
    FileInfo: TFileInfo;
    IsDir: Boolean;
  begin
    IsDir := IsDirectory(Win32FD);

    if (not IsDir) or ((IsDir) and (IncludeDirectories)) then
    begin
      FileInfo := TFileInfo.Create;
      Result.Add(FileInfo);

      FileInfo.IsDir := IsDir;

      if IncludePaths then
        FileInfo.Filename := concat(IncludeTrailingPathDelimiter(Path), Win32FD.cFileName)
      else
        FileInfo.Filename := Win32FD.cFileName;

      FileInfo.Filesize := Win32FD.nFileSizeLow;
      FileInfo.CreatedDate := FileTime2DateTime(Win32FD.ftCreationTime);
      FileInfo.ModifiedDate := FileTime2DateTime(Win32FD.ftLastWriteTime);
    end;
  end;

  procedure ScanFilesRec(const Path, Filter: String);
  var
    hFindFile : THandle;
    Win32FD : TWin32FindData;
  begin
    hFindFile := FindFirstFile(PChar(IncludeTrailingPathDelimiter(Path) + Filter), Win32FD);
    try
      If hFindFile <> INVALID_HANDLE_VALUE then
      begin
        repeat
          if (StrPas(Win32FD.cFileName) <> '.') and (StrPas(Win32FD.cFileName) <> '..') then
          begin
            AddToResult(Win32FD, Path);

            if (IsDirectory(Win32FD)) and (Recursive) then
              ScanFilesRec(IncludeTrailingPathDelimiter(concat(IncludeTrailingPathDelimiter(Path), Win32FD.cFileName)), Filter);
          end;
        until not FindNextFile(hFindFile, Win32FD);
      end;
    finally
      FindClose(hFindFile);
    end;
  end;

var
  FullFilter: String;
begin
  FullFilter := Filter;

  Result := TObjectList<TFileInfo>.Create;

  while FullFilter <> '' do
    ScanFilesRec(Path, NextBlock(FullFilter, ';'));
end;

end.
