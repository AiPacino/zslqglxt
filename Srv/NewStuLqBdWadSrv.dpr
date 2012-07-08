program NewStuLqBdWadSrv;

{$APPTYPE GUI}

uses
  Forms,
  SockApp,
  uWadMain in 'uWadMain.pas' {WadMain},
  uNewStuLqBdWebModule in 'uNewStuLqBdWebModule.pas' {NewStuLqBdWebModule: TWebModule},
  uNewStuLqBdImpl in 'uNewStuLqBdImpl.pas',
  uNewStuLqBdIntf in 'uNewStuLqBdIntf.pas',
  uNewStuLqBdSoapDM in 'uNewStuLqBdSoapDM.pas' {NewStuLqBdSoapDM: TSoapDataModule},
  uDbConnect in 'uDbConnect.pas',
  Net in '..\public\Net.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '招生录取管理系统 Ver 1.0.0.3';
  Application.CreateForm(TWadMain, WadMain);
  Application.CreateForm(TNewStuLqBdWebModule, NewStuLqBdWebModule);
  Application.Run;
end.
