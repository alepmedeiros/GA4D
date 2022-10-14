unit ga4d.core.impl.config;

interface

uses
  System.SysUtils,
  ga4d.core.interfaces;

type
  TConfig = class(TInterfacedObject, iConfiguration)
    private
      FAPISecret: String;
      FClientId: String;
      FUserId: String;
      FMeasurementId: String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iConfiguration;
      function APISecret(Value: String): iConfiguration; overload;
      function APISecret: String; overload;
      function ClientId(Value: String): iConfiguration; overload;
      function ClientId: String; overload;
      function UserId(Value: String): iConfiguration; overload;
      function UserId: String; overload;
      function SesseionID: String;
      function MeasurementId(Value: String): iConfiguration; overload;
      function MeasurementId: String; overload;
  end;

implementation

function TConfig.APISecret: String;
begin
  Result := FAPISecret;
end;

function TConfig.APISecret(Value: String): iConfiguration;
begin
  Result := Self;
  FAPISecret := Value;
end;

function TConfig.ClientId(Value: String): iConfiguration;
begin
  Result := Self;
  FClientId := Value;
end;

function TConfig.ClientId: String;
begin
  Result := FClientId;
end;

constructor TConfig.Create;
begin

end;

destructor TConfig.Destroy;
begin

  inherited;
end;

function TConfig.MeasurementId: String;
begin
  Result := FMeasurementId;
end;

function TConfig.MeasurementId(Value: String): iConfiguration;
begin
  Result := Self;
  FMeasurementId := Value;
end;

class function TConfig.New : iConfiguration;
begin
  Result := Self.Create;
end;

function TConfig.SesseionID: String;
var
  lSession: Integer;
begin
  lSession := Random(100);
  Result := lSession.ToString;
end;

function TConfig.UserId: String;
begin
  Result := FUserId;
end;

function TConfig.UserId(Value: String): iConfiguration;
begin
  Result := Self;
  FUserId := Value;
end;

end.
