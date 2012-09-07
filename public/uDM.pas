unit uDM;

interface

uses
  SysUtils, Classes, DB, DBClient, SOAPConn, Rio, SOAPHTTPClient,GridsEh,
  Messages, IniFiles, Windows,Forms, DBGridEh,DBCtrlsEh, Dialogs,DBGridEhImpExp,
  uNewStuLqBdIntf, jpeg, ExtCtrls,EncdDecdEx,EhLibCDS, IdGlobal,EhLibBDE,EhLibADO,
  PrnDbgEH,Graphics, frxChart, frxDesgn, StdActns, ActnList,StrUtils,DateUtils,
  Menus, ImgList, Controls, frxClass, frxDBSet,CnProgressFrm,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  VCLUnZip, VCLZip, InvokeRegistry, ADODB,IdMultipartFormData, frxBarcode ;

type
 // TMessageHandler = class     //使得回车消息转换成Tab消息
 //   class procedure AppMessage(var Msg:TMsg;var Handled:Boolean);
 // end;

  TDM = class(TDataModule)
    HTTPRIO1: THTTPRIO;
    SoapConnection1: TSoapConnection;
    SaveDialog1: TSaveDialog;
    frxDesigner1: TfrxDesigner;
    frxChartObject1: TfrxChartObject;
    actlst1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    PopupMenu1: TPopupMenu;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N1: TMenuItem;
    mi_Export: TMenuItem;
    ImageList_pm: TImageList;
    act_DataExport: TAction;
    act_Locate: TAction;
    L1: TMenuItem;
    N2: TMenuItem;
    fds_Delta: TfrxDBDataset;
    fds_Master: TfrxDBDataset;
    frxReport1: TfrxReport;
    cds_Master: TClientDataSet;
    cds_Delta: TClientDataSet;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    act_DataExportByButton: TAction;
    IdHTTP1: TIdHTTP;
    VCLZip1: TVCLZip;
    VCLUnZip1: TVCLUnZip;
    frxBarCodeObject1: TfrxBarCodeObject;
    procedure DataModuleCreate(Sender: TObject);
    procedure SaveDialog1TypeChange(Sender: TObject);
    procedure act_DataExportExecute(Sender: TObject);
    procedure act_LocateExecute(Sender: TObject);
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
    procedure frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
    procedure cds_MasterAfterScroll(DataSet: TDataSet);
    procedure act_DataExportByButtonExecute(Sender: TObject);
    procedure HTTPRIO1HTTPWebNode1ReceivingData(Read, Total: Integer);
    procedure HTTPRIO1HTTPWebNode1PostingData(Sent, Total: Integer);
    procedure HTTPRIO1BeforeExecute(const MethodName: string;
      var SOAPRequest: WideString);
  private
    { Private declarations }
    SendTotal,GetTotal:Integer;

    ii:Integer;
    function  SaveAsUrlImage(const sUrl,sFileName:string):Boolean;
    function  DownloadUrlImage(const sUrl:string;img:TImage;const OverPhoto:Boolean=True):Boolean;
    function  UploadUrlImage(const BmNo,sFileName:string):Boolean;
    function  GetSfxmJe(const Id,sfxm:string):string;
    procedure GetListFromTable(const sqlstr:string;out sList:TStrings);
    function  GetDeltaTableSqlText(const RepFileName:string):string;
    function  GetDeltaRepSetInfo(const RepFileName:string;
              out sDeltaTableName,sMasterFieldName,sDeltaFieldName:string):Boolean;
    function  HaveDeltaTable(const RepFileName:string):Boolean;

    procedure GetDeptListBySql(const sqlstr:string;var sList:TStrings);
  public
    { Public declarations }
    procedure SetConnInfo(const sUrl:string);
    function  GetConnInfo:string;

    function  GetPrintBH:string;
    function  GetNextPrintBH(const Number:string):string;
    function  SetPrintBH(const Number:string):Boolean;

    function  GetSkyName:string; //收款员
    function  SetSkyName(const sName:string):Boolean;
    function  GetKpyName:string; //开票员
    function  SetKpyName(const sName:string):Boolean;

    function  GetCjBL(const Km:string;const Cj_No:Integer):Integer; //设置、获取成绩录入比例
    function  SetCjBL(const Km:string;const Cj_No,Cj_BL:Integer):Boolean;

    function  OpenData(const sSqlStr:string;const ShowHint:Boolean=False):string;
    function  UpdateData(const sKey,sSqlStr:string;const vDelta:OleVariant;const ShowMsgBox:Boolean=True;const ShowHint:Boolean=False):Boolean;//只须直接把Delta传过来，我帮你转XML格式
    function  SaveCjData(const CjIndex:Integer;const vDelta:OleVariant):Boolean;
    //function  UpdateData(const sKey,sSqlStr:string;const vDelta:OleVariant):Boolean;overload;//只须直接把Delta传过来，我帮你转XML格式
    function  UpdateData2(const sKey,sSqlStr,sDelta:string):Boolean;//先转好Delta为XML格式再传过来
    function  ExecSql(const sSqlStr:string):Boolean;
    function  GetJjList(var JjList:TStrings):Boolean; //得到季度列表
    function  GetSrvAutoUpdateUrl:string;
    function  GetClientAutoUpdateUrl:string;

    function  _PrintReport(const sPath:string;const ReportFileName:string;const cds_Master_XMLData:String;
                          const OperateType:Integer;const ShowDialog:Boolean):Boolean; //OperateType: 0:Print 1:Privew 2:Design
    function  _PrintReport2(const sPath:string;const ReportFileName:string;const cds_Master_XMLData:String;
                          const Page:Integer):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  PrintReport(const ReportFileName:string;const cds_Master_XMLData:String;
                          const OperateType:Integer=1;const ShowDialog:Boolean=True):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  PrintSFD(const sId:string;const OperateType:Integer=0;const ShowDialog:Boolean=True):Boolean;overload;
    function  PrintSFD(const sIdList:Tstrings;const OperateType:Integer=0;const ShowDialog:Boolean=True):Boolean;overload;
    function  PrintSFD2(const sId:string;const Page:Integer):Boolean;
    function  UpdatePrintBH(const ID:string):Boolean;

    function  UpLoadReportFile(const Id: Integer;var ReportFileName: string;
                              var LastModifideTime:TDateTime;
                              const ShowSelectFolder:Boolean=False): Boolean;
    function  DownLoadReportFile(const Id:Integer;var ReportFileName:string;
                                 const ShowSelectFolder:Boolean=False):Boolean;
    procedure UpdateReportFile(const IsOver:Boolean=True);
    procedure DBGridEh1DrawColumnCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumnEh;  State: TGridDrawState);
    function  ExportDBEditEH(const MyDBGridEH:TDBGridEh):Boolean;

    function  DownLoadKsPhoto(const sUrl:string; img:TImage;const OverPhoto:Boolean=True):Boolean;
    function  UpLoadKsPhoto(const BmNo,sFileName: string):Boolean;
    function  DownLoadKsPhotoByKSH(const sKsh,sFileName:string; img:TImage;const OverPhoto:Boolean=True):Boolean;

    function  IsDisplayJiangXi:Boolean; //是否显示江西
    procedure GetDeptList(var sList:TStrings); //所有部门
    procedure GetAllYxList(var sList:TStrings);//所有学院
    procedure GetBKYxList(var sList:TStrings); //本科学院
    procedure GetZKYxList(var sList:TStrings); //专科学院
    procedure GetXQList(var sList:TStrings);   //校区信息
    procedure CheckKsbmData(const cds_Temp:TClientDataSet;var sError:string);//验证考生报考信息
    function  GetKshByZkzh(const sZkzh:string):string; //通过准考证号得到考生号
    function  GetKshBySfzh(const sSfzh:string):string; //通过身份证号得到考生号
    procedure SetXkYxComboBox(aDbComboBox:TDBComboBoxEh);

    procedure GetCzySfList(const sXlCc:string;out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetCzySfComboBox(const sXlCc:string;aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False);

    procedure GetSfList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetSfComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //省份
    procedure GetSfDirList(out sList:TStrings);

    procedure GetLbList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetLbComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //专业类别

    procedure GetKsLbList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetKsLbComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //考生类别

    procedure GetKLList(out sList:TStrings;const IncludeAll:Boolean=False); //科类
    procedure SetKlComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //专业科类

    procedure GetZyList(const XlCc,ZyLb:string;out sList:TStrings);
    procedure SetZyComboBox(const XlCc,ZyLb:string;aDbComboBox:TDBComboBoxEh); //专业

    procedure GetZyWithIdList(const XlCc,ZyLb:string;out sList:TStrings);

    //通过某一专业信息得到相关类别的专业
    procedure SetZyComboBoxByZy(const XlCc,Zy:string;aDbComboBox:TDBComboBoxEh);

    procedure GetXlCcList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetXlCcComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //学历层次
    function  SelectZy(const XlCc,ZyLb:string;var sList:TStrings): Boolean;
    function  GetWebSrvUrl:string;
 end;

//{$DEFINE WAD_DEBUG}
const
  GbConnSrvFileName = 'ConnNewStuLqBdSrvSet.ini';
{$IFNDEF WAD_DEBUG}
  SOAP_NAME   = 'NewStuLqBdSrv.DLL/soap';
{$ELSE}
//调试时用下面这个，切换时必须Build以便重建资源
  SOAP_NAME   = 'NewStuLqBdWadSrv.NewStuLqBd/soap';
{$ENDIF}

var
  gb_System_Mode:String; //系统模块，录取、报到、校考等
  gbIsOK,gbCanClose:Boolean;
  gb_SfDirList:TStrings;
  gb_Czy_ID,gb_Czy_Name,gb_Czy_Level,gb_Czy_Dept:String;
  gb_CanBd_BK,gb_CanBd_ZK:Boolean;//本科、专科是否允许报到
  gb_Cur_Xn,gb_Cur_Sfmc,gb_Cur_StartTime,gb_Cur_EndTime:string; //当前收费名称,开始时间,结束时间
  gb_Last_PrintBH:string; //上次用过的打印编号
  DM: TDM;
  function vobj: INewStuLqBd;//再次封装GetINetPay接口函数

  function AppSrvIsOK: Boolean;
  function GetOneSqlStr(const sSql:string):string;
  function GetSearchKey(const sStr:string;const sType:String='PY';const KeyLength:Integer=4):string;
  function IsModified(cds:TClientDataSet):Boolean;
  function GetAutoUpdateInfo:string;
  procedure PrintDBGridEH(AGrid:TDBGridEh;AOwner:Tform;APageHeader:string='';
                          ALineType:TPageColontitleLineType=pcltSingleLine);
  function  LowerJeToUpper(const je:Real):string; //小写金额转换为大写金额
  procedure SaveLog(const sMsg:string);
  procedure InitXnList(sList:TDBComboBoxEh);
  function  GetFileLastAccessTime(FileName:   String;   AFlag:   Integer):   TDateTime;
  function  DataSetNoSave(const ClientDataSet:TClientDataSet):Boolean;
  function  GetNextSjBH(const CurBH:string;const SjBHWidth:Integer):string;

  function  PosRight(const subStr,S:string):Integer;
  procedure RealseSortedIcon(const aDBGrid:TDBGridEh);
  procedure SetDBGridEHColumnWidth(const aDBGrid:TDBGridEh);
  function  ZyIsEqual(const zy1,zy2:string):Boolean; //专业是否相同
  function  PhotoIsExists(const photofilename:string):Boolean; //考生照片是否存在
  function  GetKsDataPath:string;

  function  GetSfMcBySfDm(const sfDm:string):String;
  function  GetSfDmBySfMc(const sfDm:string):String;

implementation
uses PwdFunUnit, uZySelect, Net,ActiveX,shellapi,shlObj;
{$R *.dfm}
{ TDM }

function  PosRight(const subStr,S:string):Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Length(S) downto 0 do
    if S[i]=subStr then
    begin
      Result := i;
      Break;
    end;
end;

function vobj:INewStuLqBd;//再次封装GetINetPay接口函数
var
  UseWsdl:Boolean;
  SoapURL:string;
begin
  SoapURL := DM.GetConnInfo;
  SoapURL := SoapURL+SOAP_NAME;
  UseWsdl := Pos('/wsdl',LowerCase(SoapURL))>0;
  Result := GetINewStuLqBd(UseWsdl,SoapURL,DM.HTTPRIO1);
end;

function  DataSetNoSave(const ClientDataSet:TClientDataSet):Boolean;
begin
  if ClientDataSet.State in [dsInsert,dsEdit] then
    ClientDataSet.Post;

  Result := ClientDataSet.ChangeCount>0;
end;

//==============================================================================
// linetype取值{pcltDoubleLine;pcltsingleline;pcltnon}
// AOwner:TForm TPrintDBGridEh.Create(AOwner); 负责TPrintDBGridEh类对象FREE
// TPrinterOrientation = (poPortrait, poLandscape); 纸张竖、横
//==============================================================================

procedure PrintDBGridEH(AGrid:TDBGridEh;AOwner:TForm;APageHeader:string='';
                        ALineType:TPageColontitleLineType=pcltSingleLine);
var
  prn:TPrintDBGridEh;
begin
  if AGrid.DataSource.DataSet.IsEmpty then Exit;
  prn:=TPrintDBGridEh.Create(AOwner);
  prn.Page.TopMargin := 1.5; //cm

  with prn.PageHeader do
  begin
    Font.Name:='宋体';
    Font.Size:=16;
    Font.Style:=[fsBold];
    LineType:=ALineType;
    CenterText.Text:=APageHeader;
  end;
  with prn.PageFooter do
  begin
    Font.Name:='宋体';
    Font.Size:=12;
    LeftText.Clear;
    CenterText.Add('第&[Page]页共&[Pages]页');
    LeftText.Add('打印日期：&[date]&[time]');
  end;
  prn.DBGridEh:=AGrid;
  prn.Preview;
end;

//==================================================
//Purpose   :   Get   the   last   file   access   time
//Params     :   FileName         the   File   Name
//                     AFlag     1.   the   file   creation   time
//                               2.   the   file   last   access   time
//                               3.   the   file   last   write   time
//Return     :   TDateTime
//Author     :   ePing
//Date         :   2000-08-03
//==================================================
function GetFileLastAccessTime(FileName:   String;   AFlag:   Integer):   TDateTime;
var
    WFD:   TWin32FindData;
    FileTime:   TFileTime;
    hFile:   THandle;
    DFT:   DWORD;
begin
  try
    hFile   :=   FindFirstFile(PChar(FileName),   WFD);
    if   hFile   <>   INVALID_HANDLE_VALUE   then
    begin
      case   AFlag   of
        1:   FileTimeToLocalFileTime(WFD.ftCreationTime,   FileTime);
        2:   FileTimeToLocalFileTime(WFD.ftLastAccessTime,  FileTime);
        3:   FileTimeToLocalFileTime(WFD.ftLastWriteTime,   FileTime);
      end;
      FileTimeToDosDateTime(FileTime,   LongRec(DFT).HI,   LongRec(DFT).LO);
      Result   :=   FileDateToDateTime(DFT);
    end;
  finally
    //FindClose(hFile);
  end;
end;

function GetFirstWB(const sStr:string;const KeyLength:Integer=4):string;
begin
  Result := '';
end;

function GetSearchKey(const sStr:string;const sType:String='PY';const KeyLength:Integer=4):string;
begin
  if sType='PY' then
    Result := ''//GetFirstPY(sStr,KeyLength)
  else
    Result := GetFirstWB(sStr,KeyLength);
end;

function GetOneSqlStr(const sSql:string):string;
var
  sStr:string;
begin
  sStr := LowerCase(TrimLeft(sSql));
  if (Copy(sStr,1,6)='select') and (Pos(' top ',sStr)=0) then
    sStr := 'select top 1 '+copy(sSql,7,Length(sSql)-6)
  else
    sStr := sSql;
  Result := sStr;
end;

function IsModified(cds:TClientDataSet):Boolean;
begin
  if cds.State in [dsEdit,dsInsert] then
    cds.Post;
  Result := cds.ChangeCount>0;
end;

procedure TDM.act_DataExportByButtonExecute(Sender: TObject);
begin
  act_DataExport.Execute;
end;

procedure TDM.act_DataExportExecute(Sender: TObject);
var
  myPopupMenu:TPopupMenu;
  MyDBGridEH:TDBGridEh;
begin
  //ShowMessage(TMenuItem(TAction(Sender).ActionComponent).GetParentComponent.Name);
  if (TAction(Sender).ActionComponent).GetParentComponent is TPopupMenu then
    myPopupMenu := (TAction(Sender).ActionComponent).GetParentComponent as TPopupMenu
  else
    Exit;

  //ShowMessage(MyPopupMenu.PopupComponent.Name);
  if (MyPopupMenu.PopupComponent is TDBGridEh) then
  begin
    MyDBGridEH := TDBGridEh(MyPopupMenu.PopupComponent);
    ExportDBEditEH(MyDBGridEH);
  end;
end;

procedure TDM.act_LocateExecute(Sender: TObject);
var
  myPopupMenu:TPopupMenu;
  MyDBGridEH:TDBGridEh;
begin
  //ShowMessage(TMenuItem(TAction(Sender).ActionComponent).GetParentComponent.Name);
  if (TAction(Sender).ActionComponent).GetParentComponent is TPopupMenu then
    myPopupMenu := (TAction(Sender).ActionComponent).GetParentComponent as TPopupMenu
  else
    Exit;

  //ShowMessage(MyPopupMenu.PopupComponent.Name);
  if (MyPopupMenu.PopupComponent is TDBGridEh) then
  begin
    MyDBGridEH := TDBGridEh(MyPopupMenu.PopupComponent);
    MyDBGridEH.SetFocus;
    keybd_event(VK_Control, MapVirtualKey(VK_Control, 0), 0, 0);               //按下Ctrl键
    keybd_event(ord('F'), MapVirtualKey(ord('F'), 0), 0, 0);                   //按下F键
    keybd_event(ord('F'), MapVirtualKey(ord('F'), 0), KEYEVENTF_KEYUP, 0);     //放开F键
    keybd_event(VK_Control, MapVirtualKey(VK_Control, 0), KEYEVENTF_KEYUP, 0); //放开Ctrl键
  end;
end;

procedure TDM.cds_MasterAfterScroll(DataSet: TDataSet);
var
  RepFileName,sSqlStr:string;
begin
  RepFileName := frxReport1.FileName;
  sSqlStr := GetDeltaTableSqlText(RepFileName);
  if sSqlStr<>'' then
  begin
    cds_Delta.XMLData := dm.OpenData(sSqlStr);
    //ShowMessage(cds_Master.FieldByName('准考证号').AsString+','+cds_Delta.FieldByName('考试课程').AsString);
  end;
end;

procedure TDM.CheckKsbmData(const cds_Temp:TClientDataSet;var sError:string);
var
  i:Integer;
  sField:string;
begin
  cds_Temp.Last;
  while not cds_Temp.Bof do
  begin
    for i := 0 to cds_Temp.FieldCount - 1 do
    begin
      sField := cds_Temp.Fields[i].FieldName;
      if ((sField = '考生号') or
          (sField = '姓名') or
          (sField = '身份证号') or
          (sField = '专业')) and
          (cds_Temp.Fields[i].IsNull or (cds_Temp.Fields[i].AsString='')) then
      begin
        sError := sError+IntToStr(cds_Temp.RecNo)+#13+#10;
        cds_Temp.Delete;
        Break;
      end;
    end;
    cds_Temp.Prior;
  end;
  if sError<>'' then
    sError := '以下记录可能因考生号，姓名，身份证号，专业字段为空而导入失败！记录号：';
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Kszp') then
    CreateDir(ExtractFileDir(ExtractFilePath(ParamStr(0))+'Kszp'));
  //gb_System_Mode := '录取';
  SoapConnection1.Connected := False;
  GetConnInfo;
  frxDesigner1.OpenDir := ExtractFilePath(ParamStr(0))+'Rep';
  frxDesigner1.SaveDir := frxDesigner1.OpenDir;
end;

procedure TDM.DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  //if gdSelected in State then Exit;
  if gdFocused in State then Exit;

  //if (Column.FieldName<>'交易状态') and (Column.FieldName<>'缴费金额') then Exit;

  if (Column.FieldName='缴费金额') or (Column.FieldName='金额') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsFloat<0 then
    begin
      Font.Color := clRed
      //Brush.Color := clRed
    end;
    //FillRect(Rect);
  end
  else if (Column.FieldName='交易状态') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsString='交易可疑' then
    begin
      //  Font.Color := clRed
      Brush.Color := clRed
    end
    else if Column.Field.AsString='交易审核中' then
    begin
      Font.Color := clRed;
      Brush.Color := clYellow;
    end;
    //FillRect(Rect);
  end
  else if (Column.FieldName = '打印单号') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsString='' then
    begin
      //Font.Color := clRed;
      Brush.Color := clRed;
    end;
  end;
  {else if (Column.FieldName = '是否结算') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsBoolean then
    begin
      Font.Color := clRed;
      //Brush.Color := clSilver;
    end;
  end;
  }
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);
end;

function  TDM.DownLoadKsPhoto(const sUrl:string; img:TImage;const OverPhoto:Boolean=True):Boolean;
begin
  if sUrl='' then Exit;
  Result := DownloadUrlImage(sUrl,img,OverPhoto);
end;

function TDM.DownLoadKsPhotoByKSH(const sKsh,sFileName: string; img: TImage;
  const OverPhoto: Boolean): Boolean;
var
  sPath,fn,sData,sError:string;
  cds_Temp:TClientDataSet;
begin
  fn := sFileName;
  Result := False;
  if (fn<>'') and FileExists(fn) and (not OverPhoto) then
  begin
    if img<>nil then img.Picture.LoadFromFile(fn);
    Result := True;
    Exit;
  end;
  if FileExists(fn) and OverPhoto then DeleteFile(PChar(fn));

  cds_Temp := TClientDataSet.Create(nil);
  try
    try
      if not vobj.DownLoadPhoto(sKsh,sData,sError) then
        Exit;
      cds_Temp.XMLData := sData;

      if sData='' then Exit;

      if fn='' then
        fn := cds_Temp.FieldByName('FileName').AsString;

      if not DirectoryExists(ExtractFileDir(fn)) then
        CreateDir(ExtractFileDir(fn));
        
      if not cds_Temp.FieldByName('FileData').IsNull then
        TBlobField(cds_Temp.FieldByName('FileData')).SaveToFile(fn);

      if FileExists(fn) then
      begin
        if img<>nil then img.Picture.LoadFromFile(fn);
        Result := True;
      end;
    except
      img.Picture := nil;
      Result := False;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.DownLoadReportFile(const Id: Integer; var ReportFileName: string;const ShowSelectFolder:Boolean): Boolean;
var
  bl :Boolean;
  sSqlStr,sfn :string;
  sLastTime,sLastTime2:TDateTime;
  cds_Temp:TClientDataSet;
begin
  Result := False;
  sfn := ReportFileName;
  //if (sfn<>'') and (not FileExists(sfn)) then
  //   Exit;

  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select 报表文件名,报表内容,最后修改日期 from 报表模板表 where Id='+IntToStr(Id);
    sSqlStr := DM.OpenData(sSqlStr);
    if sSqlStr='' then
      Exit
    else
      cds_Temp.XMLData := sSqlStr;

    if (sfn='') or ShowSelectFolder then
    begin
      if sfn<>'' then
        dlgSave1.FileName := sfn
      else
        dlgSave1.FileName := cds_Temp.Fields[0].AsString;
      if dlgSave1.Execute then
      begin
        sfn := dlgSave1.FileName;
      end else
        Exit;
    end;

    if cds_Temp.FieldByName('报表内容').IsNull then
    begin
      if (ReportFileName='') then
        Application.MessageBox('数据库中的报表模板为空，文件导出导出失败！　　',
          '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Exit;
    end;

    sLastTime := GetFileLastAccessTime(sfn,3);
    sLastTime2 := cds_Temp.FieldByName('最后修改日期').AsDateTime;
    if (ReportFileName='') and (sLastTime2<sLastTime) then
    begin
      if Application.MessageBox(PChar('本地文件比数据库中的报表文件内容还要新！　　'+#13+
                                      '真的要替换本地的文件吗？'), '系统提示',
          MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=IDYES then
        bl := True
      else
      begin
        bl := False;
        Exit;
      end;
    end else
      bl := True;

    if bl then
    begin
      DeleteFile(PChar(sfn));
      TBlobField(cds_Temp.FieldByName('报表内容')).SaveToFile(sfn);
    end;
    ReportFileName := ExtractFileName(sfn);
    Result := True;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.DownloadUrlImage(const sUrl: string; img: TImage;
  const OverPhoto: Boolean): Boolean;
var
  ImageStream:TMemoryStream;
  sPath,fn:string;
begin
  if img<>nil then
  begin
    img.Picture := nil;
  end;

  ii := PosRight('/',sUrl);
  fn := Copy(sUrl,ii+1,Length(sUrl));
  sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
  fn := sPath+fn;
  if not DirectoryExists(sPath) then
    ForceDirectories(sPath);

  if OverPhoto and FileExists(fn) then
    DeleteFile(PChar(fn));

  if FileExists(fn) and (img<>nil) then
  begin
    img.Picture.LoadFromFile(fn);
    Result := True;
    Exit;
  end;

  ImageStream := TMemoryStream.Create();
  try
    try
      idhttp1.Get(sUrl,ImageStream);
    except
      Result := False;
      Exit;
    end;
    Result := ImageStream.Size>0;
    if Result then
    begin
      ImageStream.Position := 0;
      ImageStream.SaveToFile(fn);
      try
        if img<>nil then
          img.Picture.LoadFromFile(fn);
      except
        Result := False;
      end;
    end;
  finally
    ImageStream.Free;
  end;
end;

function TDM._PrintReport(const sPath, ReportFileName, cds_Master_XMLData: String;
                          const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  fn,sTempPath,sHint:string;
begin
  sTempPath := sPath;
  if sPath='' then
    sTempPath := ExtractFilePath(ParamStr(0))+'Rep\';
  if not DirectoryExists(sTempPath) then
    ForceDirectories(sTempPath);

  fn := sTempPath+ReportFileName;
  if (not FileExists(fn)) and (OperateType<>2) then
  begin
    MessageBox(0, PChar('报表模板文件未找到！请检查后重试！报表文件为：　　'+#13+fn+'　　'), '系统提示',
    MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Result := False;
    Exit;
  end;
  case OperateType of
    0:
      sHint := '现在真的要打印吗？　　';
    1:
      sHint := '真的要打印预览吗？　　';
    2:
      sHint := '真的要进行报表设计吗？　　';
  end;
  if ShowDialog and (OperateType<>1) then
     if Application.MessageBox(PChar(sHint), '系统提示', MB_YESNO +
       MB_ICONQUESTION + MB_TOPMOST) = IDNO then
     begin
       Exit;
     end;

  if cds_Master_XMLData<>'' then
    cds_Master.XMLData := cds_Master_XMLData;

  //frxReport1.ReportOptions.Name := ReportFileName;
  //if CompareText(ReportFileName,'缴费单.fr3')=0 then
  if Pos('录取通知书',ReportFileName)>0 then
  begin
    frxReport1.OnGetValue := frxReport1GetValue;
    frxReport1.OnPrintPage := frxReport1PrintPage;
  end
  else
  begin
    frxReport1.OnGetValue := nil;
    frxReport1.OnPrintPage := nil;
  end;

  if FileExists(fn) then
  begin
    frxReport1.LoadFromFile(fn);
    frxReport1.Variables.Clear;
    frxReport1.Variables[' User_Var'] := ''; //建立变量分类
    frxReport1.Variables.AddVariable('User_Var','cur_sfxn',QuotedStr(gb_Cur_Xn));
    frxReport1.Variables.AddVariable('User_Var','cur_sfmc',QuotedStr(gb_Cur_Sfmc));
    frxReport1.Variables.AddVariable('User_Var','czy_id',QuotedStr(gb_Czy_ID));
    frxReport1.Variables.AddVariable('User_Var','czy_name',QuotedStr(gb_Czy_Name)); //操作员姓名
    frxReport1.Variables.AddVariable('User_Var','kpy_id',QuotedStr(GetKpyName)); //开票员
    frxReport1.Variables.AddVariable('User_Var','sky_id',QuotedStr(GetSkyName)); //收款员
    frxReport1.Variables.AddVariable('User_Var','rmb_str','');
    frxReport1.Variables.AddVariable('User_Var','sfxm_xf',QuotedStr('0.00'));  //学费
    frxReport1.Variables.AddVariable('User_Var','sfxm_ksf',QuotedStr('0.00')); //考试费
    frxReport1.Variables.AddVariable('User_Var','sfxm_zsf',QuotedStr('0.00'));  //住宿费
    frxReport1.Variables.AddVariable('User_Var','sfxm_jcf',QuotedStr('0.00'));  //教材费，现在没用它
    frxReport1.Variables.AddVariable('User_Var','pj_bh',QuotedStr(''));  //发票编号
    frxReport1.Variables.AddVariable('User_Var','app_path',QuotedStr(ExtractFilePath(ParamStr(0))));  //应用程序路径
    frxReport1.Variables.AddVariable('User_Var','photo_fn','');  //照片文件名
    case OperateType of
      0:
      begin
        frxReport1.PrintOptions.ShowDialog := ShowDialog;
        frxReport1.PrepareReport;
        frxReport1.Print;
        //frxreport1.PrintPreparedReportDlg;
      end;
      1:
      begin
        frxReport1.PrintOptions.ShowDialog := ShowDialog;
        frxReport1.ShowReport;
      end;
      2:
      begin
        frxReport1.PrintOptions.ShowDialog := ShowDialog;
        frxReport1.DesignReport;
      end;
    end;
    Result := True;
  end else
  begin
    if OperateType=2 then
    begin
      frxReport1.PrintOptions.ShowDialog := ShowDialog;
      frxReport1.DesignReport;
    end
    else
    begin
      MessageBox(0, PChar('打印模板文件未找到！请检查后重试！　　'+#13+fn+'　　'), '系统提示',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Result := False;
    end;
  end;
end;

function TDM._PrintReport2(const sPath, ReportFileName, cds_Master_XMLData: String; const Page: Integer): Boolean;
var
  fn,sTempPath:string;
begin
  sTempPath := sPath;
  if sPath='' then
    sTempPath := ExtractFilePath(ParamStr(0))+'Rep\';

  fn := sTempPath+ReportFileName;
  frxReport1.ReportOptions.Name := ReportFileName;
  if CompareText(ReportFileName,'缴费单.fr3')=0 then
  begin
    frxReport1.OnGetValue := frxReport1GetValue;
    frxReport1.OnPrintPage := frxReport1PrintPage;
  end
  else
  begin
    frxReport1.OnGetValue := nil;
    frxReport1.OnPrintPage := nil;
  end;

  if FileExists(fn) then
  begin
    if Page<>-1 then
    begin
      frxReport1.LoadFromFile(fn);
      frxReport1.Variables.Clear;
      frxReport1.Variables[' User_Var'] := ''; //建立变量分类
      frxReport1.Variables.AddVariable('User_Var','cur_sfxn',QuotedStr(gb_Cur_Xn));
      frxReport1.Variables.AddVariable('User_Var','cur_sfmc',QuotedStr(gb_Cur_Sfmc));
      frxReport1.Variables.AddVariable('User_Var','czy_id',QuotedStr(gb_Czy_ID));
      frxReport1.Variables.AddVariable('User_Var','czy_name',QuotedStr(gb_Czy_Name)); //操作员姓名
      frxReport1.Variables.AddVariable('User_Var','kpy_id',QuotedStr(GetKpyName)); //开票员
      frxReport1.Variables.AddVariable('User_Var','sky_id',QuotedStr(GetSkyName)); //收款员
      frxReport1.Variables.AddVariable('User_Var','rmb_str','');
      frxReport1.Variables.AddVariable('User_Var','sfxm_xf',QuotedStr('0.00'));  //学费
      frxReport1.Variables.AddVariable('User_Var','sfxm_ksf',QuotedStr('0.00')); //考试费
      frxReport1.Variables.AddVariable('User_Var','sfxm_zsf',QuotedStr('0.00'));  //住宿费
      frxReport1.Variables.AddVariable('User_Var','sfxm_jcf',QuotedStr('0.00'));  //教材费，现在不用它了
      frxReport1.Variables.AddVariable('User_Var','pj_bh',QuotedStr(''));  //发票编号
    end;
    case Page of
      -1:
        frxReport1.ShowPreparedReport;
      1:
        frxReport1.PrepareReport;
      else
        frxReport1.PrepareReport(False);
    end;
    Result := True;
  end else
  begin
    begin
      MessageBox(0, PChar('打印模板文件未找到！请检查后重试！　　'+#13+fn+'　　'), '系统提示',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Result := False;
    end;
  end;
end;

function TDM.ExecSql(const sSqlStr: string): Boolean;
var
  sError:string;
begin
  try
    Result := vobj.ExecSql(sSqlStr,sError) ;

    if sError<>'' then
    begin
        sError := '命令执行失败！请检查后重新执行！可能的原因为：　　'+#13+sError;
        MessageBox(0, PChar(string(sError)), '系统提示', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end;//else
    //  MessageBox(0, '数据提交（保存）成功！　　', '系统提示', MB_OK
    //    + MB_ICONINFORMATION);
  finally
    //vobj := nil;
  end;
end;

function TDM.ExportDBEditEH(const MyDBGridEH: TDBGridEh):Boolean;
var
  ExpClass:TDBGridEhExportClass;
  fn,mfn,Ext:String;
begin
  if MyDBGridEH.Owner is TForm then
    SaveDialog1.FileName := TForm(MyDBGridEH.Owner).Caption+FormatDateTime('(yyyy-mm-dd)',Now)//+'.xls'
  else
    SaveDialog1.FileName := '数据导出'+FormatDateTime('(yyyy-mm-dd)',Now);//.xls';

  if not SaveDialog1.Execute then Exit;

  fn := SaveDialog1.FileName;
  Ext := ExtractFileExt(fn);
  mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
  case SaveDialog1.FilterIndex of
    1: begin ExpClass := TDBGridEhExportAsText; Ext := '.txt'; end;
    2: begin ExpClass := TDBGridEhExportAsCSV; Ext := '.csv'; end;
    3: begin ExpClass := TDBGridEhExportAsHTML; Ext := '.htm'; end;
    4: begin ExpClass := TDBGridEhExportAsRTF; Ext := '.rtf'; end;
    5: begin ExpClass := TDBGridEhExportAsXLS; Ext := '.xls'; end;
  else
    ExpClass := nil; Ext := '';
  end;
  if ExpClass <> nil then
  begin
    SaveDialog1.FileName := mfn + Ext;
    if FileExists(SaveDialog1.FileName) then
      if MessageBox(0,
        PChar('警告！当前文件夹下存在同名文件！该同名文件名为：？　　'
        + #13#10 +'【'+ ExtractFileName(SaveDialog1.FileName)+'】　　'+#13+#13+'要覆盖这一同名文件吗？'), '系统提示', MB_YESNO + MB_ICONWARNING
        + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      begin
        Exit;
      end;

    Screen.Cursor := crHourGlass;
    try
      SaveDBGridEhToExportFile(ExpClass,MyDBGridEh, SaveDialog1.FileName,True);
      //SaveDBGridEhToExportFile(ExpClass,DBGridEh1, dlgSave1.FileName,False);
      Result := True;
    finally
      if MyDBGridEH.CanFocus then
         MyDBGridEh.SetFocus;
      Screen.Cursor := crDefault;
    end;
  end;

end;

procedure TDM.frxReport1GetValue(const VarName: string; var Value: Variant);
var
  sPath,photo_fn:String;
  sKsh,sUrl,sqlstr:string;
begin
  //if VarName='photo_fn' then
  if VarName='Picture1' then
  begin
    sPath := ExtractFilePath(ParamStr(0))+'kszp\';
    //Value := sPath;

    Photo_fn := '';
    if (cds_Master.FieldList.IndexOf('照片文件')<>-1) then
    begin
      sKsh := Trim(cds_Master.FieldByName('考生号').AsString);
      Photo_fn := Trim(cds_Master.FieldByName('照片文件').AsString);

      if Photo_fn='' then
      begin
        if FileExists(sPath+Photo_fn) then
          Photo_fn := sPath+Photo_fn
        else
          Exit;
      end;

      if photo_fn='' then Exit;

      photo_fn := sPath+photo_fn;

      if not FileExists(photo_fn) then
        dm.DownLoadKsPhotoByKSH(sKsh,photo_fn,nil,False);
      //{
      try
        if FileExists(photo_fn) then
        begin
          //TfrxPictureView(frxReport1.FindObject('Picture1')).URL := Photo_fn;
          TfrxPictureView(frxReport1.FindObject('Picture1')).Picture.LoadFromFile(Photo_fn);
        end else
        begin
          //TfrxPictureView(frxReport1.FindObject('Picture1')).URL := '';
          TfrxPictureView(frxReport1.FindObject('Picture1')).Picture := nil;
        end;
      except
      end;
      //}
    end;
  end;
end;

procedure TDM.frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
var
  Ksh,sqlstr:string;
  iCount:Integer;
begin
  if Pos('录取通知书',frxReport1.FileName)>0 then
  begin
    ksh := fds_Master.DataSet.FieldByName('考生号').AsString;
    iCount := fds_Master.DataSet.FieldByName('打印状态').AsInteger;
    sqlstr := 'update lqmd set 打印状态='+IntToStr(iCount+1)+' where 考生号='+quotedstr(ksh);
    dm.ExecSql(sqlstr);
  end;
  fds_Master.Next;
end;

function GetAutoUpdateInfo: string;
var
  fn,url:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      url := ReadString('SrvSet','UpdateUrl','');
      if LowerCase(Copy(url,1,7))<>'http://' then
        url := 'http://'+url;
      Result := url;
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetAllYxList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select 院系 from 院系信息表 where 教学单位<>0 order by 院系';
  GetDeptListBySql(sqlstr,sList);
end;

function TDM.GetCjBL(const Km: string; const Cj_No: Integer): Integer;
var
  fn,cjstr:string;
begin
  cjstr := 'Cj'+IntToStr(Cj_No)+'_Pre';

  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      if Cj_No=1 then
        Result := ReadInteger(Km,cjstr,100)
      else
        Result := ReadInteger(Km,cjstr,0);
    finally
      Free;
    end;
  end;
end;

function TDM.GetClientAutoUpdateUrl: string;
begin
  Screen.Cursor := crHourGlass;
  try
    try
      Result := vobj.GetClientAutoUpdateUrl;
    except
      //MessageBox(0, '服务器连接失败！请检查连接服务器的配置信息！　',
      //  '系统提示', MB_OK + MB_ICONWARNING + MB_TOPMOST);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TDM.GetConnInfo:string;
var
  fn,url:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      {$IFNDEF WAD_DEBUG}
        url := ReadString('SrvSet','SoapUrl','');
      {$ELSE}
        url := ReadString('SrvSet','DebugSoapUrl','http://localhost:8081/');
      {$ENDIF}
      if LowerCase(Copy(url,1,7))<>'http://' then
        url := 'http://'+url;
      if Copy(url,Length(url),1)<>'/' then
        url := url+'/';
      Result := url;
      //url := url+SOAP_NAME;
      {
      if Pos('/wsdl',LowerCase(url))>0 then
         HTTPRIO1.WSDLLocation := url
      else
        HTTPRIO1.URL := url;
      SoapConnection1.URL := url;
      }
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetCzySfList(const sXlCc: string; out sList: TStrings;
  const IncludeAll: Boolean);
var
  cds_Temp:TClientDataSet;
  sqlstr:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  if gb_Czy_Level='-1' then
  begin
    GetSfList(sList,IncludeAll);
    Exit;
  end;
  try
    sqlstr := 'select 省份 from 操作员省份表 where 1>0 '+ //where 学历层次='+quotedstr(sXlCc)+
              ' and 操作员='+quotedstr(gb_Czy_ID)+' order by 省份';
    cds_Temp.XMLData := OpenData(sqlstr);
    sList.Clear;
    if IncludeAll then
      sList.Add('全部');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('省份').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetDeltaRepSetInfo(const RepFileName: string; out sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string): Boolean;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
begin

  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select 主表,从表,主表关联字段,从表关联字段 from 报表模板表 where 报表文件名='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    if cds_Temp.FieldByName('从表').AsString='' then Exit;
    sDeltaTableName := cds_Temp.FieldByName('从表').AsString;
    sMasterFieldName := cds_Temp.FieldByName('主表关联字段').AsString;
    sDeltaFieldName := cds_Temp.FieldByName('从表关联字段').AsString;
    cds_Temp.Close;
    sMasterValue := cds_Master.FieldByName(sMasterFieldName).AsString;
    sqlstr := 'select * from '+sDeltaTableName+' where '+sDeltaFieldName+'='+quotedstr(sMasterValue);
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetDeltaTableSqlText(const RepFileName: string): string;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
  sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string;
begin
  Result := '';
  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select 主表,从表,主表关联字段,从表关联字段 from 报表模板表 where 报表文件名='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    if cds_Temp.FieldByName('从表').AsString='' then Exit;
    sDeltaTableName := cds_Temp.FieldByName('从表').AsString;
    sMasterFieldName := cds_Temp.FieldByName('主表关联字段').AsString;
    sDeltaFieldName := cds_Temp.FieldByName('从表关联字段').AsString;
    cds_Temp.Close;
    sMasterValue := cds_Master.FieldByName(sMasterFieldName).AsString;
    Result := 'select * from '+sDeltaTableName+' where '+sDeltaFieldName+'='+quotedstr(sMasterValue);
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetDeptList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select 院系 from 院系信息表 order by 院系';
  GetDeptListBySql(sqlstr,sList);
end;

procedure TDM.GetDeptListBySql(const sqlstr:string;var sList: TStrings);
var
  i:Integer;
  cds_Temp:TClientDataSet;
begin
  sList.Clear;
  cds_Temp := TClientDataSet.Create(nil);
  cds_Temp.XMLData := OpenData(sqlstr);
  try
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetJjList(var JjList: TStrings): Boolean;
var
  sData:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sData := OpenData('select * from 季节表 order by 季节');
    cds_Temp.XMLData := sData;
    JjList.Clear;
    while not cds_Temp.Eof do
    begin
      JjList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
    Result := True;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetKLList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select 科类 from 专业科类代码表 order by Id');
    sList.Clear;
    if IncludeAll then
      sList.Add('全部');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('科类').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetKpyName: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','KpyName',gb_Czy_Name);
    finally
      Free;
    end;
  end;
end;

function TDM.GetKshBySfzh(const sSfzh: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select 考生号 from 校考考生报考专业表 where 身份证号='+quotedstr(sSfzh);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    FreeAndNil(cds_Temp);
  end;
end;

function TDM.GetKshByZkzh(const sZkzh: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select 考生号 from 校考考生报考专业表 where 准考证号='+quotedstr(sZkzh);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    FreeAndNil(cds_Temp);
  end;
end;

procedure TDM.GetKsLbList(out sList: TStrings; const IncludeAll: Boolean);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select 类别 from 考生类别代码表 order by Id');
    sList.Clear;
    if IncludeAll then
      sList.Add('全部');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('类别').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetLbList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select 类别 from 专业类别代码表 order by Id');
    sList.Clear;
    if IncludeAll then
      sList.Add('全部');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('类别').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetListFromTable(const sqlstr: string; out sList: TStrings);
var
  cds_Temp:TClientDataSet;
  I: Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetNextPrintBH(const Number: string): string;
var
  Num :Integer;
  PrintNumber :string;
begin
  PrintNumber := Number;
  if Number='' then
    PrintNumber := 'FA09860001';
  Num := StrToIntDef(RightStr(PrintNumber,6),0)+1;
  PrintNumber := Copy(PrintNumber,1,4)+Format('%.6d',[Num]);
  Result := PrintNumber;
end;

function TDM.GetPrintBH: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','StartPrintBH','');
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetSfDirList(out sList: TStrings);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select 短名称,目录名 from view_省份表 where 目录名 is not null order by 短名称');
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetSfList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select 短名称 from view_省份表 order by 短名称');
    sList.Clear;
    if IncludeAll then
      sList.Add('全部');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('短名称').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetSfxmJe(const Id, sfxm: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select 金额 from 缴费记录明细表 where Pid='+quotedstr(Id)+' and 缴费项目='+quotedstr(sfxm);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '0.00';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := FormatFloat('0.00',Abs(cds_Temp.Fields[0].AsFloat));
  finally
    FreeAndNil(cds_Temp);
  end;
end;

function TDM.GetSkyName: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','SkyName',gb_Czy_Name);
    finally
      Free;
    end;
  end;
end;

function TDM.GetSrvAutoUpdateUrl: string;
begin
  Result := vobj.GetSrvAutoUpdateUrl;
end;

function TDM.GetWebSrvUrl: string;
begin
  //Result := vobj.GetWebSrvUrl;   //============小宇飞刀========
  if RightStr(Result,1)<>'/' then
    Result := Result+'/';
end;

procedure TDM.GetXlCcList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select 学历层次 from 学历层次代码表');
    sList.Clear;
    if IncludeAll then
      sList.Add('全部');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetXQList(var sList: TStrings);
var
  xq:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select 校区 from 校区信息表');
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      xq := cds_Temp.FieldByName('校区').AsString;
      sList.Add(xq);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;

end;

procedure TDM.GetZKYxList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select 院系 from 院系信息表 where 教学单位<>0 and 专科教学<>0 order by 院系';
  GetDeptListBySql(sqlstr,sList);
end;

procedure TDM.GetZyList(const XlCc,ZyLb: string; out sList: TStrings);
var
  sWhere:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    if XlCc<>'' then
      sWhere := ' where 学历层次='+quotedstr(XlCc)
    else
      sWhere := ' where 1>0';
    if ZyLb<>'' then
      sWhere := sWhere+' and 类别='+quotedstr(ZyLb);

    cds_Temp.XMLData := OpenData('select 专业 from 专业信息表 '+sWhere);
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetZyWithIdList(const XlCc, ZyLb: string; out sList: TStrings);
var
  sWhere:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    if XlCc<>'' then
      sWhere := ' where 学历层次='+quotedstr(XlCc)
    else
      sWhere := ' where 1>0';
    if ZyLb<>'' then
      sWhere := sWhere+' and 类别='+quotedstr(ZyLb);

    cds_Temp.XMLData := OpenData('select Id,专业 from 专业信息表 '+sWhere);
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.HaveDeltaTable(const RepFileName: string): Boolean;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
  sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string;
begin
  Result := False;
  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select 主表,从表,主表关联字段,从表关联字段 from 报表模板表 where 报表文件名='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    Result := (cds_Temp.FieldByName('从表').AsString<>'') and
              (cds_Temp.FieldByName('主表关联字段').AsString<>'') and
              (cds_Temp.FieldByName('从表关联字段').AsString<>'');
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.HTTPRIO1BeforeExecute(const MethodName: string;
  var SOAPRequest: WideString);
begin
  GetTotal := 0;
  SendTotal := 0;
end;

procedure TDM.HTTPRIO1HTTPWebNode1PostingData(Sent, Total: Integer);
begin
  SendTotal := SendTotal+Sent;
  UpdateProgressMax(SendTotal);//SendTotal);
  UpdateProgress(Total);//+Sent);
  UpdateProgressTitle('正在更新数据... '+FormatFloat('[已更新：0.00KB]',SendTotal/1024/32));
end;

procedure TDM.HTTPRIO1HTTPWebNode1ReceivingData(Read, Total: Integer);
begin
  GetTotal := GetTotal+Read;
  UpdateProgressMax(GetTotal);//GetTotal);
  UpdateProgress(Total);//+Read);
  UpdateProgressTitle('正在下载数据... '+FormatFloat('[已下载：0.00KB]',GetTotal/1024/32));
end;

function TDM.IsDisplayJiangXi: Boolean;
var
  sqlstr:string;
begin
  if (StrToIntDef(gb_Czy_Level,3)<>0) then
    Result := True
  else
  begin
    sqlstr := 'select count(*) from 操作员省份表 where 操作员='+quotedstr(gb_Czy_ID)+' and 省份='+quotedstr('江西');
    Result :=  (vobj.GetRecordCountBySql(sqlstr)>0);
  end;
end;

procedure TDM.GetBKYxList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select 院系 from 院系信息表 where 教学单位<>0 and 本科教学<>0 order by 院系';
  GetDeptListBySql(sqlstr,sList);
end;

procedure InitXnList(sList: TDBComboBoxEh);
var
  i,curYear:Integer;
begin
  curYear := YearOf(Now);
  sList.Items.Clear;
  sList.KeyItems.Clear;
  for i:=curYear-5 to curYear+1 do
  begin
    sList.Items.Add(Format('%4d春季',[i]));
    sList.KeyItems.Add(Format('%4d春季',[i]));
    sList.Items.Add(Format('%4d秋季',[i]));
    sList.KeyItems.Add(Format('%4d秋季',[i]));
    //sList.Items.Add(Format('%4d~%4d学年',[i,i+1]));
    //sList.KeyItems.Add(Format('%4d~%4d',[i,i+1]));
  end;
end;

function TDM.OpenData(const sSqlStr: string;const ShowHint:Boolean=False): string;
var
  sTempData,sData:string;
begin
  Screen.Cursor := crHourGlass;
  if ShowHint then
  begin
    ShowProgress('正在读取数据...');
    HTTPRIO1.HTTPWebNode.OnReceivingData := HTTPRIO1HTTPWebNode1ReceivingData;
  end else
  begin
    HTTPRIO1.HTTPWebNode.OnReceivingData := nil;//HTTPRIO1HTTPWebNode1ReceivingData;
  end;

  try
    try
      vobj.Query_Data(sSqlStr,sData);
      if gb_Use_Zip then
      begin
        //Base64Decode(sData,sTempData);
        sTempData := DecodeString(sData);
        if sTempData<>'' then
          sData := VCLUnZip1.ZLibDecompressString(sTempData);
      end;
      Result := sData;
    except
      Result := '';
    end;
  finally
    if ShowHint then
      HideProgress;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.SaveAsUrlImage(const sUrl,sFileName: string): Boolean;
var
  ImageStream:TMemoryStream;
  Jpg:TJpegImage;
  //Image1:TImage;
begin
  ImageStream := TMemoryStream.Create();
  Jpg := TJpegImage.Create;
  //Image1 := TImage.Create(nil);
  try
    try
      idhttp1.Get(sUrl,ImageStream);
    except
      Result := False;
      Exit;
    end;
    if ImageStream.Size=0 then Exit;
    ImageStream.Position := 0;
    Jpg.LoadFromStream(ImageStream);
    Jpg.SaveToFile(sFileName);
    //Image1.Picture.Assign(Jpg);
    //Image1.Picture.SaveToFile(sFileName);
    Result := True;
  finally
    ImageStream.Free;
    Jpg.Free;
    //Image1.Free;
  end;
end;

function TDM.SaveCjData(const CjIndex: Integer;
  const vDelta: OleVariant): Boolean;
var
  sqlstr,cjField,czyField,sError:string;
  ksh,cjValue,czy:string;
  cds_Temp:TClientDataSet;
  sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cjField := '成绩'+IntToStr(CjIndex);
    czyField := '操作员'+IntToStr(CjIndex);

    cds_Temp.Data := vDelta;
    sData := cds_Temp.XMLData;
    cds_Temp.First;
    while not cds_Temp.Eof do
    begin
      ksh := cds_Temp.FieldByName('考生号').AsString;
      cjValue := cds_Temp.FieldByName(cjField).AsString;
      czy := quotedstr(cds_Temp.FieldByName(czyField).AsString);
      sqlstr := 'update 校考单科成绩表 set '+cjfield+'='+cjValue+','+czyField+'='+czy+' where 考生号='+quotedstr(ksh);
      if not vobj.ExecSql(sqlstr,sError) then
      begin
        Result := False;
        break;
      end;
      cds_Temp.Next;
    end;
    //if not ShowMsgBox then Exit;

    if sError<>'' then
    begin
    sError := '数据保存失败！请检查后重新保存！可能的原因为：　　'+#13+sError;
        MessageBox(0, PChar(string(sError)), '系统提示', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end else
      MessageBox(0, '数据提交（保存）成功！　　', '系统提示', MB_OK + MB_ICONINFORMATION+ MB_TOPMOST);
  finally
    //vobj := nil;
    cds_Temp.Free;
  end;
end;

procedure TDM.SaveDialog1TypeChange(Sender: TObject);
var
  fn,mfn,Ext:string;
begin
  fn := SaveDialog1.FileName;
  Ext := ExtractFileExt(fn);
  mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
  case SaveDialog1.FilterIndex of
    1: begin Ext := '.txt'; end;
    2: begin Ext := '.csv'; end;
    3: begin Ext := '.htm'; end;
    4: begin Ext := '.rtf'; end;
    5: begin Ext := '.xls'; end;
  else
    Ext := '';
  end;
  SaveDialog1.FileName := mfn+Ext;
  SaveDialog1.DefaultExt := Ext;
end;

function TDM.SelectZy(const XlCc,ZyLb:string;var sList:TStrings): Boolean;
var
  Form: TZySelect;
begin
  Result := False;
  Form := TZySelect.Create(Application);
  try
    Form.SetData(XlCc,ZyLb,sList);
    if Form.ShowModal = mrOk then
    begin
      sList.Assign(Form.ZyList);
      //if Form.RadioGroup1.ItemIndex=2 then
      //  Value := '';
      Result := True;
    end;
  finally
    Form.Free;
  end;
end;

function TDM.SetCjBL(const Km: string; const Cj_No,Cj_BL: Integer): Boolean;
var
  fn,cjstr:string;
begin
  cjstr := 'Cj'+IntToStr(Cj_No)+'_Pre';

  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteInteger(Km,cjstr,Cj_BL);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetConnInfo(const sUrl:string);
var
  fn,url,sTemp:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  url := sUrl;

  if LowerCase(Copy(url,1,7))<>'http://' then
    url := 'http://'+url;
  if Copy(url,Length(url),1)<>'/' then
    url := url+'/';

  with TIniFile.Create(fn) do
  begin
    try
      {$IFNDEF WAD_DEBUG}
        sTemp := ReadString('SrvSet','SoapUrl','');
      {$ELSE}
        sTemp := ReadString('SrvSet','DebugSoapUrl','');
      {$ENDIF}

      if sTemp<>url then
      begin
        {$IFNDEF WAD_DEBUG}
          WriteString('SrvSet','SoapUrl',Url);
        {$ELSE}
          WriteString('SrvSet','DebugSoapUrl',Url);
        {$ENDIF}
      end;
      if Pos('/wsdl',LowerCase(url))>0 then
         HTTPRIO1.WSDLLocation := url
      else
         HTTPRIO1.URL := url;
      SoapConnection1.URL := url;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetCzySfComboBox(const sXlCc: string; aDbComboBox: TDBComboBoxEh;
  const IncludeAll: Boolean);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetCzySfList(sXlCc,sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetKlComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetKlList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

function TDM.SetKpyName(const sName: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','KpyName',sName);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetKsLbComboBox(aDbComboBox: TDBComboBoxEh;
  const IncludeAll: Boolean);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetKsLbList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetLbComboBox(aDbComboBox: TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetLbList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

function TDM.SetPrintBH(const Number: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','StartPrintBH',Number);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetSfComboBox(aDbComboBox: TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetSfList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

function TDM.SetSkyName(const sName: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','SkyName',sName);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetXkYxComboBox(aDbComboBox: TDBComboBoxEh);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    aDbComboBox.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      aDbComboBox.Items.Add('艺术设计学院');
      aDbComboBox.Items.Add('音乐学院');
    end else
      aDbComboBox.Items.Add(gb_Czy_Dept);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;

end;

procedure TDM.SetXlCcComboBox(aDbComboBox: TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetXlCcList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetZyComboBox(const XlCc,ZyLb: string; aDbComboBox: TDBComboBoxEh);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetZyList(XlCc,ZyLb,sList);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetZyComboBoxByZy(const XlCc, Zy: string;
  aDbComboBox: TDBComboBoxEh);
begin

end;

function TDM.UpdateData2(const sKey, sSqlStr, sDelta: string): Boolean;
var
  sError:string;
begin
  try
    Result := vobj.Update_Data(sKey,sSqlStr,sDelta,sError) ;

    if sError<>'' then
    begin
        sError := '数据保存失败！请检查后重新保存！可能的原因为：　　'+#13+sError;
        MessageBox(0, PChar(string(sError)), '系统提示', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end;
    //else
    //  MessageBox(0, '数据提交（保存）成功！　　', '系统提示', MB_OK
    //    + MB_ICONINFORMATION);
  finally
    //vobj := nil;
  end;
end;

function TDM.UpdatePrintBH(const ID:string): Boolean;
var
  sError,sSqlStr,PrintNumber:string;
  Num:Integer;
begin
  PrintNumber := GetPrintBH;
  if PrintNumber='' then
    PrintNumber := '未知';
  sSqlStr := 'update 缴费记录表 set 打印单号='+quotedstr(PrintNumber)+' where Id='+quotedstr(Id);
  Result := vobj.ExecSql(sSqlStr,sError);
  if Result then
  begin
    SetPrintBH(GetNextPrintBH(PrintNumber));
  end else
    SaveLog('Error:'+Id);
end;

procedure TDM.UpdateReportFile(const IsOver:Boolean);
var
  sSqlStr,sPath:string;
  cds_Temp:TClientDataSet;
  Id:Integer;
  ReportName:String;
begin
  sPath := ExtractFilePath(ParamStr(0))+'Rep\';
  if not DirectoryExists(sPath) then
    ForceDirectories(sPath);

  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  sSqlStr := 'select Id,报表文件名 from 报表模板表';
  try
    try
      cds_Temp.XMLData := OpenData(sSqlStr);
      if cds_Temp.XMLData='' then Exit;
      if cds_Temp.RecordCount=0 then Exit;

      ShowProgress('正在下载报表模板',cds_Temp.RecordCount);
      while not cds_Temp.Eof do
      begin
        Id := cds_Temp.FieldByName('Id').AsInteger;
        ReportName := cds_Temp.FieldByName('报表文件名').AsString;
        if ReportName='' then ReportName := '未命名报表.fr3';
        ReportName := sPath+ReportName;
        UpdateProgress(cds_Temp.RecNo);
        if (not IsOver) and FileExists(ReportName) then
        begin
          Sleep(500);
          cds_Temp.Next
        end else
        begin
          DownLoadReportFile(Id,ReportName);
          cds_Temp.Next;
        end;
      end;
    except
    end;
  finally
    HideProgress;
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;

end;

function TDM.UpLoadKsPhoto(const BmNo, sFileName: string): Boolean;
begin
  if not FileExists(sFileName) then Exit;
  Result := UploadUrlImage(BmNo,sFileName);
end;

function TDM.UpLoadReportFile(const Id: Integer;var ReportFileName: string;
                              var LastModifideTime:TDateTime;
                              const ShowSelectFolder:Boolean): Boolean;
var
  bl:Boolean;
  sSqlStr,sData,sfn,sHint:string;
  cds_Temp:TClientDataSet;
  sLastTime,sLastTime2:TDateTime;
begin
  Result := False;
  sfn := ReportFileName;
  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  try
    if (not ShowSelectFolder) and (sfn<>'') and (not FileExists(sfn)) then Exit;

    sSqlStr := 'select Id,报表文件名,报表内容,最后修改日期 from 报表模板表 where Id='+IntToStr(Id);
    sData := DM.OpenData(sSqlStr);
    if sData='' then
      Exit
    else
      cds_Temp.XMLData := sData;

    if (sfn='') then  sfn := cds_Temp.FieldByName('报表文件名').AsString;

    dlgOpen1.FileName := sfn;
    if (ReportFileName='') or ShowSelectFolder then
    begin
      if dlgOpen1.Execute then
      begin
        sfn := dlgOpen1.FileName;
      end else
        Exit;
    end;

    if not FileExists(sfn) then Exit;

    sLastTime := GetFileLastAccessTime(sfn,3);
    sLastTime2 := cds_Temp.FieldByName('最后修改日期').AsDateTime;
    if (ReportFileName='') and (not cds_Temp.FieldByName('报表内容').IsNull) then
    begin
       if (sLastTime2>sLastTime) then
          sHint := '数据库中的报表文件比要上传的内容还要新！'+#13+
                   '真的要用现在报表文件替换原来的报表模板吗？　　'
       else
          sHint := '真的要用现在报表文件替换原来的报表模板吗？　　';

       if Application.MessageBox(PChar(sHint), '系统提示',
          MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=IDYES then
        bl := True
      else
        bl := False;
    end else
      bl := True;

    if bl then
    begin
      cds_Temp.Edit;
      cds_Temp.FieldByName('报表文件名').AsString := ExtractFileName(sfn);
      TBlobField(cds_Temp.FieldByName('报表内容')).LoadFromFile(sfn);
      cds_Temp.FieldByName('最后修改日期').AsDateTime := sLastTime;
      cds_Temp.Post;
      Result := dm.UpdateData('Id',sSqlStr,cds_Temp.Delta,ReportFileName='');
      LastModifideTime := sLastTime;
      ReportFileName := ExtractFileName(sfn);
    end;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.UploadUrlImage(const BmNo, sFileName: string): Boolean;
var
  obj : TIdMultiPartFormDataStream;
  sResult,Url: String;
begin
  if not FileExists(sFileName) then Exit;

  obj := TIdMultiPartFormDataStream.Create;
  try
    obj.AddFormField('BmNo',BmNo);
    obj.AddFile('aFileName',sFileName, GetMIMETypeFromFile(sFileName));
    IdHTTP1.Request.ContentType := obj.RequestContentType;
    obj.Position := 0;
    //Url := GetConnInfo+'Upfile_Photo.asp';  //这个页面负责接收文件
    //Url := vobj.GetUploadProcessFile;   //这个页面负责接收文件 =======小宇飞刀========
    try
      sResult := IdHTTP1.Post(Url, obj);    //会返回一个处理提交后的结果内容
      Result := True;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('上传文件失败，错误原因：' + E.Message), ('错误'), MB_OK + MB_ICONERROR);
        Result := False;
      end;
    end;
  finally
    obj.Free;
  end;
end;

function TDM.UpdateData(const sKey, sSqlStr: string;const vDelta: OleVariant;
          const ShowMsgBox:Boolean=True;const ShowHint:Boolean=False): Boolean;
var
  sError:string;
  cds_Temp:TClientDataSet;
  sTempData,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.Data := vDelta;
    sData := cds_Temp.XMLData;
    if ShowHint then
    begin
      ShowProgress('正在更新数据...');
      //UpdateProgress(20);
      HTTPRIO1.HTTPWebNode.OnPostingData := HTTPRIO1HTTPWebNode1PostingData;
    end else
    begin
      HTTPRIO1.HTTPWebNode.OnPostingData := nil;//HTTPRIO1HTTPWebNode1PostingData;
    end;

    if gb_Use_Zip then
    begin
      sTempData := VCLZip1.ZLibCompressString(sData);
      //Base64Encode(sTempData,sData);
      sData := EncodeString(sTempData);
    end;

    Result := vobj.Update_Data(sKey,sSqlStr,sData,sError) ;

    //if not ShowMsgBox then Exit;

    if (not Result) and (sError<>'') then
    begin
      sError := '数据更新/导入失败！请检查后重试！可能的原因为：　　'+#13+sError;
      MessageBox(0, PChar(string(sError)), '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end else if Result and ShowMsgBox then
      MessageBox(0, pchar('数据提交（保存）成功！　　'), '系统提示', MB_OK + MB_ICONINFORMATION+ MB_TOPMOST);
  finally
    //vobj := nil;
    cds_Temp.Free;
    if ShowHint then
      HideProgress;
  end;
end;

function AppSrvIsOK:Boolean;
begin
  try
    Result := vobj.SrvIsOK;
  except
    Result := False;
  end;
end;

{ TMessageHandler }

//class procedure TMessageHandler.AppMessage(var Msg: TMsg; var Handled: Boolean);
//begin
{  if Msg.message=WM_KEYDOWN then
    if (Msg.wParam=VK_RETURN ) and
      (
        (Screen.ActiveForm.ActiveControl is TEdit) or
        (Screen.ActiveForm.ActiveControl is TComboBox) or
        (Screen.ActiveForm.ActiveControl is TCheckBox) or
        (Screen.ActiveForm.ActiveControl is TRadioButton) or
        (Screen.ActiveForm.ActiveControl is TLabeledEdit) or
        (Screen.ActiveForm.ActiveControl is TDBEditEh) or
        (Screen.ActiveForm.ActiveControl is TDBComboBoxEh) or
        (Screen.ActiveForm.ActiveControl is TDBCheckBoxEh) or
        (Screen.ActiveForm.ActiveControl is TDBNumberEditEh) or
        (Screen.ActiveForm.ActiveControl is TDBDateTimeEditEh)
              //可以添加需要的控件
      )
    then
    begin
      Msg.wParam:=VK_TAB;
    end
}{    else if (Msg.wParam=VK_RETURN) and
      (
       (Screen.ActiveForm.ActiveControl is TDBGrid)
      )
    then
    begin
      with Screen.ActiveForm.ActiveControl do
      begin
        //if Selectedindex<(FieldCount-1) then
        //  Selectedindex:=Selectedindex+1  // 移动到下一字段
        //else
        //  Selectedindex:=0;
      end;
    end;
}
//end;

function  LowerJeToUpper(const je:Real):string; //小写金额转换为大写金额
begin
  Result := NumToUpper(je);
end;

function TDM.PrintReport(const ReportFileName:string;const cds_Master_XMLData:String;
                         const OperateType:Integer;const ShowDialog:Boolean):Boolean; //OperateType: 0:Print 1:Privew 2:Design
begin
  Result := _PrintReport('',ReportFileName,cds_Master_XMLData,OperateType,ShowDialog);
end;

function TDM.PrintSFD(const sId: string; const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  sData,fn:string;
begin
  sData := dm.OpenData('select * from 缴费记录表 where id='+quotedstr(sId));
  fn := '缴费单.fr3';
  Result := PrintReport(fn,sData,OperateType,ShowDialog);
end;

function TDM.PrintSFD(const sIdList: Tstrings; const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  sWhere,sData,fn:string;
  i: Integer;
begin
  for i := 0 to sIdList.Count - 1 do
  begin
    sWhere := sWhere+quotedstr(sIdList[i])+',';
  end;
  if sWhere='' then Exit;

  if sWhere[Length(sWhere)]=',' then
    sWhere := Copy(sWhere,1,Length(sWhere)-1);

  sWhere := 'select * from 缴费记录表 where id in ('+sWhere+')';
  sData := dm.OpenData(sWhere);
  fn := '缴费单.fr3';
  Result := PrintReport(fn,sData,OperateType,ShowDialog);
end;

function TDM.PrintSFD2(const sId: string; const Page: Integer): Boolean;
var
  fn,sData:string;
begin
  sData := dm.OpenData('select * from 缴费记录表 where id='+quotedstr(sId));
  fn := '缴费单.fr3';
  Result := _PrintReport2('',fn,sData,Page);
end;

procedure SaveLog(const sMsg:string);
var
  sfn:string;
  sList:TStrings;
begin
  sfn := ExtractFilePath(ParamStr(0))+'NetPayLog.Txt';
  sList := TStringList.Create;
  try
    if FileExists(sfn) then
    begin
      sList.LoadFromFile(sfn);
      if sList.Count>1000 then
        sList.Clear;
    end;
    sList.Add(FormatDateTime('YYYY-MM-DD HH:NN:SS',Now)+' '+sMsg);
    sList.SaveToFile(sfn);
  finally
    sList.Free;
  end;
end;

function  GetNextSjBH(const CurBH:string;const SjBHWidth:Integer):string;
var
  ii:Integer;
begin
  ii := StrToIntDef(RightStr(CurBH,2),0)+1;
  Result := LeftStr(CurBH,SjBHWidth-2)+FormatFloat('00',ii);
end;

procedure RealseSortedIcon(const aDBGrid:TDBGridEh);
var
  i:Integer;
begin
  for i:=0 to aDBGrid.Columns.Count-1 do
  begin
    aDBGrid.Columns[i].Title.SortMarker := smNoneEh;
  end;
end;

procedure SetDBGridEHColumnWidth(const aDBGrid:TDBGridEh);
var
  i:Integer;
begin
  if not aDBGrid.DataSource.DataSet.Active then Exit;

  for i := 0 to aDBGrid.Columns.Count-1 do
  begin
    aDBGrid.Columns[i].Title.TitleButton := True;
    if aDBGrid.Columns[i].Width>150 then
      aDBGrid.Columns[i].Width := 150
    else
    begin
      aDBGrid.Columns[i].Width := 70;
      aDBGrid.Columns[i].Alignment := taCenter;
      aDBGrid.Columns[i].Title.Alignment := taCenter;
    end;

    if (Pos('层次',aDBGrid.Columns[i].FieldName)>0) or
       (Pos('科类',aDBGrid.Columns[i].FieldName)>0) or
       (Pos('省份',aDBGrid.Columns[i].FieldName)>0) then
    begin
      aDBGrid.Columns[i].Width := 60;
    end else if Pos('率',aDBGrid.Columns[i].FieldName)>0 then  //报到率、入学率等
    begin
      aDBGrid.Columns[i].Width := 100;
      aDBGrid.Columns[i].DisplayFormat := ',0.00%';
      //aDBGrid.Columns[i].Footer.ValueType := fvtStaticText;// fvtAvg;
      aDBGrid.Columns[i].Footer.FieldName := aDBGrid.Columns[i].FieldName;
      aDBGrid.Columns[i].Footer.ValueType := fvtAvg;
      aDBGrid.Columns[i].Footer.DisplayFormat := '平均：,0.00%';
    end else if Pos('数',aDBGrid.Columns[i].FieldName)>0 then
    begin
      aDBGrid.Columns[i].Width := 70;
      aDBGrid.Columns[i].DisplayFormat := ',0';
      aDBGrid.Columns[i].Footer.ValueType := fvtSum;
      aDBGrid.Columns[i].Footer.FieldName := aDBGrid.Columns[i].FieldName;
    end else if RightStr(aDBGrid.Columns[i].FieldName,2)='分' then
    begin
      aDBGrid.Columns[i].Width := 70;
      aDBGrid.Columns[i].DisplayFormat := '0.00';
      aDBGrid.Columns[i].Footer.ValueType := fvtAvg;
      aDBGrid.Columns[i].Footer.FieldName := aDBGrid.Columns[i].FieldName;
    end;
  end;
end;

function  PhotoIsExists(const photofilename:string):Boolean; //考生照片是否存在
var
  sPath:string;
begin
  if photofilename='' then
    Result := False
  else
  begin
    sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
    Result := FileExists(sPath+photofilename);
  end;
end;

function  ZyIsEqual(const zy1,zy2:string):Boolean;
var
  sTemp,_Zy2:string;
  iLen:Integer;
begin
  if (Pos('预科',zy1)>0) and (Pos('预科',zy2)>0) then
  begin
    Result := True;
    Exit;
  end;
  
  sTemp := Trim(Zy1);
  if Pos('(',sTemp)=1 then
  begin
    iLen := Pos(')',sTemp);
    sTemp := Copy(sTemp,iLen+1,Length(sTemp))+Copy(sTemp,1,iLen-1)
  end;
  sTemp := ReplaceStr(sTemp,'美术校|','');
  sTemp := ReplaceStr(sTemp,'○','');
  sTemp := ReplaceStr(sTemp,'●','');
  sTemp := ReplaceStr(sTemp,'◎','');
  sTemp := ReplaceStr(sTemp,'(','（');
  sTemp := ReplaceStr(sTemp,')','）');
  iLen := Length(sTemp);

  _Zy2 := Trim(zy2);

  if Length(_Zy2)<iLen then
    iLen := Length(_Zy2);
  if iLen>6 then iLen := 6;
  Result := (Copy(sTemp,1,iLen)=Copy(_Zy2,1,iLen));
  
end;

function GetKsDataPath:string;
var
  sPath: string;
begin
  //if SysUtils.Win32MajorVersion>=4 then //Windows 2003 以后的版本
    sPath := GetSpecialFolderDir(CSIDL_PERSONAL);//我的文档目录
  //else
  //  sPath := GetSpecialFolderDir(CSIDL_MYDOCUMENTS);

  sPath := sPath+'\.NacuesCStorage2012\';
  Result := sPath;
end;

procedure InitSfDmList;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select 短名称,left(代码,2) from View_省份表');
    while not cds_Temp.Eof do
    begin
      gb_SfDirList.Add(cds_Temp.Fields[0].AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function  GetSfMcBySfDm(const sfDm:string):String;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select 短名称 from View_省份表 where left(代码,2)='+quotedstr(sfDm));
    Result := cds_Temp.Fields[0].AsString;
  finally
    cds_Temp.Free;
  end;
end;

function  GetSfDmBySfMc(const sfDm:string):String;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select left(代码,2) from View_省份表 where 短名称='+quotedstr(sfDm));
    Result := cds_Temp.Fields[0].AsString;
  finally
    cds_Temp.Free;
  end;
end;

initialization
  gb_SfDirList := TStringList.Create;

finalization
  gb_SfDirList.Free;

end.
