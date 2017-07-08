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

unit Duds.Vcl.Form.Rename;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmRenameUnit = class(TForm)
    edtNewName: TEdit;
    Label1: TLabel;
    chkUpdateUsesClauses: TCheckBox;
    chkPromptBeforeUpdate: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    chkDummyRun: TCheckBox;
    chkRenameHistoryFiles: TCheckBox;
    procedure edtNewNameChange(Sender: TObject);
    procedure chkUpdateUsesClausesClick(Sender: TObject);
    procedure edtNewNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRenameUnit: TfrmRenameUnit;

implementation

{$R *.dfm}

procedure TfrmRenameUnit.chkUpdateUsesClausesClick(Sender: TObject);
begin
  chkPromptBeforeUpdate.Enabled := chkUpdateUsesClauses.Checked;
end;

procedure TfrmRenameUnit.edtNewNameChange(Sender: TObject);
begin
  btnOK.Enabled := edtNewName.Text <> '';
end;

procedure TfrmRenameUnit.edtNewNameKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [' ']) then
    Key := #00;
end;

end.
