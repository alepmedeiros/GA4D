unit ga4d.core.interfaces;

interface

type
  iConfiguration = interface;
  iBuild = interface;

  iGA4 = interface
    function Config: iConfiguration;
    function Build: iBuild;
  end;

  iConfiguration = interface
    function APISecret(Value: String): iConfiguration; overload;
    function APISecret: String; overload;
    function ClientId(Value: String): iConfiguration; overload;
    function ClientId: String; overload;
    function UserId(Value: String): iConfiguration; overload;
    function UserId: String; overload;
    function SessionID: String;
    function MeasurementId(Value: String): iConfiguration; overload;
    function MeasurementId: String; overload;
  end;

  iBuild = interface
    function Name(Value: String): iBuild;
    function Engagement(Value: String): iBuild;
    function Push: iBuild;
  end;

  iRestClient = interface
    function BaseURL(Value: String): iRestClient;
    function Post: iRestClient;
    function Body(Value: String): iRestClient;
  end;

implementation

end.
