Unit uDownloadDataOperate;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IniFiles, Dialogs, RzTabs, StdCtrls, ExtCtrls, RzPanel, Spin, ImgList, RzButton,
  OleServer, Buttons, RzBmpBtn, ComCtrls,PublicVariable;

Type
// Ӧ������
  TDownType =
   (dtNull,//0
    dtBatchVoteItem, //1
    dtBatchEvaluationItem, //2
    dtBatchScoreItem, //3
    dtElectionItem, // 4
    dtEvaluationRule, // 5
    dtScoreRule, // 6
    dtSelfExercise, // 7
    dtMultipleAssessItem, // 8
    dtMultipleAssessRule, // 9
    dtRandomItem//10
    );

  StrAry2 = Array Of Array Of String;
  StrAry = Array Of String;
  TDownloadOperate = Class(TObject)
  Private
    procedure SaveDwonItem(dataType: TDownType;Items:Integer);
  Public
    Function ConvertIniToArray2(filePath: String): StrAry2;
    Function ConvertIniToArray(filePath: String): StrAry;
    Function ConvertStrToArray(Value: String): StrAry;
  End;

Var
  MyiniFile: TMemIniFile;
  OleData: OleVariant;

Implementation
Uses
  uActiveSetLanguage;

procedure TDownloadOperate.SaveDwonItem(dataType: TDownType;Items:Integer);
var
  lIniFile: TInifile;
begin
  case dataType of
    dtBatchVoteItem,dtBatchEvaluationItem,dtBatchScoreItem,dtElectionItem,
    dtMultipleAssessItem:
      begin
        lIniFile := Tinifile.Create(gFilePath.System);
        lIniFile.WriteInteger('Main', 'ItemNum', Items);
        lIniFile.Free;
      end;
    dtMultipleAssessRule:
      begin
        lIniFile := Tinifile.Create(gFilePath.System);
        lIniFile.WriteInteger('Main', 'RuleNum', Items);
        lIniFile.Free;
      end;
  end;
end;

//*******************************************************
//  ����˵��:  ��ini�����ļ�ת���ɶ�ά����
//  ����˵��:  dataType: ��������
//  ����ֵ˵��: ��ά�ַ�����   StrAry2
//*******************************************************

Function TDownloadOperate.ConvertIniToArray2(filePath: String): StrAry2;
Var
  lItemNum, i, j: Integer;
  lValue: String;
  lItemArray: StrAry2;
  lKeyList: TStrings;
  language: TLanguage;
  MsgItemNumError, MsgReadFileError: String;
  dataType: TDownType;
Begin
  myIniFile := TMemIniFile.Create(filePath);
  lKeyList := TStringList.Create;

  language := TLanguage.Create;
  MsgItemNumError := language.getMsgByName('MsgItemNumError');
  MsgReadFileError := language.getMsgByName('MsgReadFileError');
  language.Free;

  dataType := TDownType(myIniFile.ReadInteger('Info', 'TableType', 0));
  //�õ���Ŀ�ĸ���
  lItemNum := MyiniFile.ReadInteger('Info', 'ItemNum', 0);
  If (lItemNum = 0) Then
    begin
      MyiniFile.Free;
      lKeyList.Free;
      Exit;
    end;

  if(MyiniFile.SectionExists('Item' + IntToStr(lItemNum))) then
  begin
    MyiniFile.ReadSection('Item' + IntToStr(lItemNum), lKeyList);
    //��ʼ����ά����
    SetLength(lItemArray, lItemNum , lKeyList.Count);
  end
  else
  begin
  MyiniFile.Free;
  lKeyList.Free;
    ShowMessage(MsgItemNumError);
    Exit;
  end;

  SaveDwonItem(dataType,lItemNum);

  For i := 0 To lItemNum-1 Do
    Begin
      lKeyList.Clear;
      MyiniFile.ReadSection('Item' + IntToStr(i+1), lKeyList);
      For j := 0 To lKeyList.Count - 1 Do
        Begin
          lValue := MyiniFile.ReadString('Item' + IntToStr(i+1), lKeyList[j], '');
          lValue:=StringReplace(lValue, '\r\n', #13#10, [rfReplaceAll]);
          lItemArray[i, j] := lValue;
        End;
    End;

  Result := lItemArray;
  MyiniFile.Free;
  lKeyList.Free;
End;

//*******************************************************
//  ����˵��:  ��ini�����ļ�ת����һά����
//  ����˵��:  dataType: ��������
//  ����ֵ˵��: һά�ַ�����   StrAry
//*******************************************************

Function TDownloadOperate.ConvertIniToArray(filePath: String): StrAry;
Var
  lItemNum, i: Integer;
  lValue: String;
  lItemArray: StrAry;
  lKeyList: TStrings;

  language: TLanguage;
  MsgItemNumError, MsgReadFileError: String;
  dataType: TDownType;
Begin
  myIniFile := TMemIniFile.Create(filePath);
  dataType := TDownType(myIniFile.ReadInteger('Info', 'TableType', 0));
  lKeyList := TStringList.Create;

  language := TLanguage.Create;
  MsgItemNumError := language.getMsgByName('MsgItemNumError');
  MsgReadFileError := language.getMsgByName('MsgReadFileError');
  language.Free;

  //�õ���Ŀ�ĸ���
  lItemNum := MyiniFile.ReadInteger('Info', 'ItemNum', 0);
  If (lItemNum = 0) Then
    Exit;

  If (MyiniFile.SectionExists('Item' + IntToStr(lItemNum))) Then
    Begin
      MyiniFile.ReadSection('Item' + IntToStr(lItemNum), lKeyList);
      //��ʼ����ά����
      SetLength(lItemArray, lItemNum);
    End
  Else
    Begin
      ShowMessage(MsgItemNumError);
      Exit;
    End;

  SaveDwonItem(dataType,lItemNum);

  For i := 0 To lItemNum - 1 Do
    Begin
      lKeyList.Clear;
      MyiniFile.ReadSection('Item' + IntToStr(i + 1), lKeyList);
//      OutputDebugString(PChar(' ReadSection Item' + IntToStr(i + 1)));
      lValue := MyiniFile.ReadString('Item' + IntToStr(i + 1), lKeyList[0], '');
      lItemArray[i] := lValue;
    End;

  Result := lItemArray;
  MyiniFile.Free;
  lKeyList.Free;
End;

//*******************************************************
//  ����˵��:  ���ַ������س�����ת����һά����
//  ����˵��:  Value: �ַ���
//  ����ֵ˵��: һά�ַ�����   StrAry
//*******************************************************

Function TDownloadOperate.ConvertStrToArray(Value: String): StrAry;
Var
  lItemArray: StrAry;
  lStrLst: TstringList;
  i: Integer;
Begin
  lStrLst := TstringList.Create;
  lStrLst.Text := Value;
  SetLength(lItemArray, lStrLst.Count); //����õ��������ƿ���
  For i := 0 To lStrLst.Count - 1 Do
    lItemArray[i] := lStrLst.Strings[i];
  lStrLst.free;
  Result := lItemArray;
End;

End.

