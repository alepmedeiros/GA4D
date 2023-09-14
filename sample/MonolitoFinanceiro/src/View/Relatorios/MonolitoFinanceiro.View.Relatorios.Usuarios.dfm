inherited RelUsuarios: TRelUsuarios
  Caption = 'RelUsuarios'
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport1: TRLReport
    DataSource = DataSource1
    inherited RLBand2: TRLBand
      inherited RLLabel2: TRLLabel
        Left = 258
        Width = 202
        Caption = 'Rela'#231#227'o de Usu'#225'rios'
        ExplicitLeft = 258
        ExplicitWidth = 202
      end
    end
    inherited RLBand3: TRLBand
      object RLLabel3: TRLLabel
        Left = 0
        Top = -1
        Width = 60
        Height = 24
        Align = faLeftTop
        Caption = 'Nome'
      end
      object RLLabel4: TRLLabel
        Left = 258
        Top = -1
        Width = 57
        Height = 24
        Align = faTopOnly
        Caption = 'Login'
      end
      object RLLabel5: TRLLabel
        Left = 652
        Top = -1
        Width = 66
        Height = 24
        Align = faRightTop
        Caption = 'Status'
      end
    end
    inherited RLBand4: TRLBand
      object RLDBText1: TRLDBText
        Left = 0
        Top = 0
        Width = 57
        Height = 24
        Align = faLeftTop
        DataField = 'nome'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 258
        Top = 0
        Width = 49
        Height = 24
        Align = faTopOnly
        DataField = 'login'
        DataSource = DataSource1
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 655
        Top = 0
        Width = 63
        Height = 24
        Align = faRightTop
        DataField = 'status'
        DataSource = DataSource1
        Text = ''
      end
    end
  end
end
