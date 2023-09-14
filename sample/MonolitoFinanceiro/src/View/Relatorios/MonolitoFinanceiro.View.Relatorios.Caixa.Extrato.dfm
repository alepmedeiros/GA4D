inherited RelCaixaExtrato: TRelCaixaExtrato
  Caption = 'RelCaixaExtrato'
  ClientWidth = 774
  ExplicitWidth = 790
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport1: TRLReport
    DataSource = DataSource1
    inherited RLBand2: TRLBand
      inherited RLLabel2: TRLLabel
        Left = 278
        Width = 162
        Caption = 'Extrato do Caixa'
        ExplicitLeft = 278
        ExplicitWidth = 162
      end
    end
    inherited RLBand5: TRLBand
      Top = 305
      ExplicitTop = 305
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 146
      Width = 718
      Height = 55
      DataFields = 'data_cadastro'
      object RLBand4: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 25
        BandType = btHeader
        object RLDBText1: TRLDBText
          Left = 0
          Top = 0
          Width = 141
          Height = 24
          Align = faLeftTop
          DataField = 'data_cadastro'
          DataSource = DataSource1
          Text = ''
        end
      end
      object RLBand6: TRLBand
        Left = 0
        Top = 25
        Width = 718
        Height = 24
        object RLDBText2: TRLDBText
          Left = 120
          Top = 0
          Width = 121
          Height = 24
          Align = faTopOnly
          DataField = 'numero_doc'
          DataSource = DataSource1
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 278
          Top = 0
          Width = 259
          Height = 24
          Align = faTopOnly
          AutoSize = False
          DataField = 'descricao'
          DataSource = DataSource1
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 666
          Top = 0
          Width = 52
          Height = 24
          Align = faRightTop
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = DataSource1
          DisplayMask = 'R$ ,0.00;R$ -,0.00;'
          Text = ''
        end
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 121
      Width = 718
      Height = 25
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RLLabel3: TRLLabel
        Left = 0
        Top = 0
        Width = 113
        Height = 24
        Align = faLeftTop
        Caption = 'Data'
      end
      object RLLabel4: TRLLabel
        Left = 120
        Top = 0
        Width = 137
        Height = 24
        Align = faTopOnly
        Caption = 'Documento'
      end
      object RLLabel5: TRLLabel
        Left = 278
        Top = 0
        Width = 259
        Height = 24
        Align = faTopOnly
        Caption = 'Descri'#231#227'o'
      end
      object RLLabel6: TRLLabel
        Left = 568
        Top = 0
        Width = 150
        Height = 24
        Align = faRightTop
        Alignment = taRightJustify
        Caption = 'Valor'
      end
    end
    object RLBand7: TRLBand
      Left = 38
      Top = 201
      Width = 718
      Height = 104
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLPanel2: TRLPanel
        Left = 0
        Top = 1
        Width = 718
        Height = 25
        Align = faTop
        object RLLabel7: TRLLabel
          Left = 392
          Top = 0
          Width = 138
          Height = 24
          Align = faTopOnly
          Alignment = taRightJustify
          Caption = 'Saldo Anterior'
        end
        object lblSaldoAnterior: TRLLabel
          Left = 551
          Top = 0
          Width = 167
          Height = 24
          Align = faRightTop
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLPanel3: TRLPanel
        Left = 0
        Top = 26
        Width = 718
        Height = 25
        Align = faTop
        object RLLabel9: TRLLabel
          Left = 359
          Top = 0
          Width = 171
          Height = 24
          Align = faTopOnly
          Alignment = taRightJustify
          Caption = 'Total de Entradas'
        end
        object lblTotalEntradas: TRLLabel
          Left = 563
          Top = 0
          Width = 155
          Height = 24
          Align = faRightTop
          Alignment = taRightJustify
        end
      end
      object RLPanel4: TRLPanel
        Left = 0
        Top = 51
        Width = 718
        Height = 25
        Align = faTop
        object RLLabel11: TRLLabel
          Left = 377
          Top = 0
          Width = 153
          Height = 24
          Align = faTopOnly
          Alignment = taRightJustify
          Caption = 'Total de Sa'#237'das'
        end
        object lblTotalSaidas: TRLLabel
          Left = 582
          Top = 0
          Width = 136
          Height = 24
          Align = faRightTop
          Alignment = taRightJustify
        end
      end
      object RLPanel5: TRLPanel
        Left = 0
        Top = 76
        Width = 718
        Height = 25
        Align = faTop
        object RLLabel13: TRLLabel
          Left = 426
          Top = 0
          Width = 104
          Height = 24
          Align = faTopOnly
          Alignment = taRightJustify
          Caption = 'SaldoFinal'
        end
        object lblSaldoFinal: TRLLabel
          Left = 584
          Top = 0
          Width = 134
          Height = 24
          Align = faRightTop
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
end
