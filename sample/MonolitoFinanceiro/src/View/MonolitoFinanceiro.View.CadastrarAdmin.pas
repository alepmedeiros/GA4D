unit MonolitoFinanceiro.View.CadastrarAdmin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCadastrarAdmin = class(TForm)
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
    procedure btnEConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastrarAdmin: TfrmCadastrarAdmin;

implementation

uses
  MonolitoFinanceiro.Model.Entidades.Usuario,
  MonolitoFinanceiro.Model.Usuarios, MonolitoFinanceiro.Model.Sistema;

{$R *.dfm}

procedure TfrmCadastrarAdmin.btnEConfirmarClick(Sender: TObject);
var
  Usuario : TModelEntidadeUsuario;
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

  Usuario := TModelEntidadeUsuario.Create;
  try
    Usuario.Nome := 'Administrador';
    Usuario.Login := 'Admin';
    Usuario.Senha := EdtSenha.Text;
    Usuario.SenhaTemporaria := false;
    Usuario.Administrador := true;

    dmUsuarios.CadastrarUsuario(Usuario);
    dmSistema.UsuarioUltimoAcesso('Admin');
  finally
    Usuario.Free;
  end;
  Application.MessageBox('Administrador Cadastrado com Sucesso', 'Sucesso', MB_OK + MB_ICONINFORMATION);
  ModalResult := mrOk;

end;

procedure TfrmCadastrarAdmin.Button1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
