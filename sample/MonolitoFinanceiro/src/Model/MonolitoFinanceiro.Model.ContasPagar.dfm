object dmContasPagar: TdmContasPagar
  OldCreateOrder = False
  Height = 227
  Width = 321
  object sqlContasPagar: TFDQuery
    Connection = dmConexao.sqlConexao
    SQL.Strings = (
      'Select * from contas_pagar')
    Left = 24
    Top = 24
  end
  object cdsContasPagar: TClientDataSet
    Aggregates = <>
    AggregatesActive = True
    CommandText = 'Select * from contas_pagar'
    Params = <>
    ProviderName = 'dspContasPagar'
    Left = 192
    Top = 24
    object cdsContasPagarid: TStringField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 36
    end
    object cdsContasPagarnumero_documento: TStringField
      FieldName = 'numero_documento'
      Origin = 'numero_documento'
      Required = True
    end
    object cdsContasPagardescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 200
    end
    object cdsContasPagarparcela: TIntegerField
      FieldName = 'parcela'
      Origin = 'parcela'
      Required = True
    end
    object cdsContasPagarvalor_parcela: TFMTBCDField
      FieldName = 'valor_parcela'
      Origin = 'valor_parcela'
      Required = True
      Precision = 18
      Size = 2
    end
    object cdsContasPagarvalor_compra: TFMTBCDField
      FieldName = 'valor_compra'
      Origin = 'valor_compra'
      Required = True
      Precision = 18
      Size = 2
    end
    object cdsContasPagarvalor_abatido: TFMTBCDField
      FieldName = 'valor_abatido'
      Origin = 'valor_abatido'
      Required = True
      Precision = 18
      Size = 2
    end
    object cdsContasPagardata_compra: TDateField
      FieldName = 'data_compra'
      Origin = 'data_compra'
      Required = True
    end
    object cdsContasPagardata_cadastro: TDateField
      FieldName = 'data_cadastro'
      Origin = 'data_cadastro'
      Required = True
    end
    object cdsContasPagardata_vencimento: TDateField
      FieldName = 'data_vencimento'
      Origin = 'data_vencimento'
      Required = True
    end
    object cdsContasPagardata_pagamento: TDateField
      FieldName = 'data_pagamento'
      Origin = 'data_pagamento'
    end
    object cdsContasPagarstatus: TStringField
      FieldName = 'status'
      Origin = 'status'
      Required = True
      FixedChar = True
      Size = 1
    end
    object cdsContasPagarTotal: TAggregateField
      FieldName = 'Total'
      Active = True
      DisplayName = ''
      Expression = 'SUM(valor_parcela)'
    end
  end
  object dspContasPagar: TDataSetProvider
    DataSet = sqlContasPagar
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 104
    Top = 24
  end
  object sqlContasPagarDetalhes: TFDQuery
    AggregatesActive = True
    Connection = dmConexao.sqlConexao
    SQL.Strings = (
      'Select * from contas_Receber_detalhes')
    Left = 96
    Top = 88
    object sqlContasPagarDetalhesid: TStringField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 36
    end
    object sqlContasPagarDetalhesid_conta_receber: TStringField
      FieldName = 'id_conta_pagar'
      Origin = 'id_conta_receber'
      Required = True
      FixedChar = True
      Size = 36
    end
    object sqlContasPagarDetalhesdetalhes: TStringField
      DisplayLabel = 'Detalhes'
      FieldName = 'detalhes'
      Origin = 'detalhes'
      Required = True
      Size = 200
    end
    object sqlContasPagarDetalhesvalor: TFMTBCDField
      DisplayLabel = 'Valor Abatido'
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      DisplayFormat = 'R$ ,0.00;R$ -,0.00;'
      Precision = 18
      Size = 2
    end
    object sqlContasPagarDetalhesdata: TDateField
      DisplayLabel = 'Data da Baixa'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
    object sqlContasPagarDetalhesusuario: TStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 50
    end
    object sqlContasPagarDetalhesnome: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'nome'
      Size = 50
    end
    object sqlContasPagarDetalhesTotal: TAggregateField
      FieldName = 'Total'
      Active = True
      DisplayName = ''
      Expression = 'SUM(valor)'
    end
  end
end
