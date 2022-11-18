object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Delphi Unit Dependency Scanner'
  ClientHeight = 643
  ClientWidth = 1051
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object StatusBar1: TStatusBar
    AlignWithMargins = True
    Left = 3
    Top = 624
    Width = 1045
    Height = 19
    Margins.Top = 0
    Margins.Bottom = 0
    Panels = <
      item
        Width = 400
      end>
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 1051
    Height = 26
    ActionManager = ActionManager1
    Caption = 'ActionToolBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = True
    ParentFont = False
    Spacing = 0
  end
  object pnlBackground: TPanel
    Left = 0
    Top = 26
    Width = 1051
    Height = 598
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Click Scan to begin the Unit Dependecy Seach'
    TabOrder = 2
    object pnlMain: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1048
      Height = 595
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Click Scan to begin the Unit Dependency Seach'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      object Splitter1: TSplitter
        Left = 0
        Top = 442
        Width = 1048
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
        ExplicitLeft = -15
        ExplicitTop = 440
        ExplicitWidth = 1118
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1048
        Height = 442
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object pcView: TPageControl
          Left = 0
          Top = 0
          Width = 1048
          Height = 442
          ActivePage = tabList
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object tabTree: TTabSheet
            Caption = 'Tree'
            object Splitter2: TSplitter
              Left = 497
              Top = 0
              Height = 412
              ResizeStyle = rsUpdate
              ExplicitLeft = 296
              ExplicitTop = -18
              ExplicitHeight = 376
            end
            object pnlTree: TPanel
              Left = 0
              Top = 0
              Width = 497
              Height = 412
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              ExplicitHeight = 415
              object edtSearch: TSearchBox
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 494
                Height = 23
                Margins.Right = 0
                Margins.Bottom = 0
                TabStop = False
                Align = alTop
                AutoSize = False
                Constraints.MinHeight = 23
                Constraints.MinWidth = 30
                DoubleBuffered = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 4473924
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentColor = True
                ParentDoubleBuffered = False
                ParentFont = False
                TabOrder = 0
                TextHint = 'Search'
                OnChange = edtSearchEditChange
                OnKeyDown = edtSearchEditKeyDown
                OnKeyPress = edtSearchEditKeyPress
              end
              object vtUnits: TVirtualStringTree
                AlignWithMargins = True
                Left = 3
                Top = 29
                Width = 494
                Height = 380
                Margins.Right = 0
                Align = alClient
                Colors.UnfocusedColor = clMedGray
                Header.AutoSizeIndex = 0
                Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize, hoHeightResize]
                Images = ImageList1
                PopupMenu = popTree
                TabOrder = 1
                TreeOptions.AutoOptions = [toAutoDropExpand, toAutoSort, toAutoTristateTracking, toAutoHideButtons, toAutoDeleteMovedNodes]
                TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
                TreeOptions.StringOptions = [toSaveCaptions, toShowStaticText, toAutoAcceptEditChange]
                OnBeforeItemErase = vtUnitsBeforeItemErase
                OnCompareNodes = vtUnitsCompareNodes
                OnDblClick = vtUnitsDblClick
                OnFocusChanged = vtUnitsFocusChanged
                OnFocusChanging = vtUnitsFocusChanging
                OnGetText = vtUnitsGetText
                OnPaintText = vtUnitsPaintText
                OnGetImageIndex = vtUnitsGetImageIndex
                OnGetNodeDataSize = vtUnitsGetNodeDataSize
                OnHeaderClick = vtCommonHeaderClick
                Touch.InteractiveGestures = [igPan, igPressAndTap]
                Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
                ExplicitHeight = 383
                Columns = <
                  item
                    Position = 0
                    Text = 'Unit'
                    Width = 350
                  end
                  item
                    Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
                    Position = 1
                    Text = 'Previous Unit Name'
                  end
                  item
                    Position = 2
                    Text = 'File Type'
                    Width = 70
                  end
                  item
                    Position = 3
                    Text = 'Lines'
                    Width = 80
                  end
                  item
                    Position = 4
                    Text = 'Used By Units'
                    Width = 80
                  end
                  item
                    Position = 5
                    Text = 'Used Units'
                    Width = 80
                  end
                  item
                    Position = 6
                    Text = 'Section'
                    Width = 80
                  end
                  item
                    Position = 7
                    Text = 'Circular'
                  end
                  item
                    Position = 8
                    Text = 'Link'
                    Width = 30
                  end
                  item
                    Position = 9
                    Text = 'Filename'
                    Width = 400
                  end>
              end
            end
            object Panel5: TPanel
              Left = 500
              Top = 0
              Width = 540
              Height = 412
              Align = alClient
              Caption = 'Select a file to display its contents here.'
              TabOrder = 1
              ExplicitHeight = 415
              object pcSource: TPageControl
                AlignWithMargins = True
                Left = 1
                Top = 4
                Width = 535
                Height = 404
                Margins.Left = 0
                ActivePage = tabParentFile
                Align = alClient
                TabOrder = 0
                Visible = False
                ExplicitHeight = 407
                object tabParentFile: TTabSheet
                  Caption = 'Parent File'
                  object Image1: TImage
                    Left = 296
                    Top = 200
                    Width = 105
                    Height = 105
                    Visible = False
                  end
                  object memParentFile: TSynEdit
                    AlignWithMargins = True
                    Left = 0
                    Top = 3
                    Width = 524
                    Height = 368
                    Margins.Left = 0
                    Align = alClient
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Courier New'
                    Font.Style = []
                    Font.Quality = fqClearTypeNatural
                    TabOrder = 0
                    UseCodeFolding = False
                    Gutter.Font.Charset = DEFAULT_CHARSET
                    Gutter.Font.Color = clWindowText
                    Gutter.Font.Height = -11
                    Gutter.Font.Name = 'Courier New'
                    Gutter.Font.Style = []
                    Gutter.Font.Quality = fqClearTypeNatural
                    Gutter.ShowLineNumbers = True
                    Gutter.Bands = <
                      item
                        Kind = gbkMarks
                        Width = 13
                      end
                      item
                        Kind = gbkLineNumbers
                      end
                      item
                        Kind = gbkFold
                      end
                      item
                        Kind = gbkTrackChanges
                      end
                      item
                        Kind = gbkMargin
                        Width = 3
                      end>
                    Highlighter = SynPasSyn1
                    ReadOnly = True
                    SelectedColor.Alpha = 0.400000005960464500
                    OnChange = memParentFileChange
                    ExplicitHeight = 371
                  end
                end
                object tabSelectedFile: TTabSheet
                  Caption = 'Selected File'
                  ImageIndex = 1
                  object memSelectedFile: TSynEdit
                    AlignWithMargins = True
                    Left = 0
                    Top = 3
                    Width = 524
                    Height = 368
                    Margins.Left = 0
                    Align = alClient
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Courier New'
                    Font.Style = []
                    Font.Quality = fqClearTypeNatural
                    TabOrder = 0
                    UseCodeFolding = False
                    Gutter.Font.Charset = DEFAULT_CHARSET
                    Gutter.Font.Color = clWindowText
                    Gutter.Font.Height = -11
                    Gutter.Font.Name = 'Courier New'
                    Gutter.Font.Style = []
                    Gutter.Font.Quality = fqClearTypeNatural
                    Gutter.ShowLineNumbers = True
                    Gutter.Bands = <
                      item
                        Kind = gbkMarks
                        Width = 13
                      end
                      item
                        Kind = gbkLineNumbers
                      end
                      item
                        Kind = gbkFold
                      end
                      item
                        Kind = gbkTrackChanges
                      end
                      item
                        Kind = gbkMargin
                        Width = 3
                      end>
                    Highlighter = SynPasSyn1
                    ReadOnly = True
                    SelectedColor.Alpha = 0.400000005960464500
                    OnChange = memSelectedFileChange
                    ExplicitHeight = 371
                  end
                end
              end
            end
          end
          object tabList: TTabSheet
            Caption = 'List'
            ImageIndex = 1
            object Splitter3: TSplitter
              Left = 497
              Top = 0
              Height = 412
              ResizeStyle = rsUpdate
              ExplicitLeft = 296
              ExplicitTop = -18
              ExplicitHeight = 376
            end
            object pnlList: TPanel
              Left = 0
              Top = 0
              Width = 497
              Height = 412
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object edtListSearch: TSearchBox
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 494
                Height = 23
                Margins.Right = 0
                Margins.Bottom = 0
                TabStop = False
                Align = alTop
                AutoSize = False
                Constraints.MinHeight = 23
                Constraints.MinWidth = 30
                DoubleBuffered = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 4473924
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentColor = True
                ParentDoubleBuffered = False
                ParentFont = False
                TabOrder = 0
                TextHint = 'Search Unit List'
                OnChange = edtListSearchEditChange
              end
              object vtUnitsList: TVirtualStringTree
                AlignWithMargins = True
                Left = 3
                Top = 29
                Width = 494
                Height = 380
                Margins.Right = 0
                Align = alClient
                Colors.UnfocusedColor = clMedGray
                Header.AutoSizeIndex = 0
                Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize, hoHeightResize]
                Images = ImageList1
                PopupMenu = popTree
                TabOrder = 1
                TreeOptions.AutoOptions = [toAutoDropExpand, toAutoSort, toAutoTristateTracking, toAutoHideButtons, toAutoDeleteMovedNodes]
                TreeOptions.PaintOptions = [toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
                TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
                OnCompareNodes = vtUnitsListCompareNodes
                OnDblClick = vtUnitsListDblClick
                OnFocusChanged = vtUnitsListFocusChanged
                OnFocusChanging = vtUnitsListFocusChanging
                OnGetText = vtUnitsListGetText
                OnPaintText = vtUnitsListPaintText
                OnGetImageIndex = vtCommonGetImageIndex
                OnHeaderClick = vtCommonHeaderClick
                Touch.InteractiveGestures = [igPan, igPressAndTap]
                Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
                Columns = <
                  item
                    Position = 0
                    Text = 'Unit'
                    Width = 350
                  end
                  item
                    Position = 1
                    Text = 'File Type'
                    Width = 70
                  end
                  item
                    Position = 2
                    Text = 'Lines'
                    Width = 80
                  end
                  item
                    Position = 3
                    Text = 'Used By Units'
                    Width = 80
                  end
                  item
                    Position = 4
                    Text = 'Used Units'
                    Width = 80
                  end
                  item
                    Position = 5
                    Text = 'Filename'
                    Width = 400
                  end>
              end
            end
            object Panel10: TPanel
              Left = 500
              Top = 0
              Width = 540
              Height = 412
              Align = alClient
              BevelOuter = bvNone
              Caption = 'Select a file to display it'#39's contents here.'
              TabOrder = 1
              object pcList: TPageControl
                Left = 0
                Top = 0
                Width = 540
                Height = 412
                ActivePage = tabUsedBy
                Align = alClient
                TabOrder = 0
                object tabUsedBy: TTabSheet
                  Caption = 'Used By Units'
                  object edtSearchUsedByList: TSearchBox
                    AlignWithMargins = True
                    Left = 0
                    Top = 0
                    Width = 532
                    Height = 23
                    Margins.Left = 0
                    Margins.Top = 0
                    Margins.Right = 0
                    TabStop = False
                    Align = alTop
                    AutoSize = False
                    Constraints.MinHeight = 23
                    Constraints.MinWidth = 30
                    DoubleBuffered = True
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 4473924
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentColor = True
                    ParentDoubleBuffered = False
                    ParentFont = False
                    TabOrder = 1
                    TextHint = 'Search Used By Units List'
                    OnChange = edtSearchUsedByListEditChange
                  end
                  object vtUsedUnits: TVirtualStringTree
                    Left = 0
                    Top = 26
                    Width = 532
                    Height = 356
                    Margins.Right = 0
                    Align = alClient
                    Colors.UnfocusedColor = clMedGray
                    Header.AutoSizeIndex = 0
                    Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize, hoHeightResize]
                    Images = ImageList1
                    PopupMenu = popTree
                    TabOrder = 0
                    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoSort, toAutoTristateTracking, toAutoHideButtons, toAutoDeleteMovedNodes]
                    TreeOptions.PaintOptions = [toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
                    TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
                    OnCompareNodes = vtUnitsListCompareNodes
                    OnDblClick = vtUnitsListDblClick
                    OnGetText = vtUnitsListGetText
                    OnPaintText = vtUnitsListPaintText
                    OnGetImageIndex = vtCommonGetImageIndex
                    OnHeaderClick = vtCommonHeaderClick
                    Touch.InteractiveGestures = [igPan, igPressAndTap]
                    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
                    Columns = <
                      item
                        Position = 0
                        Text = 'Unit'
                        Width = 350
                      end
                      item
                        Position = 1
                        Text = 'File Type'
                        Width = 70
                      end
                      item
                        Position = 2
                        Text = 'Lines'
                        Width = 80
                      end
                      item
                        Position = 3
                        Text = 'Used By Units'
                        Width = 80
                      end
                      item
                        Position = 4
                        Text = 'Used Units'
                        Width = 80
                      end
                      item
                        Position = 5
                        Text = 'Filename'
                        Width = 400
                      end>
                  end
                end
                object tabUsesList: TTabSheet
                  Caption = 'Uses Units'
                  ImageIndex = 2
                  object edtSearchUsesList: TSearchBox
                    AlignWithMargins = True
                    Left = 0
                    Top = 0
                    Width = 532
                    Height = 23
                    Margins.Left = 0
                    Margins.Top = 0
                    Margins.Right = 0
                    TabStop = False
                    Align = alTop
                    AutoSize = False
                    Constraints.MinHeight = 23
                    Constraints.MinWidth = 30
                    DoubleBuffered = True
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = 4473924
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentColor = True
                    ParentDoubleBuffered = False
                    ParentFont = False
                    TabOrder = 0
                    TextHint = 'Search Uses List'
                    OnChange = edtSearchUsesListEditChange
                  end
                  object vtUsesUnits: TVirtualStringTree
                    Left = 0
                    Top = 26
                    Width = 532
                    Height = 356
                    Margins.Right = 0
                    Align = alClient
                    Colors.UnfocusedColor = clMedGray
                    Header.AutoSizeIndex = 0
                    Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize, hoHeightResize]
                    Images = ImageList1
                    PopupMenu = popTree
                    TabOrder = 1
                    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoSort, toAutoTristateTracking, toAutoHideButtons, toAutoDeleteMovedNodes]
                    TreeOptions.PaintOptions = [toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
                    TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
                    OnCompareNodes = vtUnitsListCompareNodes
                    OnDblClick = vtUnitsListDblClick
                    OnGetText = vtUnitsListGetText
                    OnPaintText = vtUnitsListPaintText
                    OnGetImageIndex = vtCommonGetImageIndex
                    OnHeaderClick = vtCommonHeaderClick
                    Touch.InteractiveGestures = [igPan, igPressAndTap]
                    Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
                    ExplicitHeight = 359
                    Columns = <
                      item
                        Position = 0
                        Text = 'Unit'
                        Width = 350
                      end
                      item
                        Position = 1
                        Text = 'File Type'
                        Width = 70
                      end
                      item
                        Position = 2
                        Text = 'Lines'
                        Width = 80
                      end
                      item
                        Position = 3
                        Text = 'Used By Units'
                        Width = 80
                      end
                      item
                        Position = 4
                        Text = 'Used Units'
                        Width = 80
                      end
                      item
                        Position = 5
                        Text = 'Filename'
                        Width = 400
                      end>
                  end
                end
                object tabSource: TTabSheet
                  Caption = 'Source'
                  ImageIndex = 1
                  object memListFile: TSynEdit
                    AlignWithMargins = True
                    Left = 0
                    Top = 3
                    Width = 529
                    Height = 376
                    Margins.Left = 0
                    Align = alClient
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Courier New'
                    Font.Style = []
                    Font.Quality = fqClearTypeNatural
                    TabOrder = 0
                    UseCodeFolding = False
                    Gutter.Font.Charset = DEFAULT_CHARSET
                    Gutter.Font.Color = clWindowText
                    Gutter.Font.Height = -11
                    Gutter.Font.Name = 'Courier New'
                    Gutter.Font.Style = []
                    Gutter.Font.Quality = fqClearTypeNatural
                    Gutter.ShowLineNumbers = True
                    Gutter.Bands = <
                      item
                        Kind = gbkMarks
                        Width = 13
                      end
                      item
                        Kind = gbkLineNumbers
                      end
                      item
                        Kind = gbkFold
                      end
                      item
                        Kind = gbkTrackChanges
                      end
                      item
                        Kind = gbkMargin
                        Width = 3
                      end>
                    Highlighter = SynPasSyn1
                    ReadOnly = True
                    SelectedColor.Alpha = 0.400000005960464500
                    OnChange = memListFileChange
                    ExplicitHeight = 379
                  end
                end
              end
            end
          end
        end
      end
      object pnlLog: TPanel
        Left = 0
        Top = 445
        Width = 1048
        Height = 150
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object Panel9: TPanel
          Left = 784
          Top = 0
          Width = 264
          Height = 150
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object vtStats: TVirtualStringTree
            AlignWithMargins = True
            Left = 2
            Top = 3
            Width = 259
            Height = 144
            Margins.Left = 2
            Align = alClient
            Colors.UnfocusedColor = clMedGray
            Header.AutoSizeIndex = 0
            Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoDrag]
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnGetText = vtStatsGetText
            OnPaintText = vtStatsPaintText
            Touch.InteractiveGestures = [igPan, igPressAndTap]
            Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
            Columns = <
              item
                Position = 0
                Width = 175
              end
              item
                Position = 1
                Width = 80
              end>
          end
        end
        object vtLog: TVirtualStringTree
          AlignWithMargins = True
          Left = 0
          Top = 3
          Width = 784
          Height = 144
          Margins.Left = 0
          Margins.Right = 0
          Align = alClient
          Colors.UnfocusedColor = clMedGray
          Header.AutoSizeIndex = 0
          Header.MainColumn = -1
          Images = ImageList1
          NodeDataSize = 24
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
          TreeOptions.PaintOptions = [toHideFocusRect, toShowDropmark, toShowHorzGridLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
          OnGetText = vtLogGetText
          OnGetImageIndex = vtLogGetImageIndex
          Touch.InteractiveGestures = [igPan, igPressAndTap]
          Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
          Columns = <>
        end
      end
    end
  end
  object SynPasSyn1: TSynPasSyn
    CommentAttri.Foreground = clGreen
    DirectiveAttri.Foreground = clTeal
    KeyAttri.Foreground = clNavy
    StringAttri.Foreground = clBlue
    Left = 48
    Top = 272
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = actStartScan
            Caption = 'Sca&n'
            ImageIndex = 6
            ShortCut = 120
          end
          item
            Visible = False
            Action = actStopScan
            ImageIndex = 3
            ShortCut = 16497
          end
          item
            Caption = '-'
          end
          item
            Action = actRename
            Caption = 'R&ename'
            ImageIndex = 2
          end
          item
            Caption = '-'
          end
          item
            Visible = False
            Action = actSaveChanges
            Caption = 'S&ave Changes'
            ImageIndex = 1
          end
          item
            Caption = '-'
          end
          item
            Action = actShowUnitsNotInPath
            Caption = '&Show Units not in Path'
          end
          item
            Caption = '-'
          end
          item
            Action = actExpandAll
            Caption = 'E&xpand All'
          end
          item
            Action = actCollapseAll
            Caption = '&Collapse All'
          end>
      end
      item
        Items = <
          item
            Action = actStartScan
            Caption = '&Scan'
            ImageIndex = 6
            ShortCut = 120
          end
          item
            Visible = False
            Action = actStopScan
            ImageIndex = 3
            ShortCut = 16497
          end
          item
            Caption = '-'
          end
          item
            Action = actRename
            Caption = '&Rename'
            ImageIndex = 2
          end
          item
            Caption = '-'
          end
          item
            Action = actExpandAll
            Caption = '&Expand All'
          end
          item
            Action = actCollapseAll
            Caption = '&Collapse All'
          end
          item
            Caption = '-'
          end
          item
            Action = actShowUnitsNotInPath
            Caption = 'S&how Units not in Path'
          end>
      end
      item
        Items = <
          item
            Action = actStartScan
            Caption = '&Scan'
            ImageIndex = 6
            ShortCut = 120
          end
          item
            Visible = False
            Action = actStopScan
            ImageIndex = 7
            ShortCut = 16497
          end
          item
            Caption = '-'
          end
          item
            Action = actSearchAndReplace
            Caption = 'Se&arch and Replace'
            ImageIndex = 9
          end
          item
            Action = actRename
            Caption = '&Rename'
            ImageIndex = 10
          end
          item
            Caption = '-'
          end
          item
            Action = actCollapseAll
            Caption = '&Collapse All'
          end
          item
            Caption = '-'
          end
          item
            Action = actShowUnitsNotInPath
            Caption = 'S&how Units not in Path'
          end
          item
            Caption = '-'
          end
          item
            Action = actSettings
            Caption = 'Se&ttings'
          end
          item
            Caption = '-'
          end
          item
            Action = actSaveToXML
            Caption = 'Sa&ve to XML'
          end
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end>
        ActionBar = ActionToolBar1
      end>
    Images = ImageList1
    OnUpdate = ActionManager1Update
    Left = 136
    Top = 128
    StyleName = 'Platform Default'
    object actStartScan: TAction
      Caption = 'Scan'
      ImageIndex = 6
      ShortCut = 120
      OnExecute = actStartScanExecute
    end
    object actStopScan: TAction
      Caption = 'Stop'
      ImageIndex = 7
      ShortCut = 16497
      Visible = False
      OnExecute = actStopScanExecute
    end
    object actShowUnitsNotInPath: TAction
      AutoCheck = True
      Caption = 'Show Units not in Path'
      OnExecute = actShowUnitsNotInPathExecute
    end
    object actSaveChanges: TAction
      Caption = 'Save Changes'
      Visible = False
      OnExecute = actSaveChangesExecute
    end
    object actRename: TAction
      Caption = 'Rename'
      ImageIndex = 10
      OnExecute = actRenameExecute
    end
    object actExpandAll: TAction
      Caption = 'Expand All'
      OnExecute = actExpandAllExecute
    end
    object actExpand: TAction
      Caption = 'Expand'
      OnExecute = actExpandExecute
    end
    object actCollapseAll: TAction
      Caption = 'Collapse All'
      OnExecute = actCollapseAllExecute
    end
    object actCollapse: TAction
      Caption = 'Collapse'
      OnExecute = actCollapseExecute
    end
    object actSettings: TAction
      Caption = 'Settings...'
      OnExecute = actSettingsExecute
    end
    object actExit: TAction
      Caption = 'Exit'
      OnExecute = actExitExecute
    end
    object actLoadProject: TAction
      Caption = 'Load Project'
      OnExecute = actLoadProjectExecute
    end
    object actSaveProject: TAction
      Caption = 'Save Project'
      OnExecute = actSaveProjectExecute
    end
    object actSaveProjectAs: TAction
      Caption = 'Save Project As'
      OnExecute = actSaveProjectAsExecute
    end
    object actNewProject: TAction
      Caption = 'New'
      OnExecute = actNewProjectExecute
    end
    object actCloseProject: TAction
      Caption = 'Close'
      OnExecute = actCloseProjectExecute
    end
    object actSearchAndReplace: TAction
      Caption = 'Search and Replace'
      ImageIndex = 9
      OnExecute = actSearchAndReplaceExecute
    end
    object actShowFile: TAction
      Caption = 'Show file in Windows Explorer'
      OnExecute = actShowFileExecute
    end
    object actSaveToXML: TAction
      Caption = 'Save to XML'
      OnExecute = actSaveToXMLExecute
    end
    object actSaveToGephiCSV: TAction
      Caption = 'Save to Gephi CSV'
      OnExecute = actSaveToGephiCSVExecute
    end
    object actSaveToGraphML: TAction
      Caption = 'Save to GraphML'
      OnExecute = actSaveToGraphMLExecute
    end
  end
  object popTree: TPopupMenu
    Left = 208
    Top = 128
    object Rename1: TMenuItem
      Action = actRename
      ShortCut = 113
    end
    object SearchandReplace1: TMenuItem
      Action = actSearchAndReplace
      ShortCut = 16466
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object ShowfileinWindowsExplorer1: TMenuItem
      Action = actShowFile
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Expand1: TMenuItem
      Action = actExpand
    end
    object Collapse1: TMenuItem
      Action = actCollapse
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object ExpandAll1: TMenuItem
      Action = actExpandAll
    end
    object CollapseAll1: TMenuItem
      Action = actCollapseAll
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ShowUnitsnotinPath1: TMenuItem
      Action = actShowUnitsNotInPath
      AutoCheck = True
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object SavetoXML1: TMenuItem
      Action = actSaveToXML
    end
    object SavetoGephiCSV1: TMenuItem
      Action = actSaveToGephiCSV
    end
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 128
    object File1: TMenuItem
      Caption = '&File'
      object New1: TMenuItem
        Action = actNewProject
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object LoadProject1: TMenuItem
        Action = actLoadProject
        Caption = 'Open Project...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object SaveProject1: TMenuItem
        Action = actSaveProject
      end
      object SaveProjectAs1: TMenuItem
        Action = actSaveProjectAs
        Caption = 'Save Project As...'
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Settings1: TMenuItem
        Action = actSettings
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Action = actCloseProject
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = actExit
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object SearchandReplace2: TMenuItem
        Action = actSearchAndReplace
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Rename2: TMenuItem
        Action = actRename
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object SaveChanges1: TMenuItem
        Action = actSaveChanges
      end
    end
    object Scan1: TMenuItem
      Caption = 'Scan'
      object Scan2: TMenuItem
        Action = actStartScan
      end
      object Stop1: TMenuItem
        Action = actStopScan
      end
    end
    object View1: TMenuItem
      AutoCheck = True
      Caption = 'View'
      OnClick = actShowUnitsNotInPathExecute
      object ShowUnitsnotinPath2: TMenuItem
        Action = actShowUnitsNotInPath
        AutoCheck = True
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ExpandAll2: TMenuItem
        Action = actExpandAll
      end
      object CollapseAll2: TMenuItem
        Action = actCollapseAll
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.dspr'
    Filter = 
      'Dependency Scanner Projects (*.dsprj)|*.dsprj|All Files (*.*)|*.' +
      '*'
    Title = 'Open Project'
    Left = 344
    Top = 200
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dsprj'
    Filter = 
      'Dependency Scanner Projects (*.dsprj)|*.dsprj|All Files (*.*)|*.' +
      '*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Project'
    Left = 280
    Top = 200
  end
  object tmrClose: TTimer
    Enabled = False
    Interval = 20
    OnTimer = tmrCloseTimer
    Left = 48
    Top = 336
  end
  object tmrLoaded: TTimer
    Interval = 1
    OnTimer = tmrLoadedTimer
    Left = 136
    Top = 336
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.xml'
    Filter = 'XML Files (*.xml)|*.xml|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Export to XML'
    Left = 48
    Top = 197
  end
  object SaveDialog3: TSaveDialog
    DefaultExt = '.csv'
    Filter = 'CSV Files (*.csv)|*.csv|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Export to Gephi Formatted CSV'
    Left = 136
    Top = 197
  end
  object SaveDialog4: TSaveDialog
    DefaultExt = '.graphml'
    Filter = 'GraphML Files (*.graphml)|*.graphml|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Export to GraphML'
    Left = 208
    Top = 197
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    Left = 48
    Top = 408
    Bitmap = {
      494C01010B001800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000100000012000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000030000009E000000F9000000120000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000001900000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0003000000A0000000FF0000009E000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000007D000000EF00000019000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000030000
      00A1000000FF0000009F00000003000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      007E000000FF0000007C00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000003000000A20000
      00FF000000A00000000300000000000000000000000000000000000000480000
      00370000001B0000009C000000E9000000FB000000D40000006D000000800000
      00FF0000007D000000000000000000000000E8E8E8FFE8E8E8FFE8E8E8FFE8E8
      E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FF616161FF959595FF6D6D6DFFE8E8
      E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000A00000074000000BC000000C90000009D0000003300000032000000FF0000
      00A1000000030000000000000000000000000000000000000000000000580000
      00F0000000E9000000DD000000770000005D00000094000000F8000000FF0000
      008000000000000000000000000000000000C9C9C9FFFCFCFCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFF616161FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFE8E8E8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000190000
      00D60000009E000000400000002F00000068000000E2000000D8000000320000
      0003000000000000000000000000000000000000000000000000000000580000
      00FF000000FF0000004200000000000000000000000000000038000000F70000
      006D00000000000000000000000000000000C9C9C9FFFCFCFCFFC38F6BFFC391
      6CFFC3916DFFC2926EFFC2936FFFC19370FFFCFCFCFF616161FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFE8E8E8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000BA0000
      006F000000000000000000000000000000000000001A000000E2000000330000
      0000000000000000000000000000000000000000000000000000000000580000
      00FF000000FF000000F000000037000000000000000000000000000000920000
      00D200000000000000000000000000000000C9C9C9FFFCFCFCFFC38F6AFFD99B
      72FFD69B72FFD69D75FFD6A17AFFC2936FFFFCFCFCFF616161FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFE8E8E8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000028000000D90000
      00010000000000000000000000000000000000000000000000680000009D0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C9C9C9FFFCFCFCFFC38F6AFFD998
      71FFD89971FFD69B73FFD79F78FFC2926EFFFCFCFCFF616161FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFE8E8E8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000053000000A10000
      000000000000000000000000000000000000000000000000002F000000C90000
      0000000000000000000000000000000000000000000000000000000000240000
      00A80000001A00000000000000000000000000000070000000A8000000A80000
      00A800000000000000000000000000000000C9C9C9FFFCFCFCFFC38F6AFFC490
      6BFFC38F6BFFC3906CFFC3916CFFC3916DFFFCFCFCFF616161FFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFE8E8E8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000046000000B40000
      0000000000000000000000000000000000000000000000000040000000BC0000
      0000000000000000000000000000000000000000000000000000000000070000
      00EB000000920000000000000000000000000000000F000000C8000000FF0000
      00FF00000000000000000000000000000000C9C9C9FFFCFCFCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFF6B6B6BFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFCFCFCFFE8E8E8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000C000000E80000
      001A00000000000000000000000000000000000000000000009F000000730000
      0000000000000000000000000000000000000000000000000000000000000000
      005E000000FF000000920000001F0000000400000038000000C7000000FF0000
      00FF00000000000000000000000000000000C9C9C9FFC9C9C9FFC9C9C9FFC9C9
      C9FFC9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FF6A6A6AFF8E8E8EFF747474FFC9C9
      C9FFC9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000006B0000
      00CA0000001A00000000000000000000000100000072000000D40000000A0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000005F000000ED000000FF000000FF000000FF000000C9000000360000
      00C8000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      006B000000E8000000B4000000A2000000D9000000B800000018000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000800000042000000540000002F00000000000000000000
      000F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000C0000004600000053000000270000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000040000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000004000000010000000000000000000000000000
      000000000130080B2E9617228DD82335D8F92335D8F917218AD7070A2D940000
      012E000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000001C0000001B00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000050362C60705B1F40503AEF40603AEF40603AEF40603AEF40602B1F40200
      61C600000000000000000000000000000000000204290E5A85E1136796EE1469
      99EF146A9AEF146A9AEF146A9AEF146A9AEF146A9AEF146A9AEF146A9AEF146A
      9AEF146A9AEF136896EE11608EE8084669C9000000000000000000000009080B
      31992739E9FF2739E9FF2739E9FF2739E9FF2739E9FF2739E9FF2739E9FF2739
      E9FF070B2D950000000800000000000000000000000000000000000000000000
      00000000001715151594323233DF2F2F2FD72F2F30D8313131DE151516930000
      0015000000000000000000000000000000000000000000000000000000000806
      6FCF1614EBFF0F0DF7FF0E0CF4FF0E0CF4FF0E0BF4FF0E0AF4FF0E0AF7FF0B08
      EAFF02006FCF00000000000000000000000002141E67087BBCFE078CD8FF03A4
      DEFF00B4E5FF00C5EAFF00D0EFFF00DAF3FF00DEF5FF00D7F1FF00CEEDFF00BF
      E8FF00ADE1FF0392D9FF0780C8FF0A6497F40000000000000009111865C1283B
      EAFF283BEAFF283BEAFF283BEAFF283BEAFF283BEAFF283BEAFF283BEAFF283B
      EAFF283BEAFF101961BF00000008000000000000000000000000000000000606
      064F303031DC0303033C000000140000000000000000000000150303033D3131
      31DE0505054B0000000000000000000000000000000000000000080775CF1819
      ECFF1012F3FF0F10EDFF0F10EEFF0F0FEEFF0F0FEEFF0E0EEDFF0E0EEDFF0F0E
      F2FF0E0CE9FF040174CF0000000000000000000000060E7AB9FB0995D9FF0FA2
      E2FF00A3E2FF00AAE4FF00B3EAFF1B799EFF21769AFF02B3E8FF00ADE5FF00A5
      E3FF009DE1FF0FA0E3FF127DB5FF063048AB00000000080D3299283CEBFF3043
      ECFF3547ECFF283CEBFF283CEBFF283CEBFF283CEBFF283CEBFF283CEBFF3043
      ECFF2B3FEBFF283CEBFF070B2D950000000000000000000000000606064E1B1B
      1CA600000000000000001811035D161005630000000000000000000000000000
      00001C1C1CA80505054B000000000000000000000000090879CF191EEBFF1217
      F2FF1116EEFF1115EEFF1114EEFF1114EEFF1113EEFF1114EEFF1013EEFF1011
      EEFF1012F2FF0F0FEAFF040378CF000000000000000006293E990E84C4FF15B1
      ECFF16BBEDFF00BAEEFF00C7F5FF0F7195FF10688BFF00C4F0FF00BDEFFF00B4
      ECFF16B4ECFF22A5DAFF0C6596F30000000800000130293EECFF293EECFF3246
      EDFFA6AFF7FF384CEDFF293EECFF293EECFF293EECFF293EECFF3448EDFFA7B0
      F7FF3448EDFF293EECFF293EECFF0000012E0000000000000018303031DB0000
      0000000000000000001298660DDEDE8E05F92217077800000000000000000000
      000000000000313131DE00000015000000000A0973C71C26EFFF0915F5FF0D18
      F0FF131CEFFF1019F1FF0F18F1FF131AEFFF0F16F1FF0911F0FF0E14F0FF1015
      F0FF0E13F2FF1316F4FF1114EAFF040373C700000000000000071274ABF115A4
      DEFF43D5F6FF05C9F4FF00D1F7FF10CAEBFF15C7E7FF00D4F9FF00CAF5FF05C2
      F2FF46D4F7FF1275AAFD0110186500000000080D31982A3FEDFF2A3FEDFF2A3F
      EDFF3549EEFFA7B0F8FF394CEEFF2A3FEDFF2A3FEDFF3549EEFFA7B0F8FF3A4D
      EEFF2A3FEDFF2A3FEDFF2A3FEDFF080C2E9400000000161616950303033A0000
      0000000000000000001A9B6B0CDDFFA200FFE38E04F922170778000000000000
      0000000000000303033D15151693000000001C21D1FA2833E6FF141CF7FF141C
      F7FF141CF7FF141CF7FF141CF7FF141CF7FF141CF7FF141CF7FF141CF7FF141C
      F7FF141CF7FF141CF7FF141CF7FF0C0ECDFA000000000000000002111A660E82
      C1FF38D5F9FF43E0FAFF00E1FFFF11819EFF157895FF00E4FFFF00D4FAFF43DC
      FAFF36ADD6FF0B5079DA00000000000000001B2895DA2A41EEFF2A41EEFF2A41
      EEFF2A41EEFF354BEFFFA6B0F8FF394EEFFF344AEFFFA6B0F8FF3A4FEFFF2A41
      EEFF2A41EEFF2A41EEFF2A41EEFF19268ED700000000333333E2000000110000
      0000000000000000001A9B6B0CDDFFA200FFFF9C00FFE38904F9221607780000
      00000000000000000015313131DE000000001419C6F4AFAAE6FFFFFFFFFFFFFF
      FFFF2829D1FFFFFFFFFF0005DAFF0005DAFFEBE8F2FFFFFFFFFFEBE8F2FF2A33
      E1FFFFFFFFFF0D1AF3FF141FF0FF0D11C6F40000000000000000000000001362
      8EDD1FA7DBFF76EBFCFF1FEAFEFF146D8AFF136583FF08ECFFFF1CDCFEFF73E3
      F6FF0F70A6FD000508390000000000000000283FDFFA2B42EFFF2B42EFFF2B42
      EFFF2B42EFFF2B42EFFF364CF0FFA6B0F8FFA6B0F8FF3B50F0FF2B42EFFF2B42
      EFFF2B42EFFF2B42EFFF2B42EFFF283CDEF90000001F2D2D2ED4000000000000
      0000000000000000001A9B6B0CDDFFA200FFFF9C00FFFF9600FFD87F09F9120B
      035500000000000000002F2F30D80000001B1F25CBF40715E9FF8F88ECFFFFFF
      FFFF2A33E1FFFFFFFFFF2A33E1FF2A33E1FFFFFFFFFF0C20F3FFFFFFFFFF2A33
      E1FFFFFFFFFFFFFFFFFFFFFFFFFF0204C6F40000000000000000000000000006
      093F1183C1FF47D9F6FF67EEFCFF166684FF145F7CFF20E9FFFF66EAFCFF329C
      C7FF073A57BB0000000000000000000000002941E0FA2C44F0FF2C44F0FF2C44
      F0FF2C44F0FF2C44F0FF374DF1FFA9B2F9FFA9B2F9FF3B51F1FF2C44F0FF2C44
      F0FF2C44F0FF2C44F0FF2C44F0FF293EDEF9010101202D2D2DD3000000000000
      0000000000000000001A9B6B0CDDFFA200FFFF9C00FFFF9600FFD97B08FA140C
      035900000000000000002F2F2FD70000001C3D43D3F4AFAAE6FFFFFFFFFF0510
      E4FF0510E4FFFFFFFFFF2A33E1FF2A33E1FFFFFFFFFF0F28F2FFFFFFFFFF2A33
      E1FFFFFFFFFF756EEDFFFFFFFFFF201FCBF40000000000000000000000000000
      0000124C6EC51E96CEFF6AECFDFF2B85A2FF186688FF46E6FEFF62D4ECFF0E6C
      A1FA000001140000000000000000000000001C2C99DB2D45F1FF2D45F1FF2D45
      F1FF2D45F1FF384EF2FFA8B2F9FF3D53F2FF384FF2FFA9B3F9FF3C52F2FF2D45
      F1FF2D45F1FF2D45F1FF2D45F1FF1B2A92D800000000343435E3000000100000
      0000000000000000001A9B6B0CDDFFA200FFFF9C00FFE58703FA2417077A0000
      00000000000000000014323233DF000000004950D8F4FFFFFFFFFFFFFFFFAFAA
      E6FFFFFFFFFFFFFFFFFFFFFFFFFFAFAAE6FFEBE8F2FFFFFFFFFFEBE8F2FF2A33
      E1FFFFFFFFFFFFFFFFFFFFFFFFFF3334D3F40000000000000000000000000000
      0000000102201B84BFFC47C8EAFF5ED8F0FF43C6E5FF67EAFEFF2283B4FE0320
      308C000000000000000000000000000000000A0F33992D47F2FF2D47F2FF2D47
      F2FF3750F3FFA7B2FAFF3D55F3FF2D47F2FF2D47F2FF3851F3FFA9B4FAFF3C54
      F3FF2D47F2FF2D47F2FF2D47F2FF090E31960000000016161797030303390000
      0000000000000000001A9B6B0CDDFFA200FFE58E03FA2418077A000000000000
      0000000000000303033C1515159400000000585FE4FA4D66F3FF4D66F3FF4D66
      F3FF4D66F3FF4D66F3FF4D66F3FF4D66F3FF4D66F3FF4D66F3FF4D66F3FF4D66
      F3FF4D66F3FF4D66F3FF4D66F3FF3C44E2FA0000000000000000000000000000
      0000000000000C2E439D1888C5FF67E8FDFF66EAFFFF5AC0DFFF0F6291EE0000
      000300000000000000000000000000000000000001322E48F3FF2E48F3FF364F
      F3FFA8B3FAFF3D56F4FF2E48F3FF2E48F3FF2E48F3FF2E48F3FF3952F4FFA9B4
      FAFF3951F4FF2E48F3FF2E48F3FF00000130000000000000001B2F2F30D80000
      0000000000000000001396660DDEE19404FA2418077A00000000000000000000
      000000000000303031DC000000170000000029288FC7768DF6FF5273F4FF4967
      F4FF506FF4FF4A69F4FF4969F4FF4F6DF4FF506EF4FF4664F3FF4B69F4FF506C
      F4FF4765F4FF4969F5FF4D66F3FF23228EC70000000000000000000000000000
      000000000000000000102885B6F552BFE1FF85F1FBFF1776A9FE010B12570000
      000000000000000000000000000000000000000000000B11389D2F4AF4FF3751
      F4FF3C55F5FF2F4AF4FF2F4AF4FF2F4AF4FF2F4AF4FF2F4AF4FF2F4AF4FF3852
      F4FF334EF4FF2F4AF4FF0A103398000000000000000000000000060607521A1A
      1AA400000000000000001A1203611A1205680000000000000000000000000000
      00001B1B1CA60606064F0000000000000000000000002E2C9CCF7C90F6FF5E7B
      F5FF5774F4FF5976F4FF5874F4FF5873F4FF5773F4FF5773F4FF5672F4FF5571
      F4FF5775F4FF536CF4FF26259CCF000000000000000000000000000000000000
      00000000000000000000041621721784C2FF56A6CAFF0D4C71D2000000000000
      000000000000000000000000000000000000000000000000000A15216CC32F4B
      F5FF2F4BF5FF2F4BF5FF2F4BF5FF2F4BF5FF2F4BF5FF2F4BF5FF2F4BF5FF2F4B
      F5FF2F4BF5FF132169C100000009000000000000000000000000000000000606
      07522F2F30D803030339000000100000000000000000000000110303033A3030
      31DB0606064E00000000000000000000000000000000000000002F2C9DCF7D93
      F7FF6182F6FF5775F4FF5976F4FF5976F4FF5775F4FF5775F4FF5774F4FF5A7B
      F4FF5670F4FF27269DCF00000000000000000000000000000000000000000000
      0000000000000000000000000000093853AD0C3F5CBB00020326000000000000
      00000000000000000000000000000000000000000000000000000000000A0B12
      399D304DF6FF304DF6FF304DF6FF304DF6FF304DF6FF304DF6FF304DF6FF304D
      F6FF0A1035990000000900000000000000000000000000000000000000000000
      00000000001B16161797343435E32D2D2DD32D2D2ED4333333E2161616950000
      0018000000000000000000000000000000000000000000000000000000002F2D
      9FCF8095F7FF7090F7FF6B8BF7FF6C8CF7FF6C8CF7FF6B8BF7FF6D8EF6FF5D77
      F5FF27259ECF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000001320A1035991F319BDB2D49E7FA2D49E7FA1F309ADA0A1034980000
      0130000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000010101200000001F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002C2992C6595FDFF4545BDFF4555CDFF4555CDFF4555CDFF4585FDFF42826
      92C6000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000010100141B160D55372D1B78362C1A771B150D54010100130000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000C90000
      00CA0000002A00000084000000D2000000F9000000F7000000D4000000870000
      0019000000000000000000000000000000000000000000000000000000000101
      0016604D2F9EF0C278FAFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFF0C278FA5E4C
      2E9C010100140000000000000000000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF00000000000000000000000000000000000000000000
      000700000071000000CC000000F7000000F7000000C900000069000000040000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00F20000005500000000000000000000000000000000000000000706032DCAA2
      62E5FCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC
      7CFFC8A263E40705032B00000000000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000000000000000000000000000000000001C0000
      00D3000000FF000000FF000000FF000000FF000000FF000000FF000000990000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FD0000005500000009000000090000003D000000AE0000
      00FF000000FD0000005400000000000000000000000001010016CBA465E6FCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF79623CB17C633DB3FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFC8A263E401010014000000000000000000000000000000FF0000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF00000000000000FF00000000000000000000000000000007000000D30000
      00FF000000D10000004800000007000000090000004F000000B1000000130000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000CB000000000000000000000000000000000000
      0078000000FF000000F20000001B0000000000000000624E309FFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF0000000500000006FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFF5D4A2E9B000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF00000000000000000000000000000071000000FF0000
      00D00000000C0000000000000000000000000000000000000000000000000000
      007E000000700000000000000000000000000000000000000000000000CC0000
      00FF000000FF000000FF000000C7000000000000000000000000000000000000
      0000000000B1000000FF000000940000000001010015F2C676FBFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF0000000000000000FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFF0C278FA010100130000000000000000000000FF0000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF00000000000000FF000000000000000000000000000000CD000000FF0000
      0045000000000000000000000000000000000000000000000000000000790000
      00FF000000FD0000005200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000034000000FF000000EA000000001D170E57FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF0000000000000000FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF1B150D540000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000000000000000000000000000F8000000FD0000
      0005000000000000000000000000000000000000000000000074000000FF0000
      00FF000000FF000000F600000039000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000CC000000C900000000382D1B79FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF0000000000000000FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF362C1A770000000000000000000000FF0000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF00000000000000FF000000000000000000000000000000F8000000FD0000
      000500000000000000000000000000000000000000100000006B0000007A0000
      00FF000000EF0000006C000000570000000000000000000000C9000000C50000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000382D1B79FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF0B0905360B090537FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF372D1B780000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000000000000000000000000000CE000000FF0000
      0044000000000000000000000000000000000000000000000000000000540000
      00FF000000BD00000000000000000000000000000000000000ED000000FF0000
      002F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001D180E58FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFFEEC074F9EEC074F9FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFF1C170E560000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF00000000000000000000000000000073000000FF0000
      00CE0000000B000000000000000000000000000000000000000F000000D80000
      00FF000000650000000000000000000000000000000000000099000000FF0000
      00A90000000000000000000000000000000000000000000000C7000000FF0000
      00FF000000FF000000C6000000000000000001010015F2C676FBFCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFEAC072F70302011D0303011FEEC074F9FCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFF2C676FB010100150000000000000000000000FF0000
      0000000000FF000000FF000000FF000000FF000000FF00000000000000000000
      000000000080000000FF00000000000000000000000000000008000000D50000
      00FF000000CE00000043000000040000000500000048000000D5000000FF0000
      00CD00000005000000000000000000000000000000000000001E000000F40000
      00FF0000007000000000000000000000000000000000000000D2000000FF0000
      00FF000000FF000000FF000000000000000000000000635131A1FCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFFEAC072F70202011A0302011CEEC074F9FCCC7CFFFCCC
      7CFFFCCC7CFFFCCC7CFF624E309F000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0080000000FF00000080000000000000000000000000000000000000001E0000
      00D6000000FF000000FF000000FD000000FD000000FF000000FF000000D00000
      001A000000000000000000000000000000000000000000000000000000580000
      00FE000000FF000000A900000039000000080000000700000052000000FD0000
      00FF000000FF000000FF00000000000000000000000002010017CEA967E8FCCC
      7CFFFCCC7CFFFCCC7CFFFCCC7CFFEAC072F7EAC072F7FCCC7CFFFCCC7CFFFCCC
      7CFFFCCC7CFFCBA465E601010016000000000000000000000000000000FF0000
      0000000000000000000000000000000000000000000000000000000000800000
      00FF000000800000000000000000000000000000000000000000000000000000
      000900000074000000CF000000F9000000F8000000CC00000070000000070000
      0000000000000000000000000000000000000000000000000000000000000000
      005A000000F4000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000000000000000000000000000000806042FCEA9
      67E8FCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFFCCC
      7CFFCBA465E60706032D00000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0080000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000001B0000008B000000D6000000F8000000FA000000D5000000870000
      002E000000D1000000C900000000000000000000000000000000000000000201
      0017635131A1F2C676FBFCCC7CFFFCCC7CFFFCCC7CFFFCCC7CFFF2C676FB624E
      309F010100160000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000010100151D180E58382D1B79382D1B791D170E57010100150000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
