unit bar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, main, ExtCtrls;

const hideDelayMax=5;
const showHideStep=5;

type
  TfrmBar = class(TForm)
    timerShowHide: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure timerShowHideTimer(Sender: TObject);
  private
    isShowMainForm: Boolean;
    hideDelayCount:integer;
    frmMain:TfrmMain;
    procedure CreateMainForm;
    procedure ToggleMainForm;
    procedure MainFormMouseLeave(Sender: TObject);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBar: TfrmBar;

implementation

uses Math;

{$R *.dfm}

procedure TfrmBar.CreateMainForm;
begin
  self.DoubleBuffered:=true;
  Self.frmMain:=TFrmMain.Create(self);
  Self.frmMain.OnMouseLeave:=Self.MainFormMouseLeave;
  Self.frmMain.Top:=-Self.frmMain.Height;
  Self.frmMain.Show;
end;

procedure TfrmBar.FormCreate(Sender: TObject);
begin
  // hide from task bar
  SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);

  self.left:=0;
  self.top:=0;
  self.width:=screen.width;
  self.height:=5;

  Self.CreateMainForm;
end;

procedure TfrmBar.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Self.frmMain=nil then Self.CreateMainForm;
  isShowMainForm:=true;
  Self.ToggleMainForm;
end;

procedure TfrmBar.CMMouseLeave(var Message: TMessage);
begin
  isShowMainForm:=false;
  self.ToggleMainForm;
end;

procedure TfrmBar.MainFormMouseLeave(Sender: TObject);
begin
  isShowMainForm:=false;
  self.ToggleMainForm;
end;

procedure TfrmBar.ToggleMainForm;
begin
  timerShowHide.Enabled:=false;
  timerShowHide.Enabled:=true;
end;

procedure TfrmBar.timerShowHideTimer(Sender: TObject);
begin
  if isShowMainForm then begin
    hideDelayCount:=0;
    if frmMain.Top < -frmMain.Height/2 then
      frmMain.Top:=Floor(-frmMain.Height/2)
    else if frmMain.Top<0 then
      frmMain.Top:=Min(0,frmMain.Top+showHideStep)
    else
      timerShowHide.Enabled:=false;
  end else begin
    if frmMain.Top<0 then hideDelayCount:=hideDelayMax;

    if hideDelayCount<hideDelayMax then
      Inc(hideDelayCount)
    else if frmMain.Top>-frmMain.Height then
      frmMain.Top:=frmMain.Top-showHideStep
    else
      timerShowHide.Enabled:=false;
  end;
end;

end.
