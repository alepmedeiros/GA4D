unit MonolitoFinanceiro.Model.Entidades.Caixa.Resumo;

interface
type
  TModelResumoCaixa = class
  private
    FTotalSaidas: Currency;
    FTotalEntradas: Currency;
    FSaldoInicial: Currency;
    procedure SetSaldoInicial(const Value: Currency);
    procedure SetTotalEntradas(const Value: Currency);
    procedure SetTotalSaidas(const Value: Currency);
  public
    property SaldoInicial : Currency read FSaldoInicial write SetSaldoInicial;
    property TotalEntradas : Currency read FTotalEntradas write SetTotalEntradas;
    property TotalSaidas : Currency read FTotalSaidas write SetTotalSaidas;
    function SaldoParcial : Currency;
    function SaldoFinal : Currency;
  end;
implementation

{ TModelResumoCaixa }

function TModelResumoCaixa.SaldoFinal: Currency;
begin
  Result := FSaldoInicial + SaldoParcial;
end;

function TModelResumoCaixa.SaldoParcial: Currency;
begin
  Result := FTotalEntradas - FTotalSaidas;
end;

procedure TModelResumoCaixa.SetSaldoInicial(const Value: Currency);
begin
  FSaldoInicial := Value;
end;

procedure TModelResumoCaixa.SetTotalEntradas(const Value: Currency);
begin
  FTotalEntradas := Value;
end;

procedure TModelResumoCaixa.SetTotalSaidas(const Value: Currency);
begin
  FTotalSaidas := Value;
end;

end.
