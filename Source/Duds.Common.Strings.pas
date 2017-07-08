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

unit Duds.Common.Strings;

interface

uses
  System.Classes, System.SysUtils;

procedure AddToken(var Value: String; const Token: String; const Separator: String = ', ');
function NextBlock(var Value: String; Delimiter: String; QuotedString: Boolean = FALSE): String;

implementation

procedure AddToken(var Value: String; const Token: String; const Separator: String);
begin
  if Value <> '' then
    Value := concat(Value, Separator);

  Value := concat(Value, Token);
end;

function NextBlock(var Value: String; Delimiter: String; QuotedString: Boolean): String;
const
  Quote = '''';
var
  p: Integer;
  InQuotes: Boolean;
begin
  p := 1;
  InQuotes := FALSE;

  while (p <= length(Value) - length(Delimiter) + 1) and
        ((copy(Value, p, length(Delimiter)) <> Delimiter) or
        (InQuotes)) do
  begin
    if Value[p] = Quote then
      InQuotes := not InQuotes;

    Inc(p);
  end;

  if p = length(Value) then
    Result := Value
  else
    Result := copy(Value, 1, p - 1);

  Value := Trim(copy(Value, p + length(Delimiter), MaxInt));

  if (QuotedString) and (Result <> '') then
  begin
    if Result[1] = Quote then
      Delete(Result, 1, 1);

    if (Result <> '') and (Result[length(Result)] = Quote) then
      Delete(Result, length(Result), 1);
  end;
end;

end.
