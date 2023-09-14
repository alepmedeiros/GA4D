unit MonolitoFinanceiro.Model.Sistema;

interface

uses
  System.SysUtils, System.Classes, Vcl.forms;

type
  TdmSistema = class(TDataModule)
  private
    { Private declarations }
    const ARQUIVOCONFIGURACAO = 'MonolitoFinanceiro.cfg';
    function GetConfiguracao(Secao, Parametro, valorPadrao : String) : String;
    procedure SetConfiguracao(Secao, Parametro, Valor : String);
  public
    { Public declarations }
    function DataUltimoAcesso : String; overload;
    procedure DataUltimoAcesso(aValue : TDateTime); overload;
    function UsuarioUltimoAcesso : String; overload;
    procedure UsuarioUltimoAcesso(aValue : String); overload;
    function DriverID : String; overload;
    procedure DriverID(aValue : String); overload;
    function Database : String; overload;
    procedure Database(aValue : String); overload;
    function LockingMode : String; overload;
    procedure LockingMode(aValue : String); overload;
  end;

var
  dmSistema: TdmSistema;

implementation

uses
  System.IniFiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TdmSistema.DataUltimoAcesso: String;
begin
  Result := GetConfiguracao('ACESSO', 'Data', '');
end;

function TdmSistema.Database: String;
begin
  Result := GetConfiguracao('Banco de dados', 'Database', 'db\SistemaFinanceiro.db');
end;

procedure TdmSistema.Database(aValue: String);
begin
  SetConfiguracao('Banco de dados', 'Database', aValue);
end;

procedure TdmSistema.DataUltimoAcesso(aValue: TDateTime);
begin
  SetConfiguracao('ACESSO', 'Data', DateTimeToStr(aValue));
end;

function TdmSistema.DriverID: String;
begin
  Result := GetConfiguracao('Banco de dados', 'DriverID', 'SQLite');
end;

procedure TdmSistema.DriverID(aValue: String);
begin
  SetConfiguracao('Banco de dados', 'DriverID', aValue);
end;

function TdmSistema.GetConfiguracao(Secao, Parametro,
  valorPadrao: String): String;
var
  LArquivoConfig : TIniFile;
begin
  LArquivoConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + ARQUIVOCONFIGURACAO);
  try
    Result := LArquivoConfig.ReadString(Secao, Parametro, ValorPadrao);
  finally
    LArquivoConfig.Free;
  end;
end;

procedure TdmSistema.LockingMode(aValue: String);
begin
  SetConfiguracao('Banco de dados', 'LockingMode', aValue);
end;

function TdmSistema.LockingMode: String;
begin
  Result := GetConfiguracao('Banco de dados', 'LockingMode', 'Normal');
end;

procedure TdmSistema.SetConfiguracao(Secao, Parametro, Valor: String);
var
  LArquivoConfig : TIniFile;
begin
  LArquivoConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + ARQUIVOCONFIGURACAO);
  try
    LArquivoConfig.WriteString(Secao, Parametro, Valor);
  finally
    LArquivoConfig.Free;
  end;
end;

function TdmSistema.UsuarioUltimoAcesso: String;
begin
  Result := GetConfiguracao('ACESSO', 'Usuario', '');
end;

procedure TdmSistema.UsuarioUltimoAcesso(aValue: String);
begin
  SetConfiguracao('ACESSO', 'Usuario', aValue);
end;

end.
