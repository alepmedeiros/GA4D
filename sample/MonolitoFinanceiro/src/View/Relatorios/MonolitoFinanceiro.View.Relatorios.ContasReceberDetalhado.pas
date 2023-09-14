unit MonolitoFinanceiro.View.Relatorios.ContasReceberDetalhado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  MonolitoFinanceiro.View.Relatorios.PadraoAgrupado, Data.DB, RLReport;

type
  TRelContasReceberDetalhado = class(TRelPadraoAgrupado)
    RLGroup1: TRLGroup;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLBand6: TRLBand;
    RLBand7: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText8: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBResult1: TRLDBResult;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RelContasReceberDetalhado: TRelContasReceberDetalhado;

implementation

{$R *.dfm}

end.
