object Form1: TForm1
  Left = 204
  Top = 141
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Clock'
  ClientHeight = 112
  ClientWidth = 530
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblTime: TLabel
    Left = 0
    Top = 0
    Width = 530
    Height = 112
    Caption = ' 00:00:00 '
    Color = clNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clLime
    Font.Height = -96
    Font.Name = 'Consolas'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 392
    Top = 80
  end
end
