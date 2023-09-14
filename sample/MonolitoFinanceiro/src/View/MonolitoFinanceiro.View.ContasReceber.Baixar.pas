unit MonolitoFinanceiro.View.ContasReceber.Baixar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList,
  MonolitoFinanceiro.Model.Entidades.ContaReceber.Detalhe;

type
  TfrmContasReceberBaixar = class(TForm)
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
    procedure BaixarContaReceber(ID : string);
  end;

var
  frmContasReceberBaixar: TfrmContasReceberBaixar;

implementation

uses
  MonolitoFinanceiro.Model.Entidades.ContaReceber,
  MonolitoFinanceiro.Model.ContasReceber,
  MonolitoFinanceiro.Utilitarios,
  MonolitoFinanceiro.Model.Usuarios;

{$R *.dfm}

{ TfrmContasPagarBaixar }

procedure TfrmContasReceberBaixar.BaixarContaReceber(ID: string);
var
  ContaReceber : TModelContaReceber;
begin
  FID := Trim(ID);
  if FID.IsEmpty then
    raise Exception.Create('ID do contas a Pagar inválido');

  ContaReceber := dmContasReceber.GetContaReceber(FID);
  try
    if ContaReceber.Status = 'B' then
      raise Exception.Create('Não é possível baixar um documento baixado');

    if ContaReceber.Status = 'C' then
      raise Exception.Create('Não é possível baixar um documento cancelado');

    lblDocumento.Caption := ContaReceber.Documento;
    lblParcela.Caption := IntToStr(ContaReceber.Parcela);
    lblVencimento.Caption := FormatDateTime('dd/mm/yyyy', ContaReceber.DataVencimento);
    lblValorAbatido.Caption := TUtilitarios.FormatarValor(ContaReceber.ValorAbatido);
    lblValorParcela.Caption := TUtilitarios.FormatarValor(ContaReceber.ValorParcela);
    edtObservacao.Text := '';
    edtValor.Text := '';

    Self.ShowModal;
  finally
    ContaReceber.Free;
  end;

end;

procedure TfrmContasReceberBaixar.bntCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmContasReceberBaixar.btnBaixarClick(Sender: TObject);
var
  ContaReceberDetalhe : TModelContaReceberDetalhe;
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

  ContaReceberDetalhe := TModelContaReceberDetalhe.Create;
  try
    ContaReceberDetalhe.IDContaReceber := FID;
    ContaReceberDetalhe.Detalhes := edtObservacao.Text;
    ContaReceberDetalhe.Valor :=  ValorAbater;
    ContaReceberDetalhe.Data := now;
    ContaReceberDetalhe.Usuario := dmUsuarios.GetUsuarioLogado.ID;

    try
      dmContasReceber.BaixarContaReceber(ContaReceberDetalhe);
      Application.MessageBox('Documento baixado com sucesso.', 'Erro ao baixar documento', MB_OK + MB_ICONINFORMATION);
      ModalResult := MrOk;
    except on E : Exception do
      Application.MessageBox(PWideChar(E.Message), 'Erro ao baixar documento', MB_OK + MB_ICONWARNING);
    end;
  finally
    ContaReceberDetalhe.Free;
  end;
end;

procedure TfrmContasReceberBaixar.edtValorExit(Sender: TObject);
begin
  EdtValor.Text := TUtilitarios.FormatarValor(edtValor.Text);
end;

procedure TfrmContasReceberBaixar.FormCreate(Sender: TObject);
begin
  edtValor.OnKeyPress := TUtilitarios.KeyPressValor;
end;

end.
