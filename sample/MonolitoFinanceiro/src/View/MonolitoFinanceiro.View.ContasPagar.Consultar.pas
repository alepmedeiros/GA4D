unit MonolitoFinanceiro.View.ContasPagar.Consultar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids, Vcl.DBGrids,
  MonolitoFinanceiro.Model.ContasPagar, Vcl.ComCtrls, Vcl.WinXPanels,
  Vcl.WinXCtrls;

type
  TfrmContasPagarConsultar = class(TForm)
    Panel1: TPanel;
    pnlPesquisa: TPanel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    pnlCadastroBotoes: TPanel;
    btnFechar: TButton;
    btnBaixar: TButton;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Panel4: TPanel;
    StackPanel2: TStackPanel;
    Label2: TLabel;
    cbFiltroTipoData: TComboBox;
    Panel5: TPanel;
    StackPanel3: TStackPanel;
    Panel3: TPanel;
    StackPanel1: TStackPanel;
    Label1: TLabel;
    Label3: TLabel;
    DateFiltroDataInicio: TDateTimePicker;
    DateFiltroDataFinal: TDateTimePicker;
    SplitView1: TSplitView;
    Panel6: TPanel;
    StackPanel4: TStackPanel;
    Label4: TLabel;
    Panel7: TPanel;
    StackPanel5: TStackPanel;
    Label5: TLabel;
    cbFiltroStatus: TComboBox;
    Panel8: TPanel;
    StackPanel6: TStackPanel;
    Label6: TLabel;
    edtFiltroNumero: TEdit;
    edtFiltroParcela: TEdit;
    Panel9: TPanel;
    btnFiltros: TButton;
    Panel10: TPanel;
    lblTotalRecebimentos: TLabel;
    lblQuantidadeRegistros: TLabel;
    btnDetalhes: TButton;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure cbFiltroTipoDataKeyPress(Sender: TObject; var Key: Char);
    procedure cbFiltroTipoDataSelect(Sender: TObject);
    procedure btnFiltrosClick(Sender: TObject);
    procedure cbFiltroStatusKeyPress(Sender: TObject; var Key: Char);
    procedure btnBaixarClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btnDetalhesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    FFiltroPesquisa : string;
    procedure LimparFiltro;
    procedure AdicionarFiltro(aValue : string);
    procedure Pesquisar;
    procedure FiltrarData;
    procedure FiltrarNumero;
    procedure FiltrarParcela;
    procedure FiltrarStatus;
    procedure HabilitarDatas(aValue : Boolean);
  public
    { Public declarations }
  end;

var
  frmContasPagarConsultar: TfrmContasPagarConsultar;

implementation

uses
  MonolitoFinanceiro.View.ContasPagar.Baixar,
  MonolitoFinanceiro.Utilitarios,
  MonolitoFinanceiro.View.ContasPagar.Detalhes;

{$R *.dfm}

procedure TfrmContasPagarConsultar.AdicionarFiltro(aValue: string);
begin
  FFiltroPesquisa := FFiltroPesquisa + ' ' + aValue;
end;

procedure TfrmContasPagarConsultar.btnBaixarClick(Sender: TObject);
begin
  frmContasPagarBaixar.BaixarContaPagar(datasource1.DataSet.FieldByName('ID').AsString);
  if frmContasPagarBaixar.ModalResult = mrOk then
    dmContasPagar.cdsContasPagar.Refresh;
end;

procedure TfrmContasPagarConsultar.btnDetalhesClick(Sender: TObject);
begin
  frmContasPagarDetalhes.ExibirContasPagarDetalhes(datasource1.DataSet.FieldByName('ID').AsString);
end;

procedure TfrmContasPagarConsultar.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmContasPagarConsultar.btnFiltrosClick(Sender: TObject);
begin
  SplitView1.Opened := not SplitView1.Opened;
end;

procedure TfrmContasPagarConsultar.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmContasPagarConsultar.cbFiltroStatusKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
    cbFiltroStatus.ItemIndex := -1;
end;

procedure TfrmContasPagarConsultar.cbFiltroTipoDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
  begin
    cbFiltroTipoData.ItemIndex := -1;
    HabilitarDatas(false);
  end;
end;

procedure TfrmContasPagarConsultar.cbFiltroTipoDataSelect(Sender: TObject);
begin
  HabilitarDatas(true);
end;

procedure TfrmContasPagarConsultar.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  btnBaixar.Enabled := DataSource1.DataSet.FieldByName('STATUS').AsString = 'A';
end;

procedure TfrmContasPagarConsultar.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);
end;

procedure TfrmContasPagarConsultar.FiltrarNumero;
begin
  if edtFiltroNumero.Text = '' then
    exit;

  AdicionarFiltro('AND NUMERO_DOCUMENTO = :NUMERODOCUMENTO');
  dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftString, 'NUMERODOCUMENTO', TParamType.ptInput);
  dmContasPagar.cdsContasPagar.ParamByName('NUMERODOCUMENTO').AsString := edtFiltroNumero.Text;
end;

procedure TfrmContasPagarConsultar.FiltrarData;
var
  CampoData : string;
begin
  if cbFiltroTipoData.ItemIndex = -1 then
    exit;

  if (DateFiltroDataInicio.Checked = false) and (DateFiltroDataFinal.Checked = false) then
  begin
    Application.MessageBox('Uma data tem que ser selecionada.', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  case cbFiltroTipoData.ItemIndex of
    0 : CampoData := 'DATA_COMPRA';
    1 : CampoData := 'DATA_VENCIMENTO';
    2 : CampoData := 'DATA_PAGAMENTO';
  end;

  if DateFiltroDataInicio.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' >= :DATAINICIO');
    dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftDate, 'DATAINICIO', TParamType.ptInput);
    dmContasPagar.cdsContasPagar.ParamByName('DATAINICIO').AsDate := DateFiltroDataInicio.Date;
  end;

  if DateFiltroDataFinal.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' <= :DATAFINAL');
    dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftDate, 'DATAFINAL', TParamType.ptInput);
    dmContasPagar.cdsContasPagar.ParamByName('DATAFINAL').AsDate := DateFiltroDataFinal.Date;
  end;
end;

procedure TfrmContasPagarConsultar.FiltrarParcela;
var
  Parcela : integer;
begin
  if edtFiltroParcela.Text = '' then
    exit;

  if not TryStrToInt(edtFiltroParcela.Text, Parcela) then
  begin
    Application.MessageBox('Número da parcela inválido', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  AdicionarFiltro('AND PARCELA = :PARCELA');
  dmContasPagar.cdsContasPagar.Params.CreateParam(TFieldType.ftInteger, 'PARCELA', TParamType.ptInput);
  dmContasPagar.cdsContasPagar.ParamByName('PARCELA').AsInteger := Parcela;
end;

procedure TfrmContasPagarConsultar.FiltrarStatus;
begin
  if cbFiltroStatus.ItemIndex = -1 then
    exit;

  case cbFiltroStatus.ItemIndex of
    0: AdicionarFiltro('AND STATUS = ''A''');
    1: AdicionarFiltro('AND STATUS = ''C''');
    2: AdicionarFiltro('AND STATUS = ''B''');
  end;
end;

procedure TfrmContasPagarConsultar.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmContasPagarConsultar.HabilitarDatas(aValue: Boolean);
begin
  DateFiltroDataInicio.Enabled := aValue;
  DateFiltroDataFinal.Enabled := aValue;
end;

procedure TfrmContasPagarConsultar.LimparFiltro;
begin
  FFiltroPesquisa := '';
end;

procedure TfrmContasPagarConsultar.Pesquisar;
begin
  splitView1.Opened := false;

  LimparFiltro;

  dmContasPagar.cdsContasPagar.Params.Clear;

  FiltrarData;
  FiltrarNumero;
  FiltrarParcela;
  FiltrarStatus;

  dmContasPagar.cdsContasPagar.Close;
  dmContasPagar.cdsContasPagar.CommandText := 'SELECT * FROM CONTAS_PAGAR WHERE 1 = 1' + FFiltroPesquisa;
  dmContasPagar.cdsContasPagar.Open;

  lblQuantidadeRegistros.Caption := Format('Quantidade de Registro: %d', [datasource1.DataSet.RecordCount]);
  lblTotalRecebimentos.Caption := 'Total de Pagamentos: R$ ' + TUtilitarios.FormatarValor(dmContasPagar.cdsContasPagar.FieldByName('Total').AsString);

end;

end.
