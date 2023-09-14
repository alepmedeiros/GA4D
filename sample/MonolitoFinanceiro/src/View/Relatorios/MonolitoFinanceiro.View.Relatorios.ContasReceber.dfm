inherited RelContasReceber: TRelContasReceber
  Caption = 'RelContasReceber'
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport1: TRLReport
    inherited RLBand2: TRLBand
      inherited RLLabel2: TRLLabel
        Left = 214
        Width = 290
        Caption = 'Rela'#231#227'o de Contas a Receber'
        ExplicitLeft = 214
        ExplicitWidth = 290
      end
    end
    inherited RLBand3: TRLBand
      object RLLabel3: TRLLabel
        Left = 0
        Top = 0
        Width = 115
        Height = 24
        Align = faLeftTop
        Caption = 'Vencimento'
      end
      object RLLabel4: TRLLabel
        Left = 183
        Top = 0
        Width = 140
        Height = 24
        Align = faTopOnly
        Caption = 'N'#186' Documento'
      end
      object RLLabel5: TRLLabel
        Left = 586
        Top = 0
        Width = 132
        Height = 24
        Align = faRightTop
        Caption = 'Valor Parcela'
      end
      object RLLabel6: TRLLabel
        Left = 369
        Top = 0
        Width = 78
        Height = 24
        Align = faTopOnly
        Caption = 'Parcela'
      end
      object RLLabel7: TRLLabel
        Left = 498
        Top = 0
        Width = 66
        Height = 24
        Align = faTopOnly
        Caption = 'Status'
      end
    end
    inherited RLBand4: TRLBand
      object RLDBText1: TRLDBText
        Left = 0
        Top = 0
        Width = 115
        Height = 24
        Align = faLeftTop
        DataField = 'data_Vencimento'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 585
        Top = 0
        Width = 133
        Height = 24
        Align = faRightTop
        DataField = 'valor_parcela'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 183
        Top = 0
        Width = 140
        Height = 24
        Align = faTopOnly
        DataField = 'numero_documento'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 369
        Top = 0
        Width = 75
        Height = 24
        Align = faTopOnly
        DataField = 'parcela'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 501
        Top = 0
        Width = 63
        Height = 24
        Align = faTopOnly
        DataField = 'status'
        DataSource = DataSource1
        Text = ''
      end
    end
    inherited RLBand5: TRLBand
      Top = 193
      ExplicitTop = 193
    end
    object RLBand6: TRLBand
      Left = 38
      Top = 169
      Width = 718
      Height = 24
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object lblTotal: TRLLabel
        Left = 664
        Top = 1
        Width = 54
        Height = 24
        Align = faRightTop
        Caption = 'Valor'
      end
    end
  end
end
