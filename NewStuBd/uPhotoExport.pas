unit uPhotoExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, StdCtrls, Buttons, Mask,ShellAPI, StrUtils,
  DBCtrlsEh, ExtCtrls, pngimage,uStuInfo, Menus, DB, DBClient, ExtDlgs,CnProgressFrm,
  frxpngimage, DBGridEhGrouping;

type
  TPhotoExport = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    rg_Stu: TRadioGroup;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    Panel1: TPanel;
    cbb_Field: TDBComboBoxEh;
    cbb_Value: TEdit;
    btn_Exit: TBitBtn;
    btn_PhotoExport: TBitBtn;
    dxgrd_1: TDBGridEh;
    btn_Search: TBitBtn;
    lbl1: TLabel;
    cbb_PhotoFile: TDBComboBoxEh;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    SavePictureDialog1: TSavePictureDialog;
    pnl_Photo: TPanel;
    img_Photo: TImage;
    lbl_Len: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_PhotoExportClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rg_StuClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure cbb_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure cbb_ValueChange(Sender: TObject);
  private
    { Private declarations }
    sWebSrvUrl:string;
    sPath:string;
    StuInfo:TStuInfo;
    procedure GetYxList;
    procedure Open_Table;
    function  GetWhere:string;
    function  SavePhoto:Boolean;
    function DownLoadPhotoFromUrl(const Photo_Url:string;aImage:TImage=nil;const OverPhoto:Boolean=True):Boolean;
  public
    { Public declarations }
  end;

//var
//  PhotoExport: TPhotoExport;

implementation
uses uDM,Net;
{$R *.dfm}

procedure TPhotoExport.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TPhotoExport.btn_PhotoExportClick(Sender: TObject);
var
  sList:TStrings;
begin
  if MessageBox(Handle, '真的要导出当前已显示的新生照片吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  if not SelectFolder('选择照片导出目录','',sPath) then Exit;

  Screen.Cursor := crHourGlass;
  sList := TStringList.Create;
  try
    pnl_Photo.Visible := True;
    ShowProgress('正在处理....',ClientDataSet1.RecordCount);
    ClientDataSet1.First;
    sList.Clear;
    sList.Add('照片导出失败的新生名单：');
    ClientDataSet1.DisableControls;
    btn_PhotoExport.Enabled := False;
    while not ClientDataSet1.Eof do
    begin
      if not SavePhoto then
        sList.Add(IntToStr(sList.Count)+':'+ClientDataSet1.FieldByName('省份').AsString+':'+ClientDataSet1.FieldByName('考生号').AsString+'|'+ClientDataSet1.FieldByName('考生姓名').AsString);
      UpdateProgress(ClientDataSet1.RecNo);
      ClientDataSet1.Next;
      Application.ProcessMessages;
    end;
    sList.SaveToFile(sPath+'\导出结果.txt');
  finally
    ClientDataSet1.EnableControls;
    btn_PhotoExport.Enabled := True;
    sList.Free;
    HideProgress;
    pnl_Photo.Visible := False;
    Screen.Cursor := crDefault;
    MessageBox(Handle, '操作完成！照片信息已导出！　', '系统提示', MB_OK +
      MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST);
    ShellExecute(Handle,'open',PChar(sPath+'\导出结果.txt'),nil,PChar(sPath),SW_SHOW);
  end;
end;

procedure TPhotoExport.btn_SearchClick(Sender: TObject);
begin
  ClientDataSet1.Locate(cbb_Field.Text,cbb_Value.Text,[loCaseInsensitive, loPartialKey]);
end;

procedure TPhotoExport.cbb_YxChange(Sender: TObject);
begin
  if Self.Showing then
  begin
    Open_Table;
    dxgrd_1.SetFocus;
  end;
end;

function TPhotoExport.DownLoadPhotoFromUrl(const Photo_Url: string;
  aImage: TImage; const OverPhoto: Boolean): Boolean;
var
  sUrl:string;
begin
  sUrl := Trim(Photo_Url);
  if sUrl='' then Exit;
  
  if LowerCase(Copy(sUrl,1,7))<>'http:// 'then
    sUrl := sWebSrvUrl+sUrl;

  dm.DownLoadKsPhoto(sUrl,aImage,OverPhoto);
end;

procedure TPhotoExport.cbb_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(cbb_Value.Text))+')';
  if (LeftStr(cbb_Value.Text,1)='B') or (LeftStr(cbb_Value.Text,1)='Z') then
  begin
    if Copy(cbb_Value.Text,2,1)>'9' then
    begin
      cbb_Field.Text := '流水号';
      if Length(cbb_Value.Text)=7 then btn_Search.Click;
    end else
    begin
      cbb_Field.Text := '通知书编号';
      if Length(cbb_Value.Text)=8 then btn_Search.Click;
    end;
  end
  else  if LeftStr(cbb_Value.Text,2)=Copy(FormatDateTime('yyyy',Now),3,2) then
    cbb_Field.Text := '考生号';
end;

procedure TPhotoExport.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TPhotoExport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPhotoExport.FormCreate(Sender: TObject);
begin
  sWebSrvUrl := dm.GetWebSrvUrl;
  StuInfo := TStuInfo.Create(Self);
  StuInfo.DataSource1.DataSet := ClientDataSet1;
  GetYxList;
  if StrToIntDef(gb_Czy_Level,2)=2 then
  begin
    cbb_Yx.Enabled := False;
    cbb_Yx.Text := gb_Czy_Dept;
  end else
  begin
    cbb_Yx.Enabled := True;
    cbb_Yx.ItemIndex := 1;
  end;

  if gb_Czy_Level='2' then
  begin
    Self.Caption := '【'+gb_Czy_Dept+'】新生报到处理';
    lbl_Title.Caption := '新生报到处理';
  end;
  //rg_Stu.Enabled := gb_CanBd_BK and gb_CanBd_Zy;
  //rg_Stu.ItemIndex := -1;

  Open_Table;
end;

procedure TPhotoExport.FormResize(Sender: TObject);
begin
  pnl_Photo.Left := dxgrd_1.Width - pnl_Photo.Width - 2;
  pnl_Photo.Top := dxgrd_1.Height - pnl_Photo.Height - 2;
end;

function TPhotoExport.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>0 then
    sWhere := ' where 院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  sWhere := sWhere + ' and 学历层次='+quotedstr(rg_Stu.Items[rg_Stu.ItemIndex]);
  Result := sWhere;
end;

procedure TPhotoExport.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  dm.GetXlCcList(sList);
  rg_Stu.Items.Assign(sList);
  rg_Stu.ItemIndex := 0;
  try
    cbb_Yx.Items.Clear;
    dm.GetAllYxList(sList);
    cbb_Yx.Items.Add('不限院系');
    cbb_Yx.Items.AddStrings(sList);
  finally
    sList.Free;
  end;

end;

procedure TPhotoExport.Open_Table;
var
  sqlstr,sWhere:string;
begin
  Screen.Cursor := crHourGlass;
  if StuInfo.Showing then
    StuInfo.Close;
  ClientDataSet1.DisableControls;
  try
    sWhere := GetWhere;
    sqlstr := 'select * from 录取信息表 '+sWhere+' order by 流水号';
    ClientDataSet1.XMLData := dm.OpenData(sqlstr);
  finally
    ClientDataSet1.EnableControls;
    Screen.Cursor := crDefault;
  end;

end;

procedure TPhotoExport.rg_StuClick(Sender: TObject);
begin
  if Self.Showing then
  begin
    Open_Table;
    dxgrd_1.SetFocus;
  end;
end;

function TPhotoExport.SavePhoto:Boolean;
var
  ksh,photo_Url,fn,ext_fn:string;
begin
  Result := False;
  ksh := ClientDataSet1.FieldByName('考生号').AsString;
  ext_fn := ExtractFileExt(DataSource1.DataSet.FieldByName('照片文件').AsString);
  if ext_fn='' then Exit;

  fn := ClientDataSet1.FieldByName(cbb_PhotoFile.KeyItems[cbb_PhotoFile.ItemIndex]).AsString;
  fn := sPath+'\'+fn+ext_fn;

  //Photo_Url := DataSource1.DataSet.FieldByName('照片文件').AsString;
  if Self.Showing then
  begin
    img_Photo.Picture := nil;
    //DownLoadPhotoFromUrl(Photo_Url,img_Photo,False);
    Result := dm.DownLoadKsPhotoByKSH(ksh,fn,img_Photo,False);
  end;
end;

end.
