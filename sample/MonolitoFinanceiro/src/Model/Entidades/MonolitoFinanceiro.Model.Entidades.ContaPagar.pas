unit MonolitoFinanceiro.Model.Entidades.ContaPagar;

interface
type
  TModelContaPagar = class
    private
      FValorParcela: Currency;
      FDataCompra: TDate;
      FDescricao: string;
      FDataVencimento: TDate;
      FDataPagamento: TDate;
      FDocumento: string;
      FID: string;
      FValorAbatido: Currency;
      FValorCompra: Currency;
      FStatus: string;
      FDataCadastro: TDate;
      FParcela: Integer;
      procedure SetDataCadastro(const Value: TDate);
      procedure SetDataCompra(const Value: TDate);
      procedure SetDataPagamento(const Value: TDate);
      procedure SetDataVencimento(const Value: TDate);
      procedure SetDescricao(const Value: string);
      procedure SetDocumento(const Value: string);
      procedure SetID(const Value: string);
      procedure SetParcela(const Value: Integer);
      procedure SetStatus(const Value: string);
      procedure SetValorAbatido(const Value: Currency);
      procedure SetValorCompra(const Value: Currency);
      procedure SetValorParcela(const Value: Currency);
    public
      property ID : string read FID write SetID;
      property Documento : string read FDocumento write SetDocumento;
      property Descricao : string read FDescricao write SetDescricao;
      property Parcela : Integer read FParcela write SetParcela;
      property ValorParcela : Currency read FValorParcela write SetValorParcela;
      property ValorCompra : Currency read FValorCompra write SetValorCompra;
      property ValorAbatido : Currency read FValorAbatido write SetValorAbatido;
      property DataCompra : TDate read FDataCompra write SetDataCompra;
      property DataCadastro : TDate read FDataCadastro write SetDataCadastro;
      property DataVencimento : TDate read FDataVencimento write SetDataVencimento;
      property DataPagamento : TDate read FDataPagamento write SetDataPagamento;
      property Status : string read FStatus write SetStatus;

  end;
implementation

{ TModelContaPagar }

procedure TModelContaPagar.SetDataCadastro(const Value: TDate);
begin
  FDataCadastro := Value;
end;

procedure TModelContaPagar.SetDataCompra(const Value: TDate);
begin
  FDataCompra := Value;
end;

procedure TModelContaPagar.SetDataPagamento(const Value: TDate);
begin
  FDataPagamento := Value;
end;

procedure TModelContaPagar.SetDataVencimento(const Value: TDate);
begin
  FDataVencimento := Value;
end;

procedure TModelContaPagar.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TModelContaPagar.SetDocumento(const Value: string);
begin
  FDocumento := Value;
end;

procedure TModelContaPagar.SetID(const Value: string);
begin
  FID := Value;
end;

procedure TModelContaPagar.SetParcela(const Value: Integer);
begin
  FParcela := Value;
end;

procedure TModelContaPagar.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TModelContaPagar.SetValorAbatido(const Value: Currency);
begin
  FValorAbatido := Value;
end;

procedure TModelContaPagar.SetValorCompra(const Value: Currency);
begin
  FValorCompra := Value;
end;

procedure TModelContaPagar.SetValorParcela(const Value: Currency);
begin
  FValorParcela := Value;
end;

end.
