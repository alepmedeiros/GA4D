unit ga4d.entity.payload;

interface

uses
  System.Generics.Collections,
  ga4d.entity.events;

type
  TPayload = class
  private
    FClient_Id: String;
    FUser_Id: String;
    FNon_Personalized_Ads: Boolean;
    FEvents: TObjectList<TEvents>;
    FApp_Instance_Id: String;
    FTimestamp_Micros: Integer;
  public
    property App_Instance_Id: String read FApp_Instance_Id write FApp_Instance_Id;
    property Client_Id: String read FClient_Id write FClient_Id;
    property User_Id: String read FUser_Id write FUser_Id;
    property Timestamp_Micros: Integer read FTimestamp_Micros write FTimestamp_Micros;
    property Non_Personalized_Ads: Boolean read FNon_Personalized_Ads write FNon_Personalized_Ads;
    property Events: TObjectList<TEvents> read FEvents write FEvents;

    constructor Create;
    destructor Destroy; override;
    class function New: TPayload;
  end;

implementation

{ TPayload }

constructor TPayload.Create;
begin
  FEvents:= TObjectList<TEvents>.Create;
end;

destructor TPayload.Destroy;
begin
  FEvents.DisposeOf;
  inherited;
end;

class function TPayload.New: TPayload;
begin
  Result := Self.Create;
end;

end.
