unit MonolitoFinanceiro.Model.Entidades.ContaReceber;

interface
type
  TModelContaReceber = class
    private
    FDataCompra: TDate;
    FValorParcela: Currency;
    FValorCompra: Currency;
    FDescricao: string;
    FDataVencimento: TDate;
    FDocumento: string;
    FID: string;
    FValorAbatido: Currency;
    FStatus: string;
    FDataCadastro: TDate;
    FDataPagamento: TDate;
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
      property ValorVenda : Currency read FValorCompra write SetValorCompra;
      property ValorAbatido : Currency read FValorAbatido write SetValorAbatido;
      property DataVenda : TDate read FDataCompra write SetDataCompra;
      property DataCadastro : TDate read FDataCadastro write SetDataCadastro;
      property DataVencimento : TDate read FDataVencimento write SetDataVencimento;
      property DataRecebimento : TDate read FDataPagamento write SetDataPagamento;
      property Status : string read FStatus write SetStatus;

  end;
implementation

{ TModelContaReceber }

procedure TModelContaReceber.SetDataCadastro(const Value: TDate);
begin
  FDataCadastro := Value;
end;

procedure TModelContaReceber.SetDataCompra(const Value: TDate);
begin
  FDataCompra := Value;
end;

procedure TModelContaReceber.SetDataPagamento(const Value: TDate);
begin
  FDataPagamento := Value;
end;

procedure TModelContaReceber.SetDataVencimento(const Value: TDate);
begin
  FDataVencimento := Value;
end;

procedure TModelContaReceber.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TModelContaReceber.SetDocumento(const Value: string);
begin
  FDocumento := Value;
end;

procedure TModelContaReceber.SetID(const Value: string);
begin
  FID := Value;
end;

procedure TModelContaReceber.SetParcela(const Value: Integer);
begin
  FParcela := Value;
end;

procedure TModelContaReceber.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TModelContaReceber.SetValorAbatido(const Value: Currency);
begin
  FValorAbatido := Value;
end;

procedure TModelContaReceber.SetValorCompra(const Value: Currency);
begin
  FValorCompra := Value;
end;

procedure TModelContaReceber.SetValorParcela(const Value: Currency);
begin
  FValorParcela := Value;
end;

end.
