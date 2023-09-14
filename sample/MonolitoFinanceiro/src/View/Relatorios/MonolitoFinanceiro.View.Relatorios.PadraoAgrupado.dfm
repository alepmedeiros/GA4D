object RelPadraoAgrupado: TRelPadraoAgrupado
  Left = 0
  Top = 0
  Caption = 'RelPadraoAgrupado'
  ClientHeight = 494
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 0
    Top = -5
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = RLReport1BeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 43
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 0
        Top = 0
        Width = 190
        Height = 24
        Align = faLeftTop
        Caption = 'Monolito Financeiro'
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 81
      Width = 718
      Height = 40
      BandType = btTitle
      object RLLabel2: TRLLabel
        Left = 270
        Top = 0
        Width = 177
        Height = 24
        Align = faCenterTop
        Caption = 'T'#237'tulo do Relat'#243'rio'
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 145
      Width = 718
      Height = 32
      BandType = btFooter
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object lblNome: TRLLabel
        Left = 0
        Top = 1
        Width = 79
        Height = 24
        Align = faLeftTop
      end
      object RLPanel1: TRLPanel
        Left = 79
        Top = 1
        Width = 639
        Height = 32
        Align = faClientTop
        object RLSystemInfo2: TRLSystemInfo
          Left = 536
          Top = 0
          Width = 103
          Height = 24
          Align = faRightTop
          Alignment = taRightJustify
          AutoSize = False
          Info = itLastPageNumber
          Text = 'de '
        end
        object RLSystemInfo1: TRLSystemInfo
          Left = 325
          Top = 0
          Width = 211
          Height = 24
          Align = faRightTop
          Alignment = taRightJustify
          Info = itPageNumber
          Text = 'P'#225'gina '
        end
      end
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    Left = 437
    Top = 252
  end
end
