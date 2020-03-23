unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    lblTime: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  UpdateTime();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  self.DoubleBuffered:=true;
  UpdateTime();
end;

end.
