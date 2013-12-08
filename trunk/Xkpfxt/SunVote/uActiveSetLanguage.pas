Unit uActiveSetLanguage;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IniFiles, Dialogs, RzTabs, StdCtrls, ExtCtrls, RzPanel, Spin, ImgList, RzButton,
  OleServer, SunVote_TLB, Buttons, RzBmpBtn, ComCtrls,uStringOperate,PublicVariable;

Type
  TLanguage = Class(TObject)
  Private

  Public
    Constructor Create();
    Procedure SetActiveLanguage(frmName: TForm);
    Function getMsgByName(msgName: String): String;
  End;

Var
  LanguageName: String;

Implementation
{ Language }

//******************************************************************************
//  功能说明:  动态设置控件的语言
//  参数说明:  LanguageName: string，语言配置文件的文件名，除去.ini
//  返回值说明:    无
//******************************************************************************

Procedure TLanguage.SetActiveLanguage(frmName: TForm);
Var
  frmComponent: TComponent;
  i, index: Integer;
  lItemList: TStringList;
  lIniFile: TIniFile;
  lStr: String;
Begin
  lItemList := TStringList.Create;
  lIniFile := TInifile.Create(ExtractFilePath(ParamStr(0)) + 'Language\' + LanguageName);
  try
    With lIniFile Do
      Begin
        For i := 0 To frmName.ComponentCount - 1 Do
          Begin
            frmComponent := frmName.Components[i];
            If frmComponent Is TLabel Then
              Begin
                (frmComponent As TLabel).Caption := ReadString('TLabel', frmComponent.Name + '.Caption', (frmComponent As TLabel).Caption);
                (frmComponent As TLabel).WordWrap := True; //将label的自动换行属性设为True
              End;
            If frmComponent Is TCheckBox Then
              Begin
                (frmComponent As TCheckBox).Caption := ReadString('TCheckBox', frmComponent.Name + '.Caption', (frmComponent As TCheckBox).Caption);
              End;
            If frmComponent Is TButton Then
              Begin
                (frmComponent As TButton).Caption := ReadString('TButton', frmComponent.Name + '.Caption', (frmComponent As TButton).Caption);
              End;
            If frmComponent Is TRzBitBtn Then
              Begin
                (frmComponent As TRzBitBtn).Caption := ReadString('TRzBitBtn', frmComponent.Name + '.Caption', (frmComponent As TRzBitBtn).Caption);
              End;
            If frmComponent Is TRzTabSheet Then
              Begin
                (frmComponent As TRzTabSheet).Caption := ReadString('TRzTabSheet', frmComponent.Name + '.Caption', (frmComponent As TRzTabSheet).Caption);
              End;
            If frmComponent Is TComboBox Then
              Begin
                lItemList.Free;
                lItemList :=SplitL(Pchar(ReadString('TComboBox', frmComponent.Name + '.Items', '')), '\r\n');
                If lItemList.Count > 0 Then
                  Begin
                    index := (frmComponent As TComboBox).ItemIndex;
                    (frmComponent As TComboBox).Items.Clear;
                    (frmComponent As TComboBox).Items.AddStrings(lItemList);
                    (frmComponent As TComboBox).ItemIndex := index;
                  End;
              End;

            if frmComponent Is TGroupBox then
              begin
                TGroupBox(frmComponent).Caption:=ReadString('TGroupBox', frmComponent.Name + '.Caption', (frmComponent As TGroupBox).Caption);
              end;

            If frmComponent Is TMemo Then
              Begin
                lStr := ReadString('TMemo', frmComponent.Name + '.Text', (frmComponent As TMemo).Text);
                lStr := StringReplace(lStr, '\r\n', #13#10, [rfReplaceAll]);
                (frmComponent As TMemo).Text := lstr;
              End;

          End;
      End;
  finally
    lIniFile.Free;
    lItemList.Free;
  end;

End;

//******************************************************************************
//  功能说明:  根据错误信息提示的名字得到相应的错误信息
//  参数说明:  msgName: string
//  返回值说明:    string
//******************************************************************************

Function TLanguage.getMsgByName(msgName: String): String;
Var
  lIniFile: TIniFile;
Begin
  lIniFile := TInifile.Create(ExtractFilePath(ParamStr(0)) + 'Language\' + LanguageName);
  With lIniFile Do
    Begin
      Result := ReadString('Message', msgName, '');
    End;
  lIniFile.Free;
End;

Constructor TLanguage.Create;
Var
  lIniFile: TIniFile;
Begin
  Inherited;
  lIniFile := TIniFile.Create(gFilePath.System);
  LanguageName := lIniFile.ReadString('Language', 'Active', 'Chinese.ini');
{
  If LanguageName = 'Chinese.ini' Then
    frmMain.cbbSelectLanguage.itemIndex := 0
  Else
    frmMain.cbbSelectLanguage.itemIndex := 1;
}
  lIniFile.Free;
End;

End.

