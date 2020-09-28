program clock;

uses
  Forms, Windows,
  main in 'main.pas' {frmMain},
  timeMan in 'timeMan.pas',
  bar in 'bar.pas' {frmBar};

{$R *.res}
var
  Mutex: THandle;

begin
  Mutex := CreateMutex (nil, True, 'net.mjpclab.win_top_bar_clock');
  if (Mutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then begin
    Exit;
  end;

  Application.Initialize;
  Application.CreateForm(TfrmBar, frmBar);
  Application.Run;
end.
