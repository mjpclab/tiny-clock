object frmMain: TfrmMain
  Left = 180
  Top = 110
  AlphaBlend = True
  AlphaBlendValue = 192
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Clock'
  ClientHeight = 108
  ClientWidth = 428
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblTime: TLabel
    Left = 0
    Top = 0
    Width = 208
    Height = 56
    Caption = '00:00:00'
    Color = clNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clLime
    Font.Height = -48
    Font.Name = 'Consolas'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ShowAccelChar = False
    Transparent = True
    Layout = tlCenter
    OnMouseDown = FormMouseDown
  end
  object timer: TTimer
    Interval = 250
    OnTimer = timerTimer
    Left = 296
    Top = 8
  end
end
