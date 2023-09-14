unit MonolitoFinanceiro.View.ContasReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels,
  MonolitoFinanceiro.Model.ContasReceber, Datasnap.DBClient, Vcl.WinXCtrls,
  Vcl.ComCtrls, Vcl.Menus;

type
  TfrmContasReceber = class(TfrmCadastroPadrao)
    cdsParcelas: TClientDataSet;
    cdsParcelasParcela: TIntegerField;
    cdsParcelasDocumento: TStringField;
    cdsParcelasVencimento: TDateField;
    cdsParcelasValor: TCurrencyField;
    dsParcelas: TDataSource;
    Label3: TLabel;
    edtDescricao: TEdit;
    Label2: TLabel;
    edtValorVenda: TEdit;
    Label4: TLabel;
    dateVenda: TDateTimePicker;
    Label9: TLabel;
    toggleParcelamento: TToggleSwitch;
    CardParcela: TCardPanel;
    cardParcelaUnica: TCard;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtNumeroDocumento: TEdit;
    edtParcela: TEdit;
    edtValorParcela: TEdit;
    dateVencimento: TDateTimePicker;
    cardParcelamento: TCard;
    Label10: TLabel;
    Label11: TLabel;
    edtParcelas: TEdit;
    edtIntervaloDias: TEdit;
    btnGerar: TButton;
    btnLimpar: TButton;
    DBGrid2: TDBGrid;
    PopupMenu1: TPopupMenu;
    mnuBaixar: TMenuItem;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtValorVendaExit(Sender: TObject);
    procedure edtValorParcelaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure toggleParcelamentoClick(Sender: TObject);
    procedure mnuBaixarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure CadastrarParcelamento;
    procedure CadastrarParcelaUnica;
  public
    { Public declarations }
  protected
    procedure Pesquisar; override;
  end;

var
  frmContasReceber: TfrmContasReceber;

implementation

uses
  MonolitoFinanceiro.Utilitarios,
  System.SysUtils,
  System.DateUtils, MonolitoFinanceiro.View.ContasReceber.Baixar,
  MonolitoFinanceiro.View.Relatorios.ContasReceber;

{$R *.dfm}

{ TfrmContasReceber }

procedure TfrmContasReceber.btnAlterarClick(Sender: TObject);
begin
  if dmContasReceber.cdsContasReceberstatus.AsString = 'B' then
  begin
    Application.MessageBox('O documento já foi baixado e não pode ser alterado.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if dmContasReceber.cdsContasReceberstatus.AsString = 'C' then
  begin
    Application.MessageBox('O documento já foi cancelado e não pode ser alterado.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  inherited;

  toggleParcelamento.Enabled := False;
  toggleParcelamento.State := tssOff;
  CardParcela.ActiveCard := cardParcelaUnica;
  cdsParcelas.EmptyDataSet;


  edtNumeroDocumento.Text := dmContasReceber.cdsContasRecebernumero_documento.AsString;
  edtDescricao.Text := dmContasReceber.cdsContasReceberdescricao.AsString;
  edtValorVenda.Text := TUtilitarios.FormatarValor(dmContasReceber.cdsContasRecebervalor_venda.AsCurrency);
  dateVenda.DateTime := dmContasReceber.cdsContasReceberdata_venda.AsDateTime;
  edtParcela.Text := dmContasReceber.cdsContasReceberparcela.AsString;
  edtValorParcela.Text := TUtilitarios.FormatarValor(dmContasReceber.cdsContasRecebervalor_parcela.AsCurrency);
  dateVencimento.DateTime := dmContasReceber.cdsContasReceberdata_vencimento.AsDateTime;

end;

procedure TfrmContasReceber.btnExcluirClick(Sender: TObject);
begin
  if dmContasReceber.cdsContasReceberstatus.AsString = 'C' then
  begin
    Application.MessageBox('O documento já se encontra cancelado.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if Application.MessageBox('Deseja realmente cancelar esse documento?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

  try
    dmContasReceber.cdsContasReceber.Edit;
    dmContasReceber.cdsContasReceberstatus.AsString := 'C';
    dmContasReceber.cdsContasReceber.Post;
    dmContasReceber.cdsContasReceber.ApplyUpdates(0);
    Application.MessageBox('Documento cancelado com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);
    Pesquisar;
  except on E : Exception do
    Application.MessageBox(PWideChar(E.Message), 'Erro ao cancelar documento', MB_OK + MB_ICONERROR);
  end;
end;

procedure TfrmContasReceber.btnGerarClick(Sender: TObject);
var
  Contador : integer;
  QuantidadeParcelas : Integer;
  IntervaloDias : Integer;
  ValorVenda : Currency;
  ValorParcela : Currency;
  ValorResiduo : Currency;
begin
  if not TryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
    edtValorVenda.SetFocus;
    Application.MessageBox('Valor da venda inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToInt(edtParcelas.Text, QuantidadeParcelas) then
  begin
    edtParcelas.SetFocus;
    Application.MessageBox('Quantidade de parcelas inválida.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToInt(edtIntervaloDias.Text, IntervaloDias) then
  begin
    edtParcelas.SetFocus;
    Application.MessageBox('Intervalo em dias inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;
  ValorParcela := TUtilitarios.TruncarValor(ValorVenda / QuantidadeParcelas);// (Trunc(ValorCompra / QuantidadeParcelas * 100)) / 100;
  ValorResiduo := ValorVenda - (ValorParcela * QuantidadeParcelas);

  cdsParcelas.EmptyDataSet;
  for Contador := 1 to QuantidadeParcelas do
  begin
    cdsParcelas.Insert;
    cdsParcelasParcela.AsInteger := Contador;
    cdsParcelasValor.AsCurrency := ValorParcela + ValorResiduo;
    ValorResiduo := 0;
    cdsParcelasVencimento.AsDateTime := IncDay(dateVenda.Date, IntervaloDias * Contador);
    cdsParcelas.Post;
  end;
end;

procedure TfrmContasReceber.btnImprimirClick(Sender: TObject);
begin
  RelContasReceber.Dataset(Datasource1.DataSet);
  RelContasReceber.Preview;
end;

procedure TfrmContasReceber.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dateVenda.Date := now;
  dateVencimento.Date := now;

  toggleParcelamento.Enabled := True;
  toggleParcelamento.State := tssOff;
  CardParcela.ActiveCard := cardParcelaUnica;
  cdsParcelas.EmptyDataSet;
end;

procedure TfrmContasReceber.btnLimparClick(Sender: TObject);
begin
  cdsParcelas.EmptyDataSet;
end;

procedure TfrmContasReceber.btnSalvarClick(Sender: TObject);
begin
  if toggleParcelamento.State = tssOff then
  begin
    CadastrarParcelaUnica;
    inherited;
  end
  else
    CadastrarParcelamento;
end;

procedure TfrmContasReceber.CadastrarParcelamento;
var
  ValorVenda : Currency;
begin
  if not TryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
    edtValorVenda.SetFocus;
    Application.MessageBox('Valor da venda inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  cdsParcelas.First;
  while not cdsParcelas.Eof do
  begin
    if cdsParcelasParcela.AsInteger < 0 then
    begin
      Application.MessageBox('Número da parcela inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
      abort;
    end;
    if cdsParcelasDocumento.AsString = '' then
    begin
      Application.MessageBox('Número do documento inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
      abort;
    end;

    if cdsParcelasValor.AsCurrency < 0.01 then
    begin
      Application.MessageBox('Valor da Parcela inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
      abort;
    end;
    cdsParcelas.Next;
  end;

  cdsParcelas.First;
   while not cdsParcelas.Eof do
   begin
    if dmContasReceber.cdsContasReceber.State in [dsBrowse, dsInactive] then
      dmContasReceber.cdsContasReceber.Insert;

    dmContasReceber.cdsContasReceberid.AsString := TUtilitarios.GetID;
    dmContasReceber.cdsContasReceberdata_cadastro.AsDateTime := now;
    dmContasReceber.cdsContasReceberstatus.AsString := 'A';
    dmContasReceber.cdsContasRecebervalor_abatido.AsCurrency := 0;

    dmContasReceber.cdsContasRecebernumero_documento.AsString := cdsParcelasDocumento.AsString;
    dmContasReceber.cdsContasReceberdescricao.AsString := Format('%s - Parcela %d' , [edtDescricao.Text, cdsParcelasParcela.AsInteger]);
    dmContasReceber.cdsContasRecebervalor_venda.AsCurrency := ValorVenda;
    dmContasReceber.cdsContasReceberdata_venda.AsDateTime := dateVenda.Date;
    dmContasReceber.cdsContasReceberparcela.AsInteger := cdsParcelasParcela.AsInteger;
    dmContasReceber.cdsContasRecebervalor_parcela.AsCurrency := cdsParcelasValor.AsCurrency;
    dmContasReceber.cdsContasReceberdata_vencimento.AsDateTime := cdsParcelasVencimento.AsDateTime;
    dmContasReceber.cdsContasReceber.Post;
    dmContasReceber.cdsContasReceber.ApplyUpdates(0);

    cdsParcelas.Next;
   end;

  Application.MessageBox('Parcelas cadastradas com sucesso.', 'Atenção', MB_OK + MB_ICONINFORMATION);
  Pesquisar;
  pnlPrincipal.ActiveCard := cardPesquisa;end;

procedure TfrmContasReceber.CadastrarParcelaUnica;
var
  Parcela : integer;
  ValorVenda : Currency;
  ValorParcela : Currency;
begin
  if edtNumeroDocumento.Text = '' then
  begin
    edtNumeroDocumento.SetFocus;
    Application.MessageBox('O campo número do documento não pode ser vazio.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToCurr(edtValorVenda.Text, ValorVenda) then
  begin
    edtValorVenda.SetFocus;
    Application.MessageBox('Valor da venda inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToInt(edtParcela.Text, Parcela) then
  begin
    edtParcela.SetFocus;
    Application.MessageBox('Número da parcela inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToCurr(edtValorParcela.Text, ValorParcela) then
  begin
    edtValorParcela.SetFocus;
    Application.MessageBox('Valor da parcela inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if dateVencimento.Date < dateVenda.Date then
  begin
    dateVencimento.SetFocus;
    Application.MessageBox('A data de vencimento não pode ser inferior a data de compra.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if DataSource1.State in [dsInsert] then
  begin
    dmContasReceber.cdsContasReceberid.AsString := TUtilitarios.GetID;
    dmContasReceber.cdsContasReceberdata_cadastro.AsDateTime := now;
    dmContasReceber.cdsContasReceberstatus.AsString := 'A';
    dmContasReceber.cdsContasRecebervalor_abatido.AsCurrency := 0;
  end;

  dmContasReceber.cdsContasRecebernumero_documento.AsString := edtNumeroDocumento.Text;
  dmContasReceber.cdsContasReceberdescricao.AsString := edtDescricao.Text;
  dmContasReceber.cdsContasRecebervalor_venda.AsCurrency := ValorVenda;
  dmContasReceber.cdsContasReceberdata_venda.AsDateTime := dateVenda.Date;
  dmContasReceber.cdsContasReceberparcela.AsInteger := Parcela;
  dmContasReceber.cdsContasRecebervalor_parcela.AsCurrency := ValorParcela;
  dmContasReceber.cdsContasReceberdata_vencimento.AsDateTime := dateVencimento.Date;
end;

procedure TfrmContasReceber.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);

end;

procedure TfrmContasReceber.edtValorParcelaExit(Sender: TObject);
begin
  edtValorParcela.Text := TUtilitarios.FormatarValor(edtValorParcela.Text);
end;

procedure TfrmContasReceber.edtValorVendaExit(Sender: TObject);
begin
  edtValorVenda.Text := TUtilitarios.FormatarValor(edtValorVenda.Text);
end;

procedure TfrmContasReceber.FormCreate(Sender: TObject);
begin
  inherited;
  edtValorVenda.OnKeyPress := TUtilitarios.KeyPressValor;
  edtValorParcela.OnKeyPress := TUtilitarios.KeyPressValor;
end;

procedure TfrmContasReceber.mnuBaixarClick(Sender: TObject);
begin
  frmContasReceberBaixar.BaixarContaReceber(datasource1.DataSet.FieldByName('ID').AsString);
  Pesquisar;
end;

procedure TfrmContasReceber.Pesquisar;
var
  FiltroPesquisa : string;
begin
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);
  dmContasReceber.cdsContasReceber.Close;
  dmContasReceber.cdsContasReceber.CommandText := 'Select * from Contas_Receber where 1 = 1' + FiltroPesquisa;
  dmContasReceber.cdsContasReceber.Open;
  inherited;

end;

procedure TfrmContasReceber.toggleParcelamentoClick(Sender: TObject);
begin
  CardParcela.ActiveCard := cardParcelaUnica;
  if toggleParcelamento.State = tssOn then
    CardParcela.ActiveCard := cardParcelamento;
end;

end.
