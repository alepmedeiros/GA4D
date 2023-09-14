unit MonolitoFinanceiro.Utilitarios;

interface

uses
  Vcl.DBGrids, FireDAC.Stan.Param, Vcl.Grids, System.Types;
type
  TUtilitarios = class
    class function GetID : String;
    class function LikeFind(Pesquisa : string; Grid : TDBGrid) : string;
    class function FormatoMoeda(aValue : Currency) : string;
    class function FormatarValor(aValue : Currency; Decimais : Integer = 2) : string; overload;
    class function FormatarValor(aValue : string; Decimais : Integer = 2) : string; overload;
    class procedure KeyPressValor(Sender: TObject;  var Key: Char);
    class function TruncarValor(aValue : Currency; Decimais : Integer = 2) : Currency;
    class procedure ValidarData(FieldParam : TFDPAram; Data : TDateTime);
    class procedure ZebrarDBGrid(Sender : TDBGrid; Rect: TRect; Column : TColumn; State : TGridDrawState);

  end;
implementation

uses
  System.SysUtils, Vcl.StdCtrls, System.Math;

{ TUtilitarios }

class function TUtilitarios.FormatarValor(aValue: Currency;
  Decimais: Integer): string;
begin
  aValue := TruncarValor(aValue, Decimais);
  Result := FormatCurr('0.' + stringOfChar('0', Decimais), aValue);
end;

class function TUtilitarios.FormatarValor(aValue: string;
  Decimais: Integer): string;
var
  LValor : Currency;
begin
  LValor := 0;
  TryStrToCurr(aValue, LValor);
  Result := FormatarValor(LValor, Decimais);
end;

class function TUtilitarios.FormatoMoeda(aValue: Currency): string;
begin
  Result := Format('%m', [aValue]);
end;

class function TUtilitarios.GetID: String;
begin
  Result := TGUID.NewGuid.ToString;
  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
end;

class procedure TUtilitarios.KeyPressValor(Sender: TObject; var Key: Char);
begin
  if Key = FormatSettings.ThousandSeparator then
    Key := FormatSettings.DecimalSeparator;

  if not (CharInSet(Key, ['0'..'9', chr(8), FormatSettings.DecimalSeparator])) then
    Key := #0;

  if (Key = FormatSettings.DecimalSeparator) and (pos(Key, TEdit(Sender).Text) > 0) then
    Key := #0;
end;

class function TUtilitarios.LikeFind(Pesquisa: string; Grid: TDBGrid): string;
var
  LContador : Integer;
begin
  Result := '';
  if Pesquisa.Trim.IsEmpty then
    exit;
  for LContador := 0 to Pred(Grid.Columns.Count) do
    Result := Result + Grid.Columns.Items[LContador].FieldName +
      ' LIKE ' + QuotedStr('%' + Trim(Pesquisa) + '%') + ' OR ';
  Result := ' AND (' + Copy(Result, 1, Length(Result) - 4) + ')';
end;

class function TUtilitarios.TruncarValor(aValue: Currency;
  Decimais: Integer): Currency;
var
  LFator : Double;
begin
  LFator := Power(10, Decimais);
  Result := Trunc(aValue * LFator) / LFator;
end;

class procedure TUtilitarios.ValidarData(FieldParam: TFDPAram; Data: TDateTime);
begin
  FieldParam.AsDateTime := Data;
  if data = 0 then
    FieldParam.Clear
end;

class procedure TUtilitarios.ZebrarDBGrid(Sender: TDBGrid; Rect: TRect;
  Column: TColumn; State: TGridDrawState);
begin
  if not Odd(Sender.DataSource.DataSet.RecNo) then
  begin
    if not(gdSelected in State) then
    begin
      Sender.Canvas.Brush.Color := $00FFEFDF;
      Sender.Canvas.FillRect(Rect);
      Sender.DefaultDrawDataCell(Rect, Column.Field, State);
    end;
  end;
end;

end.
