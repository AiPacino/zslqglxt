unit uXkSelectCjInputSf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,IniFiles,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzPanel, RzRadGrp, Mask, DBCtrlsEh,DBClient;

type
  TXkSelectCjInputSf = class(TForm)
    btn_OK: TBitBtn;
    btn_Cancel: TBitBtn;
    GroupBox1: TGroupBox;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    grp1: TGroupBox;
    cbb_Zy: TDBComboBoxEh;
    lbl1: TLabel;
    cbb_Sf: TDBComboBoxEh;
    lbl_Pw: TLabel;
    edt_Pw: TDBComboBoxEh;
    procedure btn_CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_SfChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    IsOK:Boolean;
    procedure LoadInfoFromIni;
    procedure SaveInfoToIni;
    procedure GetSfList;
    procedure GetXkKmList;
    procedure GetYxList;
    procedure GetPwList;
  public
    { Public declarations }
    fSf,fPw:string;
  end;

const
  MyiniFileName:ShortString = 'UserSet.Ini';
//var
//  SelectCjInputIndex: TSelectCjInputIndex;
  function SelectCjInputSf(const Yx,km:string;var sf,pw: string): Boolean;

implementation
uses uDM;
{$R *.dfm}


function SelectCjInputSf(const Yx,km:string;var sf,pw: string): Boolean;
var
  Form: TForm;
begin
  Result := False;
  with TXkSelectCjInputSf.Create(Application) do
  try
    cbb_Yx.Text := Yx;
    cbb_Zy.Text := km;

    if ShowModal = mrOk then
    begin
      sf := cbb_Sf.Text;
      pw := edt_Pw.Text;
      Result := True;
    end;
  finally
    Free;
  end;
end;

procedure TXkSelectCjInputSf.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TXkSelectCjInputSf.cbb_SfChange(Sender: TObject);
begin
  btn_OK.Enabled := (cbb_Sf.Text <> '') and (edt_Pw.Text<>'');
end;

procedure TXkSelectCjInputSf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveInfoToIni;
end;

procedure TXkSelectCjInputSf.FormCreate(Sender: TObject);
begin
  IsOK := False;
end;

procedure TXkSelectCjInputSf.FormShow(Sender: TObject);
begin
  GetSfList;
  GetPwList;
  LoadInfoFromIni;
  if cbb_Yx.Text='音乐学院' then
  begin
    lbl_Pw.Enabled := True;
    edt_Pw.Enabled := True;
  end else
  begin
    lbl_Pw.Enabled := False;
    edt_Pw.Enabled := False;
    edt_Pw.Text := '无';
  end;
end;

procedure TXkSelectCjInputSf.GetPwList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
  sqlstr:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  sqlstr := 'select Id,评委 from 校考评委名单表 where 承考院系='+quotedstr(gb_Czy_Dept)+' order by 评委';
  try
    cds_Temp.XMLData := dm.OpenData(sqlstr);
    edt_Pw.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('评委').AsString);
      cds_Temp.Next;
    end;
    edt_Pw.Items.AddStrings(sList);
    edt_Pw.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkSelectCjInputSf.GetSfList;
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

procedure TXkSelectCjInputSf.GetXkKmList;
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

procedure TXkSelectCjInputSf.GetYxList;
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

procedure TXkSelectCjInputSf.LoadInfoFromIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+MyIniFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    //cbb_Yx.Text := ReadString(Self.Name,'承考院系',cbb_Yx.Text);
    //cbb_Zy.Text := ReadString(Self.Name,'考试科目',cbb_Zy.Text);
    cbb_Sf.Text := ReadString(Self.Name,'省份',cbb_Sf.Text);
    edt_Pw.Text := ReadString(Self.Name,'评委',edt_Pw.Text);
    Free;
  end;
end;

procedure TXkSelectCjInputSf.SaveInfoToIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+MyIniFileName;
  with TIniFile.Create(fn) do
  begin
    //WriteString(Self.Name,'承考院系',cbb_Yx.Text);
    WriteString(Self.Name,'省份',cbb_Sf.Text);
    //WriteString(Self.Name,'考试科目',cbb_Zy.Text);
    WriteString(Self.Name,'评委',edt_Pw.Text);
    Free;
  end;
end;

end.
