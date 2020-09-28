unit timeMan;

interface

type TTimeManager = class
  public
    function GetHhMmSs: string;
  private
    hour:Word;
    minute:Word;
    second:Word;
end;

implementation

uses SysUtils,DateUtils;

{ timeManager }

function TTimeManager.GetHhMmSs: string;
var
  t: TDateTime;
  hour,minute,second: Word;
  ms:Word;
begin
  t:=Now();
  DecodeTime(t,hour,minute,second,ms);

  if (hour<>self.hour) or (minute<>self.minute) or (second<>self.second) then begin
    Result:=FormatDateTime('hh:mm:ss', t);
  end;

  self.hour:=hour;
  self.minute:=minute;
  self.second:=second;
end;

end.
