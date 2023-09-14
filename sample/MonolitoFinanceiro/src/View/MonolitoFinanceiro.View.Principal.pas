unit MonolitoFinanceiro.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  MonolitoFinanceiro.View.Usuarios, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnuCadastro: TMenuItem;
    mnuRelatorios: TMenuItem;
    mnuAjuda: TMenuItem;
    mnuUsuarios: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    mnuFinanceiro: TMenuItem;
    mnuCaixa: TMenuItem;
    mnuResumoCaixa: TMenuItem;
    mnuContasPagar: TMenuItem;
    mnuContasReceber: TMenuItem;
    mnuContasReceberConsultar: TMenuItem;
    mnuContasPagarConsultar: TMenuItem;
    mnuExtratoCaixa: TMenuItem;
    procedure mnuUsuariosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mnuCaixaClick(Sender: TObject);
    procedure mnuResumoCaixaClick(Sender: TObject);
    procedure mnuContasPagarClick(Sender: TObject);
    procedure mnuContasReceberClick(Sender: TObject);
    procedure mnuContasReceberConsultarClick(Sender: TObject);
    procedure mnuContasPagarConsultarClick(Sender: TObject);
    procedure mnuExtratoCaixaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  MonolitoFinanceiro.View.Splash,
  MonolitoFinanceiro.View.Login,
  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceiro.View.Caixa,
  MonolitoFinanceiro.View.Caixa.Saldo,
  MonolitoFinanceiro.View.ContasPagar,
  MonolitoFinanceiro.View.ContasReceber,
  MonolitoFinanceiro.View.ContasReceber.Consultar,
  MonolitoFinanceiro.View.ContasPagar.Consultar,
  MonolitoFinanceiro.View.Caixa.Extrato,
  MonolitoFinanceiro.View.RedefinirSenha,
  MonolitoFinanceiro.View.CadastrarAdmin,
  MonolitoFinanceiro.Analytics;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmSplash := TFrmSplash.Create(nil);
  try
    frmSplash.ShowModal;
  finally
    FreeAndNil(frmSplash);
  end;
  if dmUsuarios.TabelaUsuariosVazia then
  begin
    frmCadastrarAdmin := TfrmCadastrarAdmin.Create(nil);
    try
      frmCadastrarAdmin.ShowModal;
      if frmCadastrarAdmin.ModalResult <> mrOk then
        Application.Terminate;
    finally
      FreeAndNil(frmCadastrarAdmin);
    end;
  end;

  frmLogin := TFrmLogin.Create(nil);
  try
    frmLogin.ShowModal;
    if frmLogin.ModalResult <> mrOk then
      Application.Terminate;
  finally
    FreeAndNil(frmLogin);
  end;

  TAnalytics
    .GetInstance
      .ClientID('MonolitoFinanceiro')
      .UserID(dmUsuarios.GetUsuarioLogado.ID);

  if dmUsuarios.GetUsuarioLogado.SenhaTemporaria then
  begin
    frmRedefinirSenha := TfrmRedefinirSenha.Create(nil);
    try
      frmRedefinirSenha.Usuario := dmUsuarios.GetUsuarioLogado;
      frmRedefinirSenha.ShowModal;
      if frmRedefinirSenha.ModalResult <> mrOk then
        Application.Terminate;
    finally
      FreeAndNil(frmRedefinirSenha);
    end;
  end;

  StatusBar1.Panels.Items[1].Text := 'Usuário: ' + dmUsuarios.GetUsuarioLogado.Nome;
end;

procedure TfrmPrincipal.mnuCaixaClick(Sender: TObject);
begin
  frmCaixa.Show;
end;

procedure TfrmPrincipal.mnuContasPagarClick(Sender: TObject);
begin
  frmContasPagar.Show;
end;

procedure TfrmPrincipal.mnuContasPagarConsultarClick(Sender: TObject);
begin
  frmContasPagarConsultar.Show;
end;

procedure TfrmPrincipal.mnuContasReceberClick(Sender: TObject);
begin
  frmContasReceber.Show;
end;

procedure TfrmPrincipal.mnuContasReceberConsultarClick(Sender: TObject);
begin
  frmContasReceberConsultar.Show;
end;

procedure TfrmPrincipal.mnuExtratoCaixaClick(Sender: TObject);
begin
  frmCaixaExtrato.Show
end;

procedure TfrmPrincipal.mnuResumoCaixaClick(Sender: TObject);
begin
  frmCaixaSaldo.show;
end;

procedure TfrmPrincipal.mnuUsuariosClick(Sender: TObject);
begin
  frmUsuarios.Show;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Text := DateTimeToStr(Now);
end;

end.
