program NewStuLq;

uses
  Forms,
  unt_MareData in '..\unt_MareData.pas' {frm_MareData},
  unt_IniFile in '..\unt_IniFile.pas',
  unt_FormatZymc in '..\unt_FormatZymc.pas' {frm_FormatZymc},
  unt_SqlExecute in '..\unt_SqlExecute.pas' {frm_SqlExecute},
  unt_Main in '..\unt_Main.pas' {frm_Main},
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  unt_bh in '..\unt_bh.pas' {frm_bh},
  unt_PhotoProcess in '..\unt_PhotoProcess.pas' {frm_PhotoProcess},
  unt_SQLWhere in '..\unt_SQLWhere.pas' {frm_SQLWhere},
  unt_FormatKL in '..\unt_FormatKL.pas' {frm_FormatKL},
  uNewStuList in '..\NewStuBd\uNewStuList.pas' {NewStuList},
  uLogin in '..\NewStuBd\uLogin.pas' {Login},
  uMain in '..\NewStuBd\uMain.pas' {Main},
  uChangeZy in '..\NewStuBd\uChangeZy.pas' {ChangeZy},
  uChgZyHistory in '..\NewStuBd\uChgZyHistory.pas' {ChgZyHistory};

{$R *.res}

begin
  Application.Initialize;
  frm_DM := Tfrm_DM.Create(Application);
  gbIsOK := False;
  Login := TLogin.Create(nil);
  Login.ShowModal;
  if gbIsOK then
    Application.CreateForm(TMain, Main);
  Application.Run;
end.
