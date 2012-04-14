library NewStuLqBdSrv;

uses
  ActiveX,
  ComObj,
  WebBroker,
  ISAPIApp,
  ISAPIThreadPool,
  uNewStuLqBdWebModule in 'uNewStuLqBdWebModule.pas' {NewStuLqBdWebModule: TWebModule},
  uNewStuLqBdImpl in 'uNewStuLqBdImpl.pas',
  uNewStuLqBdIntf in 'uNewStuLqBdIntf.pas',
  uNewStuLqBdSoapDM in 'uNewStuLqBdSoapDM.pas' {NewStuLqBdSoapDM: TSoapDataModule},
  uDbConnect in 'uDbConnect.pas',
  Net in '..\public\Net.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas';

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;
  Application.Initialize;
  Application.CreateForm(TNewStuLqBdWebModule, NewStuLqBdWebModule);
  Application.Run;
end.
