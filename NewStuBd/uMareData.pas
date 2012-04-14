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
    function GetEnglishCjdm:string; //�õ�Ӣ��ɼ�����
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
    //���÷�DNS�������ݿ�
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
  if SelectDirectory('ѡ���ļ���',LabeledEdit1.Text, Dir) then
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
  sPath := GetSpecialFolderDir(CSIDL_PERSONAL);//�ҵ��ĵ�Ŀ¼
  if SysUtils.Win32MajorVersion>=6 then //Windows 2003 �Ժ�İ汾
    sPath := sPath+'\.NacuesCStorage\'
  else
    sPath := 'C:\Program Files\NacuesC\';
  Caption := '¼ȡ�������ݲɼ���'+sPath+'��';

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
      GetTddDirList(vSfDir,DirList); //�õ����� t_tdd.db �ļ���Ŀ¼�б�
      for i:=0 to dirList.Count-1 do
      begin
        UpdateProgressTitle('���ںϲ�'+vSf+'...');
        tdd_dir := dirList.Strings[i];
        fn := tdd_dir+'\t_tdd.db';
        if not FileExists(fn) then exit;
        if not Connect_DBF(tdd_dir) then
        begin
          MessageBox(Handle, '¼ȡԴ���ݿ�����ʧ�ܣ�   ','����ʧ��', MB_OK+MB_ICONSTOP);
          Exit;
        end;

        fn := tdd_dir+'\tddtemp.db';
        if FileExists(fn) then DeleteFile(fn);

        try
          sqlstr := tsqlstr;

          //sfstr := ' '+QuotedStr(vSf)+' as ʡ��,';
          //Insert(sfstr,sqlstr,7);
          sqlstr := ReplaceStr(sqlstr,'��sf��',vSf);//�滻SQL�е�ʡ�ݱ���
          sqlstr := ReplaceStr(sqlstr,'��xznx��',vXznx);//�滻SQL�е�ѧ�����ޱ���

          con_DBF.Execute(sqlstr); //����һ����Ϊtddtemp.dbf����ʱ�ļ�

          sqlstr := 'Insert into lqmd select * from tddtemp in '+quotedstr(tdd_dir)+' '+quotedstr('Paradox 7.x;');
          dm.con_Access.Execute(sqlstr);

        except
          on e:Exception do
          begin
            if aMemo<>nil then
            begin
              //MessageBox(Handle, pchar('��������'+vSf+'����'),PChar('������ʱ�ļ�����'+#13+e.Message), MB_OK + MB_ICONSTOP);
              aMemo.Lines.Add('��������ʡ�ݣ�'+vSf+'('+tdd_dir+')');
              aMemo.Lines.Add('����SQL��䣺'+sqlstr);
              aMemo.Lines.Add(e.Message);
              Result := False;
              Exit;
            end;
          end;
        end;

        vTdd_Count := Get_DBF_Count('t_tdd.db');
        vTemp_Count := Get_DBF_Count('tddtemp.db');

        aMemo.Lines.Add(vSf+'��'+inttostr(vTemp_Count)+'/'+inttostr(vTdd_Count));
        //aMemo.Lines.Add('·����'+tdd_dir);

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
    oldzydm := cds_lqmd.FieldByName('¼ȡ����').AsString;
    oldzymc := cds_lqmd.FieldByName('¼ȡרҵ').AsString;
    zydm := dm.qry_Access.FieldByName('¼ȡ����').AsString;
    zymc := dm.qry_Access.FieldByName('¼ȡרҵ').AsString;

    if oldzydm<>zydm then
    begin
      //sqlstr := 'update lqmd set ¼ȡ����='+quotedstr(zydm)+',¼ȡרҵ='+quotedstr(zymc)+
      //          ' where ������='+quotedstr(sKsh)+' and ¼ȡ����='+quotedstr(oldzydm);
      cds_lqmd.Edit;
      cds_lqmd.FieldByName('¼ȡ����').AsString := zydm;
      cds_lqmd.FieldByName('¼ȡרҵ').AsString := zymc;
      cds_lqmd.FieldByName('��ע').AsString := cds_lqmd.FieldByName('��ע').AsString+'system:'+FormatDateTime('mm-dd hh:nn:ss',Now)+':'+oldzydm+','+oldzymc+'->'+zydm+','+zymc+';';
      cds_lqmd.Post;

      cds_Log.Append;
      cds_Log.FieldByName('������').AsString := cds_lqmd.FieldByName('������').AsString;
      cds_Log.FieldByName('ѧ�����').AsString := cds_lqmd.FieldByName('ѧ�����').AsString;
      cds_Log.FieldByName('ԭ¼ȡ����').AsString := oldzydm;
      cds_Log.FieldByName('ԭ¼ȡרҵ').AsString := oldzymc;
      cds_Log.FieldByName('��¼ȡ����').AsString := zydm;
      cds_Log.FieldByName('��¼ȡרҵ').AsString := zymc;
      cds_Log.FieldByName('����Ա').AsString := 'system';
      cds_Log.FieldByName('����ʱ��').AsDateTime := Now;
      cds_Log.Post;

      Memo1.Lines.Add('רҵ�����'+sKsh+','+oldzymc+'->'+zymc);

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
    cds_lqmd.FieldByName('ѧ�����').Value := rg_XlCc.Items[rg_XlCc.ItemIndex];
    for i := 0 to cds_lqmd.FieldCount - 1 do
    begin
      if cds_lqmd.Fields[i].DataType=ftAutoInc then Continue;
      fldName := cds_lqmd.Fields[i].FieldName;
      if dm.qry_Access.FindField(fldName)<>nil then
        cds_lqmd.FieldByName(fldName).Value := dm.qry_Access.FieldByName(fldName).Value;
    end;
    cds_lqmd.FieldByName('¼ȡרҵ�淶��').Value := cds_lqmd.FieldByName('¼ȡרҵ').Value;
    cds_lqmd.Post;
    Inc(Insert_Count);
  end;
begin
  if MessageBox(Handle,'���Ҫ�ɼ�������¼ȡ��������һ��������Ҫ���Ѽ�������ʮ�벻�ȵ�ʱ�䣡����', '������ʾ',
     MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then Exit;

  sXznx := rg_XlCc.Items[rg_XlCc.ItemIndex];
  tsqlstr := vobj.GetDBMareSql('%',sXznx);

  if Pos('����',sXznx)>0 then
    sXznx := '4'
  else if Pos('ר��',sXznx)>0 then
    sXznx := '3'
  else //Ԥ��
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
       Memo1.Lines.Add('����template.dll��lqmd.mdbʧ�ܣ�');
       Exit;
    end;

    if not Connect_Access(ExtractFileDir(ParamStr(0))) then Exit;

    ShowProgress('��ʼ�ϲ�����...',chklst_Sf.Items.Count-1);
    Memo1.Lines.Add('��ʼ�ϲ����ݣ����Ժ�....');
    
    for ii := 0 to chklst_Sf.Items.Count - 1 do   //����tdd_temp.db��ʱ�ļ�
    begin
      if not chklst_Sf.ItemChecked[ii] then Continue;
      sf_name := chklst_Sf.Items.Names[ii];
      sf_dir := gb_SfDirList.Values[sf_name]+'\';

      MareDataFromParadox(sf_name,sf_dir,sXzNx,Memo1);
      UpdateProgress(ii);
    end;

    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('���������ϳɱ�/ԭʼ����'+Inttostr(TddTemp_Count)+'/'+inttostr(Tdd_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('��ʼ������ʽ���ݱ�....');

    sqlstr := 'select * from lqmd where ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_lqmd.XMLData := dm.OpenData(sqlstr);

    sqlstr := 'select top 0 * from ����רҵ��¼�� where ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_Log.XMLData := dm.OpenData(sqlstr);

    dm.qry_Access.Close;
    sqlstr := 'select * from lqmd where ѧ������='+quotedstr(sXznx)+' order by ʡ��,���δ���,�������,¼ȡ����,Ͷ���ɼ� desc';
    dm.qry_Access.SQL.Text := sqlstr;
    dm.qry_Access.Open;

    UpdateProgressTitle('���ڸ���....');
    UpdateProgressMax(dm.qry_Access.RecordCount);
    Update_Count := 0;
    Insert_Count := 0;
    while not dm.qry_Access.Eof do
    begin
      UpdateProgress(dm.qry_Access.RecNo);
      sKsh := dm.qry_Access.FieldByName('������').AsString;
      if cds_lqmd.Locate('������',sKsh,[]) then
        UpdateRecord
      else
        InsertRecord;
      dm.qry_Access.Next;
    end;
    UpdateProgressTitle('���ڱ���....');
    if cds_lqmd.ChangeCount>0 then
      if not dm.UpdateData('������','select top 0 * from lqmd',cds_lqmd.Delta,False) then
      begin
        //HideProgress;
        Memo1.Lines.Add('�����ϴ�ʧ�ܣ���������ԣ�');
        //MessageBox(Handle, '�����ϴ�ʧ�ܣ���������ԣ���', 'ϵͳ��ʾ', MB_OK +
        //  MB_ICONERROR + MB_TOPMOST);
        Exit;
      end else
      begin
        if cds_Log.ChangeCount>0 then
        begin
          dm.UpdateData('Id','select top 0 * from ����רҵ��¼��',cds_Log.Delta,False);
        end;
      end;

    HideProgress;

    Memo1.Lines.Add('������ɣ�');
    Memo1.Lines.Add('���δ���������¼��'+inttostr(Insert_Count)+'��������רҵ��'+inttostr(Update_Count)+'�����˵���¼��'+inttostr(Delete_Count)+'����');
    Memo1.Lines.Add(rg_XlCc.Items[rg_XlCc.ItemIndex]+'��¼����Ϊ��'+IntToStr(cds_lqmd.RecordCount));
    Memo1.Lines.SaveToFile('Log.Txt');
    Memo1.Lines.Add('��־�ļ������Log.Txt�У�');

    MessageBox(Handle, '������ɣ����������ļ��Ѻϲ�����', 'ϵͳ��ʾ', MB_OK +
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
    if Application.MessageBox('���棡' + #13#10 +
      '��������һ���ǳ�Σ�յĲ���������Ҫ�󵼳���Դ����Ŀ¼�д�š���' +
      #13#10 + '�����еĿ������ݣ����򽫰�Դ����Ŀ¼�в����ڵĿ���������Ϊ' +
      #13#10 + '�˵���������' + #13#10#13#10 +
      '������Ҫ�Զ�����˵�������Ϣ�𣿡���', '������ʾ', MB_YESNO +
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
    '���Ҫ�ѵ����Ŀ�������ɼ��𣿡���', '�ɼ�������ʾ',
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
          MessageBox(Handle, 'DBF���ݿ�����ʧ�ܣ�   ','DBF����ʧ��', MB_OK+MB_ICONSTOP);
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

          sf := ' '+sf+' as ʡ��,';
          Insert(sf,kk,7);
          kk := 'select ksh as ������,'+GetEnglishCjdm+' into tddCjtemp.dbf from t_tdd';
          con_DBF.Execute(kk); //����һ����Ϊtddtemp.dbf����ʱ�ļ�
        except
          on e:Exception do MessageBox(Handle,PChar('������ʱ�ļ�����'+sf+#13+e.Message),
            '������ʱ�ļ���������', MB_OK + MB_ICONSTOP);
        end;

        v_tddtemp_Count := Get_DBF_Count('tddCjtemp.dbf');
        TddTemp_Count := TddTemp_Count+v_tddtemp_Count;
        Memo1.Lines.Add(ss+'\��ʱ�����ɹ���'+inttostr(v_tdd_Count)+'/'+inttostr(v_tddtemp_Count));

        Application.ProcessMessages;
      end;
    end;
    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('��������ԭʼ��/�ϳɱ���'+Inttostr(Tdd_Count)+'/'+inttostr(TddTemp_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('��ʼ������ʽ���ݱ�....');
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
          MessageBox(Handle, 'DBF���ݿ�����ʧ�ܣ�   ','DBF����ʧ��', MB_OK+MB_ICONSTOP);
          Exit;
        end;

        InsertSql := 'Insert into tt select * from tddCjtemp in '+quotedstr(ss)+' '+quotedstr('dbase 5.0;');
        try
          dm.con_Access.Execute(InsertSql);
        except
          ShowMessage('Insert ʧ�ܣ�'+InsertSql);
        end;
        //Memo1.Lines.Add(ss+' ���������ѵ��룡');
        Memo1.Lines.Text := Memo1.Lines.Text+'>>>';
        Application.ProcessMessages;
        //Memo1.Refresh;
      end;
    end;
    InsertSql := 'delete from EnglishCj';
    dm.con_Access.Execute(InsertSql);

    InsertSql := 'Insert into EnglishCj select * from tt';
    dm.con_Access.Execute(InsertSql,Insert_Count);

    Memo1.Lines.Add('������ɣ�');
    Memo1.Lines.SaveToFile('CjLog.Txt');
    Memo1.Lines.Add('��־�ļ������CjLog.Txt�У�');

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
  vv := con_DBF.Execute('select cjxdm from td_cjxdm where cjxmc in ('+quotedstr('����')+','+quotedstr('����ɼ�')+')').Fields[0].Value;
  Result := VarToStr(vv);

  if Result = '' then
    Result := QuotedStr('0.0')
  else
    Result := 'Gkcjx'+Result;
  Result := Result + ' as ����ɼ� ';
}
end;

initialization
  ShengFenStrList := TSTringList.Create;

finalization
  FreeAndNil(ShengFenStrList);

end.
