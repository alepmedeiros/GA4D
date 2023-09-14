unit MonolitoFinanceiro.View.ContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceiro.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels,
  MonolitoFinanceiro.Model.ContasPagar, Vcl.ComCtrls, Vcl.WinXCtrls,
  Datasnap.DBClient, Vcl.Menus;

type
  TfrmContasPagar = class(TfrmCadastroPadrao)
    Label2: TLabel;
    edtValorCompra: TEdit;
    edtDescricao: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    dateCompra: TDateTimePicker;
    toggleParcelamento: TToggleSwitch;
    Label9: TLabel;
    CardParcela: TCardPanel;
    cardParcelaUnica: TCard;
    Label5: TLabel;
    edtNumeroDocumento: TEdit;
    Label6: TLabel;
    edtParcela: TEdit;
    Label7: TLabel;
    edtValorParcela: TEdit;
    Label8: TLabel;
    dateVencimento: TDateTimePicker;
    cardParcelamento: TCard;
    Label10: TLabel;
    edtParcelas: TEdit;
    Label11: TLabel;
    edtIntervaloDias: TEdit;
    btnGerar: TButton;
    btnLimpar: TButton;
    DBGrid2: TDBGrid;
    cdsParcelas: TClientDataSet;
    dsParcelas: TDataSource;
    cdsParcelasParcela: TIntegerField;
    cdsParcelasValor: TCurrencyField;
    cdsParcelasVencimento: TDateField;
    cdsParcelasDocumento: TStringField;
    PopupMenu1: TPopupMenu;
    mnuBaixar: TMenuItem;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure toggleParcelamentoClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorCompraExit(Sender: TObject);
    procedure edtValorParcelaExit(Sender: TObject);
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
  frmContasPagar: TfrmContasPagar;

implementation

uses
  MonolitoFinanceiro.Utilitarios,
  System.DateUtils, System.SysUtils,
  MonolitoFinanceiro.View.ContasPagar.Baixar,
  MonolitoFinanceiro.View.Relatorios.ContasPagar;

{$R *.dfm}

{ TfrmContasPagar }

procedure TfrmContasPagar.btnAlterarClick(Sender: TObject);
begin
  if dmContasPagar.cdsContasPagarstatus.AsString = 'B' then
  begin
    Application.MessageBox('O documento já foi baixado e não pode ser alterado.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if dmContasPagar.cdsContasPagarstatus.AsString = 'C' then
  begin
    Application.MessageBox('O documento já foi cancelado e não pode ser alterado.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  inherited;

  toggleParcelamento.Enabled := False;
  toggleParcelamento.State := tssOff;
  CardParcela.ActiveCard := cardParcelaUnica;
  cdsParcelas.EmptyDataSet;


  edtNumeroDocumento.Text := dmContasPagar.cdsContasPagarnumero_documento.AsString;
  edtDescricao.Text := dmContasPagar.cdsContasPagardescricao.AsString;
  edtValorCompra.Text := TUtilitarios.FormatarValor(dmContasPagar.cdsContasPagarvalor_compra.AsCurrency);
  dateCompra.DateTime := dmContasPagar.cdsContasPagardata_compra.AsDateTime;
  edtParcela.Text := dmContasPagar.cdsContasPagarparcela.AsString;
  edtValorParcela.Text :=  TUtilitarios.FormatarValor(dmContasPagar.cdsContasPagarvalor_parcela.AsCurrency);
  dateVencimento.DateTime := dmContasPagar.cdsContasPagardata_vencimento.AsDateTime;
end;

procedure TfrmContasPagar.btnExcluirClick(Sender: TObject);
begin
  if dmContasPagar.cdsContasPagarstatus.AsString = 'C' then
  begin
    Application.MessageBox('O documento já se encontra cancelado.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if Application.MessageBox('Deseja realmente cancelar esse documento?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

  try
    dmContasPagar.cdsContasPagar.Edit;
    dmContasPagar.cdsContasPagarstatus.AsString := 'C';
    dmContasPagar.cdsContasPagar.Post;
    dmContasPagar.cdsContasPagar.ApplyUpdates(0);
    Application.MessageBox('Documento cancelado com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);
    Pesquisar;
  except on E : Exception do
    Application.MessageBox(PWideChar(E.Message), 'Erro ao cancelar documento', MB_OK + MB_ICONERROR);
  end;
end;

procedure TfrmContasPagar.btnGerarClick(Sender: TObject);
var
  Contador : integer;
  QuantidadeParcelas : Integer;
  IntervaloDias : Integer;
  ValorCompra : Currency;
  ValorParcela : Currency;
  ValorResiduo : Currency;
begin
  if not TryStrToCurr(edtValorCompra.Text, ValorCOmpra) then
  begin
    edtValorCompra.SetFocus;
    Application.MessageBox('Valor da compra inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
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
  ValorParcela := TUtilitarios.TruncarValor(ValorCompra / QuantidadeParcelas);// (Trunc(ValorCompra / QuantidadeParcelas * 100)) / 100;
  ValorResiduo := ValorCompra - (ValorParcela * QuantidadeParcelas);

  cdsParcelas.EmptyDataSet;
  for Contador := 1 to QuantidadeParcelas do
  begin
    cdsParcelas.Insert;
    cdsParcelasParcela.AsInteger := Contador;
    cdsParcelasValor.AsCurrency := ValorParcela + ValorResiduo;
    ValorResiduo := 0;
    cdsParcelasVencimento.AsDateTime := IncDay(dateCompra.Date, IntervaloDias * Contador);
    cdsParcelas.Post;
  end;
end;

procedure TfrmContasPagar.btnImprimirClick(Sender: TObject);
begin
  inherited;
  RelContasPagar.DataSet(Datasource1.DataSet);
  RelContasPagar.Preview;
end;

procedure TfrmContasPagar.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dateCompra.Date := now;
  dateVencimento.Date := now;

  toggleParcelamento.Enabled := True;
  toggleParcelamento.State := tssOff;
  CardParcela.ActiveCard := cardParcelaUnica;
  cdsParcelas.EmptyDataSet;
end;

procedure TfrmContasPagar.btnLimparClick(Sender: TObject);
begin
  cdsParcelas.EmptyDataSet;
end;

procedure TfrmContasPagar.btnSalvarClick(Sender: TObject);
begin
  if toggleParcelamento.State = tssOff then
  begin
    CadastrarParcelaUnica;
    inherited;
  end
  else
    CadastrarParcelamento;

end;

procedure TfrmContasPagar.CadastrarParcelamento;
var
  ValorCompra : Currency;
begin
  if not TryStrToCurr(edtValorCompra.Text, ValorCompra) then
  begin
    edtValorCompra.SetFocus;
    Application.MessageBox('Valor da compra inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
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
    if dmContasPagar.cdsContasPagar.State in [dsBrowse, dsInactive] then
      dmContasPagar.cdsContasPagar.Insert;

    dmContasPagar.cdsContasPagarid.AsString := TUtilitarios.GetID;
    dmContasPagar.cdsContasPagardata_cadastro.AsDateTime := now;
    dmContasPagar.cdsContasPagarstatus.AsString := 'A';
    dmContasPagar.cdsContasPagarvalor_abatido.AsCurrency := 0;

    dmContasPagar.cdsContasPagarnumero_documento.AsString := cdsParcelasDocumento.AsString;
    dmContasPagar.cdsContasPagardescricao.AsString := Format('%s - Parcela %d' , [edtDescricao.Text, cdsParcelasParcela.AsInteger]);
    dmContasPagar.cdsContasPagarvalor_compra.AsCurrency := valorCompra;
    dmContasPagar.cdsContasPagardata_compra.AsDateTime := dateCompra.Date;
    dmContasPagar.cdsContasPagarparcela.AsInteger := cdsParcelasParcela.AsInteger;
    dmContasPagar.cdsContasPagarvalor_parcela.AsCurrency := cdsParcelasValor.AsCurrency;
    dmContasPagar.cdsContasPagardata_vencimento.AsDateTime := cdsParcelasVencimento.AsDateTime;
    dmContasPagar.cdsContasPagar.Post;
    dmContasPagar.cdsContasPagar.ApplyUpdates(0);

    cdsParcelas.Next;
   end;

  Application.MessageBox('Parcelas cadastradas com sucesso.', 'Atenção', MB_OK + MB_ICONINFORMATION);
  Pesquisar;
  pnlPrincipal.ActiveCard := cardPesquisa;
end;

procedure TfrmContasPagar.CadastrarParcelaUnica;
var
  Parcela : integer;
  ValorCompra : Currency;
  ValorParcela : Currency;
begin
  if edtNumeroDocumento.Text = '' then
  begin
    edtNumeroDocumento.SetFocus;
    Application.MessageBox('O campo número do documento não pode ser vazio.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if not TryStrToCurr(edtValorCompra.Text, ValorCompra) then
  begin
    edtValorCompra.SetFocus;
    Application.MessageBox('Valor da compra inválido.', 'Atenção', MB_OK + MB_ICONWARNING);
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

  if dateVencimento.Date < dateCompra.Date then
  begin
    dateVencimento.SetFocus;
    Application.MessageBox('A data de vencimento não pode ser inferior a data de compra.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if DataSource1.State in [dsInsert] then
  begin
    dmContasPagar.cdsContasPagarid.AsString := TUtilitarios.GetID;
    dmContasPagar.cdsContasPagardata_cadastro.AsDateTime := now;
    dmContasPagar.cdsContasPagarstatus.AsString := 'A';
    dmContasPagar.cdsContasPagarvalor_abatido.AsCurrency := 0;
  end;

  dmContasPagar.cdsContasPagarnumero_documento.AsString := edtNumeroDocumento.Text;
  dmContasPagar.cdsContasPagardescricao.AsString := edtDescricao.Text;
  dmContasPagar.cdsContasPagarvalor_compra.AsCurrency := valorCompra;
  dmContasPagar.cdsContasPagardata_compra.AsDateTime := dateCompra.Date;
  dmContasPagar.cdsContasPagarparcela.AsInteger := Parcela;
  dmContasPagar.cdsContasPagarvalor_parcela.AsCurrency := ValorParcela;
  dmContasPagar.cdsContasPagardata_vencimento.AsDateTime := dateVencimento.Date;
end;

procedure TfrmContasPagar.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);
end;

procedure TfrmContasPagar.edtValorCompraExit(Sender: TObject);
begin
  edtValorCompra.Text := TUtilitarios.FormatarValor(edtValorCompra.Text);
end;

procedure TfrmContasPagar.edtValorParcelaExit(Sender: TObject);
begin
  edtValorParcela.Text := TUtilitarios.FormatarValor(edtValorParcela.Text);
end;

procedure TfrmContasPagar.FormCreate(Sender: TObject);
begin
  inherited;
  edtValorCompra.OnKeyPress := TUtilitarios.KeyPressValor;
  edtValorParcela.OnKeyPress := TUtilitarios.KeyPressValor;
end;

procedure TfrmContasPagar.mnuBaixarClick(Sender: TObject);
begin
  frmContasPagarBaixar.BaixarContaPagar(DataSource1.DataSet.FieldByName('ID').AsString);
  Pesquisar;
end;

procedure TfrmContasPagar.Pesquisar;
var
  FiltroPesquisa : string;
begin
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);
  dmContasPagar.cdsContasPagar.Close;
  dmContasPagar.cdsContasPagar.CommandText := 'Select * from Contas_Pagar where 1 = 1' + FiltroPesquisa;
  dmContasPagar.cdsContasPagar.Open;
  inherited;
end;

procedure TfrmContasPagar.toggleParcelamentoClick(Sender: TObject);
begin
  CardParcela.ActiveCard := cardParcelaUnica;
  if toggleParcelamento.State = tssOn then
    CardParcela.ActiveCard := cardParcelamento;
end;

end.
