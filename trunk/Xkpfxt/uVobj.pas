unit uVobj;

interface

uses
  SysUtils, Classes, ADODB, DB, DBClient, TConnect, frxBarcode, Dialogs,
  frxClass, frxDBSet, ImgList, Controls, Menus, StdActns, ActnList, frxChart,
  frxDesgn, Forms, Provider, CnProgressFrm, Windows;

type
  TVobj = class(TDataModule)
    frxDesigner1: TfrxDesigner;
    frxChartObject1: TfrxChartObject;
    actlst1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    act_Locate: TAction;
    act_DataExport: TAction;
    act_DataExportByButton: TAction;
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    N1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N2: TMenuItem;
    mi_Export: TMenuItem;
    ImageList_pm: TImageList;
    fds_Delta: TfrxDBDataset;
    fds_Master: TfrxDBDataset;
    frxReport1: TfrxReport;
    cds_Master: TClientDataSet;
    cds_Delta: TClientDataSet;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    frxBarCodeObject1: TfrxBarCodeObject;
    con_Local: TLocalConnection;
    con_DB: TADOConnection;
    DSP_Open: TDataSetProvider;
    qry_Open: TADOQuery;
    cds_Open: TClientDataSet;
    qry_Update: TADOQuery;
    DSP_Update: TDataSetProvider;
    cds_Update: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    function Query_Data(const sSqlStr:string;const ShowHint:Boolean=False):string;
    function Update_Data(const sKey,sSqlStr:string;const vDelta:OleVariant;const ShowMsgBox:Boolean=True;const ShowHint:Boolean=False):Boolean;//ֻ��ֱ�Ӱ�Delta���������Ұ���תXML��ʽ
    function RecordIsExists(const sSqlStr:string):Boolean;
    function ExecSqlCmd(const sSqlStr:string):Boolean;overload;
    function ExecSqlCmd(const sSqlStr:string;var sError:string):Boolean;overload;

    function RegIsOK:Boolean;
    function GetUserInfo:string;//����û�����
    function GetMACInfo:string;//����û�������
    function GetUserCode:string;//����û�ע����
    function RegUserInfo(const UserName,UserCode:string):Boolean;//ע���û�

  end;

implementation
uses Net,PwdFunUnit;
{$R *.dfm}

{ TDataModule1 }

function TVobj.ExecSqlCmd(const sSqlStr: string): Boolean;
var
  sError:string;
begin
  Result := ExecSqlCmd(sSqlStr,sError);
end;

function TVobj.ExecSqlCmd(const sSqlStr: string;
  var sError: string): Boolean;
var
  adoqry:TADOQuery;
begin
  adoqry := TADOQuery.Create(nil);
  adoqry.Connection := con_DB;
  try
    try
      adoqry.SQL.Text := sSqlStr;
      adoqry.ExecSQL;
      Result := True;
    except
      on e:Exception do
      begin
        sError := e.Message;
        Result := False;
      end;
    end;
  finally
    FreeAndNil(adoqry);
  end;
end;

function TVobj.GetMACInfo: string;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select MAC from ������Ϣ��';
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TVobj.GetUserCode: string;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select ע���� from ������Ϣ��';
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;

end;

function TVobj.GetUserInfo: string;
var
  UserName:string;
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select �û����� from ������Ϣ��';
      DataSet_Temp.Active := True;
      UserName := DataSet_Temp.Fields[0].AsString;
      Result := UserName;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TVobj.Query_Data(const sSqlStr: string;
  const ShowHint: Boolean): string;
var
  sTempData,sData:string;
begin
  Screen.Cursor := crHourGlass;
  if ShowHint then
  begin
    ShowProgress('���ڶ�ȡ����...');
  end;

  try
    cds_Open.Close;
    cds_Open.CommandText := sSqlStr ;
    try
      cds_Open.Open;
      sData := cds_Open.XMLData;
      Result := sData;
    except
      Result := '';
    end;
  finally
    cds_Open.Close;
    if ShowHint then
      HideProgress;
    Screen.Cursor := crDefault;
  end;
end;

function TVobj.RecordIsExists(const sSqlStr: string): Boolean;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := sSqlStr;
    try
      DataSet_Temp.Open;
      Result := DataSet_Temp.Fields[0].AsInteger>0;
    except
      Result := False;
    end;
  finally
    DataSet_Temp.Close;
    DataSet_Temp.Free;
  end;
end;

function TVobj.RegIsOK: Boolean;
var
  UserName,RegCode,sMac:string;
  sqlText:String;
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select �û�����,MAC,ע���� from ������Ϣ�� where getdate()<='+quotedstr('2014-07-01 11:00');
      DataSet_Temp.Active := True;
      UserName := DataSet_Temp.Fields[0].AsString;
      sMac := DataSet_Temp.Fields[1].AsString;
      RegCode := DataSet_Temp.Fields[2].AsString;
      if sMac<>GetMACAddress then
      begin
        sMac := GetMACAddress;
        sqlText := 'update ������Ϣ�� set MAC='+quotedstr(sMac);
        con_DB.Execute(SqlText);
      end;
      if RegCode<>'' then
        RegCode := DeCrypt(RegCode); //��ע������н����Ի�ԭ�û�����
      //RegCode := EnCrypt(UserName);
      //Result := (RegCode = DataSet_Temp.Fields[1].AsString) and (DataSet_Temp.Fields[1].AsString<>'');
      Result := (RegCode = UserName) and (RegCode<>'');
    except
      Result := False;
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TVobj.RegUserInfo(const UserName, UserCode: string): Boolean;
var
  qry_Temp:TADOQuery;
  sMac,sqlstr:string;
begin
  qry_Temp := TADOQuery.Create(nil);
  qry_Temp.Connection := con_DB;
  try
  sMac := GetMacAddress;
  with qry_Temp do
  begin
    Active := False;
    sql.Text := 'select �û�����,MAC,ע���� from ������Ϣ��';
    Active := True;
    if RecordCount=0 then
      sqlstr := 'Insert into ������Ϣ�� (�û�����,ע����,MAC) values('+quotedstr(UserName)+','+quotedstr(UserCode)+','+quotedstr(sMac)
    else
      sqlstr := 'update ������Ϣ�� set �û�����='+quotedstr(UserName)+',ע����='+quotedstr(UserCode)+',MAC='+quotedstr(sMac);

    try
      close;
      sql.Text := sqlstr;
      ExecSql;
      Result := True;//RegIsOK;
    except
      Result := False;
    end;
  end;
  finally
    qry_Temp.Free;
  end;
end;

function TVobj.Update_Data(const sKey, sSqlStr: string;
  const vDelta: OleVariant; const ShowMsgBox, ShowHint: Boolean): Boolean;
var
  iErrorCount,i:Integer;
  sData,sError:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  Result := False;
  try
    cds_Temp.Data := vDelta;
    sData := cds_Temp.XMLData;

    qry_Update.Close;
    qry_Update.SQL.Text := sSqlStr;

    cds_Update.XMLData := sData;

    for i := 0 to cds_Update.FieldCount - 1 do
    begin
      //if UpperCase(dm.cds_Update.Fields[i].FieldName) = UpperCase(pkField) then
      //  dm.cds_Update.Fields[i].ProviderFlags := dm.cds_Update.Fields[i].ProviderFlags + [ pfInKey,pfInWhere ]
      //else
      //  dm.cds_Update.Fields[i].ProviderFlags := dm.cds_Update.Fields[i].ProviderFlags-[pfInWhere,pfInKey];

      if cds_Update.Fields[i].DataType in [ ftDate, ftTime, ftDateTime ] then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInWhere ]
      else if cds_Update.Fields[i].DataType = ftAutoInc then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInUpdate ];
    end;


    qry_Update.Open;
    with qry_Update.FieldByName(sKey) do //����������AdoDataSet�����ã�������ClientDataSet������
      ProviderFlags := ProviderFlags + [ pfInKey,pfInWhere ];

    try
      iErrorCount := cds_Update.ApplyUpdates(0);
      Result := iErrorCount=0;
    except
      on e:Exception do
      begin
        sError := e.Message;
        Result := False;
      end;
    end;
  finally
    cds_Temp.Free;
    cds_Update.Active := False;
    if (not Result) and (sError<>'') then
    begin
      sError := '���ݸ���/����ʧ�ܣ���������ԣ����ܵ�ԭ��Ϊ������'+#13+sError;
      MessageBox(0, PChar(string(sError)), 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end else if Result and ShowMsgBox then
      MessageBox(0, pchar('�����ύ�����棩�ɹ�������'), 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION+ MB_TOPMOST);
    if ShowHint then
      HideProgress;
  end;
end;

end.
