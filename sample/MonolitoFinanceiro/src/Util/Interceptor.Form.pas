unit Interceptor.Form;
interface

uses
  Vcl.Forms;

type
  TForm = class(Vcl.Forms.TForm)
  protected
    procedure DoShow; override;
  end;
implementation

uses
  MonolitoFinanceiro.Analytics;

{ TForm }

procedure TForm.DoShow;
begin
  TAnalytics.GetInstance.Event(Self.Name);
  inherited;
end;

end.
