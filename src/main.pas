unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, util;
type

  { TfrmMain }

  TfrmMain = class(TForm)
    lblTime: TLabel;
    timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure timerTimer(Sender: TObject);
  private
    moving: boolean;
    startX: integer;
    startY: integer;
    procedure UpdateTime;
    procedure UpdateLayout;
    procedure UpdateRoundCorner;
  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{$IFDEF Windows}
uses Windows;
{$ENDIF}

{ TfrmMain }

procedure TfrmMain.timerTimer(Sender: TObject);
begin
     UpdateTime;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  UpdateTime;
  UpdateLayout;
  UpdateRoundCorner;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  UpdateLayout;
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
        UpdateLayout;
        UpdateRoundCorner;
      end;
    40: // down
      if lblTime.Font.Size > 5 then begin
        lblTime.Font.Size:=lblTime.Font.Size-1;
        UpdateLayout;
        UpdateRoundCorner;
      end;
  end;
end;

procedure TfrmMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then begin
    moving:=true;
    startX:=X;
    startY:=Y;
  end;
end;

procedure TfrmMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if moving then begin
    Left:=Left + X - startX;
    Top:= Top + Y - startY;
  end;
end;

procedure TfrmMain.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  moving:=false;
end;

procedure TfrmMain.UpdateTime;
var
  hhmmss: string;
begin
  hhmmss := GetHhMmSs;
  if Length(hhmmss) > 0 then begin
    lblTime.Caption := hhmmss;
  end;
end;

procedure TfrmMain.UpdateLayout;
var
  newWidth, newHeight : integer;
  centerX, centerY: integer;
  hPadding: integer;
begin
  centerX := Left + (Width shr 1);
  centerY := Top + (Height shr 1);

  hPadding := (lblTime.Font.Size * Screen.PixelsPerInch div 96) shr 1;
  newWidth := lblTime.Width + hPadding;
  newHeight := lblTime.Height;

  Left := centerX - (newWidth shr 1);
  Top := centerY - (newHeight shr 1);
  Width := newWidth;
  Height := newHeight;

  lblTime.Left:=hPadding shr 1;
end;

procedure TfrmMain.UpdateRoundCorner;
{$IFDEF Windows}
var
  roundRgn: THandle;
  r: integer;
begin
  r:=Round(Height * 0.15);
  roundRgn:=CreateRoundRectRgn(0, 0, self.Width, self.Height, r, r);
  if roundRgn <> 0 then begin
    SetwindowRgn(Handle, roundRgn, true)
  end;
end;
{$ELSE}
begin
end;
{$ENDif}

end.

