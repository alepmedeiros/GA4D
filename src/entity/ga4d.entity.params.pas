unit ga4d.entity.params;

interface

type
  TParams = class
  private
    FEngagement_time_Msec: String;
    FSession_Id: String;
  public
    property Engagement_time_Msec: String read FEngagement_time_Msec write FEngagement_time_Msec;
    property Session_Id: String read FSession_Id write FSession_Id;

    class function New: TParams;
  end;

implementation

{ TParams }

class function TParams.New: TParams;
begin
  Result := Self.Create;
end;

end.
