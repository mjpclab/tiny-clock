unit bar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, main, ExtCtrls;

type
  TfrmBar = class(TForm)
    timerHideMainForm: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure timerHideMainFormTimer(Sender: TObject);
  private
    frmMain:TfrmMain;
    procedure CreateMainForm;
    procedure ShowMainForm;
    procedure HideMainForm;
    procedure OnMainFormResize(Sender: TObject);
    procedure OnMainFormMouseLeave(Sender: TObject);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBar: TfrmBar;

implementation

{$R *.dfm}

procedure TfrmBar.CreateMainForm;
begin
  Self.frmMain:=TFrmMain.Create(self);
  Self.frmMain.OnResize:=Self.OnMainFormResize;
  Self.frmMain.OnResize(Self.frmMain);
  Self.frmMain.OnMouseLeave:=Self.OnMainFormMouseLeave;
end;

procedure TfrmBar.OnMainFormResize(Sender: TObject);
begin
  Self.frmMain.top:=0;
  Self.frmMain.left:=screen.width-Self.frmMain.width;
end;

procedure TfrmBar.OnMainFormMouseLeave(Sender: TObject);
begin
    self.timerHideMainForm.Enabled:=false;
    self.timerHideMainForm.Enabled:=true;
end;

procedure TfrmBar.CMMouseLeave(var Message: TMessage);
begin
  if (Self.frmMain<>nil) then begin
    self.timerHideMainForm.Enabled:=false;
    self.timerHideMainForm.Enabled:=true;
  end;
end;

procedure TfrmBar.ShowMainForm;
begin
  Self.frmMain.Show;
  Self.SetFocus;
end;

procedure TfrmBar.HideMainForm;
begin
  Self.frmMain.Hide;
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
  timerHideMainForm.Enabled:=false;
  if Self.frmMain=nil then Self.CreateMainForm;
  if Self.frmMain.Visible=false then begin
    Self.ShowMainForm;
  end;
end;

procedure TfrmBar.timerHideMainFormTimer(Sender: TObject);
begin
  self.HideMainForm;
  self.timerHideMainForm.Enabled:=false;
end;

end.
