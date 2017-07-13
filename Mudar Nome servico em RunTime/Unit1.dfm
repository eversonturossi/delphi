object ServicoAlteradoRunTime: TServicoAlteradoRunTime
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'AAA Servico Teste'
  BeforeInstall = ServiceBeforeInstall
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  OnExecute = ServiceExecute
  Height = 359
  Width = 664
end
