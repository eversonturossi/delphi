object Service1: TService1
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'AAA Servico Teste'
  BeforeInstall = ServiceBeforeInstall
  BeforeUninstall = ServiceBeforeUninstall
  OnExecute = ServiceExecute
  Height = 359
  Width = 664
end
