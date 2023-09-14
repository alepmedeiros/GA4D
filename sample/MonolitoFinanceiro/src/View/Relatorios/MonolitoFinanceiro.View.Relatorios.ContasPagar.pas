unit MonolitoFinanceiro.View.Relatorios.ContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  MonolitoFinanceiro.View.Relatorios.Padrao, Data.DB, RLReport;

type
  TRelContasPagar = class(TRelPadrao)
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand6: TRLBand;
    lblTotal: TRLLabel;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RelContasPagar: TRelContasPagar;

implementation

uses
  MonolitoFinanceiro.Utilitarios;

{$R *.dfm}

procedure TRelContasPagar.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  lblTotal.Caption := 'Total R$' + TUtilitarios.FormatarValor(datasource1.DataSet.FieldByName('Total').AsString);
end;

end.
