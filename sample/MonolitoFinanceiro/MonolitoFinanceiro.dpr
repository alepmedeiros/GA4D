program MonolitoFinanceiro;



uses
  Vcl.Forms,
  MonolitoFinanceiro.View.Principal in 'src\View\MonolitoFinanceiro.View.Principal.pas' {frmPrincipal},
  MonolitoFinanceiro.View.CadastroPadrao in 'src\View\MonolitoFinanceiro.View.CadastroPadrao.pas' {frmCadastroPadrao},
  MonolitoFinanceiro.View.Splash in 'src\View\MonolitoFinanceiro.View.Splash.pas' {frmSplash},
  MonolitoFinanceiro.Model.Conexao in 'src\Model\MonolitoFinanceiro.Model.Conexao.pas' {dmConexao: TDataModule},
  MonolitoFinanceiro.View.Usuarios in 'src\View\MonolitoFinanceiro.View.Usuarios.pas' {frmUsuarios},
  MonolitoFinanceiro.Model.Usuarios in 'src\Model\MonolitoFinanceiro.Model.Usuarios.pas' {dmUsuarios: TDataModule},
  MonolitoFinanceiro.Utilitarios in 'src\Util\MonolitoFinanceiro.Utilitarios.pas',
  MonolitoFinanceiro.View.Login in 'src\View\MonolitoFinanceiro.View.Login.pas' {frmLogin},
  MonolitoFinanceiro.Model.Entidades.Usuario in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.Usuario.pas',
  MonolitoFinanceiro.Model.Sistema in 'src\Model\MonolitoFinanceiro.Model.Sistema.pas' {dmSistema: TDataModule},
  MonolitoFinanceiro.View.RedefinirSenha in 'src\View\MonolitoFinanceiro.View.RedefinirSenha.pas' {frmRedefinirSenha},
  MonolitoFinanceiro.Model.Caixa in 'src\Model\MonolitoFinanceiro.Model.Caixa.pas' {dmCaixa: TDataModule},
  MonolitoFinanceiro.View.Caixa in 'src\View\MonolitoFinanceiro.View.Caixa.pas' {frmCaixa},
  MonolitoFinanceiro.View.Caixa.Saldo in 'src\View\MonolitoFinanceiro.View.Caixa.Saldo.pas' {frmCaixaSaldo},
  MonolitoFinanceiro.Model.Entidades.Caixa.Resumo in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.Caixa.Resumo.pas',
  MonolitoFinanceiro.Model.ContasPagar in 'src\Model\MonolitoFinanceiro.Model.ContasPagar.pas' {dmContasPagar: TDataModule},
  MonolitoFinanceiro.View.ContasPagar in 'src\View\MonolitoFinanceiro.View.ContasPagar.pas' {frmContasPagar},
  MonolitoFinanceiro.Model.ContasReceber in 'src\Model\MonolitoFinanceiro.Model.ContasReceber.pas' {dmContasReceber: TDataModule},
  MonolitoFinanceiro.View.ContasReceber in 'src\View\MonolitoFinanceiro.View.ContasReceber.pas' {frmContasReceber},
  MonolitoFinanceiro.View.ContasReceber.Baixar in 'src\View\MonolitoFinanceiro.View.ContasReceber.Baixar.pas' {frmContasReceberBaixar},
  MonolitoFinanceiro.Model.Entidades.ContaPagar in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.ContaPagar.pas',
  MonolitoFinanceiro.Model.Entidades.ContaPagar.Detalhe in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.ContaPagar.Detalhe.pas',
  MonolitoFinanceiro.Model.Entidades.ContaReceber in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.ContaReceber.pas',
  MonolitoFinanceiro.Model.Entidades.ContaReceber.Detalhe in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.ContaReceber.Detalhe.pas',
  MonolitoFinanceiro.View.ContasPagar.Baixar in 'src\View\MonolitoFinanceiro.View.ContasPagar.Baixar.pas' {frmContasPagarBaixar},
  MonolitoFinanceiro.View.ContasPagar.Consultar in 'src\View\MonolitoFinanceiro.View.ContasPagar.Consultar.pas' {frmContasPagarConsultar},
  MonolitoFinanceiro.View.ContasPagar.Detalhes in 'src\View\MonolitoFinanceiro.View.ContasPagar.Detalhes.pas' {frmContasPagarDetalhes},
  MonolitoFinanceiro.View.ContasReceber.Consultar in 'src\View\MonolitoFinanceiro.View.ContasReceber.Consultar.pas' {frmContasReceberConsultar},
  MonolitoFinanceiro.View.ContasReceber.Detalhes in 'src\View\MonolitoFinanceiro.View.ContasReceber.Detalhes.pas' {frmContasReceberDetalhes},
  MonolitoFinanceiro.Model.Entidades.Caixa.Lancamento in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.Caixa.Lancamento.pas',
  MonolitoFinanceiro.View.Relatorios.Padrao in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.Padrao.pas' {RelPadrao},
  MonolitoFinanceiro.View.Relatorios.Usuarios in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.Usuarios.pas' {RelUsuarios},
  MonolitoFinanceiro.View.Relatorios.ContasReceber in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.ContasReceber.pas' {RelContasReceber},
  MonolitoFinanceiro.View.Relatorios.PadraoAgrupado in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.PadraoAgrupado.pas' {RelPadraoAgrupado},
  MonolitoFinanceiro.View.Relatorios.ContasReceberDetalhado in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.ContasReceberDetalhado.pas' {RelContasReceberDetalhado},
  MonolitoFinanceiro.View.Caixa.Extrato in 'src\View\MonolitoFinanceiro.View.Caixa.Extrato.pas' {frmCaixaExtrato},
  MonolitoFinanceiro.View.Relatorios.Caixa.Extrato in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.Caixa.Extrato.pas' {RelCaixaExtrato},
  MonolitoFinanceiro.View.Relatorios.Caixa in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.Caixa.pas' {RelCaixa},
  MonolitoFinanceiro.View.Relatorios.ContasPagar in 'src\View\Relatorios\MonolitoFinanceiro.View.Relatorios.ContasPagar.pas' {RelContasPagar},
  MonolitoFinanceiro.View.CadastrarAdmin in 'src\View\MonolitoFinanceiro.View.CadastrarAdmin.pas' {frmCadastrarAdmin},
  MonolitoFinanceiro.Analytics in 'src\Util\MonolitoFinanceiro.Analytics.pas',
  Interceptor.Form in 'src\Util\Interceptor.Form.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmUsuarios, dmUsuarios);
  Application.CreateForm(TdmCaixa, dmCaixa);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadastroPadrao, frmCadastroPadrao);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.CreateForm(TdmSistema, dmSistema);
  Application.CreateForm(TfrmCaixa, frmCaixa);
  Application.CreateForm(TfrmCaixaSaldo, frmCaixaSaldo);
  Application.CreateForm(TdmContasPagar, dmContasPagar);
  Application.CreateForm(TfrmContasPagar, frmContasPagar);
  Application.CreateForm(TdmContasReceber, dmContasReceber);
  Application.CreateForm(TfrmContasReceber, frmContasReceber);
  Application.CreateForm(TfrmContasReceberBaixar, frmContasReceberBaixar);
  Application.CreateForm(TfrmContasPagarBaixar, frmContasPagarBaixar);
  Application.CreateForm(TfrmContasPagarConsultar, frmContasPagarConsultar);
  Application.CreateForm(TfrmContasPagarDetalhes, frmContasPagarDetalhes);
  Application.CreateForm(TfrmContasReceberConsultar, frmContasReceberConsultar);
  Application.CreateForm(TfrmContasReceberDetalhes, frmContasReceberDetalhes);
  Application.CreateForm(TRelPadrao, RelPadrao);
  Application.CreateForm(TRelUsuarios, RelUsuarios);
  Application.CreateForm(TRelContasReceber, RelContasReceber);
  Application.CreateForm(TRelPadraoAgrupado, RelPadraoAgrupado);
  Application.CreateForm(TRelContasReceberDetalhado, RelContasReceberDetalhado);
  Application.CreateForm(TfrmCaixaExtrato, frmCaixaExtrato);
  Application.CreateForm(TRelCaixaExtrato, RelCaixaExtrato);
  Application.CreateForm(TRelCaixa, RelCaixa);
  Application.CreateForm(TRelContasPagar, RelContasPagar);
  Application.Run;
end.

