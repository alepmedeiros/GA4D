unit MonolitoFinanceiro.Model.ContasPagar;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  MonolitoFinanceiro.Model.Conexao,
  MonolitoFinanceiro.Model.Entidades.ContaPagar,
  MonolitoFinanceiro.Model.Entidades.ContaPagar.Detalhe;

type
  TdmContasPagar = class(TDataModule)
    sqlContasPagar: TFDQuery;
    cdsContasPagar: TClientDataSet;
    dspContasPagar: TDataSetProvider;
    cdsContasPagarid: TStringField;
    cdsContasPagarnumero_documento: TStringField;
    cdsContasPagardescricao: TStringField;
    cdsContasPagarparcela: TIntegerField;
    cdsContasPagarvalor_parcela: TFMTBCDField;
    cdsContasPagarvalor_compra: TFMTBCDField;
    cdsContasPagarvalor_abatido: TFMTBCDField;
    cdsContasPagardata_compra: TDateField;
    cdsContasPagardata_cadastro: TDateField;
    cdsContasPagardata_vencimento: TDateField;
    cdsContasPagardata_pagamento: TDateField;
    cdsContasPagarstatus: TStringField;
    cdsContasPagarTotal: TAggregateField;
    sqlContasPagarDetalhes: TFDQuery;
    sqlContasPagarDetalhesid: TStringField;
    sqlContasPagarDetalhesid_conta_receber: TStringField;
    sqlContasPagarDetalhesdetalhes: TStringField;
    sqlContasPagarDetalhesvalor: TFMTBCDField;
    sqlContasPagarDetalhesdata: TDateField;
    sqlContasPagarDetalhesusuario: TStringField;
    sqlContasPagarDetalhesnome: TStringField;
    sqlContasPagarDetalhesTotal: TAggregateField;
  private
    { Private declarations }
    procedure GravarContaPagar(ContaPagar: TModelContaPagar; SQLGravar : TFDQuery);
    procedure GravarContaPagarDetalhe(ContaPagarDetalhe : TModelContaPagarDetalhe; SQLGravar : TFDQuery);
  public
    { Public declarations }
    function GetContaPagar(ID : string) : TModelContaPagar;
    procedure BaixarContaPagar(BaixaPagar : TModelContaPagarDetalhe);
  end;

var
  dmContasPagar: TdmContasPagar;

implementation

uses
  MonolitoFinanceiro.Utilitarios, MonolitoFinanceiro.Model.Caixa,
  MonolitoFinanceiro.Model.Entidades.Caixa.Lancamento;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmContasPagar }

procedure TdmContasPagar.BaixarContaPagar(BaixaPagar: TModelContaPagarDetalhe);
var
  ContaPagar : TModelContaPagar;
  SQLGravar : TFDQuery;
  LancamentoCaixa : TModelCaixaLancamento;
begin
  ContaPagar := GetContaPagar(BaixaPagar.IdContaPagar);
  try
    if ContaPagar.Id = '' then
      raise Exception.Create('Conta pagar não encontrada');

    ContaPagar.ValorAbatido := ContaPagar.ValorAbatido + BaixaPagar.Valor;

    if ContaPagar.ValorAbatido >= ContaPagar.ValorParcela then
    begin
      ContaPagar.Status := 'B';
      ContaPagar.DataPagamento := Now;
    end;

    BaixaPagar.Id := TUtilitarios.GetID;

    LancamentoCaixa := TModelCaixaLancamento.Create;
    try
      LancamentoCaixa.ID := TUtilitarios.GetID;
      LancamentoCaixa.NumeroDoc := ContaPagar.Documento;
      LancamentoCaixa.Descricao := Format('Baixa Conta Pagar Numero %s - Parcela %d', [contaPagar.Documento, ContaPagar.Parcela]);
      LancamentoCaixa.Valor := BaixaPagar.Valor;
      LancamentoCaixa.Tipo := 'D';
      LancamentoCaixa.DataCadastro := now;

      SQLGravar := TFDQuery.Create(nil);
      try
        SQLGravar.Connection := dmConexao.SQLConexao;
        dmConexao.SQLConexao.StartTransaction;
        try
          GravarContaPagar(ContaPagar, SQLGravar);
          GravarContaPagarDetalhe(BaixaPagar, SQLGravar);
          dmCaixa.GravarLancamento(LancamentoCaixa, SQLGravar);
          dmConexao.SQLConexao.Commit;
        except
          dmConexao.SQLConexao.Rollback;
          raise;
        end;
      finally
        SQLGravar.Free;
      end;
    finally
      LancamentoCaixa.Free;
    end;

  finally
    ContaPagar.Free;
  end;
end;

function TdmContasPagar.GetContaPagar(ID: string): TModelContaPagar;
var
  SQLConsulta : TFDQuery;
begin
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.sqlConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT * FROM CONTAS_PAGAR WHERE ID = :ID');
    SQLConsulta.ParamByName('ID').AsString := ID;
    SQLConsulta.Open;
    Result := TModelContaPagar.Create;
    try
      Result.ID := SQLConsulta.FieldByName('ID').AsString;
      Result.Documento := SQLConsulta.FieldByName('NUMERO_DOCUMENTO').AsString;
      Result.Descricao := SQLConsulta.FieldByName('DESCRICAO').AsString;
      Result.Parcela := SQLConsulta.FieldByName('PARCELA').AsInteger;
      Result.ValorParcela := SQLConsulta.FieldByName('VALOR_PARCELA').AsCurrency;
      Result.ValorCompra := SQLConsulta.FieldByName('VALOR_COMPRA').AsCurrency;
      Result.ValorAbatido := SQLConsulta.FieldByName('VALOR_ABATIDO').AsCurrency;
      Result.DataCompra := SQLConsulta.FieldByName('DATA_COMPRA').AsDateTime;
      Result.DataCadastro := SQLConsulta.FieldByName('DATA_CADASTRO').AsDateTime;
      Result.DataVencimento := SQLConsulta.FieldByName('DATA_VENCIMENTO').AsDateTime;
      Result.DataPagamento := SQLConsulta.FieldByName('DATA_PAGAMENTO').AsDateTime;
      Result.Status := SQLConsulta.FieldByName('STATUS').AsString;
    except
      Result.Free;
      raise;
    end;
  finally
    SQLConsulta.Free;
  end;
end;

procedure TdmContasPagar.GravarContaPagar(ContaPagar: TModelContaPagar; SQLGravar : TFDQuery);
var
  SQL : string;
begin
  SQL := 'UPDATE CONTAS_PAGAR SET VALOR_ABATIDO = :VALORABATIDO,' +
        ' VALOR_PARCELA = :VALORPARCELA,' +
        ' STATUS = :STATUS,' +
        ' DATA_PAGAMENTO = :DATAPAGAMENTO' +
        ' WHERE ID = :IDCONTAPAGAR;';

  SQLGravar.SQL.Clear;
  SQLGravar.Params.clear;

  SQLGravar.SQL.ADD(SQL);
  SQLGravar.ParamByName('VALORABATIDO').AsCurrency := ContaPagar.ValorAbatido;
  SQLGravar.ParamByName('VALORPARCELA').AsCurrency := ContaPagar.ValorParcela;
  SQLGravar.ParamByName('STATUS').AsString := ContaPagar.Status;
  TUtilitarios.ValidarData(SQLGravar.ParamByName('DATAPAGAMENTO'), ContaPagar.DataPagamento);
  SQLGravar.ParamByName('IDCONTAPAGAR').AsString := ContaPagar.ID;

  SQLGravar.Prepare;
  SQLGravar.ExecSQL;

end;

procedure TdmContasPagar.GravarContaPagarDetalhe(ContaPagarDetalhe : TModelContaPagarDetalhe; SQLGravar : TFDQuery);
var
  SQL : string;
begin
  SQL := 'INSERT INTO CONTAS_PAGAR_DETALHES (ID, ID_CONTA_PAGAR,' +
         ' DETALHES, VALOR, DATA, USUARIO) VALUES (:IDDETALHE,' +
         ' :IDCONTAPAGAR, :DETALHES, :VALOR, :DATA, :USUARIO);';

  SQLGravar.SQL.Clear;
  SQLGravar.Params.Clear;

  SQLGravar.SQL.ADD(SQL);
  SQLGravar.ParamByName('IDDETALHE').AsString := ContaPagarDetalhe.Id;
  SQLGravar.ParamByName('IDCONTAPAGAR').AsString := ContaPagarDetalhe.IdContapagar;
  SQLGravar.ParamByName('DETALHES').AsString := ContaPagarDetalhe.Detalhes;
  SQLGravar.ParamByName('VALOR').AsCurrency := ContaPagarDetalhe.Valor;

  SQLGravar.ParamByName('DATA').AsDateTime := ContaPagarDetalhe.Data;
  SQLGravar.ParamByName('USUARIO').AsString := ContaPagarDetalhe.Usuario;

  SQLGravar.Prepare;
  SQLGravar.ExecSQL;
end;

end.
