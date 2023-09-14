unit MonolitoFinanceiro.View.RedefinirSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  MonolitoFinanceiro.Model.Entidades.Usuario;

type
  TfrmRedefinirSenha = class(TForm)
    Panel1: TPanel;
    lblNomeAplicacao: TLabel;
    lblUsuario: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    edtSenha: TEdit;
    Panel4: TPanel;
    Label3: TLabel;
    edtConfirmarSenha: TEdit;
    Panel5: TPanel;
    btnEConfirmar: TButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEConfirmarClick(Sender: TObject);
  private
    FUsuario: TModelEntidadeUsuario;
    procedure SetUsuario(const Value: TModelEntidadeUsuario);
    { Private declarations }
  public
    { Public declarations }
    property Usuario : TModelEntidadeUsuario read FUsuario write SetUsuario;
  end;

var
  frmRedefinirSenha: TfrmRedefinirSenha;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios;

{$R *.dfm}

procedure TfrmRedefinirSenha.btnEConfirmarClick(Sender: TObject);
begin
  edtSenha.Text := Trim(edtSenha.Text);
  edtConfirmarSenha.Text := Trim(edtConfirmarSenha.Text);

  if edtSenha.Text = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('Informe a sua nova senha', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if edtConfirmarSenha.Text = '' then
  begin
    edtConfirmarSenha.SetFocus;
    Application.MessageBox('Confirme a sua nova senha', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  if edtSenha.Text <> edtConfirmarSenha.Text then
  begin
    edtConfirmarSenha.SetFocus;
    Application.MessageBox('Senha diferente da confirmação', 'Atenção', MB_OK + MB_ICONWARNING);
    abort;
  end;

  Usuario.Senha := EdtSenha.Text;
  dmUsuarios.RedefinirSenha(Usuario);
  Application.MessageBox('Senha alterada com Sucesso', 'Sucesso', MB_OK + MB_ICONINFORMATION);
  ModalResult := mrOk;

end;

procedure TfrmRedefinirSenha.Button1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmRedefinirSenha.FormShow(Sender: TObject);
begin
  lblUsuario.Caption := FUsuario.Nome;
end;

procedure TfrmRedefinirSenha.SetUsuario(const Value: TModelEntidadeUsuario);
begin
  FUsuario := Value;
end;

end.
