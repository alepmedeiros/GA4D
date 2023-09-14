unit MonolitoFinanceiro.View.Relatorios.Caixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  MonolitoFinanceiro.View.Relatorios.Padrao, Data.DB, RLReport;

type
  TRelCaixa = class(TRelPadrao)
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText5: TRLDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RelCaixa: TRelCaixa;

implementation

{$R *.dfm}

end.
