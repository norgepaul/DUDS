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

unit Duds.Vcl.Utils;

interface

uses
  WinApi.Windows,

  Vcl.Controls, Vcl.Forms;

procedure EnableControlAndChildren(Control: TWinControl; DoEnable: Boolean);
function ScaleDimension(const Value: Integer; const PixelsPerInch: Integer): Integer;

implementation

procedure EnableControlAndChildren(Control: TWinControl; DoEnable: Boolean);
var
  i: Integer;
begin
  Control.Enabled := DoEnable;
  for i := 0 to Control.ControlCount - 1 do
    if Control.Controls[i] is TWinControl then
      EnableControlAndChildren(Control.Controls[i] as TWinControl, DoEnable);
end;

function ScaleDimension(const Value: Integer; const PixelsPerInch: Integer): Integer;
begin
  Result := MulDiv(Value, Screen.PixelsPerInch, PixelsPerInch);
end;

end.
