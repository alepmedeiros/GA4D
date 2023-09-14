inherited RelCaixa: TRelCaixa
  Caption = 'RelCaixa'
  ExplicitLeft = -59
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport1: TRLReport
    inherited RLBand3: TRLBand
      object RLLabel3: TRLLabel
        Left = 0
        Top = 0
        Width = 113
        Height = 24
        Align = faLeftTop
        Caption = 'Data'
      end
      object RLLabel4: TRLLabel
        Left = 119
        Top = 0
        Width = 121
        Height = 24
        Align = faTopOnly
        Caption = 'Documento'
      end
      object RLLabel5: TRLLabel
        Left = 246
        Top = 0
        Width = 264
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
      object RLLabel7: TRLLabel
        Left = 516
        Top = 0
        Width = 46
        Height = 24
        Align = faTopOnly
        Caption = 'Tipo'
      end
    end
    inherited RLBand4: TRLBand
      object RLDBText1: TRLDBText
        Left = 0
        Top = 0
        Width = 113
        Height = 24
        Align = faLeftTop
        DataField = 'data_cadastro'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 119
        Top = 0
        Width = 121
        Height = 24
        Align = faTopOnly
        DataField = 'numero_doc'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 246
        Top = 0
        Width = 267
        Height = 24
        Align = faTopOnly
        AutoSize = False
        DataField = 'descricao'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 568
        Top = 0
        Width = 150
        Height = 24
        Align = faRightTop
        Alignment = taRightJustify
        DataField = 'valor'
        DataSource = DataSource1
        DisplayMask = 'R$ ,0.00;R$ -,0.00;'
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 519
        Top = 0
        Width = 43
        Height = 24
        Align = faTopOnly
        AutoSize = False
        DataField = 'tipo'
        DataSource = DataSource1
        Text = ''
      end
    end
  end
end
