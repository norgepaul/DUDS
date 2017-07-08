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

unit Duds.Common.Utils;

interface

uses
  System.DateUtils, System.SysUtils, System.Classes,

  System.Win.Registry, WinApi.Windows,

  Duds.Common.Strings;

function FormatCardinal(const Value: Cardinal): String;
function CompareInteger(const A, B: Integer): Integer; overload;
function CompareInteger(const A, B: Int64): Integer; overload;
function CompareBoolean(const A, B: Boolean): Integer;
function SecondsToTimeString(const Seconds: Integer): String;

implementation

resourcestring
  StrDDays = '%d days';
  StrDDay = '%d day';

function FormatCardinal(const Value: Cardinal): String;
var
  p: Integer;
begin
  Result := IntToStr(Value);

  p := length(Result) - 3;

  while p > 0 do
  begin
    Insert(',', Result, p + 1);

    dec(p, 3);
  end;
end;

function SecondsToTimeString(const Seconds: Integer): String;
var
  Days, Hours, Minutes, Secs: Integer;
begin
  Result := '';

  Days := Trunc(1 / 86400 * Seconds);
  Hours := Trunc((Seconds mod 86400) / 3600);
  Minutes := Trunc((Seconds mod 3600) / 60);
  Secs := Trunc(Seconds mod 60);

  if Days = 1 then
    AddToken(Result, format(StrDDay, [Days]), ', ') else
  if Days > 1 then
    AddToken(Result, format(StrDDays, [Days]), ' ');

  if (Hours > 0) or (Days > 0) then
    AddToken(Result, format('%dh', [Hours]), ' ');

  if (Minutes > 0) or (Days > 0) or (Hours > 0) then
    AddToken(Result, format('%dm', [Minutes]), ' ');

  if (Secs > 0) or (Days > 0) or (Hours > 0)  or (Minutes > 0) then
    AddToken(Result, format('%ds', [Secs]), ' ');

  if Result = '' then
    Result := '0s';
end;

function CompareInteger(const A, B: Integer): Integer;
begin
  if A = B then
    Result := 0
  else if A < B then
    Result := -1
  else
    Result := 1;
end;

function CompareInteger(const A, B: Int64): Integer;
begin
  if A = B then
    Result := 0
  else if A < B then
    Result := -1
  else
    Result := 1;
end;

function CompareBoolean(const A, B: Boolean): Integer;
begin
  if A = B then
    Result := 0 else
  if A and (not B) then
    Result := -1
  else
    Result := 1;
end;

end.
