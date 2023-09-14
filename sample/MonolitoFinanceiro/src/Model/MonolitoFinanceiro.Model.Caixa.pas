unit MonolitoFinanceiro.Model.Caixa;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet,
  MonolitoFinanceiro.Model.Conexao, MonolitoFinanceiro.Model.Entidades.Caixa.Resumo,
  MonolitoFinanceiro.Model.Entidades.Caixa.Lancamento,
  FireDAC.Comp.Client;

type
  TdmCaixa = class(TDataModule)
    sqlCaixa: TFDQuery;
    cdsCaixa: TClientDataSet;
    dspCaixa: TDataSetProvider;
    cdsCaixaID: TStringField;
    cdsCaixaNUMERO_DOC: TStringField;
    cdsCaixaDESCRICAO: TStringField;
    cdsCaixaVALOR: TFMTBCDField;
    cdsCaixaTIPO: TStringField;
    cdsCaixaDATA_CADASTRO: TDateField;
    sqlCaixaExtrato: TFDQuery;
  private
    { Private declarations }
    function GetSaldoAnteriorCaixa(Data : TDate) : Currency;
    function GetTotalEntradasCaixa(DataInicial, DataFinal : TDate) : Currency;
    function GetTotalSaidasCaixa(DataInicial, DataFinal : TDate) : Currency;
  public
    { Public declarations }
    function ResumoCaixa(DataInicial, DataFinal : TDate) : TModelResumoCaixa;
    procedure GravarLancamento(aValue : TModelCaixaLancamento; SQLGravar : TFDQuery);
  end;

var
  dmCaixa: TdmCaixa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmCaixa }

function TdmCaixa.GetSaldoAnteriorCaixa(Data: TDate): Currency;
var
  SQLConsulta : TFDQuery;
  TotalEntradas : Currency;
  TotalSaidas : Currency;
begin
  Result := 0;
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.sqlConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT IFNULL(SUM(VALOR), 0) AS VALOR FROM CAIXA WHERE TIPO = ''R''');
    SQLConsulta.SQL.Add(' AND DATA_CADASTRO < :DATA');
    SQLConsulta.ParamByName('DATA').AsDate := Data;
    SQLConsulta.Open;
    TotalEntradas := SQLConsulta.FieldByName('VALOR').AsCurrency;

    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT IFNULL(SUM(VALOR), 0) AS VALOR FROM CAIXA WHERE TIPO = ''D''');
    SQLConsulta.SQL.Add(' AND DATA_CADASTRO < :DATA');
    SQLConsulta.ParamByName('DATA').AsDate := Data;
    SQLConsulta.Open;
    TotalSaidas := SQLConsulta.FieldByName('VALOR').AsCurrency;
  finally
    SQLConsulta.Free;
  end;
  Result := TotalEntradas - TotalSaidas;
end;

function TdmCaixa.GetTotalEntradasCaixa(DataInicial,
  DataFinal: TDate): Currency;
var
  SQLConsulta : TFDQuery;
begin
  Result := 0;
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.sqlConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT IFNULL(SUM(VALOR), 0) AS VALOR FROM CAIXA WHERE TIPO = ''R''');
    SQLConsulta.SQL.Add(' AND DATA_CADASTRO BETWEEN :DATAINICIAL AND :DATAFINAL');
    SQLConsulta.ParamByName('DATAINICIAL').AsDate := DataInicial;
    SQLConsulta.ParamByName('DATAFINAL').AsDate := DataFinal;
    SQLConsulta.Open;
    Result := sqlConsulta.FieldByName('VALOR').AsCurrency;
  finally
    SQLConsulta.Free;
  end;
end;

function TdmCaixa.GetTotalSaidasCaixa(DataInicial, DataFinal: TDate): Currency;
var
  SQLConsulta : TFDQuery;
begin
  Result := 0;
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.sqlConexao;
    SQLConsulta.SQL.Clear;
    SQLConsulta.SQL.Add('SELECT IFNULL(SUM(VALOR), 0) AS VALOR FROM CAIXA WHERE TIPO = ''D''');
    SQLConsulta.SQL.Add(' AND DATA_CADASTRO BETWEEN :DATAINICIAL AND :DATAFINAL');
    SQLConsulta.ParamByName('DATAINICIAL').AsDate := DataInicial;
    SQLConsulta.ParamByName('DATAFINAL').AsDate := DataFinal;
    SQLConsulta.Open;
    Result := sqlConsulta.FieldByName('VALOR').AsCurrency;
  finally
    SQLConsulta.Free;
  end;
end;

procedure TdmCaixa.GravarLancamento(aValue: TModelCaixaLancamento;
  SQLGravar: TFDQuery);
var
  SQL : string;
begin
  SQL := 'INSERT INTO CAIXA (ID, NUMERO_DOC, DESCRICAO,' +
         ' VALOR, TIPO, DATA_CADASTRO) VALUES (:IDCAIXA, ' +
         ' :NUMERO_DOC_CAIXA, :DESCRICAO_CAIXA, :VALOR_CAIXA,' +
         ' :TIPO, :DATA_CADASTRO)';

  SQLGravar.sql.Clear;
  SQLGravar.Params.Clear;
  SQLGravar.SQL.Add(SQL);
  SQLGravar.ParamByName('IDCAIXA').AsString := aValue.ID;
  SQLGravar.ParamByName('NUMERO_DOC_CAIXA').AsString := aValue.NumeroDoc;
  SQLGravar.ParamByName('DESCRICAO_CAIXA').AsString := aValue.Descricao;
  SQLGravar.ParamByName('VALOR_CAIXA').AsCurrency := aValue.Valor;
  SQLGravar.ParamByName('TIPO').AsString := aValue.Tipo;
  SQLGravar.ParamByName('DATA_CADASTRO').AsDate := aValue.DataCadastro;
  SQLGravar.Prepare;
  SQLGravar.ExecSQL;
end;

function TdmCaixa.ResumoCaixa(DataInicial, DataFinal: TDate): TModelResumoCaixa;
begin
  if DataInicial > DataFinal then
    raise Exception.Create('Período Inválido');

  Result := TModelResumoCaixa.Create;
  try
    Result.SaldoInicial := GetSaldoAnteriorCaixa(DataInicial);
    Result.TotalEntradas := GetTotalEntradasCaixa(DataInicial, DataFinal);
    Result.TotalSaidas := GetTotalSaidasCaixa(DataInicial, DataFinal);
  except
    Result.Free;
    raise;
  end;
end;

end.
