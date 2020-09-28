program clock;

uses
  Forms,
  main in 'main.pas' {frmMain},
  timeMan in 'timeMan.pas',
  bar in 'bar.pas' {frmBar};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBar, frmBar);
  Application.Run;
end.
