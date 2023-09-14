unit MonolitoFinanceiro.Model.Entidades.ContaReceber.Detalhe;

interface
type
  TModelContaReceberDetalhe = class
    private
    FValor: Currency;
    FIdContaPagar: string;
    FDetalhes: string;
    FId: string;
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
      property IdContaReceber : string read FIdContaPagar write SetIdContaPagar;
      property Detalhes : string read FDetalhes write SetDetalhes;
      property Valor : Currency read FValor write SetValor;
      property Data : TDate read FData write SetData;
      property Usuario : string read FUsuario write SetUsuario;

  end;
implementation

{ TModelContaReceberDetalhe }

procedure TModelContaReceberDetalhe.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TModelContaReceberDetalhe.SetDetalhes(const Value: string);
begin
  FDetalhes := Value;
end;

procedure TModelContaReceberDetalhe.SetId(const Value: string);
begin
  FId := Value;
end;

procedure TModelContaReceberDetalhe.SetIdContaPagar(const Value: string);
begin
  FIdContaPagar := Value;
end;

procedure TModelContaReceberDetalhe.SetUsuario(const Value: string);
begin
  FUsuario := Value;
end;

procedure TModelContaReceberDetalhe.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
