unit uMareData_BDE_Photo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls,FileCtrl, DB, ADODB,StrUtils,
  IniFiles, StatusBarEx, RzPanel, RzRadGrp, RzLstBox, RzChkLst,CnProgressFrm,
  DBClient, Menus, DBTables, Grids, DBGrids, CnButtonEdit;

type
  TMareData_BDE_Photo = class(TForm)
    GroupBox1: TGroupBox;
    chklst_Sf: TRzCheckList;
    pnl_Bottom: TPanel;
    btn_OK: TBitBtn;
    btn_Exit: TButton;
    pnl_Main: TPanel;
    grp1: TGroupBox;
    Memo1: TMemo;
    rg_XlCc: TRzRadioGroup;
    cds_lqmd: TClientDataSet;
    cds_Temp: TClientDataSet;
    pm1: TPopupMenu;
    mni_SelectAll: TMenuItem;
    mni_UnSelectAll: TMenuItem;
    mni_N1: TMenuItem;
    mni_Select2: TMenuItem;
    chk1: TCheckBox;
    btnedt_Path: TCnButtonEdit;
    chk_OverWrite: TCheckBox;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mni_Select2Click(Sender: TObject);
    procedure chklst_SfChange(Sender: TObject; Index: Integer;
      NewState: TCheckBoxState);
    procedure rg_XlCcClick(Sender: TObject);
    procedure chk1Click(Sender: TObject);
    procedure btnedt_PathButtonClick(Sender: TObject);
  private
    { Private declarations }
    myIniFile:TInifile;
    procedure InitSfCheckList;
    procedure SelectSf(const iType:Integer);
    procedure SetState;
  public
    { Public declarations }
    //xznx :string;
  end;

var
  MareData_BDE_Photo: TMareData_BDE_Photo;

implementation

uses uIniFile,uDM,Net,ActiveX,shellapi,shlObj;

{$R *.dfm}

procedure GetALLFileList(const path: String; var  sList: TStrings);
var
  fpath,fn: string;
  fs: TsearchRec;
begin
  fpath := path+'\';
  fpath := ReplaceStr(fpath,'\\','\');
  fn := fpath+ '*.*';
  if findfirst(fn,faAnyFile,fs)=0 then
  begin
    if (fs.Name <> '.') and (fs.Name <> '..')   then
      if (fs.Attr and faDirectory)=faDirectory   then
        GetALLFileList(fpath+fs.Name,sList)
      else
        sList.add(LowerCase(fpath)+LowerCase(fs.Name));
      while findnext(fs)=0 do
      begin
        if (fs.Name <> '.')and(fs.Name <> '..')   then
          if (fs.Attr and faDirectory)=faDirectory then
            GetALLFileList(fpath+fs.Name,sList)
          else
            sList.add(LowerCase(fpath)+LowerCase(fs.Name));
      end;
  end;
  findclose(fs);
end;

procedure GetKsPhotoFileList(const path: String;const bIncludeKzspStr:Boolean; var  FileResult: TStrings);
var
  bl:Boolean;
  fnExt,sDir: string;
  i: Integer;
  sList:TStrings;
begin
  sList := TStringList.Create;
  GetALLFileList(path,sList);
  try
    for i:=0 to sList.Count-1 do
    begin
      if bIncludeKzspStr then
      begin
        sDir := LowerCase(ExtractFilePath(sList[i])); // \kszp\
        bl := (RightStr(sDir,6)='\kszp\');
      end else
        bl := True;

      fnExt := RightStr(sList[i],4);
      if bl and ((fnExt='.jpg') or (fnExt='jpeg') or (fnExt='.bmp')) then // or (fnExt='.gif') or (fnExt='.png') then
        FileResult.Add(sList[i]);
    end;
  finally
    sList.Free;
  end;
end;

procedure TMareData_BDE_Photo.SelectSf(const iType: Integer);
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

procedure TMareData_BDE_Photo.SetState;
var
  i: Integer;
begin
  for i := 0 to chklst_Sf.Items.Count - 1 do
  begin
    if chklst_Sf.ItemChecked[i] then
      Break;
  end;
  btn_OK.Enabled := i<=chklst_Sf.Items.Count-1;
end;

procedure TMareData_BDE_Photo.btnedt_PathButtonClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := btnedt_Path.Text;
  if SelectDirectory('ѡ���ļ���','', Dir) then
  begin
    btnedt_Path.Text := Dir;
  end;
end;

procedure TMareData_BDE_Photo.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMareData_BDE_Photo.InitSfCheckList;
var
  sqlstr:string;
begin
  sqlstr := 'select distinct ʡ�� from lqmd where ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex])+' order by ʡ��';
  cds_lqmd.XMLData := dm.OpenData(sqlstr);
  chklst_Sf.Items.Clear;
  while not cds_lqmd.Eof do
  begin
    chklst_Sf.Items.Add(cds_lqmd.FieldByName('ʡ��').AsString);
    cds_lqmd.Next;
  end;
  cds_lqmd.Close;
end;

procedure TMareData_BDE_Photo.btn_OKClick(Sender: TObject);
var
  Update_Count,Insert_Count :Integer;
  sqlstr,sPath,sKsh,sfn,sError,sSfstr :string;
  sList:TStrings;
  i,ii: Integer;
  function GetKsPhotoFileName(const ksh:string):string;
  var
    i:Integer;
  begin
    Result := '';
    for i:=0 to sList.Count-1 do
    begin
      if Pos(ksh,sList[i])>0 then
      begin
        Result := sList[i];
        Break;
      end;
    end;
  end;
  function SavePhoto(): Boolean;
  begin
    if cds_Temp.RecordCount>0 then
    begin
      Result := vobj.UpLoadPhoto(cds_Temp.XMLData,sError,chk_OverWrite.Checked);
      if Result then
      begin
        Update_Count := Update_Count+cds_Temp.RecordCount;
        cds_Temp.XMLData := dm.OpenData('select top 0 * from �ļ��ϴ��ṹ��');
      end;
    end else
    begin
      Result := True;
    end;
  end;
begin
  if MessageBox(Handle,pchar('���Ҫ�ɼ������ϵĿ�����Ƭ��Ϣ����һ��������Ҫ���Ѽ��롡'+#13+
                             '����ʮ�벻�ȵ�ʱ�䣡'+#13+'��Ҫ����������'), '������ʾ',
     MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then Exit;

  Screen.Cursor := crHourGlass;
  btn_OK.Enabled := False;
  sList := TStringList.Create;
  try
    Memo1.Lines.Clear;

    Update_Count := 0;
    Insert_Count := 0;

    ShowProgress('��ʼ�ɼ���Ƭ��Ϣ...');
    Memo1.Lines.Add('��ʼ�ɼ���Ƭ�����Ժ�....');

    if chk1.Checked then
      sPath := btnedt_Path.Text
    else
      sPath := GetKsDataPath;
    if RightStr(sPath,1)<>'\' then
      sPath := sPath+'\';
      
    GetKsPhotoFileList(sPath,not chk1.Checked, sList);

    for i := 0 to chklst_Sf.Items.Count - 1 do
    begin
      if not chklst_Sf.ItemChecked[i] then Continue;

      sSfstr := chklst_Sf.Items[i];
      Memo1.Lines.Add(sSfstr+':');

      sqlstr := 'select ʡ��,������ from lqmd where ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex])+
                ' and ʡ��='+quotedstr(sSfstr)+' order by ʡ��,������';
      cds_lqmd.XMLData := dm.OpenData(sqlstr);

      cds_Temp.XMLData := dm.OpenData('select top 0 * from �ļ��ϴ��ṹ��');

      if cds_lqmd.RecordCount>0 then
        UpdateProgressMax(cds_lqmd.RecordCount);
      ii := 0;
      while not cds_lqmd.Eof do
      begin
        UpdateProgress(cds_lqmd.RecNo);
        sKsh := cds_lqmd.FieldByName('������').AsString;
        sfn := GetKsPhotoFileName(sKsh);
        if (sfn<>'') and FileExists(sfn) then
        begin
          Inc(ii);
          Inc(Insert_Count);
          cds_Temp.Append;
          cds_Temp.FieldByName('Ksh').AsString := sKsh;
          cds_Temp.FieldByName('FileName').AsString := ExtractFileName(sfn);
          TBlobField(cds_Temp.FieldByName('FileData')).LoadFromFile(sfn);
          cds_Temp.Post;
          if (cds_Temp.RecordCount>=50) then
          begin
            UpdateProgressTitle('�����ϴ���'+sSfstr+'��������Ƭ....');
            if not SavePhoto then
              Break
            else
              UpdateProgressTitle('���ڲɼ���'+sSfstr+'��������Ƭ....');
          end;
        end else
          Memo1.Lines.Add('    '+sKsh+' ��Ƭ�ɼ�ʧ�ܣ�');
        cds_lqmd.Next;
      end;
      Memo1.Lines.Add('    '+sSfstr+'(��Ƭ��/������):'+IntToStr(ii)+'/'+IntTostr(cds_lqmd.RecordCount));
      UpdateProgressTitle('�����ϴ���'+sSfstr+'��������Ƭ....');
      if cds_Temp.RecordCount>0 then
      begin
        if not SavePhoto then
        begin
          Memo1.Lines.Add(sSfstr+'��Ƭ�ϴ�ʧ�ܣ�ԭ��Ϊ��');
          Memo1.Lines.Add(sError);
        end else
        begin
          //Update_Count := Update_Count+cds_Temp.RecordCount;
          Memo1.Lines.Add('    '+IntToStr(Update_Count)+' ����Ƭ�ϴ��ɹ���');
        end;
      end;
      Memo1.Lines.Add('');
    end;  //end for ...sf

    HideProgress;

    Memo1.Lines.Add('������ɣ�');
    Memo1.Lines.Add('���δ����ɼ���Ƭ��'+inttostr(Insert_Count)+'�ţ�������Ƭ��'+inttostr(Update_Count)+'�ţ�');
    Memo1.Lines.SaveToFile('Log.Txt');
    Memo1.Lines.Add('��־�ļ������Log.Txt�У�');

    if (Insert_Count>0) and (Update_Count>0) then
      MessageBox(Handle, '������ɣ�������Ƭ��Ϣ�ɼ���ɣ���', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_TOPMOST)
    else if (Insert_Count>0) and (Update_Count<=0) then
      MessageBox(Handle, '������ɣ�������Ƭ��Ϣ�ɼ�ʧ�ܣ���', 'ϵͳ��ʾ', MB_OK + MB_ICONERROR + MB_TOPMOST);

    btn_OK.Enabled := True;
  finally
    sList.Free;
    cds_lqmd.Close;
    cds_Temp.Close;
    HideProgress;
    btn_OK.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMareData_BDE_Photo.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  btnedt_Path.Text := GetKsDataPath;
  sList := TStringList.Create;
  try
    dm.GetXlCcList(sList);
    rg_XlCc.Items.Assign(sList);

    //dm.GetSfDirList(sList);
    //chklst_Sf.Items.Assign(sList);
    InitSfCheckList;
  finally
    sList.Free;
  end;
end;

procedure TMareData_BDE_Photo.LabeledEdit1Change(Sender: TObject);
begin
  //btn_OK.Enabled := LabeledEdit1.Text<>'';
end;

procedure TMareData_BDE_Photo.mni_Select2Click(Sender: TObject);
begin
  SelectSf(TMenuItem(Sender).Tag);
  SetState;
end;

procedure TMareData_BDE_Photo.rg_XlCcClick(Sender: TObject);
begin
  InitSfCheckList;
end;

procedure TMareData_BDE_Photo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  myIniFile.Free;
  Action := caFree;
end;

procedure TMareData_BDE_Photo.chk1Click(Sender: TObject);
begin
  btnedt_Path.Enabled := chk1.Checked;
end;

procedure TMareData_BDE_Photo.chklst_SfChange(Sender: TObject; Index: Integer;
  NewState: TCheckBoxState);
begin
  SetState;
end;

end.
