unit MonolitoFinanceiro.View.Caixa.Extrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids, Vcl.DBGrids,
  MonolitoFinanceiro.Model.Caixa,
  MonolitoFinanceiro.Model.Entidades.Caixa.Resumo;

type
  TfrmCaixaExtrato = class(TForm)
    ImageList1: TImageList;
    pnlPrincipal: TPanel;
    pnlPesquisar: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnPesquisar: TButton;
    dateInicial: TDateTimePicker;
    dateFinal: TDateTimePicker;
    pnlContent: TPanel;
    pnlPesquisarBotoes: TPanel;
    btnFechar: TButton;
    btnImprimir: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    lblSaldoFinal: TLabel;
    lblTotalSaidas: TLabel;
    lblTotalEntradas: TLabel;
    lblSaldoAnterior: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    FResumoCaixa : TModelResumoCaixa;
    procedure Pesquisar;
  public
    { Public declarations }
  end;

var
  frmCaixaExtrato: TfrmCaixaExtrato;

implementation

uses
  System.DateUtils,
  MonolitoFinanceiro.Utilitarios,
  MonolitoFinanceiro.View.Relatorios.Caixa.Extrato;

{$R *.dfm}

procedure TfrmCaixaExtrato.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCaixaExtrato.btnImprimirClick(Sender: TObject);
begin
  RelCaixaExtrato.dataSet(DataSource1.DataSet);
  RelCAixaExtrato.ResumoCaixa(FResumoCaixa);
  RelCaixaExtrato.Preview;
end;

procedure TfrmCaixaExtrato.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCaixaExtrato.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);

end;

procedure TfrmCaixaExtrato.FormDestroy(Sender: TObject);
begin
  FResumoCaixa.free;
end;

procedure TfrmCaixaExtrato.FormShow(Sender: TObject);
begin
  dateInicial.Date := IncDay(Now, -7);
  dateFinal.date := Now;
  Pesquisar;
end;

procedure TfrmCaixaExtrato.Pesquisar;
var
  SQL : string;
begin
  SQl := 'SELECT DATA_CADASTRO, NUMERO_DOC, DESCRICAO,' +
    ' CASE TIPO' +
       ' WHEN "D" THEN CAST(-VALOR AS REAL)' +
       ' WHEN "R" THEN CAST(VALOR AS REAL)' +
    ' END VALOR' +
    ' FROM CAIXA' +
    ' WHERE DATA_CADASTRO BETWEEN :DATAINICIO AND :DATAFINAL';

  dmCaixa.sqlCaixaExtrato.Close;
  dmCaixa.sqlCaixaExtrato.SQL.Clear;
  dmCaixa.sqlCaixaExtrato.SQL.Add(SQL);
  dmCaixa.sqlCaixaExtrato.ParamByName('DATAINICIO').AsDate := dateInicial.Date;
  dmCaixa.sqlCaixaExtrato.ParamByName('DATAFINAL').AsDate := dateFinal.Date;
  dmCaixa.sqlCaixaExtrato.Open;

  if Assigned(FResumoCaixa) then
    FResumoCaixa.Free;

  FResumoCaixa := dmCaixa.ResumoCaixa(dateInicial.Date, dateFinal.Date);

  lblSaldoAnterior.Caption := TUtilitarios.FormatoMoeda(FResumoCaixa.SaldoInicial);
  lblTotalEntradas.Caption := TUtilitarios.FormatoMoeda(FResumoCaixa.TotalEntradas);
  lblTotalSaidas.Caption := TUtilitarios.FormatoMoeda(FResumoCaixa.TotalSaidas);
  lblSaldoFinal.Caption := TUtilitarios.FormatoMoeda(FResumoCaixa.SaldoFinal);
end;

end.
