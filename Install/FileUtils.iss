function GetCommandlineParam(const ParamName: String): String;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to ParamCount - 1 do
  begin
    MsgBox(ParamStr(i), mbInformation, mb_OK);
  
    if pos('\d' + ParamName, ParamStr(i)) = 1 then
    begin
      Result := copy(ParamStr(i), pos('=', ParamStr(i)) + 1, length(ParamStr(i)));
      
      Break; 
    end;    
  end;
end;

procedure KillTask(const TaskExeName: String);
var
  ResultCode: Integer;
begin
  Exec('taskkill.exe', '/IM ' + TaskExeName + ' /F', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
end;

procedure ForceAppQuit(const AppFileName, AppDescription: String; ForceKillTask: Boolean);
var
  ErrorCode: Integer;
  FilePath, WinKillPath: String;
begin
  FilePath := ExpandConstant('{app}\') + AppFileName;

  if FileExists(FilePath) then
  begin
    try
      Exec(FilePath, ' /QUIT', '', SW_HIDE, ewNoWait, ErrorCode);
    except
      // Just in case
    end;

    Sleep(1000);
  end;

  if ForceKillTask then
    KillTask(AppFilename)
end;
