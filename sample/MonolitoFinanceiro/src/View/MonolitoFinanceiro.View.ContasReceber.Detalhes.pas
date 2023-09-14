unit MonolitoFinanceiro.View.ContasReceber.Detalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.StdCtrls,
  MonolitoFinanceiro.Model.ContasReceber;

type
  TfrmContasReceberDetalhes = class(TForm)
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
    lblValorVenda: TLabel;
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
    procedure ExibirContasReceberDetalhes(IDContaReceber : string);
  end;

var
  frmContasReceberDetalhes: TfrmContasReceberDetalhes;

implementation

uses
  MonolitoFinanceiro.Model.Entidades.ContaReceber,
  MonolitoFinanceiro.Utilitarios;

{$R *.dfm}

procedure TfrmContasReceberDetalhes.btnFecharClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmContasReceberDetalhes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);
end;

procedure TfrmContasReceberDetalhes.ExibirContasReceberDetalhes(
  IDContaReceber: string);
var
  ContaReceber : TModelContaReceber;
  SQL : string;
begin
  if IDContaReceber.IsEmpty then
    raise Exception.Create('ID do contas a Receber inválido');

  ContaReceber := dmContasReceber.GetContaReceber(IDContaReceber);
  try
    if ContaReceber.ID.IsEmpty then
      raise Exception.Create('Contas a Recebe Não Encontrado');
    lblNumeroDocumento.Caption := ContaReceber.Documento;
    lblDescricao.Caption := ContaReceber.Descricao;
    lblVencimento.Caption := FormatDateTime('DD/MM/YYYY', ContaReceber.DataVencimento);
    lblNumeroParcela.Caption := IntToStr(ContaReceber.Parcela);
    lblValorVenda.Caption := TUtilitarios.FormatoMoeda(ContaReceber.ValorVenda);
    lblValorParcela.Caption := TUtilitarios.FormatoMoeda(ContaReceber.ValorParcela);
  finally
    ContaReceber.Free;
  end;

  SQL := 'SELECT * FROM CONTAS_RECEBER_DETALHES' +
    ' LEFT JOIN USUARIOS ON CONTAS_RECEBER_DETALHES.USUARIO = USUARIOS.ID' +
    ' WHERE ID_CONTA_RECEBER = :IDCONTARECEBER';
  dmContasReceber.sqlContasReceberDetalhes.Close;
  dmContasReceber.sqlContasReceberDetalhes.sql.Clear;
  dmContasReceber.sqlContasReceberDetalhes.Params.Clear;
  dmContasReceber.sqlContasReceberDetalhes.sql.Add(SQL);
  dmContasReceber.sqlContasReceberDetalhes.ParamByName('IDCONTARECEBER').AsString := IDContaReceber;
  dmContasReceber.sqlContasReceberDetalhes.Prepare;
  dmContasReceber.sqlContasReceberDetalhes.Open;

  lblQuantidadeRegistros.Caption := Format('Quantidade de Registro: %d', [datasource1.DataSet.RecordCount]);
  lblTotalDetalhes.Caption := 'Total de Recebimentos: R$ ' + TUtilitarios.FormatarValor(dmContasReceber.sqlContasReceberDetalhes.FieldByName('Total').AsString);

  Self.ShowModal;
end;

end.
