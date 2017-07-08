object frmSearchAndReplace: TfrmSearchAndReplace
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Search and Replace Unit Names'
  ClientHeight = 222
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 7
    Width = 213
    Height = 13
    Caption = 'Search for (supports regular expressions):'
  end
  object Label2: TLabel
    Left = 8
    Top = 47
    Width = 69
    Height = 13
    Caption = 'Replace with:'
  end
  object Label3: TLabel
    Left = 8
    Top = 87
    Width = 22
    Height = 13
    Caption = 'Test:'
  end
  object Label4: TLabel
    Left = 231
    Top = 87
    Width = 35
    Height = 13
    Caption = 'Result:'
  end
  object edtSearch: TEdit
    Left = 8
    Top = 21
    Width = 434
    Height = 21
    TabOrder = 0
    OnChange = edtSearchChange
    OnKeyPress = edtSearchKeyPress
  end
  object chkPromptBeforeUpdate: TCheckBox
    Left = 8
    Top = 167
    Width = 237
    Height = 17
    Caption = 'Prompt before updating uses clauses'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object btnOK: TButton
    Left = 150
    Top = 191
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 7
  end
  object btnCancel: TButton
    Left = 230
    Top = 191
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object chkDummyRun: TCheckBox
    Left = 8
    Top = 126
    Width = 248
    Height = 17
    Caption = 'Dummy Run - No files will be updated'
    TabOrder = 4
  end
  object chkRenameHistoryFiles: TCheckBox
    Left = 8
    Top = 146
    Width = 237
    Height = 17
    Caption = 'Rename files in the "__history" folder'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object edtReplace: TEdit
    Left = 8
    Top = 61
    Width = 434
    Height = 21
    TabOrder = 1
    OnChange = edtSearchChange
    OnKeyPress = edtSearchKeyPress
  end
  object edtTest: TEdit
    Left = 8
    Top = 101
    Width = 217
    Height = 21
    TabOrder = 2
    OnChange = edtSearchChange
    OnKeyPress = edtSearchKeyPress
  end
  object edtResult: TEdit
    Left = 231
    Top = 101
    Width = 211
    Height = 21
    ReadOnly = True
    TabOrder = 3
    OnChange = edtSearchChange
    OnKeyPress = edtSearchKeyPress
  end
end
