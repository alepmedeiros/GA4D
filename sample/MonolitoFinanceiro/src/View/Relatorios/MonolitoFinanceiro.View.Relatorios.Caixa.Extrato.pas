unit MonolitoFinanceiro.View.Relatorios.Caixa.Extrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  MonolitoFinanceiro.View.Relatorios.PadraoAgrupado, Data.DB, RLReport,
  MonolitoFinanceiro.Model.Entidades.Caixa.Resumo;

type
  TRelCaixaExtrato = class(TRelPadraoAgrupado)
    RLGroup1: TRLGroup;
    RLBand4: TRLBand;
    RLBand3: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand6: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLBand7: TRLBand;
    RLPanel2: TRLPanel;
    RLLabel7: TRLLabel;
    lblSaldoAnterior: TRLLabel;
    RLPanel3: TRLPanel;
    RLLabel9: TRLLabel;
    lblTotalEntradas: TRLLabel;
    RLPanel4: TRLPanel;
    RLLabel11: TRLLabel;
    lblTotalSaidas: TRLLabel;
    RLPanel5: TRLPanel;
    RLLabel13: TRLLabel;
    lblSaldoFinal: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure ResumoCaixa(ResumoCaixa : TModelResumoCaixa);
  end;

var
  RelCaixaExtrato: TRelCaixaExtrato;

implementation

uses
  MonolitoFinanceiro.Utilitarios;

{$R *.dfm}

{ TRelCaixaExtrato }

procedure TRelCaixaExtrato.ResumoCaixa(ResumoCaixa: TModelResumoCaixa);
begin
  lblSaldoAnterior.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoInicial);
  lblTotalEntradas.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.TotalEntradas);
  lblTotalSaidas.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.TotalSaidas);
  lblSaldoFinal.Caption := TUtilitarios.FormatoMoeda(ResumoCaixa.SaldoFinal);
end;

end.
