unit MonolitoFinanceiro.View.ContasReceber.Consultar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Data.DB, Vcl.Grids, Vcl.DBGrids,
  MonolitoFinanceiro.Model.ContasReceber, Vcl.ComCtrls, Vcl.WinXPanels,
  Vcl.WinXCtrls;

type
  TfrmContasReceberConsultar = class(TForm)
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
    btnImprimir: TButton;
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
    procedure btnImprimirClick(Sender: TObject);
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
  frmContasReceberConsultar: TfrmContasReceberConsultar;

implementation

uses
  MonolitoFinanceiro.View.ContasReceber.Baixar,
  MonolitoFinanceiro.Utilitarios,
  MonolitoFinanceiro.View.ContasReceber.Detalhes,
  MonolitoFinanceiro.View.Relatorios.ContasReceberDetalhado;

{$R *.dfm}

procedure TfrmContasReceberConsultar.AdicionarFiltro(aValue: string);
begin
  FFiltroPesquisa := FFiltroPesquisa + ' ' + aValue;
end;

procedure TfrmContasReceberConsultar.btnBaixarClick(Sender: TObject);
begin
  frmContasReceberBaixar.BaixarContaReceber(datasource1.DataSet.FieldByName('ID').AsString);
  if frmContasReceberBaixar.ModalResult = mrOk then
    dmContasReceber.cdsContasReceber.Refresh;
end;

procedure TfrmContasReceberConsultar.btnDetalhesClick(Sender: TObject);
begin
  frmContasReceberDetalhes.ExibirContasReceberDetalhes(datasource1.DataSet.FieldByName('ID').AsString);
end;

procedure TfrmContasReceberConsultar.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmContasReceberConsultar.btnFiltrosClick(Sender: TObject);
begin
  SplitView1.Opened := not SplitView1.Opened;
end;

procedure TfrmContasReceberConsultar.btnImprimirClick(Sender: TObject);
var
  SQL : String;
begin
  SQL := 'SELECT * FROM CONTAS_RECEBER' +
    ' LEFT JOIN CONTAS_RECEBER_DETALHES ON' +
    ' CONTAS_RECEBER.ID = CONTAS_RECEBER_DETALHES.ID_CONTA_RECEBER WHERE 1 = 1' + FFiltroPesquisa;
  dmContasReceber.sqlRelContasReceberDetalhado.Close;
  dmContasReceber.sqlRelContasReceberDetalhado.sql.Clear;
  dmContasReceber.sqlRelContasReceberDetalhado.SQL.Add(SQL);
  dmContasReceber.sqlRelContasReceberDetalhado.Open;
  RelContasReceberDetalhado.dataset(dmContasReceber.sqlRelContasReceberDetalhado);
  RelContasReceberDetalhado.Preview;
end;

procedure TfrmContasReceberConsultar.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmContasReceberConsultar.cbFiltroStatusKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
    cbFiltroStatus.ItemIndex := -1;
end;

procedure TfrmContasReceberConsultar.cbFiltroTipoDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then
  begin
    cbFiltroTipoData.ItemIndex := -1;
    HabilitarDatas(false);
  end;
end;

procedure TfrmContasReceberConsultar.cbFiltroTipoDataSelect(Sender: TObject);
begin
  HabilitarDatas(true);
end;

procedure TfrmContasReceberConsultar.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  btnBaixar.Enabled := DataSource1.DataSet.FieldByName('STATUS').AsString = 'A';
end;

procedure TfrmContasReceberConsultar.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);
end;

procedure TfrmContasReceberConsultar.FiltrarNumero;
begin
  if edtFiltroNumero.Text = '' then
    exit;

  AdicionarFiltro('AND NUMERO_DOCUMENTO = :NUMERODOCUMENTO');
  dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftString, 'NUMERODOCUMENTO', TParamType.ptInput);
  dmContasReceber.cdsContasReceber.ParamByName('NUMERODOCUMENTO').AsString := edtFiltroNumero.Text;
end;

procedure TfrmContasReceberConsultar.FiltrarData;
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
    0 : CampoData := 'DATA_VENDA';
    1 : CampoData := 'DATA_VENCIMENTO';
    2 : CampoData := 'DATA_RECEBIMENTO';
  end;

  if DateFiltroDataInicio.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' >= :DATAINICIO');
    dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftDate, 'DATAINICIO', TParamType.ptInput);
    dmContasReceber.cdsContasReceber.ParamByName('DATAINICIO').AsDate := DateFiltroDataInicio.Date;
  end;

  if DateFiltroDataFinal.Checked then
  begin
    AdicionarFiltro('AND ' + CampoData + ' <= :DATAFINAL');
    dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftDate, 'DATAFINAL', TParamType.ptInput);
    dmContasReceber.cdsContasReceber.ParamByName('DATAFINAL').AsDate := DateFiltroDataFinal.Date;
  end;
end;

procedure TfrmContasReceberConsultar.FiltrarParcela;
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
  dmContasReceber.cdsContasReceber.Params.CreateParam(TFieldType.ftInteger, 'PARCELA', TParamType.ptInput);
  dmContasReceber.cdsContasReceber.ParamByName('PARCELA').AsInteger := Parcela;
end;

procedure TfrmContasReceberConsultar.FiltrarStatus;
begin
  if cbFiltroStatus.ItemIndex = -1 then
    exit;

  case cbFiltroStatus.ItemIndex of
    0: AdicionarFiltro('AND STATUS = ''A''');
    1: AdicionarFiltro('AND STATUS = ''C''');
    2: AdicionarFiltro('AND STATUS = ''B''');
  end;
end;

procedure TfrmContasReceberConsultar.FormShow(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmContasReceberConsultar.HabilitarDatas(aValue: Boolean);
begin
  DateFiltroDataInicio.Enabled := aValue;
  DateFiltroDataFinal.Enabled := aValue;
end;

procedure TfrmContasReceberConsultar.LimparFiltro;
begin
  FFiltroPesquisa := '';
end;

procedure TfrmContasReceberConsultar.Pesquisar;
begin
  splitView1.Opened := false;

  LimparFiltro;

  dmContasReceber.cdsContasReceber.Params.Clear;

  FiltrarData;
  FiltrarNumero;
  FiltrarParcela;
  FiltrarStatus;

  dmContasReceber.cdsContasReceber.Close;
  dmContasReceber.cdsContasReceber.CommandText := 'SELECT * FROM CONTAS_RECEBER WHERE 1 = 1' + FFiltroPesquisa;
  dmContasReceber.cdsContasReceber.Open;

  lblQuantidadeRegistros.Caption := Format('Quantidade de Registro: %d', [datasource1.DataSet.RecordCount]);
  lblTotalRecebimentos.Caption := 'Total de Recebimentos: R$ ' + TUtilitarios.FormatarValor(dmContasReceber.cdsContasReceber.FieldByName('Total').AsString);

end;

end.
