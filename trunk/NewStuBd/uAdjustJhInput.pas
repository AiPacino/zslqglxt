unit uAdjustJhInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrlsEh, DB, DBClient;

type
  TAdjustJhInput = class(TForm)
    cds_Zy: TClientDataSet;
    cbb_Sf: TDBComboBoxEh;
    cbb_Zy: TDBComboBoxEh;
    cbb_Kl: TDBComboBoxEh;
    edt_Count: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edt_OldCount: TDBEditEh;
    pnl_1: TPanel;
    btn_Post: TBitBtn;
    btn_Exit: TBitBtn;
    bvl1: TBevel;
    cds_Temp: TClientDataSet;
    Label1: TLabel;
    cbb_ZyLb: TDBComboBoxEh;
    lbl6: TLabel;
    edt_oldzjs: TDBEditEh;
    lbl7: TLabel;
    edt_Syjhs: TDBEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure cbb_ZyChange(Sender: TObject);
    procedure cbb_KlChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbb_ZyLbChange(Sender: TObject);
    procedure cbb_SfChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_OldCountChange(Sender: TObject);
    procedure edt_CountChange(Sender: TObject);
  private
    { Private declarations }
    aType:Integer;
    aNo,aXlCc,aSf,aCzLx,aZyId:string;
    aDataSet:TClientDataSet;
    procedure SaveData;
    procedure FillZyLb;
  public
    { Public declarations }
    procedure FillData(const iType:Integer;const sNo,sXlcc,sSf,sCzLx:string;const aCDS:TClientDataSet);
  end;

var
  AdjustJhInput: TAdjustJhInput;

implementation
uses uDM;
{$R *.dfm}

{ TAdjustJhInput }

procedure TAdjustJhInput.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TAdjustJhInput.btn_PostClick(Sender: TObject);
begin
  SaveData;
end;

procedure TAdjustJhInput.cbb_KlChange(Sender: TObject);
var
  sqlstr:string;
begin
  if cbb_Kl.Text='' then Exit;

  sqlstr := 'select 专业Id,计划数 from View_分省专业计划表 where 省份='+quotedstr(cbb_Sf.Text)+
            ' and 学历层次='+quotedstr(aXlcc)+' and 专业='+quotedstr(cbb_Zy.Text)+
            ' and 科类='+quotedstr(cbb_Kl.Text);
  cds_Temp.XMLData := DM.OpenData(sqlstr);

  aZyId := cds_Temp.Fields[0].AsString;
  edt_OldCount.Text := '';
  edt_OldCount.Text := cds_Temp.Fields[1].AsString;
  cds_Temp.Close;
  edt_oldzjs.Text := IntToStr(vobj.GetZyJHChgCount(aXLCc,cbb_Sf.Text, aZyId,cbb_Kl.Text));
end;

procedure TAdjustJhInput.cbb_SfChange(Sender: TObject);
begin
  FillZyLb;
end;

procedure TAdjustJhInput.cbb_ZyChange(Sender: TObject);
var
  sqlstr:string;
begin
  if cbb_Zy.Text='' then Exit;
  aZyId := cbb_Zy.Value;

  sqlstr := 'select 科类 from View_分省专业计划表 where 省份='+quotedstr(cbb_Sf.Text)+
            ' and 学历层次='+quotedstr(aXlcc)+' and 专业='+quotedstr(cbb_Zy.Text);

  cbb_Kl.Text := '';
  cbb_Kl.Items.Clear;
  edt_OldCount.Text := '';
  cds_Temp.XMLData := DM.OpenData(sqlstr);
  while not cds_Temp.Eof do
  begin
    cbb_Kl.Items.Add(cds_Temp.Fields[0].AsString);
    cds_Temp.Next;
  end;
  cds_Temp.Close;
end;

procedure TAdjustJhInput.cbb_ZyLbChange(Sender: TObject);
var
  sqlstr:string;
begin
  if cbb_Sf.Text='' then Exit;

  sqlstr := 'select distinct 专业Id,专业 from View_分省专业计划表 where 省份='+quotedstr(cbb_Sf.Text)+
            ' and 学历层次='+quotedstr(aXlcc)+' and 类别='+quotedstr(cbb_ZyLb.Text)+' order by 专业';
  cds_Temp.XMLData := DM.OpenData(sqlstr);

  cbb_Zy.Text := '';
  cbb_Zy.KeyItems.Clear;
  cbb_Zy.Items.Clear;
  cbb_Kl.Text := '';
  cbb_Kl.Items.Clear;
  edt_OldCount.Text := '';
  //edt_Count.Text := '';

  while not cds_Temp.Eof do
  begin
    cbb_Zy.KeyItems.Add(cds_Temp.Fields[0].AsString);
    cbb_Zy.Items.Add(cds_Temp.Fields[1].AsString);
    cds_Temp.Next;
  end;
  cds_Temp.Close;
end;

procedure TAdjustJhInput.edt_CountChange(Sender: TObject);
begin
  btn_Post.Enabled := StrToIntDef(edt_Syjhs.Text,0)+StrToIntDef(TEdit(Sender).Text,0)>=0;
end;

procedure TAdjustJhInput.edt_OldCountChange(Sender: TObject);
begin
  edt_Syjhs.Text := IntToStr(StrToIntDef(edt_OldCount.Text,0)+StrToIntDef(edt_oldzjs.Text,0));
end;

procedure TAdjustJhInput.FillData(const iType:Integer;const sNo,sXlcc,sSf,sCzLx: string;
  const aCDS: TClientDataSet);
begin
  cbb_sf.Items.Clear;
  cbb_Sf.Items.Add(sSf);
  aType := iType;
  aNo := sNo;
  aXlCc := sXlcc;
  aSf := sSf;
  aCzLx := sCzLx;
  aDataSet := aCDS;
  cbb_Sf.Text := aSf;
  cbb_Sf.OnChange(Self);
  cbb_Sf.Enabled := aCzLx<>'省内调整';
  if cbb_Sf.Enabled then
    cbb_Sf.Items.Add('预留计划');
end;

procedure TAdjustJhInput.FillZyLb;
var
  sqlstr:string;
begin
  cbb_zyLb.Text := '';
  cbb_ZyLb.Items.Clear;

  cbb_Zy.Text := '';
  cbb_Zy.Items.Clear;
  cbb_Kl.Text := '';
  cbb_Kl.Items.Clear;
  edt_OldCount.Text := '';

  cds_Temp.Close;
  sqlstr := 'select distinct 类别 from View_分省专业计划表 where 省份='+quotedstr(cbb_Sf.Text)+
            ' and 学历层次='+quotedstr(aXlcc)+' order by 类别';
  cds_Temp.XMLData := DM.OpenData(sqlstr);

  while not cds_Temp.Eof do
  begin
    cbb_ZyLb.Items.Add(cds_Temp.Fields[0].AsString);
    cds_Temp.Next;
  end;
  cds_Temp.Close;
end;

procedure TAdjustJhInput.FormCreate(Sender: TObject);
begin
  //dm.SetSfComboBox(cbb_Sf);
end;

procedure TAdjustJhInput.FormShow(Sender: TObject);
begin
  //dm.SetSfComboBox(cbb_Sf);
  cbb_Zy.Text := '';
  cbb_Kl.Text := '';
  edt_OldCount.Text := '';
  edt_Count.Text := '';
end;

procedure TAdjustJhInput.SaveData;
var
  sqlstr:string;
begin
  sqlstr := 'Insert Into 计划调整明细表 (pId,专业Id,科类,增减数) Values('+
            quotedstr(aNo)+','+aZyId+','+
            quotedstr(cbb_Kl.Text)+','+edt_Count.Text+')';
//  dm.ExecSql(sqlstr);
//{
  if aType=0 then
    aDataSet.Append
  else
    aDataSet.Edit;
  aDataSet.FieldByName('pId').AsString := aNo;
  //aDataSet.FieldByName('学历层次').AsString := aXlCc;
  //aDataSet.FieldByName('类别').AsString := cbb_ZyLb.Text;
  aDataSet.FieldByName('省份').AsString := cbb_Sf.Text;
  aDataSet.FieldByName('专业Id').AsString := aZyId;
  //aDataSet.FieldByName('专业').AsString := cbb_Zy.Text;
  aDataSet.FieldByName('科类').AsString := cbb_Kl.Text;
  aDataSet.FieldByName('增减数').AsString := edt_Count.Text;
  aDataSet.Post;
//}
{
  if aCzLx<>'省内调整' then
  begin
    aDataSet.Append;
    aDataSet.FieldByName('pId').AsString := aNo;
    aDataSet.FieldByName('专业Id').AsString := aZyId;//:=85
    aDataSet.FieldByName('科类').AsString := cbb_Kl.Text;//:='文理综合';
    aDataSet.FieldByName('增减数').AsInteger := - StrToIntDef(edt_Count.Text,0);
    aDataSet.Post;
  end;
}
end;

end.
