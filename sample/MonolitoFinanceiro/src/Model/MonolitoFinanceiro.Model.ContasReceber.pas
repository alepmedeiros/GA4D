unit MonolitoFinanceiro.Model.ContasReceber;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  MonolitoFinanceiro.Model.Conexao,
  MonolitoFinanceiro.Model.Entidades.ContaReceber,
  MonolitoFinanceiro.Model.Entidades.ContaReceber.Detalhe, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait;

type
  TdmContasReceber = class(TDataModule)
    sqlContasReceber: TFDQuery;
    cdsContasReceber: TClientDataSet;
    dspContasReceber: TDataSetProvider;
    cdsContasReceberid: TStringField;
    cdsContasRecebernumero_documento: TStringField;
    cdsContasReceberdescricao: TStringField;
    cdsContasReceberparcela: TIntegerField;
    cdsContasRecebervalor_parcela: TFMTBCDField;
    cdsContasRecebervalor_venda: TFMTBCDField;
    cdsContasRecebervalor_abatido: TFMTBCDField;
    cdsContasReceberdata_venda: TDateField;
    cdsContasReceberdata_cadastro: TDateField;
    cdsContasReceberdata_vencimento: TDateField;
    cdsContasReceberdata_recebimento: TDateField;
    cdsContasReceberstatus: TStringField;
    sqlContasReceberDetalhes: TFDQuery;
    sqlContasReceberDetalhesid: TStringField;
    sqlContasReceberDetalhesid_conta_receber: TStringField;
    sqlContasReceberDetalhesdetalhes: TStringField;
    sqlContasReceberDetalhesvalor: TFMTBCDField;
    sqlContasReceberDetalhesdata: TDateField;
    sqlContasReceberDetalhesusuario: TStringField;
    sqlContasReceberDetalhesTotal: TAggregateField;
    cdsContasReceberTotal: TAggregateField;
    sqlContasReceberDetalhesnome: TStringField;
    sqlRelContasReceberDetalhado: TFDQuery;
  private
    { Private declarations }
    procedure GravarContaReceber(ContaReceber: TModelContaReceber; SQLGravar : TFDQuery);
    procedure GravarContaReceberDetalhe(ContaReceberDetalhe : TModelContaReceberDetalhe; SQLGravar : TFDQuery);
  public
    { Public declarations }
    function GetContaReceber(ID : string) : TModelContaReceber;
    procedure BaixarContaReceber(BaixaReceber: TModelContaReceberDetalhe);
  end;

var
  dmContasReceber: TdmContasReceber;

implementation

uses
  MonolitoFinanceiro.Utilitarios,
  MonolitoFinanceiro.Model.Entidades.Caixa.Lancamento,
  MonolitoFinanceiro.Model.Caixa;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmContasReceber }


procedure TdmContasReceber.BaixarContaReceber(
  BaixaReceber: TModelContaReceberDetalhe);
var
  ContaReceber : TModelContaReceber;
  SQLGravar : TFDQuery;
  LancamentoCaixa : TModelCaixaLancamento;
begin
  ContaReceber := GetContaReceber(BaixaReceber.IdContaReceber);
  try
    if ContaReceber.Id = '' then
      raise Exception.Create('Conta a reber não encontrada');

    ContaReceber.ValorAbatido := ContaReceber.ValorAbatido + BaixaReceber.Valor;

    if ContaReceber.ValorAbatido >= ContaReceber.ValorParcela then
    begin
      ContaReceber.Status := 'B';
      ContaReceber.DataRecebimento := Now;
    end;

    BaixaReceber.Id := TUtilitarios.GetID;

    LancamentoCaixa := TModelCaixaLancamento.Create;
    try
      LancamentoCaixa.ID := TUtilitarios.GetID;
      LancamentoCaixa.NumeroDoc := ContaReceber.Documento;
      LancamentoCaixa.Descricao := Format('Baixa Conta Receber Numero %s - Parcela %d', [contaReceber.Documento, ContaReceber.Parcela]);
      LancamentoCaixa.Valor := BaixaReceber.Valor;
      LancamentoCaixa.Tipo := 'R';
      LancamentoCaixa.DataCadastro := now;

      SQLGravar := TFDQuery.Create(nil);
      try
        SQLGravar.Connection := dmConexao.SQLConexao;
        dmConexao.SQLConexao.StartTransaction;
        try
          GravarContaReceber(ContaReceber, SQLGravar);
          GravarContaReceberDetalhe(BaixaReceber, SQLGravar);
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
    ContaReceber.Free;
  end;
end;

function TdmContasReceber.GetContaReceber(ID: string): TModelContaReceber;
var
  SQLConsulta : TFDQuery;
begin
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.sqlConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT * FROM CONTAS_RECEBER WHERE ID = :ID');
    SQLConsulta.ParamByName('ID').AsString := ID;
    SQLConsulta.Open;
    Result := TModelContaReceber.Create;
    try
      Result.ID := SQLConsulta.FieldByName('ID').AsString;
      Result.Documento := SQLConsulta.FieldByName('NUMERO_DOCUMENTO').AsString;
      Result.Descricao := SQLConsulta.FieldByName('DESCRICAO').AsString;
      Result.Parcela := SQLConsulta.FieldByName('PARCELA').AsInteger;
      Result.ValorParcela := SQLConsulta.FieldByName('VALOR_PARCELA').AsCurrency;
      Result.ValorVenda := SQLConsulta.FieldByName('VALOR_VENDA').AsCurrency;
      Result.ValorAbatido := SQLConsulta.FieldByName('VALOR_ABATIDO').AsCurrency;
      Result.DataVenda := SQLConsulta.FieldByName('DATA_VENDA').AsDateTime;
      Result.DataCadastro := SQLConsulta.FieldByName('DATA_CADASTRO').AsDateTime;
      Result.DataVencimento := SQLConsulta.FieldByName('DATA_VENCIMENTO').AsDateTime;
      Result.DataRecebimento := SQLConsulta.FieldByName('DATA_RECEBIMENTO').AsDateTime;
      Result.Status := SQLConsulta.FieldByName('STATUS').AsString;
    except
      Result.Free;
      raise;
    end;
  finally
    SQLConsulta.Free;
  end;
end;

procedure TdmContasReceber.GravarContaReceber(ContaReceber: TModelContaReceber;
  SQLGravar: TFDQuery);
var
  SQL : string;
begin
  SQL := 'UPDATE CONTAS_RECEBER SET VALOR_ABATIDO = :VALORABATIDO,' +
        ' VALOR_PARCELA = :VALORPARCELA,' +
        ' STATUS = :STATUS,' +
        ' DATA_RECEBIMENTO = :DATARECEBIMENTO' +
        ' WHERE ID = :IDCONTARECEBER;';

  SQLGravar.SQL.Clear;
  SQLGravar.Params.clear;

  SQLGravar.SQL.ADD(SQL);
  SQLGravar.ParamByName('VALORABATIDO').AsCurrency := ContaReceber.ValorAbatido;
  SQLGravar.ParamByName('VALORPARCELA').AsCurrency := ContaReceber.ValorParcela;
  SQLGravar.ParamByName('STATUS').AsString := ContaReceber.Status;
  TUtilitarios.ValidarData(SQLGravar.ParamByName('DATARECEBIMENTO'), ContaReceber.DataRecebimento);
  SQLGravar.ParamByName('IDCONTARECEBER').AsString := ContaReceber.ID;

  SQLGravar.Prepare;
  SQLGravar.ExecSQL;

end;


procedure TdmContasReceber.GravarContaReceberDetalhe(
  ContaReceberDetalhe: TModelContaReceberDetalhe; SQLGravar: TFDQuery);
var
  SQL : string;
begin
  SQL := 'INSERT INTO CONTAS_RECEBER_DETALHES (ID, ID_CONTA_RECEBER,' +
         ' DETALHES, VALOR, DATA, USUARIO) VALUES (:IDDETALHE,' +
         ' :IDCONTARECEBER, :DETALHES, :VALOR, :DATA, :USUARIO);';

  SQLGravar.SQL.Clear;
  SQLGravar.Params.Clear;

  SQLGravar.SQL.ADD(SQL);
  SQLGravar.ParamByName('IDDETALHE').AsString := ContaReceberDetalhe.Id;
  SQLGravar.ParamByName('IDCONTARECEBER').AsString := ContaReceberDetalhe.IdContaReceber;
  SQLGravar.ParamByName('DETALHES').AsString := ContaReceberDetalhe.Detalhes;
  SQLGravar.ParamByName('VALOR').AsCurrency := ContaReceberDetalhe.Valor;

  SQLGravar.ParamByName('DATA').AsDateTime := ContaReceberDetalhe.Data;
  SQLGravar.ParamByName('USUARIO').AsString := ContaReceberDetalhe.Usuario;

  SQLGravar.Prepare;
  SQLGravar.ExecSQL;
end;

end.
