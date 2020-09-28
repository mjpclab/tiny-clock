program clock;

uses
  Forms,
  main in 'main.pas' {frmMain},
  timeMan in 'timeMan.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
