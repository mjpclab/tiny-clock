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
  private
    { Private declarations }
    procedure UpdateTime();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.UpdateTime();
begin
  lblTime.Caption:=FormatDateTime(' hh:mm:ss ', Now());
end;

procedure TForm1.timerTimer(Sender: TObject);
begin
  UpdateTime();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.DoubleBuffered:=true;
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
        lblTime.Font.Size:=lblTime.Font.Size+1;
    40: // down
      if lblTime.Font.Size > 5 then
        lblTime.Font.Size:=lblTime.Font.Size-1;
  end;

end;

end.
