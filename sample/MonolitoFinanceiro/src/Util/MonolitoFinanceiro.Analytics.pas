unit MonolitoFinanceiro.Analytics;

interface

uses
  ga4d.core.interfaces;
type
  TAnalytics = class
    private
      const
        APISECRET = 'APISECRET';
        MEASUREMENTID = 'MEASUREMENTID';

      class var FInstance : TAnalytics;
      FGA4D : iGA4;
      constructor CreatePrivate;
    public
      constructor Create;
      destructor Destroy; override;
      class function GetInstance : TAnalytics;
      class destructor Finish;
      function ClientID(Value : string) : TAnalytics;
      function UserID(Value : string) : TAnalytics;
      procedure Event(Value : string);

  end;
implementation
uses
  System.SysUtils,
  System.Classes,
  ga4d.core.impl.ga4d;

{ TAnalytics }

function TAnalytics.ClientID(Value: string): TAnalytics;
begin
  Result := Self;
  FGA4D.Config.ClientId(Value);
end;

constructor TAnalytics.Create;
begin
  raise Exception.Create('Invoke the GetInstance Method.');
end;

constructor TAnalytics.CreatePrivate;
begin
  FGA4D := TGA4D.New;
  FGA4D
    .Config
      .APISecret(APISECRET)
      .MeasurementId(MEASUREMENTID);
end;

destructor TAnalytics.Destroy;
begin

  inherited;
end;

procedure TAnalytics.Event(Value: string);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      FGA4D
        .Build
          .Name(StringReplace(Value, ' ','_', [rfReplaceAll]))
          .Engagement(Trunc(now).ToString)
          .Push;
    end
  ).Start;
end;

class destructor TAnalytics.Finish;
begin
  if Assigned(FInstance) then
    FInstance.DisposeOf;
end;

class function TAnalytics.GetInstance: TAnalytics;
begin
  if not Assigned(Finstance) then
    FInstance := TAnalytics.CreatePrivate;
  Result := FInstance;
end;

function TAnalytics.UserID(Value: string): TAnalytics;
begin
  Result := Self;
  FGA4D.Config.UserId(Value);
end;

end.
