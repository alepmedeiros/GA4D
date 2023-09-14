inherited frmUsuarios: TfrmUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  PixelsPerInch = 96
  TextHeight = 19
  inherited PnlPrincipal: TCardPanel
    inherited cardCadastro: TCard
      object Label2: TLabel [0]
        Left = 16
        Top = 35
        Width = 42
        Height = 19
        Caption = 'Nome'
      end
      object Label3: TLabel [1]
        Left = 16
        Top = 68
        Width = 39
        Height = 19
        Caption = 'Login'
      end
      object Label5: TLabel [2]
        Left = 16
        Top = 100
        Width = 43
        Height = 19
        Caption = 'Status'
      end
      object edtNome: TEdit
        Left = 88
        Top = 32
        Width = 361
        Height = 27
        TabOrder = 1
      end
      object edtLogin: TEdit
        Left = 88
        Top = 65
        Width = 361
        Height = 27
        TabOrder = 2
      end
      object ToggleStatus: TToggleSwitch
        Left = 88
        Top = 98
        Width = 130
        Height = 21
        StateCaptions.CaptionOn = 'Ativo'
        StateCaptions.CaptionOff = 'Bloqueado'
        TabOrder = 3
      end
    end
    inherited cardPesquisa: TCard
      inherited pnlPesquisarBotoes: TPanel
        inherited btnImprimir: TButton
          OnClick = btnImprimirClick
        end
      end
      inherited pnlGrid: TPanel
        inherited DBGrid1: TDBGrid
          PopupMenu = PopupMenu
          Columns = <
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 275
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'login'
              Title.Caption = 'Login'
              Width = 261
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'administrador'
              Title.Caption = 'Admin'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Title.Caption = 'Status'
              Width = 59
              Visible = True
            end>
        end
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = dmUsuarios.cdsUsuarios
  end
  object PopupMenu: TPopupMenu
    Left = 608
    Top = 211
    object mnuRedefinirSenha: TMenuItem
      Caption = 'Redefinir Senha'
      OnClick = mnuRedefinirSenhaClick
    end
  end
end
