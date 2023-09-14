unit MonolitoFinanceiro.Model.Entidades.Caixa.Lancamento;

interface
type
  TModelCaixaLancamento = class
    private
    FID: String;
    FNumeroDoc: string;
    FValor: Currency;
    FDescricao: string;
    FDataCadastro: TDate;
    FTipo: string;
    procedure SetID(const Value: String);
    procedure SetNumeroDoc(const Value: string);
    procedure SetDescricao(const Value: string);
    procedure SetValor(const Value: Currency);
    procedure SetDataCadastro(const Value: TDate);
    procedure SetTipo(const Value: string);
    public
      property ID : String read FID write SetID;
      property NumeroDoc : string read FNumeroDoc write SetNumeroDoc;
      property Descricao : string read FDescricao write SetDescricao;
      property Valor : Currency read FValor write SetValor;
      property Tipo : string read FTipo write SetTipo;
      property DataCadastro : TDate read FDataCadastro write SetDataCadastro;

  end;
implementation

{ TModelCaixaLancamento }

procedure TModelCaixaLancamento.SetDataCadastro(const Value: TDate);
begin
  FDataCadastro := Value;
end;

procedure TModelCaixaLancamento.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TModelCaixaLancamento.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TModelCaixaLancamento.SetNumeroDoc(const Value: string);
begin
  FNumeroDoc := Value;
end;

procedure TModelCaixaLancamento.SetTipo(const Value: string);
begin
  FTipo := Value;
end;

procedure TModelCaixaLancamento.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
