unit MonolitoFinanceiro.Model.Entidades.ContaPagar.Detalhe;

interface
type
  TModelContaPagarDetalhe = class
    private
      FValor: Currency;
      FDetalhes: string;
      FId: string;
      FIdContaPagar: string;
      FUsuario: string;
      FData: TDate;
      procedure SetData(const Value: TDate);
      procedure SetDetalhes(const Value: string);
      procedure SetId(const Value: string);
      procedure SetIdContaPagar(const Value: string);
      procedure SetUsuario(const Value: string);
      procedure SetValor(const Value: Currency);
    public
      property Id : string read FId write SetId;
      property IdContaPagar : string read FIdContaPagar write SetIdContaPagar;
      property Detalhes : string read FDetalhes write SetDetalhes;
      property Valor : Currency read FValor write SetValor;
      property Data : TDate read FData write SetData;
      property Usuario : string read FUsuario write SetUsuario;
  end;
implementation

{ TModelContaPagarDetalhe }

procedure TModelContaPagarDetalhe.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TModelContaPagarDetalhe.SetDetalhes(const Value: string);
begin
  FDetalhes := Value;
end;

procedure TModelContaPagarDetalhe.SetId(const Value: string);
begin
  FId := Value;
end;

procedure TModelContaPagarDetalhe.SetIdContaPagar(const Value: string);
begin
  FIdContaPagar := Value;
end;

procedure TModelContaPagarDetalhe.SetUsuario(const Value: string);
begin
  FUsuario := Value;
end;

procedure TModelContaPagarDetalhe.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
