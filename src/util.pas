unit util;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function GetHhMmSs: string;

implementation

const Code0=Ord('0');

function GetHhMmSs: string;
var
  t: TDateTime;
  hour,minute,second: Word;
  ms:Word;
  buf: array[0..7] of Char;
begin
  t:=Now();
  DecodeTime(t,hour,minute,second,ms);

  buf[0]:=Chr((hour div 10) + Code0);
  buf[1]:=Chr((hour mod 10) + Code0);
  buf[2]:=':';
  buf[3]:=Chr((minute div 10) + Code0);
  buf[4]:=Chr((minute mod 10) + Code0);
  buf[5]:=':';
  buf[6]:=Chr((second div 10) + Code0);
  buf[7]:=Chr((second mod 10) + Code0);

  Result:=buf;
end;

end.

