object frmDependencyScannerSetting: TfrmDependencyScannerSetting
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Settings'
  ClientHeight = 466
  ClientWidth = 609
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object pcSettings: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 603
    Height = 432
    ActivePage = tabRootFiles
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 597
    ExplicitHeight = 415
    object tabRootFiles: TTabSheet
      Caption = 'Root Files'
      object Panel4: TPanel
        Left = 482
        Top = 0
        Width = 113
        Height = 351
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 476
        ExplicitHeight = 334
        object btnAddFile: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 107
          Height = 25
          Align = alTop
          Caption = 'Add Root Files'
          TabOrder = 0
          OnClick = btnAddFileClick
        end
        object chkIncludeProjectSearchPaths: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 65
          Width = 107
          Height = 40
          Align = alTop
          Caption = 'Automatically add Project Search Paths'
          Checked = True
          State = cbChecked
          TabOrder = 2
          WordWrap = True
        end
        object btnScanForProjects: TButton
          AlignWithMargins = True
          Left = 3
          Top = 34
          Width = 107
          Height = 25
          Align = alTop
          Caption = 'Scan for Projects'
          TabOrder = 1
          OnClick = btnScanForProjectsClick
        end
      end
      object pnlFTSInfo: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 354
        Width = 589
        Height = 47
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 2
        Visible = False
        ExplicitTop = 337
        ExplicitWidth = 583
        object Panel14: TPanel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 587
          Height = 45
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          BevelOuter = bvNone
          Color = 12910591
          ParentBackground = False
          TabOrder = 0
          ExplicitWidth = 581
          object lnkFTSInfo: TLabel
            AlignWithMargins = True
            Left = 1
            Top = 1
            Width = 585
            Height = 43
            Margins.Left = 1
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alClient
            Caption = 
              'Enter at least one root file. The following files types are supp' +
              'orted - Pascal Files (.pas), Delphi Projects (.dpr), Delphi Pack' +
              'ages (.dpk) and Group Projects(.groupproj).  Each of the root fi' +
              'le directories will be searched for matching units. Add addition' +
              'al paths under the Search Paths tab.'
            Color = 14548991
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
            WordWrap = True
            ExplicitWidth = 555
            ExplicitHeight = 39
          end
        end
      end
      object memRootFiles: TRichEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 476
        Height = 345
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
        OnChange = OnSettingChange
        ExplicitWidth = 470
        ExplicitHeight = 328
      end
    end
    object tabSearchPaths: TTabSheet
      Caption = 'Search Paths'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 482
        Top = 0
        Width = 113
        Height = 404
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 476
        ExplicitHeight = 387
        object btnAddPath: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 107
          Height = 25
          Align = alTop
          Caption = 'Add Search Paths'
          TabOrder = 0
          OnClick = btnAddPathClick
        end
        object chkRecursive: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 34
          Width = 107
          Height = 31
          Align = alTop
          Caption = 'Recursive'
          TabOrder = 1
          WordWrap = True
        end
      end
      object memSearchPaths: TRichEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 476
        Height = 398
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
        OnChange = OnSettingChange
        ExplicitWidth = 470
        ExplicitHeight = 381
      end
    end
    object tabUnitScopes: TTabSheet
      Caption = 'Unit Scope Names'
      ImageIndex = 4
      object memUnitScopeNames: TRichEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 589
        Height = 398
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        Lines.Strings = (
          'Winapi'
          'System.Win'
          'Data.Win'
          'Datasnap.Win'
          'Web.Win'
          'Soap.Win'
          'Xml.Win'
          'Bde'
          'System'
          'Xml'
          'Data'
          'Datasnap'
          'Web'
          'Soap'
          'Vcl'
          'Vcl.Imaging'
          'Vcl.Touch'
          'Vcl.Samples'
          'Vcl.Shell')
        ParentFont = False
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        OnChange = OnSettingChange
        ExplicitWidth = 583
        ExplicitHeight = 381
      end
    end
    object tabScan: TTabSheet
      Caption = 'Scan'
      ImageIndex = 3
      object chkLinkUnits: TCheckBox
        Left = 16
        Top = 16
        Width = 233
        Height = 17
        Caption = 'Link Units that are found multiple times'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = OnSettingChange
      end
      object chkRunScanOnLoad: TCheckBox
        Left = 16
        Top = 39
        Width = 233
        Height = 17
        Caption = 'Start the scan when a project is loaded'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object tabEnvironment: TTabSheet
      Caption = 'Environment'
      ImageIndex = 2
      object chkLoadLastProject: TCheckBox
        Left = 16
        Top = 16
        Width = 233
        Height = 17
        Caption = 'Open last Project on Startup'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 438
    Width = 609
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 421
    ExplicitWidth = 603
    object lblStatus: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 5
      Width = 444
      Height = 20
      Margins.Top = 5
      Align = alClient
      AutoSize = False
      EllipsisPosition = epPathEllipsis
      ExplicitLeft = 112
      ExplicitTop = 8
      ExplicitWidth = 33
      ExplicitHeight = 13
    end
    object btnOK: TButton
      AlignWithMargins = True
      Left = 453
      Top = 0
      Width = 75
      Height = 25
      Margins.Top = 0
      Margins.Right = 0
      Align = alRight
      Caption = '&OK'
      Default = True
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = btnOKClick
      ExplicitLeft = 447
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 531
      Top = 0
      Width = 75
      Height = 25
      Margins.Top = 0
      Align = alRight
      Cancel = True
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
      ExplicitLeft = 525
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.pas'
    Filter = 
      'Delphi Files (*.pas;*.dpr;*.dpk;*.groupproj)|*.pas;*.dpr;*.dpk;*' +
      '.groupproj|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Select Root File'
    Left = 120
    Top = 168
  end
  object popDelphiPaths: TPopupMenu
    Left = 209
    Top = 168
    object miWindowsPaths: TMenuItem
      Caption = 'Browse for Path...'
      OnClick = miWindowsPathsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miDelphiXE1: TMenuItem
      Tag = 15
      Caption = 'Delphi XE'
      OnClick = miDelphiXE3Click
    end
    object miDelphiXE2: TMenuItem
      Tag = 16
      Caption = 'Delphi XE2'
      OnClick = miDelphiXE3Click
    end
    object miDelphiXE3: TMenuItem
      Tag = 17
      Caption = 'Delphi XE3'
      OnClick = miDelphiXE3Click
    end
    object miDelphiXE41: TMenuItem
      Tag = 18
      Caption = 'Delphi XE4'
      OnClick = miDelphiXE3Click
    end
    object DelphiXE51: TMenuItem
      Tag = 19
      Caption = 'Delphi XE5'
      OnClick = miDelphiXE3Click
    end
    object DelphiXE61: TMenuItem
      Tag = 20
      Caption = 'Delphi XE6'
      OnClick = miDelphiXE3Click
    end
    object DelphiXE71: TMenuItem
      Tag = 21
      Caption = 'Delphi XE7'
      OnClick = miDelphiXE3Click
    end
  end
end
