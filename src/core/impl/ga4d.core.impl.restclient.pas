unit ga4d.core.impl.restclient;

interface

uses
  RestRequest4D,
  REST.Types,
  REST.Client,
  ga4d.core.interfaces;

type
  TRestClient = class(TInterfacedObject, iRestClient)
  private
    FReq: IRequest;
    {$IFDEF VER280}
    FBody: String;
    FURL: String;
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iRestClient;
    function BaseURL(Value: String): iRestClient;
    function Post: iRestClient;
    function Body(Value: String): iRestClient;
  end;

implementation

{ TMyClass }

function TRestClient.BaseURL(Value: String): iRestClient;
begin
  Result := Self;
  FReq.BaseURL(Value);
  {$IFDEF VER280}
  FURL := Value;
  {$ENDIF}
end;

function TRestClient.Body(Value: String): iRestClient;
begin
  Result := Self;
  FReq.AddBody(Value);
  {$IFDEF VER280}
  FBody := Value;
  {$ENDIF}
end;

constructor TRestClient.Create;
begin
  FReq := TRequest.New;
end;

destructor TRestClient.Destroy;
begin

  inherited;
end;

class function TRestClient.New: iRestClient;
begin
  Result := Self.Create;
end;

function TRestClient.Post: iRestClient;
begin
  Result := Self;
  FReq.Post;
  {$IFDEF VER280}
  FRestClient := TRESTClient.Create(FURL);
  FRestClient.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestClient.AcceptEncoding := '';
  FRestClient.AutoCreateParams := true;
  FRestClient.AllowCookies := true;
  FRestClient.BaseURL := Url;
  FRestClient.ContentType := '';
  FRestClient.FallbackCharsetEncoding := 'utf-8';
  FRestClient.HandleRedirects := true;

  FRestResponse := TRESTResponse.Create(FRestClient);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(FRestClient);
  FRestRequest.Accept :=
    'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  FRestRequest.AcceptEncoding := '';
  FRestRequest.AutoCreateParams := true;
  FRestRequest.Client := FRestClient;
  FRestRequest.Method := rmPOST;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Response := FRestResponse;

  FRestRequest.Params.Add;
  FRestRequest.Params[0].ContentType := ctAPPLICATION_JSON;
  FRestRequest.Params[0].Kind := pkREQUESTBODY;
  FRestRequest.Params[0].Name := 'body';
  FRestRequest.Params[0].Value := FBody;
  FRestRequest.Params[0].Options := [poDoNotEncode];

  FRestRequest.Execute;
  {$ENDIF}
end;

end.
