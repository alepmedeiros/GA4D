unit ga4d.core.impl.ga4d;

interface

uses
  ga4d.core.interfaces,
  ga4d.core.impl.config,
  ga4d.core.impl.ga4dbuild;

type
  TGA4D = class(TInterfacedObject, iGA4)
  private
    FConfig: iConfiguration;
    FBuild: iBuild;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iGA4;
    function config: iConfiguration;
    function Build: iBuild;
  end;

implementation

function TGA4D.Build: iBuild;
begin
  if not Assigned(FBuild) then
    FBuild := TBuild.New(FConfig);
  Result := FBuild;
end;

function TGA4D.config: iConfiguration;
begin
  Result := FConfig;
end;

constructor TGA4D.Create;
begin
  FConfig := TConfig.New;
end;

destructor TGA4D.Destroy;
begin

  inherited;
end;

class function TGA4D.New: iGA4;
begin
  Result := Self.Create;
end;

end.
