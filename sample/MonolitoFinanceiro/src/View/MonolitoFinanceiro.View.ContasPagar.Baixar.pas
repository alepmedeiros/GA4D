unit MonolitoFinanceiro.View.ContasPagar.Baixar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList,
  MonolitoFinanceiro.Model.Entidades.ContaPagar.Detalhe;

type
  TfrmContasPagarBaixar = class(TForm)
    pnlPrincipal: TPanel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblDocumento: TLabel;
    lblParcela: TLabel;
    lblVencimento: TLabel;
    lblValorParcela: TLabel;
    lblValorAbatido: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    edtObservacao: TEdit;
    edtValor: TEdit;
    pnlCadastroBotoes: TPanel;
    bntCancelar: TButton;
    btnBaixar: TButton;
    ImageList1: TImageList;
    procedure bntCancelarClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
  private
    { Private declarations }
    FID : String;
  public
    { Public declarations }
    procedure BaixarContaPagar(ID : string);
  end;

var
  frmContasPagarBaixar: TfrmContasPagarBaixar;

implementation

uses
  MonolitoFinanceiro.Model.Entidades.ContaPagar,
  MonolitoFinanceiro.Model.ContasPagar,
  MonolitoFinanceiro.Utilitarios, MonolitoFinanceiro.Model.Usuarios;

{$R *.dfm}

{ TfrmContasPagarBaixar }

procedure TfrmContasPagarBaixar.BaixarContaPagar(ID: string);
var
  ContaPagar : TModelContaPagar;
begin
  FID := Trim(ID);
  if FID.IsEmpty then
    raise Exception.Create('ID do contas a Pagar inválido');

  ContaPagar := dmContasPagar.GetContaPagar(FID);
  try
    if ContaPagar.Status = 'B' then
      raise Exception.Create('Não é possível baixar um documento baixado');

    if ContaPagar.Status = 'C' then
      raise Exception.Create('Não é possível baixar um documento cancelado');

    lblDocumento.Caption := ContaPagar.Documento;
    lblParcela.Caption := IntToStr(ContaPagar.Parcela);
    lblVencimento.Caption := FormatDateTime('dd/mm/yyyy', ContaPagar.DataVencimento);
    lblValorAbatido.Caption := TUtilitarios.FormatarValor(ContaPagar.ValorAbatido);
    lblValorParcela.Caption := TUtilitarios.FormatarValor(ContaPagar.ValorParcela);
    edtObservacao.Text := '';
    edtValor.Text := '';

    Self.ShowModal;
  finally
    ContaPagar.Free;
  end;

end;

procedure TfrmContasPagarBaixar.bntCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmContasPagarBaixar.btnBaixarClick(Sender: TObject);
var
  ContaPagarDetalhe : TModelContaPagarDetalhe;
  ValorAbater : Currency;
begin
  if Trim(edtObservacao.Text) = '' then
  begin
    edtObservacao.SetFocus;
    Application.MessageBox('A observação não pode ser vazia', 'Atenção', MB_OK + MB_ICONWARNING);
    abort
  end;

  ValorAbater := 0;
  TryStrToCurr(edtValor.Text, ValorAbater);

  if ValorAbater <= 0 then
  begin
    edtValor.SetFocus;
    Application.MessageBox('Valor inválido', 'Atenção', MB_OK + MB_ICONWARNING);
    abort
  end;

  ContaPagarDetalhe := TModelContaPagarDetalhe.Create;
  try
    ContaPagarDetalhe.IDContaPagar := FID;
    ContaPagarDetalhe.Detalhes := edtObservacao.Text;
    ContaPagarDetalhe.Valor :=  ValorAbater;
    ContaPagarDetalhe.Data := now;
    ContaPagarDetalhe.Usuario := dmUsuarios.GetUsuarioLogado.ID;

    try
      dmContasPagar.BaixarContaPagar(ContaPagarDetalhe);
      Application.MessageBox('Documento baixado com sucesso.', 'Erro ao baixar documento', MB_OK + MB_ICONINFORMATION);
      ModalResult := MrOk;
    except on E : Exception do
      Application.MessageBox(PWideChar(E.Message), 'Erro ao baixar documento', MB_OK + MB_ICONWARNING);
    end;
  finally
    COntaPagarDetalhe.Free;
  end;
end;

procedure TfrmContasPagarBaixar.edtValorExit(Sender: TObject);
begin
  EdtValor.Text := TUtilitarios.FormatarValor(edtValor.Text);
end;

procedure TfrmContasPagarBaixar.FormCreate(Sender: TObject);
begin
  edtValor.OnKeyPress := TUtilitarios.KeyPressValor;
end;

end.
