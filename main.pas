unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, timeMan;

type
  TfrmMain = class(TForm)
    timer: TTimer;
    lblTime: TLabel;
    pnlPadLeft: TPanel;
    pnlPadRight: TPanel;
    procedure timerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    timeManager:TTimeManager;
    { Private declarations }
    procedure UpdateLayout;
    procedure UpdateTime;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMDisplayChange(var Message: TWMDisplayChange); message WM_DISPLAYCHANGE;
  protected
    FOnMouseLeave: TNotifyEvent;
  public
    { Public declarations }
  published
    property OnMouseLeave:TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

var
  frmMain: TfrmMain;

implementation


{$R *.dfm}

procedure TfrmMain.UpdateLayout;
begin
  MoveWindow(self.Handle, 0, Top, Screen.Width, Height, False);
end;

procedure TfrmMain.UpdateTime();
var
  str:string;
begin
  str:=self.timeManager.GetHhMmSs;
  if Length(str)>0 then begin
    lblTime.Caption:=str;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  self.timeManager:=TTimeManager.Create;
  self.DoubleBuffered:=true;
  UpdateLayout();
  UpdateTime();
end;

procedure TfrmMain.timerTimer(Sender: TObject);
begin
  UpdateTime();
end;

procedure TfrmMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(Self.Handle,WM_SYSCOMMAND,SC_MOVE+1,0)
end;

procedure TfrmMain.CMMouseLeave(var Message: TMessage);
begin
  if Assigned(Self.OnMouseLeave) then
    Self.OnMouseLeave(Self);
end;

procedure TfrmMain.WMDisplayChange(var Message: TWMDisplayChange);
begin
  self.UpdateLayout;
end;

end.
