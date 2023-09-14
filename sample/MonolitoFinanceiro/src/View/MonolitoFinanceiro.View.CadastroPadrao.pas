unit MonolitoFinanceiro.View.CadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.WinXPanels, Vcl.Mask,
  Vcl.DBCtrls, Interceptor.Form;

type
  TfrmCadastroPadrao = class(TForm)
    PnlPrincipal: TCardPanel;
    cardCadastro: TCard;
    cardPesquisa: TCard;
    pnlPesquisa: TPanel;
    pnlPesquisarBotoes: TPanel;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    edtPesquisar: TEdit;
    Label1: TLabel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    btnFechar: TButton;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnImprimir: TButton;
    pnlCadastroBotoes: TPanel;
    bntCancelar: TButton;
    btnSalvar: TButton;
    DataSource1: TDataSource;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure bntCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure HabilitarBotoes;
    procedure LimparCampos;
  public
    { Public declarations }
  protected
    procedure Pesquisar; virtual;
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

uses
  Datasnap.DBClient, Vcl.WinXCtrls,
  MonolitoFinanceiro.Utilitarios,
  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceiro.Analytics;

{$R *.dfm}

procedure TfrmCadastroPadrao.btnAlterarClick(Sender: TObject);
begin
  TClientDataSet(datasource1.DataSet).Edit;
  PnlPrincipal.ActiveCard := cardCadastro;
end;

procedure TfrmCadastroPadrao.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir o registro?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

  try
    TClientDataSet(datasource1.DataSet).Delete;
    TClientDataSet(datasource1.DataSet).ApplyUpdates(0);
    Application.MessageBox('Registro excluído com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);
    Pesquisar;
  except on E : Exception do
    Application.MessageBox(PWideChar(E.Message), 'Erro ao excluir registro', MB_OK + MB_ICONERROR);
  end;
end;

procedure TfrmCadastroPadrao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroPadrao.btnIncluirClick(Sender: TObject);
begin
  LimparCampos;
  PnlPrincipal.ActiveCard := cardCadastro;
  TClientDataSet(datasource1.DataSet).Insert;
end;

procedure TfrmCadastroPadrao.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmCadastroPadrao.btnSalvarClick(Sender: TObject);
var
  Mensagem : string;
begin
  Mensagem := 'Registro alterado com sucesso!';

  if DataSource1.State in [dsInsert] then
    Mensagem := 'Registro incluído com sucesso!';


  TClientDataSet(DataSource1.DataSet).Post;
  TClientDataSet(DataSource1.DataSet).ApplyUpdates(0);
  Application.MessageBox(PWideChar(Mensagem), 'Atenção', MB_OK + MB_ICONINFORMATION);

  Pesquisar;
  pnlPrincipal.ActiveCard := cardPesquisa;

end;

procedure TfrmCadastroPadrao.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TUtilitarios.ZebrarDBGrid(TDBGrid(Sender), Rect, Column, State);
end;

procedure TfrmCadastroPadrao.bntCancelarClick(Sender: TObject);
begin
  TClientDataSet(datasource1.DataSet).Cancel;
  PnlPrincipal.ActiveCard := cardPesquisa;
end;

procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := cardPesquisa;
  Pesquisar;
end;

procedure TfrmCadastroPadrao.HabilitarBotoes;
begin
  btnExcluir.Enabled := not DataSource1.DataSet.IsEmpty;
  btnAlterar.Enabled := not DataSource1.DataSet.IsEmpty;
end;

procedure TfrmCadastroPadrao.LimparCampos;
var
  Contador : integer;
begin
  for Contador := 0 to Pred(ComponentCount) do
  begin
    if Components[Contador] is TCustomEdit then
      TCustomEdit(Components[Contador]).Clear
    else if Components[Contador] is TToggleSwitch then
      TToggleSwitch(Components[Contador]).State := tssOn
    else if Components[Contador] is  TRadioGroup then
      TRadioGroup(Components[Contador]).ItemIndex := -1;
  end;
end;

procedure TfrmCadastroPadrao.Pesquisar;
begin
  HabilitarBotoes;
end;

end.
