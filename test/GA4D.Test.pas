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
      .APISecret('rKMhVkGqS6W4vgfwhygcbQ')
      .ClientId('GA4D')
      .UserId('APP_Test_Unit')
      .MeasurementId('G-2MQE8MC9KF');
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
