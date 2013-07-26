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
    function GetEnglishCjdm:string; //�õ�Ӣ��ɼ�����
    procedure InitSfDirList;
    procedure SelectSf(const iType:Integer);
    procedure SetState;

    function  Get_TDD_Count(const sXlcc:string):Integer;
    function  Init_Con_BDE(const sDir: string):Boolean;
    function  Get_TDD_SfDm(const sfmc:string=''):string; //�õ�ĳһͶ�������ʡ�ݴ���
    //t_tdd.Pcdm=t_jhk.Pcdm and t_tdd.Kldm=t_jhk.Kldm and t_tdd.Jhxz=t_jhk.Jhxz and
    //t_tdd.tddw=t_jhk.tddw and t_tdd.lqzy=t_jhk.zydh
    function  Get_JHK_Zymc(const pcdm,kldm,jhxz,tddw,zydm:string;out xznx,sfsf:string):string; //�õ��ƻ����е�רҵ����
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
var
  sf_name,sf_dir,sqlstr :string;
  ii:Integer;
  Update_Count,Insert_Count,Delete_Count :Integer;
  sKsh,sXlcc :string;
  procedure UpdateRecord;
  var
    oldksh,ksh,oldzydm,oldzymc,zydm,zymc,oldkszt,kszt,oldcj,cj:string;
  begin
    oldksh := cds_lqmd.FieldByName('������').AsString;
    oldzydm := cds_lqmd.FieldByName('¼ȡ����').AsString;
    oldzymc := cds_lqmd.FieldByName('¼ȡרҵ').AsString;
    oldkszt := cds_lqmd.FieldByName('����״̬').AsString;
    oldcj := cds_lqmd.FieldByName('�ɼ�').AsString;

    ksh := qry_BDE.FieldByName('������').AsString;
    zydm := qry_BDE.FieldByName('¼ȡ����').AsString;
    zymc := qry_BDE.FieldByName('¼ȡרҵ').AsString;
    kszt := qry_BDE.FieldByName('����״̬').AsString;
    cj := qry_BDE.FieldByName('�ɼ�').AsString;

    if (oldksh=ksh) and ((oldkszt<>kszt) or (oldzydm<>zydm) or (oldcj<>cj)) then
    begin
      //sqlstr := 'update lqmd set ¼ȡ����='+quotedstr(zydm)+',¼ȡרҵ='+quotedstr(zymc)+
      //          ' where ������='+quotedstr(sKsh)+' and ¼ȡ����='+quotedstr(oldzydm);
      cds_lqmd.Edit;
      if oldcj<>cj then
        cds_lqmd.FieldByName('�ɼ�').AsString := cj;

      if (kszt<>'5') and (oldkszt<>kszt) then
        cds_lqmd.FieldByName('����״̬').AsString := kszt;
      if (oldzydm<>zydm) then
      begin
        cds_lqmd.FieldByName('¼ȡ����').AsString := zydm;
        cds_lqmd.FieldByName('¼ȡרҵ').AsString := zymc;
        cds_lqmd.FieldByName('��ע').AsString := cds_lqmd.FieldByName('��ע').AsString+'system:'+FormatDateTime('mm-dd hh:nn:ss',Now)+':'+oldzydm+','+oldzymc+'->'+zydm+','+zymc+';';
        cds_lqmd.FieldByName('�ɼ�Ա').AsString := gb_Czy_ID;
        cds_lqmd.FieldByName('�ɼ�IP').AsString := GetLocalIpStr;
      end;
      cds_lqmd.Post;

      if (oldzydm<>zydm) and (zydm<>'') then
      begin
        cds_Log.Append;
        cds_Log.FieldByName('������').AsString := cds_lqmd.FieldByName('������').AsString;
        cds_Log.FieldByName('ѧ�����').AsString := cds_lqmd.FieldByName('ѧ�����').AsString;
        cds_Log.FieldByName('ԭ¼ȡ����').AsString := oldzydm;
        cds_Log.FieldByName('ԭ¼ȡרҵ').AsString := oldzymc;
        cds_Log.FieldByName('��¼ȡ����').AsString := zydm;
        cds_Log.FieldByName('��¼ȡרҵ').AsString := zymc;
        cds_Log.FieldByName('����Ա').AsString := 'sys:'+gb_Czy_Id;
        cds_Log.FieldByName('����ʱ��').AsDateTime := Now;
        cds_Log.Post;
        Memo1.Lines.Add('רҵ�����'+sKsh+','+oldzymc+'->'+zymc);
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
    cds_lqmd.FieldByName('ѧ�����').Value := rg_XlCc.Items[rg_XlCc.ItemIndex];
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
    cds_lqmd.FieldByName('¼ȡרҵ�淶��').Value := cds_lqmd.FieldByName('¼ȡרҵ').Value;
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
        if cds_lqmd.FieldByName('������').Value=Ksh then
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
      GetTddDirList(vSfDir,DirList); //�õ����� t_tdd.db �ļ���Ŀ¼�б�
      for i:=0 to dirList.Count-1 do
      begin
        UpdateProgressTitle('���ڲɼ���'+vSf+'������...');
        tdd_dir := dirList.Strings[i];
        fn := tdd_dir+'\t_tdd.db';
        if not FileExists(fn) then exit;
        if not Init_Con_BDE(tdd_dir) then
        begin
          MessageBox(Handle, PChar(vSf+'¼ȡ���ݶ�ȡʧ�ܣ��Ƿ����ڽ��и�ʡ��¼ȡ����?   '+#13+'����ǵĻ�����ر�¼ȡϵͳ��'),'����ʧ��', MB_OK+MB_ICONSTOP);
          Exit;
        end;

        try
          sqlstr := vobj.GetDBMareSql(vSf,vXlcc);

          sqlstr := ReplaceStr(sqlstr,'��sf��',vSf);//�滻SQL�е�ʡ�ݱ���
          //sqlstr := ReplaceStr(sqlstr,'��xznx��',vXznx);//�滻SQL�е�ѧ�����ޱ���
          sqlstr := ReplaceStr(sqlstr,'��czy��',gb_Czy_ID);//�滻SQL�еĲɼ�Ա����
          sqlstr := ReplaceStr(sqlstr,'��ip��',GetLocalIpStr());//�滻SQL�е�IP����

          qry_BDE.Close;
          qry_BDE.SQL.Text := sqlstr;
          qry_BDE.Open;

          if qry_BDE.RecordCount>0 then
            UpdateProgressMax(qry_BDE.RecordCount);
          while not qry_BDE.Eof do
          begin
            UpdateProgress(qry_BDE.RecNo);
            sKsh := qry_BDE.FieldByName('������').AsString;
            //if cds_lqmd.Locate('������',sKsh,[]) then
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
              aMemo.Lines.Add('��������ʡ�ݣ�'+vSf+'('+tdd_dir+')');
              aMemo.Lines.Add(e.Message);
              Result := False;
              Exit;
            end;
          end;
        end;

        vTdd_Count := Get_TDD_Count(vXlcc);
        vTemp_Count := qry_BDE.RecordCount;

        aMemo.Lines.Add(vSf+'��'+inttostr(vTemp_Count)+'/'+inttostr(vTdd_Count));

        Tdd_Count := Tdd_Count+ vTdd_Count;
        TddTemp_Count := TddTemp_Count+vTemp_Count;
      end;
      Result := True;
    finally
      dirList.Free;
    end;
  end;
begin
  if MessageBox(Handle,pchar('���Ҫ�ɼ�������¼ȡ��������һ��������Ҫ���Ѽ��롡'+#13+
                             '����ʮ�벻�ȵ�ʱ�䣡'+#13+'��Ҫ����������'), '������ʾ',
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

    sqlstr := 'select * from lqmd where ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    //sqlstr := 'select * from lqmd order by ������';//where ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_lqmd.XMLData := dm.OpenData(sqlstr);
    sqlstr := 'select top 0 * from ����רҵ��¼��';
    cds_Log.XMLData := dm.OpenData(sqlstr);

    ShowProgress('��ʼ�ɼ�����...');
    Memo1.Lines.Add('��ʼ�ɼ����ݣ����Ժ�....');

    for ii := 0 to chklst_Sf.Items.Count - 1 do   //����tdd_temp.db��ʱ�ļ�
    begin
      if not chklst_Sf.ItemChecked[ii] then Continue;
      sf_name := chklst_Sf.Items.Names[ii];
      sf_dir := gb_SfDirList.Values[sf_name]+'\';

      MareDataFromParadox(sf_name,sf_dir,sXlcc,Memo1);
    end;

    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('���������ϳɱ�/ԭʼ����'+Inttostr(TddTemp_Count)+'/'+inttostr(Tdd_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('��ʼ������ʽ���ݱ�....');

    UpdateProgressTitle('��ʼ������ʽ���ݱ�....');
    if cds_lqmd.ChangeCount>0 then
      if not dm.UpdateData('������','select top 0 * from lqmd',cds_lqmd.Delta,False) then
      begin
        Memo1.Lines.Add('������ʽ���ݱ�ʧ�ܣ���������ԣ�');
        Exit;
      end else
      begin
        vobj.UpdateLqInfo(rg_XlCc.Items[rg_XlCc.ItemIndex]);
        if cds_Log.ChangeCount>0 then
        begin
          dm.UpdateData('Id','select top 0 * from ����רҵ��¼��',cds_Log.Delta,False);
        end;
      end;

    HideProgress;

    Memo1.Lines.Add('������ɣ�');
    Memo1.Lines.Add('���δ���������¼��'+inttostr(Insert_Count)+'�������¼�¼��'+inttostr(Update_Count)+'�����˵���¼��'+inttostr(Delete_Count)+'����');
    Memo1.Lines.Add(rg_XlCc.Items[rg_XlCc.ItemIndex]+'��¼����Ϊ��'+IntToStr(cds_lqmd.RecordCount));
    Memo1.Lines.SaveToFile('Log.Txt');
    Memo1.Lines.Add('��־�ļ������Log.Txt�У�');

    MessageBox(Handle, '������ɣ����������ļ��Ѻϲ�����', 'ϵͳ��ʾ', MB_OK +
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
    //cds_lqmd.FieldByName('�ƻ����ʴ���').AsString := qry_BDE.FieldByName('�ƻ����ʴ���').AsString;
    //cds_lqmd.FieldByName('Ͷ����λ����').AsString := qry_BDE.FieldByName('Ͷ����λ����').AsString;

    pcdm := cds_lqmd.FieldByName('���δ���').AsString;
    kldm := cds_lqmd.FieldByName('�������').AsString;
    jhxz := cds_lqmd.FieldByName('�ƻ����ʴ���').AsString;
    tddw := cds_lqmd.FieldByName('Ͷ����λ����').AsString;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ1').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('רҵ1����').AsString <> zymc then
      cds_lqmd.FieldByName('רҵ1����').AsString := zymc;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ2').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('רҵ2����').AsString <> zymc then
      cds_lqmd.FieldByName('רҵ2����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ3').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('רҵ3����').AsString <> zymc then
      cds_lqmd.FieldByName('רҵ3����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ4').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('רҵ4����').AsString <> zymc then
      cds_lqmd.FieldByName('רҵ4����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ5').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('רҵ5����').AsString <> zymc then
      cds_lqmd.FieldByName('רҵ5����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ6').AsString,xznx,sfsf);
    if cds_lqmd.FieldByName('רҵ6����').AsString <> zymc then
      cds_lqmd.FieldByName('רҵ6����').AsString := zymc;
    cds_lqmd.Post;
}
    //====================================================

    aSf := cds_lqmd.FieldByName('ʡ��').AsString;
    aXm := cds_lqmd.FieldByName('��������').AsString;
    pcdm := cds_lqmd.FieldByName('���δ���').AsString;
    kldm := cds_lqmd.FieldByName('�������').AsString;
    jhxz := cds_lqmd.FieldByName('�ƻ����ʴ���').AsString;
    tddw := cds_lqmd.FieldByName('Ͷ����λ����').AsString;

    oldksh := cds_lqmd.FieldByName('������').AsString;
    oldzydm := cds_lqmd.FieldByName('¼ȡ����').AsString;
    oldzymc := cds_lqmd.FieldByName('¼ȡרҵ').AsString;
    oldkszt := cds_lqmd.FieldByName('����״̬').AsString;
    oldcj := cds_lqmd.FieldByName('�ɼ�').AsString;
    oldtel := cds_lqmd.FieldByName('��ϵ�绰').AsString;


    ksh := qry_BDE.FieldByName('������').AsString;
    zydm := qry_BDE.FieldByName('¼ȡ����').Value;
    zydm := Trim(zydm);
    //zymc := qry_BDE.FieldByName('¼ȡרҵ').AsString; //����ɼ������п�����Ϣ�Ļ���ʹ������Ƿǳ������˴����
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,zydm,xznx,sfsf);
    kszt := Trim(qry_BDE.FieldByName('����״̬').AsString);
    cj := qry_BDE.FieldByName('�ɼ�').AsString;
    tel := Trim(qry_BDE.FieldByName('��ϵ�绰').AsString);

    if (oldkszt='5') and (oldtel<>tel) and (not IsTelephone(oldtel)) then
    begin
      cds_lqmd.Edit;
      cds_lqmd.FieldByName('��ϵ�绰').AsString := tel;
      cds_lqmd.Post;
      Inc(Update_Count);
    end;
    //���¼ȡ�ѽ����������˵�״̬�Ŀ��������ݾ��Բ�����
    if (oldkszt='5') or (oldkszt='3') then
    begin
      if (kszt<>oldkszt) or (oldzydm<>zydm) then //����˵����������ص��Ŀ�����Ϣ
      begin
        sTemp := format('������%s %-8s',[ksh,aXm]);
        if oldkszt='5' then
          sTemp := sTemp+' ¼ȡ��Ķ�'
        else
          sTemp := sTemp+' �˵�����Ͷ';
        Memo1.Lines.Add(sTemp);
{
          sQList.Add(aSf+' '+ksh+' '+aXm+' ¼ȡ��Ķ���')
        else
          sQList.Add(aSf+' '+ksh+' '+aXm+' �˵�����Ͷ��');
}
      end;
      Exit;
    end;

    if ((oldkszt<>'5') and ((oldzydm<>zydm) or (oldzymc<>zymc))) or (oldkszt<>kszt) then
    begin
      //sqlstr := 'update lqmd set ¼ȡ����='+quotedstr(zydm)+',¼ȡרҵ='+quotedstr(zymc)+
      //          ' where ������='+quotedstr(sKsh)+' and ¼ȡ����='+quotedstr(oldzydm);
      cds_lqmd.Edit;

      if (oldkszt<>'5') and (oldkszt<>kszt) then
        cds_lqmd.FieldByName('����״̬').AsString := kszt;
      if (oldkszt<>'5') and ((oldzydm<>zydm) or (oldzymc<>zymc)) then
      begin
        cds_lqmd.FieldByName('¼ȡ����').AsString := zydm;
        cds_lqmd.FieldByName('¼ȡרҵ').AsString := zymc;
        cds_lqmd.FieldByName('¼ȡרҵ�淶��').AsString := zymc;
        if zymc<>'' then
        begin
          cds_lqmd.FieldByName('ѧ������').AsString := xznx;
          //cds_lqmd.FieldByName('�Ƿ�ʦ��').AsString := sfsf;
        end;
        //cds_lqmd.FieldByName('��ע').AsString := cds_lqmd.FieldByName('��ע').AsString+'system:'+FormatDateTime('mm-dd hh:nn:ss',Now)+':'+oldzydm+','+oldzymc+'->'+zydm+','+zymc+';';
        cds_lqmd.FieldByName('�ɼ�Ա').AsString := gb_Czy_ID;
        cds_lqmd.FieldByName('�ɼ�IP').AsString := GetLocalIpStr;
      end;
      cds_lqmd.Post;

      if (kszt='3') and (oldzydm<>zydm) and (zymc='') then //�˵���
      begin
        cds_Log.Append;
        cds_Log.FieldByName('������').AsString := cds_lqmd.FieldByName('������').AsString;
        cds_Log.FieldByName('ѧ�����').AsString := cds_lqmd.FieldByName('ѧ�����').AsString;
        cds_Log.FieldByName('ԭ¼ȡ����').AsString := oldzydm;
        cds_Log.FieldByName('ԭ¼ȡרҵ').AsString := oldzymc;
        cds_Log.FieldByName('��¼ȡ����').AsString := zydm;
        cds_Log.FieldByName('��¼ȡרҵ').AsString := '�˵�';//zymc;
        cds_Log.FieldByName('����Ա').AsString := 'sys:'+gb_Czy_Id;
        cds_Log.FieldByName('����ʱ��').AsDateTime :=  Now;//FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
        cds_Log.Post;
        Memo1.Lines.Add('������'+sKsh+' '+'רҵ���:'+oldzymc+'->'+zymc);
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
    cds_lqmd.FieldByName('ѧ�����').Value := rg_XlCc.Items[rg_XlCc.ItemIndex];
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

    //=====================��俼������רҵ����===============================
    pcdm := cds_lqmd.FieldByName('���δ���').Value;
    kldm := cds_lqmd.FieldByName('�������').Value;
    jhxz := cds_lqmd.FieldByName('�ƻ����ʴ���').Value;
    tddw := cds_lqmd.FieldByName('Ͷ����λ����').Value;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ1').Value,xznx,sfsf);
    cds_lqmd.FieldByName('רҵ1����').AsString := zymc;
    cds_lqmd.FieldByName('ѧ������').AsString := xznx;
    //cds_lqmd.FieldByName('�Ƿ�ʦ��').AsString := sfsf;

    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ2').Value,xznx,sfsf);
    cds_lqmd.FieldByName('רҵ2����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ3').Value,xznx,sfsf);
    cds_lqmd.FieldByName('רҵ3����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ4').Value,xznx,sfsf);
    cds_lqmd.FieldByName('רҵ4����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ5').Value,xznx,sfsf);
    cds_lqmd.FieldByName('רҵ5����').AsString := zymc;
    zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('רҵ6').Value,xznx,sfsf);
    cds_lqmd.FieldByName('רҵ6����').AsString := zymc;

    if not cds_lqmd.FieldByName('¼ȡ����').IsNull then
    begin
      zymc := Get_JHK_Zymc(pcdm,kldm,jhxz,tddw,cds_lqmd.FieldByName('¼ȡ����').Value,xznx,sfsf);
      cds_lqmd.FieldByName('¼ȡרҵ').Value := zymc;
      if zymc<>'' then
      begin
        cds_lqmd.FieldByName('ѧ������').AsString := xznx;
        //cds_lqmd.FieldByName('�Ƿ�ʦ��').AsString := sfsf;
      end;
    end else
    begin
      cds_lqmd.FieldByName('¼ȡרҵ').Clear;
    end;

    //=====================��俼������רҵ����===============================

    cds_lqmd.FieldByName('¼ȡרҵ�淶��').Value := cds_lqmd.FieldByName('¼ȡרҵ').Value;
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
        if cds_lqmd.FieldByName('������').Value=Ksh then
        begin
          Result := True;
          Exit;
        end;
        cds_lqmd.Next;
      end;
      //UpdateProgress(cds_lqmd.RecordCount);
    end;

    procedure CheckTdKsInfo; //����˵�������Ϣ
    var
      sKsh:string;
    begin
      //===============����˵�������Ϣ==============
      if qry_BDE_TDKS.Active then
      begin
        while not qry_BDE_TDKS.Eof do
        begin
          UpdateProgress(qry_BDE.RecNo);
          sKsh := qry_BDE_TDKS.FieldByName('������').AsString;
          //if cds_lqmd.Locate('������',sKsh,[]) then
          if KsIsExists(sKsh) and (cds_lqmd.FieldByName('����״̬').AsString<>'5') and
            (cds_lqmd.FieldByName('����״̬').AsString<>'3') then
          begin
            if cds_lqmd.FieldByName('����״̬').AsString<>qry_BDE_TDKS.FieldByName('����״̬').AsString then
            begin
              cds_lqmd.Edit;
              cds_lqmd.FieldByName('����״̬').AsString := qry_BDE_TDKS.FieldByName('����״̬').AsString;
              cds_lqmd.FieldByName('¼ȡ����').Clear;
              cds_lqmd.FieldByName('¼ȡרҵ').Clear;
              cds_lqmd.FieldByName('¼ȡרҵ�淶��').Clear;
              cds_lqmd.Post;

              cds_Log.Append;
              cds_Log.FieldByName('������').AsString := cds_lqmd.FieldByName('������').AsString;
              cds_Log.FieldByName('ѧ�����').AsString := cds_lqmd.FieldByName('ѧ�����').AsString;
              cds_Log.FieldByName('ԭ¼ȡ����').AsString := cds_lqmd.FieldByName('¼ȡ����').AsString;
              cds_Log.FieldByName('ԭ¼ȡרҵ').AsString := cds_lqmd.FieldByName('¼ȡרҵ').AsString;
              cds_Log.FieldByName('��¼ȡ����').AsString := '';
              cds_Log.FieldByName('��¼ȡרҵ').AsString := '�˵�';//zymc;
              cds_Log.FieldByName('����Ա').AsString := 'sys:'+gb_Czy_Id;
              cds_Log.FieldByName('����ʱ��').AsDateTime :=  Now;//FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
              cds_Log.Post;
              if aMemo<>nil then
                aMemo.Lines.Add('�˵���'+sKsh+' '+'�˵�');

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

    procedure CheckTddNotExistsKsInfo(const aSf:string); //���lqmd�����е�t_tdd����û�еļ�¼
    var
      sKsh,sSf,sXm:string;
    begin
      //===============����˵�����==============
      if qry_BDE.Active then
      begin
        if cds_lqmd.RecordCount>0 then
          UpdateProgressMax(cds_lqmd.RecordCount);
        cds_lqmd.First;
        while not cds_lqmd.Eof do
        begin
          UpdateProgress(cds_lqmd.RecNo);
          sKsh := cds_lqmd.FieldByName('������').AsString;
          sXm := cds_lqmd.FieldByName('��������').AsString;
          sSf := cds_lqmd.FieldByName('ʡ��').AsString;
          if sSf=aSf then
          begin
            if not qry_BDE.Locate('������',sKsh,[]) then
            begin
              if aMemo<>nil then
                aMemo.Lines.Add(' '+sKsh+' '+sXm+' T_TDD.DB���в����ڴ˿���')
              else
                sQList.Add(aSf+' '+sKsh+' '+sXm+' T_TDD.DB���в����ڴ˿���');
            end;
          end;

          cds_lqmd.Next;
        end;
      end;
      //=========================================
    end;

  begin
    try
      for i:=0 to dirList.Count-1 do //dirListΪ���� t_tdd.db �ļ���Ŀ¼�б�
      begin
        UpdateProgressTitle('���ڲɼ���'+vSf+'������...');
        tdd_dir := dirList.Strings[i];
        fn := tdd_dir+'\NacuesCUniv.mdb'; //'\t_tdd.db';
        if not FileExists(fn) then Continue;
        if not Init_Con_BDE(tdd_dir) then
        begin
          MessageBox(Handle, PChar(vSf+'¼ȡ���ݶ�ȡʧ�ܣ��Ƿ����ڽ��и�ʡ��¼ȡ����?   '+#13+'����ǵĻ�����ر�¼ȡϵͳ��'),'����ʧ��', MB_OK+MB_ICONSTOP);
          Exit;
        end;
        tdd_sfdm := Get_TDD_SfDm(vSf);// �õ���ǰĿ¼�µ�ʡ�ݴ���
        if vSfDm<>tdd_sfdm then Continue; //����������Ҫ�ɼ���ʡ��

        try
          sqlstr := vobj.GetDBMareSql(vSf,vXlcc);

          sqlstr := ReplaceStr(sqlstr,'��sf��',vSf);//�滻SQL�е�ʡ�ݱ���
          sqlstr := ReplaceStr(sqlstr,'��czy��',gb_Czy_ID);//�滻SQL�еĲɼ�Ա����
          sqlstr := ReplaceStr(sqlstr,'��ip��',GetLocalIpStr());//�滻SQL�е�IP����

          qry_BDE.Close;
          qry_BDE.SQL.Text := sqlstr;
          qry_BDE.Open;

          qry_BDE_TDKS.Close;
          if FileExists(tdd_dir+'\NacuesCUniv.mdb') then
          begin
            sqlstr := vobj.GetTdksSql(vSf,vXlcc);
            sqlstr := ReplaceStr(sqlstr,'��sf��',vSf);//�滻SQL�е�ʡ�ݱ���
            sqlstr := ReplaceStr(sqlstr,'��czy��',gb_Czy_ID);//�滻SQL�еĲɼ�Ա����
            sqlstr := ReplaceStr(sqlstr,'��ip��',GetLocalIpStr());//�滻SQL�е�IP����
            qry_BDE_TDKS.Close;
            qry_BDE_TDKS.SQL.Text := sqlstr;
            qry_BDE_TDKS.Open;
          end;

          if qry_BDE.RecordCount>0 then
            UpdateProgressMax(qry_BDE.RecordCount);

          vTdd_Count := Get_TDD_Count(vXlcc);
          vTemp_Count := qry_BDE.RecordCount;
          aMemo.Lines.Add(vSf+'��'+inttostr(vTemp_Count)+'/'+inttostr(vTdd_Count));
          Tdd_Count := Tdd_Count+ vTdd_Count;
          TddTemp_Count := TddTemp_Count+vTemp_Count;

          while not qry_BDE.Eof do
          begin
            UpdateProgress(qry_BDE.RecNo);
            sKsh := qry_BDE.FieldByName('������').AsString;
            //if cds_lqmd.Locate('������',sKsh,[]) then
            if KsIsExists(sKsh) then
            begin
              //if cds_lqmd.FieldbyName('ѧ�����').AsString=rg_XlCc.Items[rg_XlCc.ItemIndex] then
                UpdateRecord
              //else
              //  Memo1.Lines.Add('������'+sKsh+' ѧ����β�һ��');
            end
            else
              InsertRecord;
            qry_BDE.Next;
          end;
          CheckTdksInfo;//����˵�������Ϣ
          if chk1.Checked then
            CheckTddNotExistsKsInfo(sf_name);
        except
          on e:Exception do
          begin
            if aMemo<>nil then
            begin
              aMemo.Lines.Add('��������ʡ�ݣ�'+vSf+'('+tdd_dir+')');
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
  if MessageBox(Handle,pchar('���Ҫ�ɼ�������¼ȡ��������һ��������Ҫ���Ѽ��롡'+#13+
                             '����ʮ�벻�ȵ�ʱ�䣡'+#13+'��Ҫ����������'), '������ʾ',
     MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then Exit;

  sXznx := rg_XlCc.Items[rg_XlCc.ItemIndex];

  Screen.Cursor := crHourGlass;
  btn_Start.Enabled := False;
  dirList := TStringList.Create;
  sQList := TStringList.Create; //�����ʵļ�¼

  sKsDataPath := GetKsDataPath; //��������Ŀ¼
  GetTddDirList(sKsDataPath,dirList); //�õ����� t_tdd.db �ļ���Ŀ¼�б�
  try
    Memo1.Lines.Clear;

    Tdd_Count := 0;
    TddTemp_Count := 0;

    Update_Count := 0;
    Insert_Count := 0;
    Delete_Count := 0;

    sqlstr := 'select * from lqmd where ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
    cds_lqmd.XMLData := dm.OpenData(sqlstr);
    sqlstr := 'select top 0 * from ����רҵ��¼��';
    cds_Log.XMLData := dm.OpenData(sqlstr);

    ShowProgress('��ʼ�ɼ�����...');
    Memo1.Lines.Add('��ʼ�ɼ����ݣ����Ժ�....');

    for ii := 0 to chklst_Sf.Items.Count - 1 do   //����tdd_temp.db��ʱ�ļ�
    begin
      if not chklst_Sf.ItemChecked[ii] then Continue;
      sf_name := chklst_Sf.Items.Names[ii];
      sf_dm := GetSfDmBySfMc(sf_name);
      sf_dir := gb_SfDirList.Values[sf_name]+'\';

      MareDataFromParadox(sf_name,sf_dm,rg_XlCc.Items[rg_XlCc.ItemIndex],Memo1);
    end;

    Memo1.Lines.Add('===================================');
    Memo1.Lines.Add('���������ϳɱ�/ԭʼ����'+Inttostr(TddTemp_Count)+'/'+inttostr(Tdd_Count));
    Memo1.Lines.Add('===================================');

    Memo1.Lines.Add('��ʼ������ʽ���ݱ�....');

    UpdateProgressTitle('��ʼ������ʽ���ݱ�....');
    if cds_lqmd.ChangeCount>0 then
      if not dm.UpdateData('������','select top 0 * from lqmd',cds_lqmd.Delta,False) then
      begin
        Memo1.Lines.Add('������ʽ���ݱ�ʧ�ܣ���������ԣ�');
        Exit;
      end else
      begin
        vobj.UpdateLqInfo(rg_XlCc.Items[rg_XlCc.ItemIndex]);
        if cds_Log.ChangeCount>0 then
        begin
          dm.UpdateData('Id','select top 0 * from ����רҵ��¼��',cds_Log.Delta,False);
        end;
      end;

    HideProgress;

    Memo1.Lines.Add('������ɣ�');
    Memo1.Lines.Add('���δ���������¼��'+inttostr(Insert_Count)+'�������¼�¼��'+inttostr(Update_Count)+'�����˵���¼��'+inttostr(Delete_Count)+'����');
    Memo1.Lines.Add(rg_XlCc.Items[rg_XlCc.ItemIndex]+'��¼����Ϊ��'+IntToStr(cds_lqmd.RecordCount));
    if sQList.Count>0 then
    begin
      Memo1.Lines.Add('');
      Memo1.Lines.Add('===================================');
      Memo1.Lines.Add('���¿�����Ϣ�����ʣ����ֹ��˶ԣ�');
      Memo1.Lines.AddStrings(sQList);
      Memo1.Lines.Add('===================================');
    end;
    Memo1.Lines.SaveToFile('Log.Txt');
    Memo1.Lines.Add('��־�ļ������Log.Txt�У�');

    MessageBox(Handle, '������ɣ����������ļ��Ѻϲ�����', 'ϵͳ��ʾ', MB_OK +
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
  zymc := DataSet.FieldByName('¼ȡרҵ�淶��').AsString;
  zymc := StringReplace(zymc,'(','��',[rfReplaceAll, rfIgnoreCase]);
  zymc := StringReplace(zymc,')','��',[rfReplaceAll, rfIgnoreCase]);
  DataSet.FieldByName('¼ȡרҵ�淶��').AsString := zymc;
end;

procedure TMareData.chk1Click(Sender: TObject);
begin
  if chk1.Checked then
  begin
    if Application.MessageBox('���Ҫ���ɼ�����ڵ�t_tdd���в����ڵĿ�����¼�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
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
          dm.con_DBF.Execute(kk); //����һ����Ϊtddtemp.dbf����ʱ�ļ�
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
  vv := dm.con_DBF.Execute('select cjxdm from td_cjxdm where cjxmc in ('+quotedstr('����')+','+quotedstr('����ɼ�')+')').Fields[0].Value;
  Result := VarToStr(vv);

  if Result = '' then
    Result := QuotedStr('0.0')
  else
    Result := 'Gkcjx'+Result;
  Result := Result + ' as ����ɼ� ';
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
    if sfmc<>'�㶫' then
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
