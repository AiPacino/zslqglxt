unit uMareData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls,FileCtrl, DB, ADODB,StrUtils,
  IniFiles, StatusBarEx, RzPanel, RzRadGrp, RzLstBox, RzChkLst,CnProgressFrm,
  DBClient, Menus, DBTables;

type
  TMareData = class(TForm)
    GroupBox1: TGroupBox;
    chklst_Sf: TRzCheckList;
    pnl_Bottom: TPanel;
    chk1: TCheckBox;
    btn_OK: TBitBtn;
    btn_Photo: TBitBtn;
    btn_Cj: TBitBtn;
    btn_Exit: TButton;
    chk_Jx: TCheckBox;
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
    Con_BDE: TDatabase;
    qry_BDE: TQuery;
    qry_Update: TADOQuery;
    qry_Access: TADOQuery;
    con_Access: TADOConnection;
    con_DBF: TADOConnection;
    qry_DBF: TADOQuery;
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
  private
    { Private declarations }
    myIniFile:TInifile;
    CheckedSfList:TStrings;
    tsqlstr:string;
    Tdd_Count,TddTemp_Count:Integer;
    function GetEnglishCjdm:string; //得到英语成绩代码
    procedure InitSfDirList;
    procedure SelectSf(const iType:Integer);
    procedure SetState;

    function Init_Con_BDE(const sDir: string):Boolean;
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
function Connect_Access(const DataPath: string): Boolean;
begin
  try
    dm.con_Access.Close;
    dm.con_Access.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;'
                             +'Data Source='+DataPath+'\lqmd.mdb;Persist Security Info=False';
    dm.con_Access.Open;
  finally
    Result := dm.con_Access.Connected;
  end;
end;

function Connect_DBF(const DataPath: string;const IsParadoxDB:Boolean=True): Boolean;
begin
  try
    con_DBF.Close;
    //采用非DNS连接数据库
    //con_DBF.ConnectionString:='PROVIDER=MSDASQL;Persist Security Info=False;'
    //                         +'DRIVER={Microsoft Visual Foxpro Driver};'
    //                         +'SourceDB='+DataPath+';SourceType=DBF';
    if IsParadoxDB then
      con_DBF.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+DataPath
                               +';Extended Properties=Paradox 7.x;Persist Security Info=False'
    else
      con_DBF.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+DataPath
                               +';Extended Properties=dbase 5.0;Persist Security Info=False';
    con_DBF.Open;
  finally
    Result := con_DBF.Connected;
  end;
end;

function Get_DBF_Count(const tb_name: string): Integer;
var
  ii:integer;
begin
   ii := con_DBF.Execute('select count(*) from '+tb_name).Fields[0].Value;
   Result := ii;
end;

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
    fn := sList[i]+'\t_tdd.db';
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
      break;
  end;
  btn_OK.Enabled := i<=chklst_Sf.Items.Count-1;
  btn_Photo.Enabled := btn_OK.Enabled;
  btn_Cj.Enabled := btn_OK.Enabled;
end;

procedure TMareData.SpeedButton1Click(Sender: TObject);
var
  Dir: string;
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
  Con_BDE.DatabaseName := 'MyBDE';
  Con_BDE.DriverName := 'STANDARD';
  Con_BDE.Params.Values['DEFAULT DRIVER'] := 'PARADOX';
  Con_BDE.Params.Values['PATH'] := sDir;
  con_BDE.Open;
  Result := Con_BDE.Connected;
end;

procedure TMareData.InitSfDirList;
var
  sPath: string;
  ZslqxtDataDir:string;
  i: Integer;
begin
  sPath := GetSpecialFolderDir(CSIDL_PERSONAL);//我的文档目录
  if SysUtils.Win32MajorVersion>=6 then //Windows 2003 以后的版本
    sPath := sPath+'\.NacuesCStorage\'
  else
    sPath := 'C:\Program Files\NacuesC\';
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

  function MareDataFromParadox(const vSf,vSfDir,vXznx :string;aMemo:TMemo=nil):Boolean;
  var
    i:Integer;
    fn,sqlstr,sfstr,tdd_dir:string;
    dirList:TStrings;
    vTemp_Count,vTdd_Count:Integer;
  begin
    dirList:=TStringList.Create;
    try
      GetTddDirList(vSfDir,DirList); //得到包含 t_tdd.db 文件的目录列表
      for i:=0 to dirList.Count-1 do
      begin
        UpdateProgressTitle('正在合并'+vSf+'...');
        tdd_dir := dirList.Strings[i];
        fn := tdd_dir+'\t_tdd.db';
        if not FileExists(fn) then exit;
        if not Connect_DBF(tdd_dir) then
        begin
          MessageBox(Handle, '录取源数据库连接失败！   ','连接失败', MB_OK+MB_ICONSTOP);
          Exit;
        end;

        fn := tdd_dir+'\tddtemp.db';
        if FileExists(fn) then DeleteFile(fn);

        try
          sqlstr := tsqlstr;

          //sfstr := ' '+QuotedStr(vSf)+' as 省份,';
          //Insert(sfstr,sqlstr,7);
          sqlstr := ReplaceStr(sqlstr,'『sf』',vSf);//替换SQL中的省份变量
          sqlstr := ReplaceStr(sqlstr,'『xznx』',vXznx);//替换SQL中的学制年限变量

          con_DBF.Execute(sqlstr); //生成一个名为tddtemp.dbf的临时文件

          sqlstr := 'Insert into lqmd select * from tddtemp in '+quotedstr(tdd_dir)+' '+quotedstr('Paradox 7.x;');
          dm.con_Access.Execute(sqlstr);

        except
          on e:Exception do
          begin
            if aMemo<>nil then
            begin
              //MessageBox(Handle, pchar('操作出错！'+vSf+'　　'),PChar('创建临时文件出错！'+#13+e.Message), MB_OK + MB_ICONSTOP);
              aMemo.Lines.Add('操作出错！省份：'+vSf+'('+tdd_dir+')');
              aMemo.Lines.Add('出错SQL语句：'+sqlstr);
              aMemo.Lines.Add(e.Message);
              Result := False;
              Exit;
            end;
          end;
        end;

        vTdd_Count := Get_DBF_Count('t_tdd.db');
        vTemp_Count := Get_DBF_Count('tddtemp.db');

        aMemo.Lines.Add(vSf+'：'+inttostr(vTemp_Count)+'/'+inttostr(vTdd_Count));
        //aMemo.Lines.Add('路径：'+tdd_dir);

        Tdd_Count := Tdd_Count+ vTdd_Count;
        TddTemp_Count := TddTemp_Count+vTemp_Count;
      end;
      Result := True;
    finally
      dirList.Free;
    end;
  end;
var
  sf_name,sf_dir,InsertSql,sqlstr,Path,fn :string;
  i,ii:Integer;
  v_tdd_Count,v_tddtemp_Count,Update_Count,Insert_Count,Delete_Count :Integer;
  sKsh,sXznx,sXzWhere :string;
  procedure UpdateRecord;
  var
    oldzydm,oldzymc,zydm,zymc:string;
  begin
    oldzydm := cds_lqmd.FieldByName('录取代码').AsString;
    oldzymc := cds_lqmd.FieldByName('录取专业').AsString;
    zydm := dm.qry_Access.FieldByName('录取代码').AsString;
    zymc := dm.qry_Access.FieldByName('录取专业').AsString;

    if oldzydm<>zydm then
    begin
      //sqlstr := 'update lqmd set 录取代码='+quotedstr(zydm)+',录取专业='+quotedstr(zymc)+
      //          ' where 考生号='+quotedstr(sKsh)+' and 录取代码='+quotedstr(oldzydm);
      cds_lqmd.Edit;
      cds_lqmd.FieldByName('录取代码').AsString := zydm;
      cds_lqmd.FieldByName('录取专业').AsString := zymc;
      cds_lqmd.FieldByName('备注').AsString := cds_lqmd.FieldByName('备注').AsString+'system:'+FormatDateTime('mm-dd hh:nn:ss',Now)+':'+oldzydm+','+oldzymc+'->'+zydm+','+zymc+';';
      cds_lqmd.Post;

      cds_Log.Append;
      cds_Log.FieldByName('考生号').AsString := cds_lqmd.FieldByName('考生号').AsString;
      cds_Log.FieldByName('学历层次').AsString := cds_lqmd.FieldByName('学历层次').AsString;
      cds_Log.FieldByName('原录取代码').AsString := oldzydm;
      cds_Log.FieldByName('原录取专业').AsString := oldzymc;
      cds_Log.FieldByName('新录取代码').AsString := zydm;
      cds_Log.FieldByName('新录取专业').AsString := zymc;
      cds_Log.FieldByName('操作员').AsString := 'system';
      cds_Log.FieldByName('操作时间').AsDateTime := Now;
      cds_Log.Post;

      Memo1.Lines.Add('专业变更：'+sKsh+','+oldzymc+'->'+zymc);

      Inc(Update_Count);
    end;
  end;
  procedure InsertRecord;
  var
    i:Integer;
    fldName:string;
  begin
    cds_lqmd.Append;
    cds_lqmd.FieldByName('Action_Time').Value := Now;
    cds_lqmd.FieldByName('学历层次').Value := rg_XlCc.Items[rg_XlCc.ItemIndex];
    for i := 0 to cds_lqmd.FieldCount - 1 do
    begin
      if cds_lqmd.Fields[i].DataType=ftAutoInc then Continue;
      fldName := cds_lqmd.Fields[i].FieldName;
      if dm.qry_Access.FindField(fldName)<>nil then
        cds_lqmd.FieldByName(fldName).Value := dm.qry_Access.FieldByName(fldName).Value;
    end;
    cds_lqmd.FieldByName('录取专业规范名').Value := cds_lqmd.FieldByName('录取专业').Value;
    cds_lqmd.Post;
    Inc(Insert_Count);
  end;
begin
  if MessageBox(Handle,'真的要采集本机的录取数据吗？这一操作可能要花费几秒至几十秒不等的时间！　　', '操作提示',
     MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then Exit;

  sXznx := rg_XlCc.Items[rg_XlCc.ItemIndex];
  tsqlstr := vobj.GetDBMareSql('%',sXznx);

  if Pos('本科',sXznx)>0 then
    sXznx := '4'
  else if Pos('专科',sXznx)>0 then
    sXznx := '3'
  else //预科
    sXznx := '1';

  Screen.Cursor := crHourGlass;
  try
    Tdd_Count := 0;
    TddTemp_Count := 0;

    Memo1.Lines.Clear;

    fn := ExtractFilePath(ParamStr(0))+'lqmd.mdb';
    DeleteFile(fn);
    if not CopyFile(PChar(ExtractFilePath(ParamStr(0))+'\template.dll'),PChar(fn),False) then
    begin
       Memo1.Lines.Add('复制template.dll至lqmd.mdb失败！');
       Exit;
    end;

    if not Connect_Access(ExtractFileDir(ParamStr(0))) then Exit;

    ShowProgress('开始合并数据...',chklst_Sf.Items.Count-1);
    Memo1.Lines.Add('开始合并数据，请稍候....');
    
    for ii := 0 to chklst_Sf.Items.Count - 1 do   //创建tdd_temp.db临时文件
    begin
      if not chklst_Sf.ItemChecked[ii] then Continue;
      sf_name := chklst_Sf.Items.Names[ii];
      sf_dir := gb_SfDirList.Values[sf_name]+'\';

      MareDataFromParadox(sf_name,sf_dir,sXzNx,Memo1);
      UpdateProgress(ii);
    end;

    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('总人数（合成表/原始表）：'+Inttostr(TddTemp_Count)+'/'+inttostr(Tdd_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('开始更新正式数据表....');

    sqlstr := 'select * from lqmd where 学历层次='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_lqmd.XMLData := dm.OpenData(sqlstr);

    sqlstr := 'select top 0 * from 更换专业记录表 where 学历层次='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_Log.XMLData := dm.OpenData(sqlstr);

    dm.qry_Access.Close;
    sqlstr := 'select * from lqmd where 学制年限='+quotedstr(sXznx)+' order by 省份,批次代码,科类代码,录取代码,投档成绩 desc';
    dm.qry_Access.SQL.Text := sqlstr;
    dm.qry_Access.Open;

    UpdateProgressTitle('正在更新....');
    UpdateProgressMax(dm.qry_Access.RecordCount);
    Update_Count := 0;
    Insert_Count := 0;
    while not dm.qry_Access.Eof do
    begin
      UpdateProgress(dm.qry_Access.RecNo);
      sKsh := dm.qry_Access.FieldByName('考生号').AsString;
      if cds_lqmd.Locate('考生号',sKsh,[]) then
        UpdateRecord
      else
        InsertRecord;
      dm.qry_Access.Next;
    end;
    UpdateProgressTitle('正在保存....');
    if cds_lqmd.ChangeCount>0 then
      if not dm.UpdateData('考生号','select top 0 * from lqmd',cds_lqmd.Delta,False) then
      begin
        //HideProgress;
        Memo1.Lines.Add('数据上传失败！请检查后重试！');
        //MessageBox(Handle, '数据上传失败！请检查后重试！　', '系统提示', MB_OK +
        //  MB_ICONERROR + MB_TOPMOST);
        Exit;
      end else
      begin
        if cds_Log.ChangeCount>0 then
        begin
          dm.UpdateData('Id','select top 0 * from 更换专业记录表',cds_Log.Delta,False);
        end;
      end;

    HideProgress;

    Memo1.Lines.Add('更新完成！');
    Memo1.Lines.Add('本次处理共新增记录：'+inttostr(Insert_Count)+'条，更改专业：'+inttostr(Update_Count)+'条，退档记录：'+inttostr(Delete_Count)+'条！');
    Memo1.Lines.Add(rg_XlCc.Items[rg_XlCc.ItemIndex]+'记录总数为：'+IntToStr(cds_lqmd.RecordCount));
    Memo1.Lines.SaveToFile('Log.Txt');
    Memo1.Lines.Add('日志文件存放于Log.Txt中！');

    MessageBox(Handle, '操作完成！考生数据文件已合并！　', '系统提示', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);

    btn_OK.Enabled := True;
  finally
    cds_lqmd.Close;
    cds_Log.Close;
    dm.con_Access.Close;
    con_DBF.Close;
    HideProgress;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMareData.FormCreate(Sender: TObject);
var
  s:string;
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

procedure TMareData.chk1Click(Sender: TObject);
begin
  if chk1.Checked then
  begin
    if Application.MessageBox('警告！' + #13#10 +
      '　　这是一个非常危险的操作！而且要求导出的源数据目录中存放　　' +
      #13#10 + '了所有的考生数据，否则将把源数据目录中不存在的考生均处理为' +
      #13#10 + '退档考生！！' + #13#10#13#10 +
      '　　还要自动检查退档考生信息吗？　　', '警告提示', MB_YESNO +
      MB_ICONWARNING + MB_DEFBUTTON2) = IDNO then
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
  Con_BDE.CloseDataSets;
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
          con_DBF.Execute(kk); //生成一个名为tddtemp.dbf的临时文件
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
  vv := con_DBF.Execute('select cjxdm from td_cjxdm where cjxmc in ('+quotedstr('外语')+','+quotedstr('外语成绩')+')').Fields[0].Value;
  Result := VarToStr(vv);

  if Result = '' then
    Result := QuotedStr('0.0')
  else
    Result := 'Gkcjx'+Result;
  Result := Result + ' as 外语成绩 ';
}
end;

initialization
  ShengFenStrList := TSTringList.Create;

finalization
  FreeAndNil(ShengFenStrList);

end.
