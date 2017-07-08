object frmRenameUnit: TfrmRenameUnit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Rename Unit'
  ClientHeight = 139
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 7
    Width = 83
    Height = 13
    Caption = 'New Unit Name:'
  end
  object edtNewName: TEdit
    Left = 8
    Top = 21
    Width = 434
    Height = 21
    TabOrder = 1
    OnChange = edtNewNameChange
    OnKeyPress = edtNewNameKeyPress
  end
  object chkUpdateUsesClauses: TCheckBox
    Left = 8
    Top = 140
    Width = 249
    Height = 17
    Caption = 'Update uses clauses with new name'
    Checked = True
    State = cbChecked
    TabOrder = 0
    Visible = False
    OnClick = chkUpdateUsesClausesClick
  end
  object chkPromptBeforeUpdate: TCheckBox
    Left = 8
    Top = 85
    Width = 237
    Height = 17
    Caption = 'Prompt before updating uses clauses'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object btnOK: TButton
    Left = 150
    Top = 109
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TButton
    Left = 230
    Top = 109
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object chkDummyRun: TCheckBox
    Left = 8
    Top = 44
    Width = 248
    Height = 17
    Caption = 'Dummy Run - No files will be updated'
    TabOrder = 2
  end
  object chkRenameHistoryFiles: TCheckBox
    Left = 8
    Top = 64
    Width = 237
    Height = 17
    Caption = 'Rename files in the "__history" folder'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
end
