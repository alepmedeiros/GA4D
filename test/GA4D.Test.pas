unit GA4D.Test;

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  ga4d.core.interfaces, ga4d.core.impl.ga4d;

type
  [TestFixture]
  TGA4DTest = class
  private
    FGA4D: iGA4;

    CONST
      APISECRET = 'DBZH7_HlSLWlPgHZVktQfw';
      CLIENTID = '3854820615';
      USERID = '';
      MEASUREMENTID = 'G-7S90J0EX3X';
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure RegistraEvento;
  end;

implementation

procedure TGA4DTest.RegistraEvento;
var
  lTime: TTime;
begin
  lTime := now;
  FGA4D
    .Build
    .Name('TesteUnitario_GA4D')
    .Engagement(Trunc(lTime).ToString)
    .Push;
end;

procedure TGA4DTest.Setup;
begin
  FGA4D := TGA4D.New;
  FGA4D
    .Config
      .APISecret(APISECRET)
      .ClientId(CLIENTID)
      .UserId(USERID)
      .MeasurementId(MEASUREMENTID);
end;

procedure TGA4DTest.TearDown;
var
  lTime: TTime;
begin
  lTime := now;
  FGA4D
    .Build
    .Name('TesteUnitario_GA4D')
    .Engagement(Trunc(lTime).ToString)
    .Push;
end;

initialization
  TDUnitX.RegisterTestFixture(TGA4DTest);

end.
