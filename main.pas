unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls  ;

type
  TForm1 = class(TForm)
    timer: TTimer;
    lblTime: TLabel;
    procedure timerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure UpdateLayout;
    procedure UpdateTime;
    procedure UpdateWinRgb;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.UpdateLayout;
var
  newWidth, newHeight : integer;
  newLeft, newTop : Integer;
begin
  newWidth := lblTime.Width + lblTime.Font.Size;
  newHeight := lblTime.Height;
  MoveWindow(self.Handle, Left, Top, newWidth, newHeight, False);

  lblTime.Left:=Round(lblTime.Font.Size/2);
end;

procedure TForm1.UpdateWinRgb;
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

procedure TForm1.UpdateTime();
begin
  lblTime.Caption:=FormatDateTime('hh:mm:ss', Now());
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.DoubleBuffered:=true;
  UpdateLayout();
  UpdateWinRgb();
  UpdateTime();
end;

procedure TForm1.timerTimer(Sender: TObject);
begin
  UpdateTime();
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  step:integer;
  value:integer;
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
        UpdateWinRgb();
      end;
    40: // down
      if lblTime.Font.Size > 5 then begin
        lblTime.Font.Size:=lblTime.Font.Size-1;
        UpdateLayout();
        UpdateWinRgb();
      end;
  end;

end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture; 
  PostMessage(Self.Handle,WM_SYSCOMMAND,SC_MOVE+1,0)
end;

end.
