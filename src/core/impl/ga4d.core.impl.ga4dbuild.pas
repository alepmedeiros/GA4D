unit ga4d.core.impl.ga4dbuild;

interface

uses
  System.SysUtils,
  RestRequest4D,
  ga4d.utils,
  ga4d.core.interfaces,
  ga4d.entity.events,
  ga4d.entity.payload;

type
  TBuild = class(TInterfacedObject, iBuild)
  private
    FConfig: iConfiguration;
    FReq: IRequest;
    FPayload: TPayload;
    FName: String;
    FTime: String;
  public
    constructor Create(Config: iConfiguration);
    destructor Destroy; override;
    class function New(Config: iConfiguration): iBuild;
    function Name(Value: String): iBuild;
    function Engagement(Value: String): iBuild;
    function Push: iBuild;
  end;

implementation

constructor TBuild.Create(Config: iConfiguration);
begin
  FConfig := Config;

  FPayload:= TPayload.New;

  FReq := TRequest.New.BaseURL(Format(GA4COLLECT.GetValue,
    [FConfig.MeasurementId, FConfig.APISecret]));
end;

destructor TBuild.Destroy;
begin
  FPayload.DisposeOf;
  inherited;
end;

function TBuild.Engagement(Value: String): iBuild;
begin
  Result := Self;
  FTime := Value;
end;

function TBuild.Name(Value: String): iBuild;
begin
  Result := Self;
  FName := Value;
end;

class function TBuild.New(Config: iConfiguration): iBuild;
begin
  Result := Self.Create(Config);
end;

function TBuild.Push: iBuild;
var
  lEvent: TEvents;
begin
  Result := Self;

  FPayload.Client_Id := FConfig.ClientId;
  FPayload.User_Id := FConfig.UserId;
  lEvent:= TEvents.New;
  lEvent.Name := FName;
  lEvent.Params.Engagement_time_Msec := FTime;
  lEvent.Params.Session_Id := FConfig.SessionID;
  FPayload.Events.Add(lEvent);

  FReq
    .AddBody(FPayload.ToJson)
    .Post;
end;

end.
