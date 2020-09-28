unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, timeMan;

type
  TfrmMain = class(TForm)
    timer: TTimer;
    lblTime: TLabel;
    procedure timerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  private
    timeManager:TTimeManager;
    { Private declarations }
    procedure UpdateLayout;
    procedure UpdateTime;
    procedure UpdateWinRgn;
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
var
  newWidth, newHeight : integer;
begin
  newWidth := lblTime.Width + lblTime.Font.Size;
  newHeight := lblTime.Height;
  MoveWindow(self.Handle, Left, Top, newWidth, newHeight, False);

  lblTime.Left:=Round(lblTime.Font.Size/2);
end;

procedure TfrmMain.UpdateWinRgn;
var
  roundRgn: THandle;
  r: integer;
begin
  r:=Round(self.Height * 0.13);
  roundRgn:=CreateRoundRectRgn(0, 0, self.Width, self.Height, r, r);
  if roundRgn <> 0 then begin
    SetwindowRgn(self.handle, roundRgn, true)
  end;
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
  UpdateWinRgn();
  UpdateTime();
end;

procedure TfrmMain.timerTimer(Sender: TObject);
begin
  UpdateTime();
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    27: // ESC
      self.Close();
    37: // left
      begin
        if self.AlphaBlendValue >=5 then
          self.AlphaBlendValue:=self.AlphaBlendValue-5
        else
          self.AlphaBlendValue:=0
      end;
    39: // right
      begin
        if self.AlphaBlendValue <=250 then
          self.AlphaBlendValue:=self.AlphaBlendValue+5
        else
          self.AlphaBlendValue:=255
      end;
    38: // up
      begin
        lblTime.Font.Size:=lblTime.Font.Size+1;
        UpdateLayout();
        UpdateWinRgn();
      end;
    40: // down
      if lblTime.Font.Size > 5 then begin
        lblTime.Font.Size:=lblTime.Font.Size-1;
        UpdateLayout();
        UpdateWinRgn();
      end;
  end;

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

end.
