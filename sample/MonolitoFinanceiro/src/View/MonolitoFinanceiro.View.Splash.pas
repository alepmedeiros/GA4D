unit MonolitoFinanceiro.View.Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmSplash = class(TForm)
    pnlPrincipal: TPanel;
    imgLogo: TImage;
    lblNomeAplicacao: TLabel;
    ProgressBar1: TProgressBar;
    lblStatus: TLabel;
    Timer1: TTimer;
    Panel1: TPanel;
    imgDll: TImage;
    imgBancoDeDados: TImage;
    imgConfiguracoes: TImage;
    imgIniciando: TImage;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarStatus(Mensagem: String; Imagem : TImage);
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.AtualizarStatus(Mensagem: String; Imagem : TImage);
begin
  lblStatus.Caption := Mensagem;
  Imagem.Visible := True;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position <= 100 then
  begin
    ProgressBar1.StepIt;
    case ProgressBar1.Position of
      10 : AtualizarStatus('Carregando dependências...', imgDll);
      25 : AtualizarStatus('Conectando ao banco de dados...', imgBancoDeDados);
      45 : AtualizarStatus('Carregando as configurações...', imgConfiguracoes);
      75 : AtualizarStatus('Inciando o Sistema...', imgIniciando);
    end;
  end;
  if ProgressBar1.Position = 100 then
    Close;
end;

end.
