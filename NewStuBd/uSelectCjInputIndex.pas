unit uSelectCjInputIndex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,IniFiles,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzPanel, RzRadGrp, Mask, DBCtrlsEh,DBClient;

type
  TSelectCjInputIndex = class(TForm)
    RadioGroup1: TRzRadioGroup;
    btn_OK: TBitBtn;
    btn_Cancel: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    grp1: TGroupBox;
    cbb_Zy: TDBComboBoxEh;
    grp2: TGroupBox;
    cbb_Sf: TDBComboBoxEh;
    procedure btn_CancelClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    IsOK:Boolean;
    procedure LoadInfoFromIni;
    procedure SaveInfoToIni;
    procedure GetSfList;
    procedure GetXkKmList;
    procedure GetYxList;
  public
    { Public declarations }
  end;

const
  MyiniFileName:ShortString = 'UserSet.Ini';
//var
//  SelectCjInputIndex: TSelectCjInputIndex;
  function SelectCjInputNo(var Yx,Sf,km:string;var cjIndex: Integer): Boolean;

implementation
uses uDM;
{$R *.dfm}


function SelectCjInputNo(var Yx,Sf,km:string;var cjIndex: Integer): Boolean;
var
  Form: TForm;
begin
  Result := False;
  with TSelectCjInputIndex.Create(Application) do
  try
    if ShowModal = mrOk then
    begin
      yx := cbb_Yx.Text;
      sf := cbb_Sf.Text;
      km := cbb_Zy.Text;
      cjIndex := RadioGroup1.ItemIndex;
      Result := IsOK;
    end;
  finally
    Free;
  end;
end;

procedure TSelectCjInputIndex.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TSelectCjInputIndex.btn_OKClick(Sender: TObject);
var
  yx,sf,km,sError:string;
begin
  yx := cbb_Yx.Text;
  sf := cbb_Sf.Text;
  km := cbb_Zy.Text;
  if vobj.CjIsPosted(RadioGroup1.ItemIndex+1,Yx,Sf,Km) then
  begin
    MessageBox(Handle, PChar('【'+Sf+Km+'】第'+IntToStr(RadioGroup1.ItemIndex+1)+'次成绩数据已上传，不能再进行录入了！　'), 
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;

  if not vobj.InitCjStateData(yx,sf,km,sError) then
  begin
    MessageBox(Handle, PChar('初始化成绩录入状态失败！'+'　　'+#13+sError+'　　'), '系统提示', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;
  if not vobj.InitCjInputData(yx,sf,km,False,sError) then
  begin
    MessageBox(Handle, PChar('生成成绩录入数据失败！'+'　　'+#13+sError+'　　'), '系统提示', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;
  if (RadioGroup1.ItemIndex=1) and (not vobj.FirstCjIsEnd(yx,sf,km)) then
  begin
    MessageBox(Handle, '本科目的第一次成绩录入还未完成，暂时还　　' + #13#10 + 
      '不能进行第二次成绩录入！', '系统提示', MB_OK + MB_ICONSTOP +
      MB_TOPMOST);
    Exit;
  end;
  IsOK := True;
end;

procedure TSelectCjInputIndex.cbb_YxChange(Sender: TObject);
begin
  GetSfList;
  GetXkKmList;
end;

procedure TSelectCjInputIndex.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveInfoToIni;
end;

procedure TSelectCjInputIndex.FormCreate(Sender: TObject);
begin
  IsOK := False;
  GetYxList;
  LoadInfoFromIni;
end;

procedure TSelectCjInputIndex.GetSfList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select distinct 省份 from 校考考点设置表 where 承考院系= '+quotedstr(cbb_Yx.Text));
    cbb_Sf.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('省份').AsString);
      cds_Temp.Next;
    end;
    //cbb_Sf.Items.Add('不限省份');
    cbb_Sf.Items.AddStrings(sList);
    cbb_Sf.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TSelectCjInputIndex.GetXkKmList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select distinct 考试科目 from 校考科目表 where 承考院系='+quotedstr(cbb_Yx.Text));
    cbb_Zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('考试科目').AsString);
      cds_Temp.Next;
    end;
    //cbb_Zy.Items.Add('不限科目');
    cbb_Zy.Items.AddStrings(sList);
    cbb_Zy.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TSelectCjInputIndex.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    //if gb_Czy_Level<>'2' then
    begin
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
    end;// else
    //  sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TSelectCjInputIndex.LoadInfoFromIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+MyIniFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    cbb_Yx.Text := ReadString(Self.Name,'承考院系',cbb_Yx.Text);
    cbb_Sf.Text := ReadString(Self.Name,'省份',cbb_Sf.Text);
    cbb_Zy.Text := ReadString(Self.Name,'考试科目',cbb_Zy.Text);
    RadioGroup1.ItemIndex := ReadInteger(Self.Name,'录入顺序',RadioGroup1.ItemIndex);
    Free;
  end;
end;

procedure TSelectCjInputIndex.RadioGroup1Click(Sender: TObject);
begin
  btn_OK.Enabled := RadioGroup1.ItemIndex<>-1;
end;

procedure TSelectCjInputIndex.SaveInfoToIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+MyIniFileName;
  with TIniFile.Create(fn) do
  begin
    WriteString(Self.Name,'承考院系',cbb_Yx.Text);
    WriteString(Self.Name,'省份',cbb_Sf.Text);
    WriteString(Self.Name,'考试科目',cbb_Zy.Text);
    WriteInteger(Self.Name,'录入顺序',RadioGroup1.ItemIndex);
    Free;
  end;
end;

end.
