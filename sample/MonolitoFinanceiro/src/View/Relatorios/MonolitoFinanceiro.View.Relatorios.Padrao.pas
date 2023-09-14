unit MonolitoFinanceiro.View.Relatorios.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TRelPadrao = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLBand2: TRLBand;
    RLLabel2: TRLLabel;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    lblNome: TRLLabel;
    RLPanel1: TRLPanel;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo1: TRLSystemInfo;
    DataSource1: TDataSource;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Dataset(aValue : TDataset);
    procedure Preview;
  end;

var
  RelPadrao: TRelPadrao;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios;

{$R *.dfm}

{ TForm1 }

procedure TRelPadrao.Dataset(aValue: TDataset);
begin
  Datasource1.DataSet := aValue;
end;

procedure TRelPadrao.Preview;
begin
  RLReport1.Preview;
end;

procedure TRelPadrao.RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
lblNome.Caption := Format('Impresso por %s em %s', [dmUsuarios.GetUsuarioLogado.Nome, FormatDateTime('dd/mm/yyyy', now)]);
end;

end.
