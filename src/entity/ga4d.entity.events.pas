unit ga4d.entity.events;

interface

uses
  ga4d.entity.params;

type
  TEvents = class
  private
    FName: String;
    FParams: TParams;
  public
    property Name: String read FName write FName;
    property Params: TParams read FParams write FParams;

    constructor Create;
    destructor Destroy; override;
    class function New: TEvents;
  end;

implementation

{ TEvents }

constructor TEvents.Create;
begin
  FParams := TParams.New;
end;

destructor TEvents.Destroy;
begin
  FParams.DisposeOf;
  inherited;
end;

class function TEvents.New: TEvents;
begin
  Result := Self.Create;
end;

end.
