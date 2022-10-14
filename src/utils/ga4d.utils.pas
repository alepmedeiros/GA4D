unit ga4d.utils;

interface

uses
  System.JSON,
  ga4d.entity.payload,
  GBJSON.Interfaces;

type
  TBaseURL = (GABASE);
  TEndPoint = (GA4COLLECT, UACOLLECT, VALIDMEASUREMENT);

  TBaseURLHelp = record helper for TBaseURL
    function GetValue: String;
  end;

  TEndPointHelp = record helper for TEndPoint
    function GetValue: String;
  end;

  TPayloadHelper = class helper for TPayload
    function JsonToObject(Value: String): TPayload;
    function ToJson: TJsonObject;
  end;

implementation

{ TEndPointHelp }

function TEndPointHelp.GetValue: String;
begin
  case Self of
    GA4COLLECT: Result := GABASE.GetValue + '/mp/collect?measurement_id=%s&api_secret=%s';
    UACOLLECT: Result :=  GABASE.GetValue  + '/collect';
    VALIDMEASUREMENT : Result := GABASE.GetValue +  '/debug/mp/collect?measurement_id=%s&api_secret=%s';
  end;
end;

{ TBaseURLHelp }

function TBaseURLHelp.GetValue: String;
begin
  Result := 'https://www.google-analytics.com';
end;

{ TPayloadHelper }

function TPayloadHelper.JsonToObject(Value: String): TPayload;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Serializer<TPayload>.JsonStringToObject(Value);
end;

function TPayloadHelper.ToJson: TJsonObject;
begin
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLower);
  Result := TGBJSONDefault.Deserializer<TPayload>.ObjectToJsonObject(Self);
end;

end.
