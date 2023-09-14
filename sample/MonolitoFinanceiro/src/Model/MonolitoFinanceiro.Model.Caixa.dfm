object dmCaixa: TdmCaixa
  OldCreateOrder = False
  Height = 278
  Width = 378
  object sqlCaixa: TFDQuery
    Connection = dmConexao.sqlConexao
    Left = 24
    Top = 24
  end
  object cdsCaixa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCaixa'
    Left = 192
    Top = 24
    object cdsCaixaID: TStringField
      FieldName = 'ID'
      Size = 36
    end
    object cdsCaixaNUMERO_DOC: TStringField
      FieldName = 'NUMERO_DOC'
    end
    object cdsCaixaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object cdsCaixaVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Size = 18
    end
    object cdsCaixaTIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
    object cdsCaixaDATA_CADASTRO: TDateField
      FieldName = 'DATA_CADASTRO'
    end
  end
  object dspCaixa: TDataSetProvider
    DataSet = sqlCaixa
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 24
  end
  object sqlCaixaExtrato: TFDQuery
    Connection = dmConexao.sqlConexao
    Left = 24
    Top = 88
  end
end
