program DependencyScanner;

uses
  Vcl.Forms,
  Duds.Vcl.Form.Main in 'Duds.Vcl.Form.Main.pas' {frmMain},
  Duds.Vcl.Form.FindReplace in 'Duds.Vcl.Form.FindReplace.pas' {frmSearchAndReplace},
  Duds.Vcl.Form.Settings in 'Duds.Vcl.Form.Settings.pas' {frmDependencyScannerSetting},
  Duds.Vcl.Form.Rename in 'Duds.Vcl.Form.Rename.pas' {frmRenameUnit},
  Duds.Common.Interfaces in 'Duds.Common.Interfaces.pas',
  Duds.Common.Types in 'Duds.Common.Types.pas',
  Duds.Common.Files in 'Duds.Common.Files.pas',
  Duds.Common.Strings in 'Duds.Common.Strings.pas',
  Duds.Common.Helper.IniFile in 'Duds.Common.Helper.IniFile.pas',
  Duds.Common.Classes in 'Duds.Common.Classes.pas',
  Duds.Common.Utils in 'Duds.Common.Utils.pas',
  Duds.Vcl.HourGlass in 'Duds.Vcl.HourGlass.pas',
  Duds.Common.Parser.Pascal in 'Duds.Common.Parser.Pascal.pas',
  Duds.Common.Parser.Pascal.Tokeniser in 'Duds.Common.Parser.Pascal.Tokeniser.pas',
  Duds.Vcl.Utils in 'Duds.Vcl.Utils.pas',
  Duds.Common.Delphi in 'Duds.Common.Delphi.pas',
  Duds.Vcl.VirtualTreeview in 'Duds.Vcl.VirtualTreeview.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Delphi Unit Dependency Scanner';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
