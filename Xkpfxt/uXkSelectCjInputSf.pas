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
  if cbb_Yx.Text='����ѧԺ' then
  begin
    lbl_Pw.Enabled := True;
    edt_Pw.Enabled := True;
  end else
  begin
    lbl_Pw.Enabled := False;
    edt_Pw.Enabled := False;
    edt_Pw.Text := '��';
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
  sqlstr := 'select Id,��ί from У����ί������ where �п�Ժϵ='+quotedstr(gb_Czy_Dept)+' order by ��ί';
  try
    cds_Temp.XMLData := dm.OpenData(sqlstr);
    edt_Pw.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('��ί').AsString);
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
    cds_Temp.XMLData := dm.OpenData('select distinct ʡ�� from У���������ñ� where �п�Ժϵ= '+quotedstr(cbb_Yx.Text));
    cbb_Sf.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('ʡ��').AsString);
      cds_Temp.Next;
    end;
    //cbb_Sf.Items.Add('����ʡ��');
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
    cds_Temp.XMLData := dm.OpenData('select distinct ���Կ�Ŀ from У����Ŀ�� where �п�Ժϵ='+quotedstr(cbb_Yx.Text));
    cbb_Zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('���Կ�Ŀ').AsString);
      cds_Temp.Next;
    end;
    //cbb_Zy.Items.Add('���޿�Ŀ');
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
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
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
    //cbb_Yx.Text := ReadString(Self.Name,'�п�Ժϵ',cbb_Yx.Text);
    //cbb_Zy.Text := ReadString(Self.Name,'���Կ�Ŀ',cbb_Zy.Text);
    cbb_Sf.Text := ReadString(Self.Name,'ʡ��',cbb_Sf.Text);
    edt_Pw.Text := ReadString(Self.Name,'��ί',edt_Pw.Text);
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
    //WriteString(Self.Name,'�п�Ժϵ',cbb_Yx.Text);
    WriteString(Self.Name,'ʡ��',cbb_Sf.Text);
    //WriteString(Self.Name,'���Կ�Ŀ',cbb_Zy.Text);
    WriteString(Self.Name,'��ί',edt_Pw.Text);
    Free;
  end;
end;

end.
