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
    edt_OldCount: TEdit;
    pnl_1: TPanel;
    btn_Post: TBitBtn;
    btn_Exit: TBitBtn;
    bvl1: TBevel;
    cds_Temp: TClientDataSet;
    Label1: TLabel;
    cbb_ZyLb: TDBComboBoxEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure cbb_ZyChange(Sender: TObject);
    procedure cbb_KlChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbb_ZyLbChange(Sender: TObject);
    procedure cbb_SfChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

  sqlstr := 'select רҵId,�ƻ��� from View_��ʡרҵ�ƻ��� where ʡ��='+quotedstr(cbb_Sf.Text)+
            ' and ѧ�����='+quotedstr(aXlcc)+' and רҵ='+quotedstr(cbb_Zy.Text)+
            ' and ����='+quotedstr(cbb_Kl.Text);
  cds_Temp.XMLData := DM.OpenData(sqlstr);

  //aZyId := cds_Temp.Fields[0].AsString;
  edt_OldCount.Text := '';
  edt_OldCount.Text := cds_Temp.Fields[1].AsString;
  cds_Temp.Close;
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

  sqlstr := 'select ���� from View_��ʡרҵ�ƻ��� where ʡ��='+quotedstr(cbb_Sf.Text)+
            ' and ѧ�����='+quotedstr(aXlcc)+' and רҵ='+quotedstr(cbb_Zy.Text);

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

  sqlstr := 'select distinct רҵId,רҵ from View_��ʡרҵ�ƻ��� where ʡ��='+quotedstr(cbb_Sf.Text)+
            ' and ѧ�����='+quotedstr(aXlcc)+' and ���='+quotedstr(cbb_ZyLb.Text)+' order by רҵ';
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

procedure TAdjustJhInput.FillData(const iType:Integer;const sNo,sXlcc,sSf,sCzLx: string;
  const aCDS: TClientDataSet);
begin
  aType := iType;
  aNo := sNo;
  aXlCc := sXlcc;
  aSf := sSf;
  aCzLx := sCzLx;
  aDataSet := aCDS;
  cbb_Sf.Text := aSf;
  cbb_Sf.OnChange(Self);
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
  sqlstr := 'select distinct ��� from View_��ʡרҵ�ƻ��� where ʡ��='+quotedstr(cbb_Sf.Text)+
            ' and ѧ�����='+quotedstr(aXlcc)+' order by ���';
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
  dm.SetSfComboBox(cbb_Sf);
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
  sqlstr := 'Insert Into �ƻ�������ϸ�� (pId,רҵId,����,������) Values('+
            quotedstr(aNo)+','+aZyId+','+
            quotedstr(cbb_Kl.Text)+','+edt_Count.Text+')';
//  dm.ExecSql(sqlstr);
//{
  if aType=0 then
    aDataSet.Append
  else
    aDataSet.Edit;
  aDataSet.FieldByName('pId').AsString := aNo;
  //aDataSet.FieldByName('ѧ�����').AsString := aXlCc;
  //aDataSet.FieldByName('ʡ��').AsString := cbb_Sf.Text;
  //aDataSet.FieldByName('���').AsString := cbb_ZyLb.Text;
  aDataSet.FieldByName('רҵId').AsString := aZyId;
  //aDataSet.FieldByName('רҵ').AsString := cbb_Zy.Text;
  aDataSet.FieldByName('����').AsString := cbb_Kl.Text;
  aDataSet.FieldByName('������').AsString := edt_Count.Text;
  aDataSet.Post;
//}
  if aCzLx<>'ʡ�ڵ���' then
  begin
    aDataSet.Append;
    aDataSet.FieldByName('pId').AsString := aNo;
    aDataSet.FieldByName('רҵId').AsString := '85';
    aDataSet.FieldByName('����').AsString := '�����ۺ�';
    aDataSet.FieldByName('������').AsInteger := - StrToIntDef(edt_Count.Text,0);
    aDataSet.Post;
  end;
end;

end.
