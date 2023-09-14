inherited frmCaixa: TfrmCaixa
  Caption = 'Caixa'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  inherited PnlPrincipal: TCardPanel
    inherited cardCadastro: TCard
      object Label2: TLabel [0]
        Left = 16
        Top = 35
        Width = 105
        Height = 19
        Caption = 'N'#186' Documento'
      end
      object Label3: TLabel [1]
        Left = 16
        Top = 68
        Width = 67
        Height = 19
        Caption = 'Descri'#231#227'o'
      end
      object Label5: TLabel [2]
        Left = 16
        Top = 101
        Width = 37
        Height = 19
        Caption = 'Valor'
      end
      object edtNumeroDocumento: TEdit
        Left = 144
        Top = 32
        Width = 361
        Height = 27
        TabOrder = 1
      end
      object edtDescricao: TEdit
        Left = 144
        Top = 65
        Width = 361
        Height = 27
        TabOrder = 2
      end
      object RadioGroup1: TRadioGroup
        Left = 16
        Top = 131
        Width = 489
        Height = 57
        Caption = 'Tipo'
        Columns = 2
        Items.Strings = (
          'Receita'
          'Despesa')
        TabOrder = 3
      end
      object edtValor: TEdit
        Left = 145
        Top = 99
        Width = 361
        Height = 27
        TabOrder = 4
      end
    end
    inherited cardPesquisa: TCard
      inherited pnlPesquisa: TPanel
        object Label4: TLabel [1]
          Left = 368
          Top = 12
          Width = 32
          Height = 19
          Caption = 'Tipo'
        end
        object cbTipo: TComboBox
          Left = 368
          Top = 31
          Width = 145
          Height = 27
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 2
          Text = 'TODOS'
          Items.Strings = (
            'TODOS'
            'RECEITA'
            'DESPESAS')
        end
      end
      inherited pnlPesquisarBotoes: TPanel
        inherited btnImprimir: TButton
          OnClick = btnImprimirClick
        end
      end
      inherited pnlGrid: TPanel
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'DATA_CADASTRO'
              Title.Caption = 'Data'
              Width = 115
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NUMERO_DOC'
              Title.Caption = 'N'#186' Documento'
              Width = 135
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 264
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TIPO'
              Title.Caption = 'Tipo'
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR'
              Title.Caption = 'Valor'
              Visible = True
            end>
        end
      end
    end
  end
  inherited DataSource1: TDataSource
    DataSet = dmCaixa.cdsCaixa
  end
end
