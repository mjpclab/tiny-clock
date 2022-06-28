unit util;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function GetHhMmSs: string;

implementation

const Code0 = Ord('0');
var
  lastHour, lastMinute, lastSecond: Word;

  currentTime: TDateTime;
  hour, minute, second, ms: Word;
  timeBuf: array[0..7] of Char;

function GetHhMmSs: string;
begin
  currentTime:=Now();
  DecodeTime(currentTime,hour,minute,second,ms);

  if (hour=lastHour) And (minute=lastMinute) And (second=lastSecond) then begin
    Result:='';
    Exit;
  end;

  lastHour := hour;
  lastMinute := minute;
  lastSecond := second;

  timeBuf[0]:=Chr((hour div 10) + Code0);
  timeBuf[1]:=Chr((hour mod 10) + Code0);
  timeBuf[2]:=':';
  timeBuf[3]:=Chr((minute div 10) + Code0);
  timeBuf[4]:=Chr((minute mod 10) + Code0);
  timeBuf[5]:=':';
  timeBuf[6]:=Chr((second div 10) + Code0);
  timeBuf[7]:=Chr((second mod 10) + Code0);

  Result:=timeBuf;
end;

end.

