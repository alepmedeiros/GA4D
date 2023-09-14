unit MonolitoFinanceiro.View.ContasPagar.Detalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  MonolitoFinanceiro.Model.ContasPagar;

type
  TfrmContasPagarDetalhes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    ImageList1: TImageList;
    DataSource1: TDataSource;
    btnFechar: TButton;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblNumeroDocumento: TLabel;
    lblVencimento: TLabel;
    lblNumeroParcela: TLabel;
    Panel9: TPanel;
    lblDescricao: TLabel;
    lblValorCompra: TLabel;
    lblValorParcela: TLabel;
    Panel10: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel11: TPanel;
    lblTotalDetalhes: TLabel;
    lblQuantidadeRegistros: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExibirContasPagarDetalhes(IDContaPagar : string);
  end;

var
  frmContasPagarDetalhes: TfrmContasPagarDetalhes;

implementation

uses
  MonolitoFinanceiro.Model.Entidades.ContaPagar,
  MonolitoFinanceiro.Utilitarios;

{$R *.dfm}

procedure TfrmContasPagarDetalhes.btnFecharClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmContasPagarDetalhes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);
end;

procedure TfrmContasPagarDetalhes.ExibirContasPagarDetalhes(
  IDContaPagar: string);
var
  ContaPagar : TModelContaPagar;
  SQL : string;
begin
  if IDContaPagar.IsEmpty then
    raise Exception.Create('ID do contas a Receber inválido');

  ContaPagar := dmContasPagar.GetContaPagar(IDContaPagar);
  try
    if ContaPagar.ID.IsEmpty then
      raise Exception.Create('Contas a Pagar Não Encontrado');
    lblNumeroDocumento.Caption := ContaPagar.Documento;
    lblDescricao.Caption := ContaPagar.Descricao;
    lblVencimento.Caption := FormatDateTime('DD/MM/YYYY', ContaPagar.DataVencimento);
    lblNumeroParcela.Caption := IntToStr(ContaPagar.Parcela);
    lblValorCompra.Caption := TUtilitarios.FormatoMoeda(ContaPagar.ValorCompra);
    lblValorParcela.Caption := TUtilitarios.FormatoMoeda(ContaPagar.ValorParcela);
  finally
    ContaPagar.Free;
  end;

  SQL := 'SELECT * FROM CONTAS_PAGAR_DETALHES' +
    ' LEFT JOIN USUARIOS ON CONTAS_PAGAR_DETALHES.USUARIO = USUARIOS.ID' +
    ' WHERE ID_CONTA_PAGAR = :IDCONTAPAGAR';
  dmContasPagar.sqlContasPagarDetalhes.Close;
  dmContasPagar.sqlContasPagarDetalhes.sql.Clear;
  dmContasPagar.sqlContasPagarDetalhes.Params.Clear;
  dmContasPagar.sqlContasPagarDetalhes.sql.Add(SQL);
  dmContasPagar.sqlContasPagarDetalhes.ParamByName('IDCONTAPAGAR').AsString := IDContaPagar;
  dmContasPagar.sqlContasPagarDetalhes.Prepare;
  dmContasPagar.sqlContasPagarDetalhes.Open;

  lblQuantidadeRegistros.Caption := Format('Quantidade de Registro: %d', [datasource1.DataSet.RecordCount]);
  lblTotalDetalhes.Caption := 'Total de Pagamentos: R$ ' + TUtilitarios.FormatarValor(dmContasPagar.sqlContasPagarDetalhes.FieldByName('Total').AsString);

  Self.ShowModal;
end;

end.
