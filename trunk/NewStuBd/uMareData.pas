unit uMareData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls,FileCtrl, DB, ADODB,StrUtils,
  IniFiles, StatusBarEx, RzPanel, RzRadGrp, RzLstBox, RzChkLst,CnProgressFrm,
  DBClient, Menus, DBTables, Grids, DBGrids;

type
  TMareData = class(TForm)
    GroupBox1: TGroupBox;
    chklst_Sf: TRzCheckList;
    pnl_Bottom: TPanel;
    chk1: TCheckBox;
    btn_OK: TBitBtn;
    btn_Exit: TButton;
    pnl_Main: TPanel;
    grp1: TGroupBox;
    Memo1: TMemo;
    rg_XlCc: TRzRadioGroup;
    cds_lqmd: TClientDataSet;
    cds_Log: TClientDataSet;
    pm1: TPopupMenu;
    mni_SelectAll: TMenuItem;
    mni_UnSelectAll: TMenuItem;
    mni_N1: TMenuItem;
    mni_Select2: TMenuItem;
    btn_Start: TBitBtn;
    cds_Temp: TClientDataSet;
    qry_BDE: TADOQuery;
    qry_Temp: TADOQuery;
    qry_BDE_TDKS: TADOQuery;
    Con_BDE: TADOConnection;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chk1Click(Sender: TObject);
    procedure btn_CjClick(Sender: TObject);
    procedure mni_Select2Click(Sender: TObject);
    procedure chklst_SfChange(Sender: TObject; Index: Integer;
      NewState: TCheckBoxState);
    procedure cds_lqmdBeforePost(DataSet: TDataSet);
    procedure btn_StartClick(Sender: TObject);
  private
    { Private declarations }
    myIniFile:TInifile;
    Tdd_Count,TddTemp_Count:Integer;
    function GetEnglishCjdm:string; //得到英语成绩代码
    procedure InitSfDirList;
    procedure SelectSf(const iType:Integer);
    procedure SetState;

    function  Get_TDD_Count(const sXlcc:string):Integer;
    function  Init_Con_BDE(const sDir: string):Boolean;
    function  Get_TDD_SfDm(const sfmc:string=''):string; //得到某一投档单表的省份代码
    //t_tdd.Pcdm=t_jhk.Pcdm and t_tdd.Kldm=t_jhk.Kldm and t_tdd.Jhxz=t_jhk.Jhxz and
    //t_tdd.tddw=t_jhk.tddw and t_tdd.lqzy=t_jhk.zydh
    function  Get_JHK_Zymc(const pcdm,kldm,jhxz,tddw,zydm:string;out xznx,sfsf:string):string; //得到计划库中的专业名称
    procedure Close_Con_BDE;

  public
    { Public declarations }
    //xznx :string;
  end;

var
  ShengFenStrList:TStrings;
  MareData: TMareData;

implementation

uses uIniFile,uDM,Net,ActiveX,shellapi,shlObj;

{$R *.dfm}
procedure findall(Path,fn: String; var fileresult: Tstrings);
var
  fpath: String;
  fs: TsearchRec;
begin
  //fpath:=disk+path+'\*.*';
  fpath := path+'\*.*';
  if findfirst(fpath,faAnyFile,fs)=0 then
  begin
    if (fs.Name<>'.')and(fs.Name<>'..') then
      if (fs.Attr and faDirectory)=faDirectory then
         findall(path+'\'+fs.Name,fn,fileresult)
      else
      begin
         if UpperCase(PChar(fs.Name))=UpperCase(PChar(fn)) then
           fileresult.add(path+'\'+fs.Name+'('+inttostr(fs.Size)+')');
      end;

    while findnext(fs)=0 do
    begin
      if (fs.Name<>'.')and(fs.Name<>'..') then
        if (fs.Attr and faDirectory)=faDirectory then
           findall(path+'\'+fs.Name,fn,fileresult)
        else
         if UpperCase(PChar(fs.Name))=UpperCase(PChar(fn)) then
           fileresult.add(path+'\'+fs.Name+'('+inttostr(fs.Size)+')');
    end;
  end;
  findclose(fs);
end;

procedure FindAllDirectory(const Path:String; var fileresult: Tstrings);
var
  sPath,fpath: String;
  fs: TsearchRec;
begin
  if RightStr(Path,1)<>'\' then
    sPath := Path+'\'
  else
    sPath := Path;
  fpath := sPath+'*.*';
  //fpath := sPath+'NacuesCUniv.mdb';

  if findfirst(fpath,faAnyFile,fs)=0 then
  begin
    if (fs.Name<>'.')and(fs.Name<>'..') then
      if (fs.Attr and faDirectory)=faDirectory then
      begin
         fileresult.add(sPath+fs.Name);
         FindAllDirectory(sPath+fs.Name,fileresult);
      end;

    while FindNext(fs)=0 do
    begin
      if (fs.Name<>'.')and(fs.Name<>'..') then
        if (fs.Attr and faDirectory)=faDirectory then
        begin
           fileresult.add(sPath+fs.Name);
           FindAllDirectory(sPath+fs.Name,fileresult)
        end;
    end;
  end;
  findclose(fs);
end;

procedure GetTddDirList(const Path:string;out sList:TStrings);
var
  fn: String;
  i:Integer;
begin
  sList.Clear;
  FindAllDirectory(Path,sList);
  i := sList.Count - 1;
  while i>=0 do
  begin
    fn := sList[i]+'\NacuesCUniv.mdb'; //'\t_tdd.db';
    if not FileExists(fn) then
      sList.Delete(i);
    Dec(i);
  end;
end;

procedure TMareData.SelectSf(const iType: Integer);
var
  i:Integer;
begin
  for i := 0 to chklst_Sf.Items.Count - 1 do
  begin
    case iType of
      1:
        chklst_Sf.ItemChecked[i] := True;
      2:
        chklst_Sf.ItemChecked[i] := False;
      3:
        chklst_Sf.ItemChecked[i] := not chklst_Sf.ItemChecked[i];
    end;
  end;
end;

procedure TMareData.SetState;
var
  i: Integer;
begin
  for i := 0 to chklst_Sf.Items.Count - 1 do
  begin
    if chklst_Sf.ItemChecked[i] then
      Break;
  end;
  btn_OK.Enabled := i<=chklst_Sf.Items.Count-1;
  btn_Start.Enabled := i<=chklst_Sf.Items.Count-1;
end;

procedure TMareData.SpeedButton1Click(Sender: TObject);
//var
//  Dir: string;
begin
{
  Dir := '';
  if SelectDirectory('选择文件夹',LabeledEdit1.Text, Dir) then
  begin
    LabeledEdit1.Text := Dir;
    IniOptions.SYSSETINITPATH := Dir;
  IniOptions.SaveSettings(myIniFile);
  end;
}
end;

procedure TMareData.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

function TMareData.Init_Con_BDE(const sDir: string):Boolean;
begin
  Close_Con_BDE;
  Con_BDE.LoginPrompt := False;
  Con_BDE.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;'+
                              'Data Source='+sDir+'\NacuesCUniv.mdb;Persist Security Info=False';
  con_BDE.Connected := True;
  Result := Con_BDE.Connected;
end;

procedure TMareData.InitSfDirList;
var
  sPath: string;
  i: Integer;
begin
  sPath := GetKsDataPath;
  Caption := '录取考生数据采集【'+sPath+'】';

  gb_SfDirList.Clear;
  DM.GetSfDirList(gb_SfDirList);
  chklst_Sf.Items.Assign(gb_SfDirList);

  for i := 0 to gb_SfDirList.Count - 1 do
  begin
    gb_SfDirList.ValueFromIndex[i] := sPath+gb_SfDirList.ValueFromIndex[i];
  end;
end;

procedure TMareData.btn_OKClick(Sender: TObject);
var
  sf_name,sf_dir,sqlstr :string;
  ii:Integer;
  Update_Count,Insert_Count,Delete_Count :Integer;
  sKsh,sXlcc :string;
  procedure UpdateRecord;
  var
    oldksh,ksh,oldzydm,oldzymc,zydm,zymc,oldkszt,kszt,oldcj,cj:string;
  begin
    oldksh := cds_lqmd.FieldByName('考生号').AsString;
    oldzydm := cds_lqmd.FieldByName('录取代码').AsString;
    oldzymc := cds_lqmd.FieldByName('录取专业').AsString;
    oldkszt := cds_lqmd.FieldByName('考生状态').AsString;
    oldcj := cds_lqmd.FieldByName('成绩').AsString;

    ksh := qry_BDE.FieldByName('考生号').AsString;
    zydm := qry_BDE.FieldByName('录取代码').AsString;
    zymc := qry_BDE.FieldByName('录取专业').AsString;
    kszt := qry_BDE.FieldByName('考生状态').AsString;
    cj := qry_BDE.FieldByName('成绩').AsString;

    if (oldksh=ksh) and ((oldkszt<>kszt) or (oldzydm<>zydm) or (oldcj<>cj)) then
    begin
      //sqlstr := 'update lqmd set 录取代码='+quotedstr(zydm)+',录取专业='+quotedstr(zymc)+
      //          ' where 考生号='+quotedstr(sKsh)+' and 录取代码='+quotedstr(oldzydm);
      cds_lqmd.Edit;
      if oldcj<>cj then
        cds_lqmd.FieldByName('成绩').AsString := cj;

      if (kszt<>'5') and (oldkszt<>kszt) then
        cds_lqmd.FieldByName('考生状态').AsString := kszt;
      if (oldzydm<>zydm) then
      begin
        cds_lqmd.FieldByName('录取代码').AsString := zydm;
        cds_lqmd.FieldByName('录取专业').AsString := zymc;
        cds_lqmd.FieldByName('备注').AsString := cds_lqmd.FieldByName('备注').AsString+'system:'+FormatDateTime('mm-dd hh:nn:ss',Now)+':'+oldzydm+','+oldzymc+'->'+zydm+','+zymc+';';
        cds_lqmd.FieldByName('采集员').AsString := gb_Czy_ID;
        cds_lqmd.FieldByName('采集IP').AsString := GetLocalIpStr;
      end;
      cds_lqmd.Post;

      if (oldzydm<>zydm) and (zydm<>'') then
      begin
        cds_Log.Append;
        cds_Log.FieldByName('考生号').AsString := cds_lqmd.FieldByName('考生号').AsString;
        cds_Log.FieldByName('学历层次').AsString := cds_lqmd.FieldByName('学历层次').AsString;
        cds_Log.FieldByName('原录取代码').AsString := oldzydm;
        cds_Log.FieldByName('原录取专业').AsString := oldzymc;
        cds_Log.FieldByName('新录取代码').AsString := zydm;
        cds_Log.FieldByName('新录取专业').AsString := zymc;
        cds_Log.FieldByName('操作员').AsString := 'sys:'+gb_Czy_Id;
        cds_Log.FieldByName('操作时间').AsDateTime := Now;
        cds_Log.Post;
        Memo1.Lines.Add('专业变更：'+sKsh+','+oldzymc+'->'+zymc);
      end;

      Inc(Update_Count);
    end;
  end;
  procedure InsertRecord;
  var
    i:Integer;
    fldName:string;
  begin
    cds_lqmd.Append;
    cds_lqmd.FieldByName('Action_Time').Value := FormatDateTime('yyyy-mm-dd',Now);
    cds_lqmd.FieldByName('学历层次').Value := rg_XlCc.Items[rg_XlCc.ItemIndex];
    for i := 0 to cds_lqmd.FieldCount - 1 do
    begin
      if cds_lqmd.Fields[i].DataType=ftAutoInc then Continue;
      fldName := cds_lqmd.Fields[i].FieldName;
      if qry_BDE.FindField(fldName)<>nil then
      begin
        if not qry_BDE.FieldByName(fldName).IsNull then
          cds_lqmd.FieldByName(fldName).Value := qry_BDE.FieldByName(fldName).Value;
      end;
    end;
    cds_lqmd.FieldByName('录取专业规范名').Value := cds_lqmd.FieldByName('录取专业').Value;
    cds_lqmd.Post;
    Inc(Insert_Count);
  end;
  function MareDataFromParadox(const vSf,vSfDir,vXlcc :string;aMemo:TMemo=nil):Boolean;
  var
    i:Integer;
    fn,sqlstr,tdd_dir:string;
    dirList:TStrings;
    vTemp_Count,vTdd_Count:Integer;

    function KsIsExists(const Ksh:string):Boolean;
    begin
      Result := False;
      cds_lqmd.First;
      //UpdateProgressMax(cds_lqmd.RecordCount);
      while not cds_lqmd.Eof do
      begin
        //UpdateProgress(cds_lqmd.RecNo);
        if cds_lqmd.FieldByName('考生号').Value=Ksh then
        begin
          Result := True;
          Exit;
        end;
        cds_lqmd.Next;
      end;
      //UpdateProgress(cds_lqmd.RecordCount);
    end;
  begin
    dirList := TStringList.Create;
    try
      GetTddDirList(vSfDir,DirList); //得到包含 t_tdd.db 文件的目录列表
      for i:=0 to dirList.Count-1 do
      begin
        UpdateProgressTitle('正在采集【'+vSf+'】数据...');
        tdd_dir := dirList.Strings[i];
        fn := tdd_dir+'\t_tdd.db';
        if not FileExists(fn) then exit;
        if not Init_Con_BDE(tdd_dir) then
        begin
          MessageBox(Handle, PChar(vSf+'录取数据读取失败！是否正在进行该省的录取工作?   '+#13+'如果是的话，请关闭录取系统！'),'连接失败', MB_OK+MB_ICONSTOP);
          Exit;
        end;

        try
          sqlstr := vobj.GetDBMareSql(vSf,vXlcc);

          sqlstr := ReplaceStr(sqlstr,'『sf』',vSf);//替换SQL中的省份变量
          //sqlstr := ReplaceStr(sqlstr,'『xznx』',vXznx);//替换SQL中的学制年限变量
          sqlstr := ReplaceStr(sqlstr,'『czy』',gb_Czy_ID);//替换SQL中的采集员变量
          sqlstr := ReplaceStr(sqlstr,'『ip』',GetLocalIpStr());//替换SQL中的IP变量

          qry_BDE.Close;
          qry_BDE.SQL.Text := sqlstr;
          qry_BDE.Open;

          if qry_BDE.RecordCount>0 then
            UpdateProgressMax(qry_BDE.RecordCount);
          while not qry_BDE.Eof do
          begin
            UpdateProgress(qry_BDE.RecNo);
            sKsh := qry_BDE.FieldByName('考生号').AsString;
            //if cds_lqmd.Locate('考生号',sKsh,[]) then
            if KsIsExists(sKsh) then
              UpdateRecord
            else
              InsertRecord;
            qry_BDE.Next;
          end;
        except
          on e:Exception do
          begin
            if aMemo<>nil then
            begin
              aMemo.Lines.Add('操作出错！省份：'+vSf+'('+tdd_dir+')');
              aMemo.Lines.Add(e.Message);
              Result := False;
              Exit;
            end;
          end;
        end;

        vTdd_Count := Get_TDD_Count(vXlcc);
        vTemp_Count := qry_BDE.RecordCount;

        aMemo.Lines.Add(vSf+'：'+inttostr(vTemp_Count)+'/'+inttostr(vTdd_Count));

        Tdd_Count := Tdd_Count+ vTdd_Count;
        TddTemp_Count := TddTemp_Count+vTemp_Count;
      end;
      Result := True;
    finally
      dirList.Free;
    end;
  end;
begin
  if MessageBox(Handle,pchar('真的要采集本机的录取数据吗？这一操作可能要花费几秒　'+#13+
                             '至几十秒不等的时间！'+#13+'还要继续操作吗？'), '操作提示',
     MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then Exit;

  sXlcc := rg_XlCc.Items[rg_XlCc.ItemIndex];

  Screen.Cursor := crHourGlass;
  btn_OK.Enabled := False;
  try
    Memo1.Lines.Clear;

    Tdd_Count := 0;
    TddTemp_Count := 0;

    Update_Count := 0;
    Insert_Count := 0;

    sqlstr := 'select * from lqmd where 学历层次='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    //sqlstr := 'select * from lqmd order by 考生号';//where 学历层次='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_lqmd.XMLData := dm.OpenData(sqlstr);
    sqlstr := 'select top 0 * from 更换专业记录表';
    cds_Log.XMLData := dm.OpenData(sqlstr);

    ShowProgress('开始采集数据...');
    Memo1.Lines.Add('开始采集数据，请稍候....');

    for ii := 0 to chklst_Sf.Items.Count - 1 do   //创建tdd_temp.db临时文件
    begin
      if not chklst_Sf.ItemChecked[ii] then Continue;
      sf_name := chklst_Sf.Items.Names[ii];
      sf_dir := gb_SfDirList.Values[sf_name]+'\';

      MareDataFromParadox(sf_name,sf_dir,sXlcc,Memo1);
    end;

    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('总人数（合成表/原始表）：'+Inttostr(TddTemp_Count)+'/'+inttostr(Tdd_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('开始更新正式数据表....');

    UpdateProgressTitle('开始更新正式数据表....');
    if cds_lqmd.ChangeCount>0 then
      if not dm.UpdateData('考生号','select top 0 * from lqmd',cds_lqmd.Delta,False) then
      begin
        Memo1.Lines.Add('更新正式数据表失败！请检查后重试！');
        Exit;
      end else
      begin
        vobj.UpdateLqInfo(rg_XlCc.Items[rg_XlCc.ItemIndex]);
        if cds_Log.ChangeCount>0 then
        begin
          dm.UpdateData('Id','select top 0 * from 更换专业记录表',cds_Log.Delta,False);
        end;
      end;

    HideProgress;

    Memo1.Lines.Add('更新完成！');
    Memo1.Lines.Add('本次处理共新增记录：'+inttostr(Insert_Count)+'条，更新记录：'+inttostr(Update_Count)+'条，退档记录：'+inttostr(Delete_Count)+'条！');
    Memo1.Lines.Add(rg_XlCc.Items[rg_XlCc.ItemIndex]+'记录总数为：'+IntToStr(cds_lqmd.RecordCount));
    Memo1.Lines.SaveToFile('Log.Txt');
    Memo1.Lines.Add('日志文件存放于Log.Txt中！');

    MessageBox(Handle, '操作完成！考生数据文件已合并！　', '系统提示', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);

    btn_OK.Enabled := True;
  finally
    cds_lqmd.Close;
    cds_Log.Close;
    Close_Con_BDE;
    HideProgress;
    btn_OK.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMareData.btn_StartClick(Sender: TObject);
var
  sf_name,sf_dm,sf_dir,sqlstr :string;
  ii:Integer;
  Update_Count,Insert_Count,Delete_Count :Integer;
  sKsh,sXznx,sKsDataPath :string;
  dirList,sQList:TStrings;
  procedure UpdateRecord;
    function IsTelephone(const str:string):Boolean;
    var
      i,ii:Integer;
    begin
      ii := 0;
      for i := 1 to Length(str) do
      begin
        if str[i] in ['0'..'9'] then inc(ii);
      end;
      Result := ii>=7;
    end;
  var
    aSf,aXm,oldksh,ksh,oldzydm,oldzymc,zydm,zymc,oldkszt,kszt,oldcj,cj,oldtel,tel:string;
    pcdm,kldm,jhxz,tddw,xznx,sfsf,sTemp:string;
  begin

    //====================================================
{
    cds_lqmd.Edit;
    //cds_lqmd.FieldByName('计划性质代码').AsString := qry_BDE.FieldByName('计划性质代码').AsString;
    //cds_lqmd.FieldByName('投档单位代码').AsString := qry_BDE.FieldByName('投档单位代码').AsString;

    pcdm := cds_lqmd.FieldByName('批次代码').AsString;
    kldm := cds_lqmd.FieldByName('科类代码').AsString;
    jhxz := cds_lqmd.FieldByName('计划性质代码').AsString;
    tddw := cds_lqmd.FieldByName('投档单位代码').AsString;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业1').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('专业1名称').AsString <> zymc then
      cds_lqmd.FieldByName('专业1名称').AsString := zymc;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业2').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('专业2名称').AsString <> zymc then
      cds_lqmd.FieldByName('专业2名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业3').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('专业3名称').AsString <> zymc then
      cds_lqmd.FieldByName('专业3名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业4').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('专业4名称').AsString <> zymc then
      cds_lqmd.FieldByName('专业4名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业5').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('专业5名称').AsString <> zymc then
      cds_lqmd.FieldByName('专业5名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业6').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('专业6名称').AsString <> zymc then
      cds_lqmd.FieldByName('专业6名称').AsString := zymc;
    cds_lqmd.Post;
}
    //====================================================

    aSf := cds_lqmd.FieldByName('省份').AsString;
    aXm := cds_lqmd.FieldByName('考生姓名').AsString;
    pcdm := cds_lqmd.FieldByName('批次代码').AsString;
    kldm := cds_lqmd.FieldByName('科类代码').AsString;
    jhxz := cds_lqmd.FieldByName('计划性质代码').AsString;
    tddw := cds_lqmd.FieldByName('投档单位代码').AsString;

    oldksh := cds_lqmd.FieldByName('考生号').AsString;
    oldzydm := cds_lqmd.FieldByName('录取代码').AsString;
    oldzymc := cds_lqmd.FieldByName('录取专业').AsString;
    oldkszt := cds_lqmd.FieldByName('考生状态').AsString;
    oldcj := cds_lqmd.FieldByName('成绩').AsString;
    oldtel := cds_lqmd.FieldByName('联系电话').AsString;


    ksh := qry_BDE.FieldByName('考生号').AsString;
    zydm := qry_BDE.FieldByName('录取代码').Value;
    zydm := Trim(zydm);
    //zymc := qry_BDE.FieldByName('录取专业').AsString; //如果采集了所有考生信息的话，使用这个是非常、极端错误的
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,zydm,xznx,sfsf);
    kszt := Trim(qry_BDE.FieldByName('考生状态').AsString);
    cj := qry_BDE.FieldByName('成绩').AsString;
    tel := Trim(qry_BDE.FieldByName('联系电话').AsString);

    if (oldkszt='5') and (oldtel<>tel) and (not IsTelephone(oldtel)) then
    begin
      cds_lqmd.Edit;
      cds_lqmd.FieldByName('联系电话').AsString := tel;
      cds_lqmd.Post;
      Inc(Update_Count);
    end;
    //如果录取已结束或者已退档状态的考生，数据绝对不动！
    if (oldkszt='5') or (oldkszt='3') then
    begin
      if (kszt<>oldkszt) or (oldzydm<>zydm) then //检查退档后又重新重档的考生信息
      begin
        sTemp := format('　　　%s %-8s',[ksh,aXm]);
        if oldkszt='5' then
          sTemp := sTemp+' 录取后改动'
        else
          sTemp := sTemp+' 退档后重投';
        Memo1.Lines.Add(sTemp);
{
          sQList.Add(aSf+' '+ksh+' '+aXm+' 录取后改动？')
        else
          sQList.Add(aSf+' '+ksh+' '+aXm+' 退档后重投？');
}
      end;
      Exit;
    end;

    if ((oldkszt<>'5') and ((oldzydm<>zydm) or (oldzymc<>zymc))) or (oldkszt<>kszt) then
    begin
      //sqlstr := 'update lqmd set 录取代码='+quotedstr(zydm)+',录取专业='+quotedstr(zymc)+
      //          ' where 考生号='+quotedstr(sKsh)+' and 录取代码='+quotedstr(oldzydm);
      cds_lqmd.Edit;

      if (oldkszt<>'5') and (oldkszt<>kszt) then
        cds_lqmd.FieldByName('考生状态').AsString := kszt;
      if (oldkszt<>'5') and ((oldzydm<>zydm) or (oldzymc<>zymc)) then
      begin
        cds_lqmd.FieldByName('录取代码').AsString := zydm;
        cds_lqmd.FieldByName('录取专业').AsString := zymc;
        cds_lqmd.FieldByName('录取专业规范名').AsString := zymc;
        if zymc<>'' then
        begin
          cds_lqmd.FieldByName('学制年限').AsString := xznx;
          //cds_lqmd.FieldByName('是否师范').AsString := sfsf;
        end;
        //cds_lqmd.FieldByName('备注').AsString := cds_lqmd.FieldByName('备注').AsString+'system:'+FormatDateTime('mm-dd hh:nn:ss',Now)+':'+oldzydm+','+oldzymc+'->'+zydm+','+zymc+';';
        cds_lqmd.FieldByName('采集员').AsString := gb_Czy_ID;
        cds_lqmd.FieldByName('采集IP').AsString := GetLocalIpStr;
      end;
      cds_lqmd.Post;

      if (kszt='3') and (oldzydm<>zydm) and (zymc='') then //退档了
      begin
        cds_Log.Append;
        cds_Log.FieldByName('考生号').AsString := cds_lqmd.FieldByName('考生号').AsString;
        cds_Log.FieldByName('学历层次').AsString := cds_lqmd.FieldByName('学历层次').AsString;
        cds_Log.FieldByName('原录取代码').AsString := oldzydm;
        cds_Log.FieldByName('原录取专业').AsString := oldzymc;
        cds_Log.FieldByName('新录取代码').AsString := zydm;
        cds_Log.FieldByName('新录取专业').AsString := '退档';//zymc;
        cds_Log.FieldByName('操作员').AsString := 'sys:'+gb_Czy_Id;
        cds_Log.FieldByName('操作时间').AsDateTime :=  Now;//FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
        cds_Log.Post;
        Memo1.Lines.Add('　　　'+sKsh+' '+'专业变更:'+oldzymc+'->'+zymc);
      end;
      Inc(Update_Count);
    end;
    //  Inc(Update_Count);
  end;
  procedure InsertRecord;
  var
    i:Integer;
    fldName:string;
    pcdm,kldm,jhxz,tddw,zymc,xznx,sfsf:string;
  begin
    cds_lqmd.Append;
    cds_lqmd.FieldByName('Action_Time').Value := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
    cds_lqmd.FieldByName('学历层次').Value := rg_XlCc.Items[rg_XlCc.ItemIndex];
    for i := 0 to cds_lqmd.FieldCount - 1 do
    begin
      if cds_lqmd.Fields[i].DataType=ftAutoInc then Continue;
      fldName := cds_lqmd.Fields[i].FieldName;
      if qry_BDE.FindField(fldName)<>nil then
      begin
        if not qry_BDE.FieldByName(fldName).IsNull then
          cds_lqmd.FieldByName(fldName).Value := qry_BDE.FieldByName(fldName).Value;
      end;
    end;

    //=====================填充考生报考专业名称===============================
    pcdm := cds_lqmd.FieldByName('批次代码').Value;
    kldm := cds_lqmd.FieldByName('科类代码').Value;
    jhxz := cds_lqmd.FieldByName('计划性质代码').Value;
    tddw := cds_lqmd.FieldByName('投档单位代码').Value;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业1').Value,xznx,sfsf);
    cds_lqmd.FieldByName('专业1名称').AsString := zymc;
    cds_lqmd.FieldByName('学制年限').AsString := xznx;
    //cds_lqmd.FieldByName('是否师范').AsString := sfsf;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业2').Value,xznx,sfsf);
    cds_lqmd.FieldByName('专业2名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业3').Value,xznx,sfsf);
    cds_lqmd.FieldByName('专业3名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业4').Value,xznx,sfsf);
    cds_lqmd.FieldByName('专业4名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业5').Value,xznx,sfsf);
    cds_lqmd.FieldByName('专业5名称').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('专业6').Value,xznx,sfsf);
    cds_lqmd.FieldByName('专业6名称').AsString := zymc;

    if not cds_lqmd.FieldByName('录取代码').IsNull then
    begin
      zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('录取代码').Value,xznx,sfsf);
      cds_lqmd.FieldByName('录取专业').Value := zymc;
      if zymc<>'' then
      begin
        cds_lqmd.FieldByName('学制年限').AsString := xznx;
        //cds_lqmd.FieldByName('是否师范').AsString := sfsf;
      end;
    end else
    begin
      cds_lqmd.FieldByName('录取专业').Clear;
    end;

    //=====================填充考生报考专业名称===============================

    cds_lqmd.FieldByName('录取专业规范名').Value := cds_lqmd.FieldByName('录取专业').Value;
    cds_lqmd.Post;
    Inc(Insert_Count);
  end;

  function MareDataFromParadox(const vSf,vSfDm,vXlcc :string;aMemo:TMemo=nil):Boolean;
  var
    i:Integer;
    fn,sqlstr,tdd_dir,tdd_sfdm:string;
    vTemp_Count,vTdd_Count:Integer;
    
    function KsIsExists(const Ksh:string):Boolean;
    begin
      Result := False;
      cds_lqmd.First;
      //UpdateProgressMax(cds_lqmd.RecordCount);
      while not cds_lqmd.Eof do
      begin
        //UpdateProgress(cds_lqmd.RecNo);
        if cds_lqmd.FieldByName('考生号').Value=Ksh then
        begin
          Result := True;
          Exit;
        end;
        cds_lqmd.Next;
      end;
      //UpdateProgress(cds_lqmd.RecordCount);
    end;

    procedure CheckTdKsInfo; //检查退档考生信息
    var
      sKsh:string;
    begin
      //===============检查退档考生信息==============
      if qry_BDE_TDKS.Active then
      begin
        while not qry_BDE_TDKS.Eof do
        begin
          UpdateProgress(qry_BDE.RecNo);
          sKsh := qry_BDE_TDKS.FieldByName('考生号').AsString;
          //if cds_lqmd.Locate('考生号',sKsh,[]) then
          if KsIsExists(sKsh) and (cds_lqmd.FieldByName('考生状态').AsString<>'5') and
            (cds_lqmd.FieldByName('考生状态').AsString<>'3') then
          begin
            if cds_lqmd.FieldByName('考生状态').AsString<>qry_BDE_TDKS.FieldByName('考生状态').AsString then
            begin
              cds_lqmd.Edit;
              cds_lqmd.FieldByName('考生状态').AsString := qry_BDE_TDKS.FieldByName('考生状态').AsString;
              cds_lqmd.FieldByName('录取代码').Clear;
              cds_lqmd.FieldByName('录取专业').Clear;
              cds_lqmd.FieldByName('录取专业规范名').Clear;
              cds_lqmd.Post;

              cds_Log.Append;
              cds_Log.FieldByName('考生号').AsString := cds_lqmd.FieldByName('考生号').AsString;
              cds_Log.FieldByName('学历层次').AsString := cds_lqmd.FieldByName('学历层次').AsString;
              cds_Log.FieldByName('原录取代码').AsString := cds_lqmd.FieldByName('录取代码').AsString;
              cds_Log.FieldByName('原录取专业').AsString := cds_lqmd.FieldByName('录取专业').AsString;
              cds_Log.FieldByName('新录取代码').AsString := '';
              cds_Log.FieldByName('新录取专业').AsString := '退档';//zymc;
              cds_Log.FieldByName('操作员').AsString := 'sys:'+gb_Czy_Id;
              cds_Log.FieldByName('操作时间').AsDateTime :=  Now;//FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
              cds_Log.Post;
              if aMemo<>nil then
                aMemo.Lines.Add('退档：'+sKsh+' '+'退档');

              Inc(Delete_Count);
            end;
          end;
          //else
          //  InsertRecord;
          qry_BDE_TDKS.Next;
        end;
      end;
      //=========================================
    end;

    procedure CheckTddNotExistsKsInfo(const aSf:string); //检查lqmd表中有但t_tdd表中没有的记录
    var
      sKsh,sSf,sXm:string;
    begin
      //===============检查退档考生==============
      if qry_BDE.Active then
      begin
        if cds_lqmd.RecordCount>0 then
          UpdateProgressMax(cds_lqmd.RecordCount);
        cds_lqmd.First;
        while not cds_lqmd.Eof do
        begin
          UpdateProgress(cds_lqmd.RecNo);
          sKsh := cds_lqmd.FieldByName('考生号').AsString;
          sXm := cds_lqmd.FieldByName('考生姓名').AsString;
          sSf := cds_lqmd.FieldByName('省份').AsString;
          if sSf=aSf then
          begin
            if not qry_BDE.Locate('考生号',sKsh,[]) then
            begin
              if aMemo<>nil then
                aMemo.Lines.Add(' '+sKsh+' '+sXm+' T_TDD.DB表中不存在此考生')
              else
                sQList.Add(aSf+' '+sKsh+' '+sXm+' T_TDD.DB表中不存在此考生');
            end;
          end;

          cds_lqmd.Next;
        end;
      end;
      //=========================================
    end;

  begin
    try
      for i:=0 to dirList.Count-1 do //dirList为包含 t_tdd.db 文件的目录列表
      begin
        UpdateProgressTitle('正在采集【'+vSf+'】数据...');
        tdd_dir := dirList.Strings[i];
        fn := tdd_dir+'\NacuesCUniv.mdb'; //'\t_tdd.db';
        if not FileExists(fn) then Continue;
        if not Init_Con_BDE(tdd_dir) then
        begin
          MessageBox(Handle, PChar(vSf+'录取数据读取失败！是否正在进行该省的录取工作?   '+#13+'如果是的话，请关闭录取系统！'),'连接失败', MB_OK+MB_ICONSTOP);
          Exit;
        end;
        tdd_sfdm := Get_TDD_SfDm(vSf);// 得到当前目录下的省份代码
        if vSfDm<>tdd_sfdm then Continue; //不是我们想要采集的省份

        try
          sqlstr := vobj.GetDBMareSql(vSf,vXlcc);

          sqlstr := ReplaceStr(sqlstr,'『sf』',vSf);//替换SQL中的省份变量
          sqlstr := ReplaceStr(sqlstr,'『czy』',gb_Czy_ID);//替换SQL中的采集员变量
          sqlstr := ReplaceStr(sqlstr,'『ip』',GetLocalIpStr());//替换SQL中的IP变量

          qry_BDE.Close;
          qry_BDE.SQL.Text := sqlstr;
          qry_BDE.Open;

          qry_BDE_TDKS.Close;
          if FileExists(tdd_dir+'\NacuesCUniv.mdb') then
          begin
            sqlstr := vobj.GetTdksSql(vSf,vXlcc);
            sqlstr := ReplaceStr(sqlstr,'『sf』',vSf);//替换SQL中的省份变量
            sqlstr := ReplaceStr(sqlstr,'『czy』',gb_Czy_ID);//替换SQL中的采集员变量
            sqlstr := ReplaceStr(sqlstr,'『ip』',GetLocalIpStr());//替换SQL中的IP变量
            qry_BDE_TDKS.Close;
            qry_BDE_TDKS.SQL.Text := sqlstr;
            qry_BDE_TDKS.Open;
          end;

          if qry_BDE.RecordCount>0 then
            UpdateProgressMax(qry_BDE.RecordCount);

          vTdd_Count := Get_TDD_Count(vXlcc);
          vTemp_Count := qry_BDE.RecordCount;
          aMemo.Lines.Add(vSf+'：'+inttostr(vTemp_Count)+'/'+inttostr(vTdd_Count));
          Tdd_Count := Tdd_Count+ vTdd_Count;
          TddTemp_Count := TddTemp_Count+vTemp_Count;

          while not qry_BDE.Eof do
          begin
            UpdateProgress(qry_BDE.RecNo);
            sKsh := qry_BDE.FieldByName('考生号').AsString;
            //if cds_lqmd.Locate('考生号',sKsh,[]) then
            if KsIsExists(sKsh) then
            begin
              //if cds_lqmd.FieldbyName('学历层次').AsString=rg_XlCc.Items[rg_XlCc.ItemIndex] then
                UpdateRecord
              //else
              //  Memo1.Lines.Add('　　　'+sKsh+' 学历层次不一致');
            end
            else
              InsertRecord;
            qry_BDE.Next;
          end;
          CheckTdksInfo;//检查退档考生信息
          if chk1.Checked then
            CheckTddNotExistsKsInfo(sf_name);
        except
          on e:Exception do
          begin
            if aMemo<>nil then
            begin
              aMemo.Lines.Add('操作出错！省份：'+vSf+'('+tdd_dir+')');
              aMemo.Lines.Add(e.Message);
              Result := False;
              Exit;
            end;
          end;
        end;
      end;
      Result := True;
    finally
    end;
  end;
begin
  if MessageBox(Handle,pchar('真的要采集本机的录取数据吗？这一操作可能要花费几秒　'+#13+
                             '至几十秒不等的时间！'+#13+'还要继续操作吗？'), '操作提示',
     MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then Exit;

  sXznx := rg_XlCc.Items[rg_XlCc.ItemIndex];

  Screen.Cursor := crHourGlass;
  btn_Start.Enabled := False;
  dirList := TStringList.Create;
  sQList := TStringList.Create; //有疑问的记录

  sKsDataPath := GetKsDataPath; //考生数据目录
  GetTddDirList(sKsDataPath,dirList); //得到包含 t_tdd.db 文件的目录列表
  try
    Memo1.Lines.Clear;

    Tdd_Count := 0;
    TddTemp_Count := 0;

    Update_Count := 0;
    Insert_Count := 0;
    Delete_Count := 0;

    sqlstr := 'select * from lqmd where 学历层次='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_lqmd.XMLData := dm.OpenData(sqlstr);
    sqlstr := 'select top 0 * from 更换专业记录表';
    cds_Log.XMLData := dm.OpenData(sqlstr);

    ShowProgress('开始采集数据...');
    Memo1.Lines.Add('开始采集数据，请稍候....');

    for ii := 0 to chklst_Sf.Items.Count - 1 do   //创建tdd_temp.db临时文件
    begin
      if not chklst_Sf.ItemChecked[ii] then Continue;
      sf_name := chklst_Sf.Items.Names[ii];
      sf_dm := GetSfDmBySfMc(sf_name);
      sf_dir := gb_SfDirList.Values[sf_name]+'\';

      MareDataFromParadox(sf_name,sf_dm,rg_XlCc.Items[rg_XlCc.ItemIndex],Memo1);
    end;

    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('总人数（合成表/原始表）：'+Inttostr(TddTemp_Count)+'/'+inttostr(Tdd_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('开始更新正式数据表....');

    UpdateProgressTitle('开始更新正式数据表....');
    if cds_lqmd.ChangeCount>0 then
      if not dm.UpdateData('考生号','select top 0 * from lqmd',cds_lqmd.Delta,False) then
      begin
        Memo1.Lines.Add('更新正式数据表失败！请检查后重试！');
        Exit;
      end else
      begin
        vobj.UpdateLqInfo(rg_XlCc.Items[rg_XlCc.ItemIndex]);
        if cds_Log.ChangeCount>0 then
        begin
          dm.UpdateData('Id','select top 0 * from 更换专业记录表',cds_Log.Delta,False);
        end;
      end;

    HideProgress;

    Memo1.Lines.Add('更新完成！');
    Memo1.Lines.Add('本次处理共新增记录：'+inttostr(Insert_Count)+'条，更新记录：'+inttostr(Update_Count)+'条，退档记录：'+inttostr(Delete_Count)+'条！');
    Memo1.Lines.Add(rg_XlCc.Items[rg_XlCc.ItemIndex]+'记录总数为：'+IntToStr(cds_lqmd.RecordCount));
    if sQList.Count>0 then
    begin
      Memo1.Lines.Add('');
      Memo1.Lines.Add('===================================');
      Memo1.Lines.Add('以下考生信息有疑问，请手工核对：');
      Memo1.Lines.AddStrings(sQList);
      Memo1.Lines.Add('===================================');
    end;
    Memo1.Lines.SaveToFile('Log.Txt');
    Memo1.Lines.Add('日志文件存放于Log.Txt中！');

    MessageBox(Handle, '操作完成！考生数据文件已合并！　', '系统提示', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);

    btn_OK.Enabled := True;
  finally
    dirList.Free;
    sQList.Free;
    cds_lqmd.Close;
    cds_Log.Close;
    Close_Con_BDE;
    HideProgress;
    btn_Start.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMareData.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    //dm.GetSfDirList(sList);
    //chklst_Sf.Items.Assign(sList);

    InitSfDirList;

    dm.GetXlCcList(sList);
    rg_XlCc.Items.Assign(sList);

  finally
    sList.Free;
  end;
end;

procedure TMareData.LabeledEdit1Change(Sender: TObject);
begin
  //btn_OK.Enabled := LabeledEdit1.Text<>'';
end;

procedure TMareData.mni_Select2Click(Sender: TObject);
begin
  SelectSf(TMenuItem(Sender).Tag);
  SetState;
end;

procedure TMareData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  myIniFile.Free;
  Action := caFree;
end;

procedure TMareData.cds_lqmdBeforePost(DataSet: TDataSet);
var
  zymc:string;
begin
  zymc := DataSet.FieldByName('录取专业规范名').AsString;
  zymc := StringReplace(zymc,'(','（',[rfReplaceAll, rfIgnoreCase]);
  zymc := StringReplace(zymc,')','）',[rfReplaceAll, rfIgnoreCase]);
  DataSet.FieldByName('录取专业规范名').AsString := zymc;
end;

procedure TMareData.chk1Click(Sender: TObject);
begin
  if chk1.Checked then
  begin
    if Application.MessageBox('真的要检查采集库存在但t_tdd表中不存在的考生记录吗？　', '系统提示', MB_YESNO +
      MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
          chk1.Checked := False;
  end;
end;

procedure TMareData.chklst_SfChange(Sender: TObject; Index: Integer;
  NewState: TCheckBoxState);
begin
  SetState;
end;

procedure TMareData.Close_Con_BDE;
begin
  Con_BDE.Close;
  Con_BDE.Connected := False;
end;

procedure TMareData.btn_CjClick(Sender: TObject);
{
var
  tmp_sf,sf,kk,ss,InsertSql,path,dir,fn :string;
  DirList:TStrings;
  iCount,i:Integer;
  v_tdd_Count,v_tddtemp_Count,Update_Count,Insert_Count,Delete_Count :Integer;
  action_time,sf_str :string;
}
begin
{
  action_time := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
  if MessageBox(Handle,
    '真的要把导出的考生外语成绩吗？　　', '成绩导出提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  try
    Screen.Cursor := crHourGlass;
    DirList := TStringList.Create;
    Dir := LabeledEdit1.Text;
    FindAllDirectory(Dir,DirList);
    Tdd_Count := 0;
    TddTemp_Count := 0;
    sf_str := '';

    path := ExtractFileDir(Application.ExeName);
    fn := path+'\lqmd.mdb';

    if not FileExists(fn) then
       CopyFile(PChar(path+'\template.dll'),PChar(fn),False);

    //Connect_Access(path);

    Memo1.Lines.Clear;

    for i:=0 to DirList.Count-1 do
    begin
      ss := DirList.Strings[i];
      fn := ss+'\t_tdd.dbf';
      if FileExists(fn) then
      begin
        if not Connect_DBF(ss) then
        begin
          MessageBox(Handle, 'DBF数据库连接失败！   ','DBF连接失败', MB_OK+MB_ICONSTOP);
          Exit;
        end;

        v_tdd_Count := Get_DBF_Count('t_tdd.dbf');
        Tdd_Count := Tdd_Count+v_tdd_Count;

        fn := ss+'\tddCjtemp.dbf';
        if FileExists(fn) then
           DeleteFile(fn);

        try
          kk := tsqlstr;
          tmp_sf := GetSFStr(ss);
          sf := QuotedStr(tmp_sf);

          if Pos(sf,sf_str)=0 then
          begin
             if sf_str = '' then
                sf_str := sf
             else
                sf_str := sf_str+','+sf;
          end;

          sf := ' '+sf+' as 省份,';
          Insert(sf,kk,7);
          kk := 'select ksh as 考生号,'+GetEnglishCjdm+' into tddCjtemp.dbf from t_tdd';
          dm.con_DBF.Execute(kk); //生成一个名为tddtemp.dbf的临时文件
        except
          on e:Exception do MessageBox(Handle,PChar('创建临时文件出错！'+sf+#13+e.Message),
            '创建临时文件出错！　　', MB_OK + MB_ICONSTOP);
        end;

        v_tddtemp_Count := Get_DBF_Count('tddCjtemp.dbf');
        TddTemp_Count := TddTemp_Count+v_tddtemp_Count;
        Memo1.Lines.Add(ss+'\临时表创建成功！'+inttostr(v_tdd_Count)+'/'+inttostr(v_tddtemp_Count));

        Application.ProcessMessages;
      end;
    end;
    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('总人数（原始表/合成表）：'+Inttostr(Tdd_Count)+'/'+inttostr(TddTemp_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('开始更新正式数据表....');
    try
      dm.con_Access.Execute('drop table tt');
    except
    end;
    dm.con_Access.Execute('select * into tt from EnglishCj where 1=0');

    for i:=0 to DirList.Count-1 do
    begin
      ss := DirList.Strings[i];
      fn := ss+'\tddCjtemp.dbf';
      if FileExists(fn) then
      begin
        if not Connect_DBF(ss) then
        begin
          MessageBox(Handle, 'DBF数据库连接失败！   ','DBF连接失败', MB_OK+MB_ICONSTOP);
          Exit;
        end;

        InsertSql := 'Insert into tt select * from tddCjtemp in '+quotedstr(ss)+' '+quotedstr('dbase 5.0;');
        try
          dm.con_Access.Execute(InsertSql);
        except
          ShowMessage('Insert 失败！'+InsertSql);
        end;
        //Memo1.Lines.Add(ss+' 考生数据已导入！');
        Memo1.Lines.Text := Memo1.Lines.Text+'>>>';
        Application.ProcessMessages;
        //Memo1.Refresh;
      end;
    end;
    InsertSql := 'delete from EnglishCj';
    dm.con_Access.Execute(InsertSql);

    InsertSql := 'Insert into EnglishCj select * from tt';
    dm.con_Access.Execute(InsertSql,Insert_Count);

    Memo1.Lines.Add('处理完成！');
    Memo1.Lines.SaveToFile('CjLog.Txt');
    Memo1.Lines.Add('日志文件存放于CjLog.Txt中！');

    btn_OK.Enabled := True;
  finally
    dm.qry_Access.Requery();
    try
      dm.con_Access.Execute('drop table tt');
    except
    end;
    Screen.Cursor := crDefault;
    DirList.Free;
  end;
}
end;

function TMareData.GetEnglishCjdm: string;
//var
//  vv:Variant;
begin
{
  vv := dm.con_DBF.Execute('select cjxdm from td_cjxdm where cjxmc in ('+quotedstr('外语')+','+quotedstr('外语成绩')+')').Fields[0].Value;
  Result := VarToStr(vv);

  if Result = '' then
    Result := QuotedStr('0.0')
  else
    Result := 'Gkcjx'+Result;
  Result := Result + ' as 外语成绩 ';
}
end;

function TMareData.Get_JHK_Zymc(const pcdm, kldm, jhxz, tddw,
  zydm: string;out xznx,sfsf:string): string;
var
  sqlstr:string;
begin
  try
    Result := '';
    sqlstr := 'select zymc,xznx,sfsf from t_jhk'+
              ' where strcomp(trim(pcdm),'+quotedstr(pcdm)+',0)=0'+
              ' and strcomp(trim(kldm),'+quotedstr(kldm)+',0)=0'+
              ' and strcomp(trim(jhxz),'+quotedstr(jhxz)+',0)=0'+
              ' and strcomp(trim(tddw),'+quotedstr(tddw)+',0)=0'+
              ' and strcomp(trim(zydh),'+quotedstr(zydm)+',0)=0';
    qry_Temp.Close;
    qry_Temp.SQL.Text := sqlstr;
    qry_Temp.Open;
    Result := qry_Temp.Fields[0].AsString;
    xznx := qry_Temp.Fields[1].AsString;
    sfsf := qry_Temp.Fields[2].AsString;
  finally
    qry_Temp.Close;
  end;
end;

function TMareData.Get_TDD_Count(const sXlcc: string): Integer;
var
  sqlstr:string;
begin
  try
    Result := 0;
    sqlstr := vobj.GetTddCountSql(sXlcc);
    qry_Temp.Close;
    qry_Temp.SQL.Text := sqlstr;
    qry_Temp.Open;
    Result := qry_Temp.Fields[0].Value;
  finally
    qry_Temp.Close;
  end;
end;

function TMareData.Get_TDD_SfDm(const sfmc:string=''): string;
var
  sqlstr:string;
begin
  try
    Result := '';
    sqlstr := 'select ksh,zkzh from t_tdd';
    qry_Temp.Close;
    qry_Temp.SQL.Text := sqlstr;
    qry_Temp.Open;
    if sfmc<>'广东' then
    begin
      if qry_Temp.Fields[0].AsString<>'' then
        Result := Copy(qry_Temp.Fields[0].AsString,3,2);
    end else
    begin
      if qry_Temp.Fields[1].AsString<>'' then
        Result := Copy(qry_Temp.Fields[1].AsString,3,2);
    end;
  finally
    qry_Temp.Close;
  end;
end;

initialization
  ShengFenStrList := TSTringList.Create;

finalization
  FreeAndNil(ShengFenStrList);

end.
