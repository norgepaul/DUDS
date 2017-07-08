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

unit Duds.Vcl.Form.FindReplace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  RegularExpressions;

type
  TfrmSearchAndReplace = class(TForm)
    edtSearch: TEdit;
    Label1: TLabel;
    chkPromptBeforeUpdate: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    chkDummyRun: TCheckBox;
    chkRenameHistoryFiles: TCheckBox;
    edtReplace: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtTest: TEdit;
    edtResult: TEdit;
    Label4: TLabel;
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    procedure UpdateRegEx;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearchAndReplace: TfrmSearchAndReplace;

implementation

resourcestring
  StrInvalidRegularExpr = 'Invalid Regular Expression';

{$R *.dfm}

procedure TfrmSearchAndReplace.edtSearchChange(Sender: TObject);
begin
  UpdateRegEx;

  btnOK.Enabled := (edtSearch.Text <> '') and (edtReplace.Text <> '') and (edtResult.Tag = 0);
end;

procedure TfrmSearchAndReplace.UpdateRegEx;
begin
  try
    edtResult.Text := TRegEx.Replace(edtTest.Text, edtSearch.Text, edtReplace.Text);
    edtResult.Font.Color := clWindowText;
    edtResult.Tag := 0;
  except
    if edtSearch.Text = '' then
      edtResult.Text := ''
    else
      edtResult.Text := StrInvalidRegularExpr;

    edtResult.Font.Color := clRed;
    edtResult.Tag := 1;
  end;
end;

procedure TfrmSearchAndReplace.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [' ']) then
    Key := #00;
end;

procedure TfrmSearchAndReplace.FormShow(Sender: TObject);
begin
  UpdateRegEx;
end;

end.
