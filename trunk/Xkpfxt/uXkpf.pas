unit uXkpf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, RzBorder, DBCtrls, Mask,
  DBGridEhGrouping, GridsEh, DBGridEh;

type
  TXkpf = class(TForm)
    pnl_right: TPanel;
    pnl1: TPanel;
    led_Time: TRzLEDDisplay;
    lbl1: TLabel;
    pnl2: TPanel;
    bvl2: TBevel;
    pnl3: TPanel;
    btn_1: TBitBtn;
    btn_2: TBitBtn;
    cds_Cj: TClientDataSet;
    ds_Cj: TDataSource;
    cds_stu: TClientDataSet;
    ds_stu: TDataSource;
    cds_stuId: TAutoIncField;
    cds_stuStringField: TStringField;
    cds_stuStringField2: TStringField;
    cds_stuStringField3: TStringField;
    cds_stuStringField4: TStringField;
    cds_stuStringField5: TStringField;
    cds_stuStringField6: TStringField;
    cds_stuStringField7: TStringField;
    cds_stuStringField8: TStringField;
    cds_stuStringField9: TStringField;
    cds_stuStringField10: TStringField;
    cds_stuDateTimeField: TDateTimeField;
    cds_stuDateTimeField2: TDateTimeField;
    cds_stuFloatField: TFloatField;
    cds_stuStringField11: TStringField;
    cds_stuStringField12: TStringField;
    cds_stuStringField13: TStringField;
    cds_stuStringField14: TStringField;
    grp1: TGroupBox;
    lbl2: TLabel;
    dbedt1: TDBEdit;
    lbl3: TLabel;
    dbedt2: TDBEdit;
    lbl4: TLabel;
    dbedt3: TDBEdit;
    lbl5: TLabel;
    dbedt4: TDBEdit;
    lbl6: TLabel;
    dbedt5: TDBEdit;
    lbl7: TLabel;
    dbedt6: TDBEdit;
    lbl8: TLabel;
    dbedt7: TDBEdit;
    lbl9: TLabel;
    dbedt8: TDBEdit;
    lbl10: TLabel;
    dbedt9: TDBEdit;
    lbl11: TLabel;
    lbl12: TLabel;
    dbedt11: TDBEdit;
    dbmmo1: TDBMemo;
    btn_3: TBitBtn;
    btn_4: TBitBtn;
    tmr1: TTimer;
    pnl4: TPanel;
    lbl13: TLabel;
    dbedt_Rch: TDBEdit;
    pnl_cj: TPanel;
    DBGridEh2: TDBGridEh;
    lbl_Rch: TLabel;
    pnl5: TPanel;
    btn_5: TBitBtn;
    procedure tmr1Timer(Sender: TObject);
    procedure btn_3Click(Sender: TObject);
    procedure btn_4Click(Sender: TObject);
    procedure btn_2Click(Sender: TObject);
    procedure btn_1Click(Sender: TObject);
    procedure btn_5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    aKsh:string;
    aRch:string;
    aYx,aSf,aKd,aZy:string;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy:string);
  end;

var
  Xkpf: TXkpf;

implementation
uses uDM, uPwqd;
{$R *.dfm}

procedure TXkpf.btn_1Click(Sender: TObject);
begin
  with TPwqd.Create(nil) do
  begin
    SetParam(ayx,asf,akd,azy);
    if ShowModal=mrOk then
    begin
      btn_1.Enabled := False;
      btn_2.Enabled := True;
      cds_Cj.Close;
    end;
  end;
end;

procedure TXkpf.btn_2Click(Sender: TObject);
var
  ksh,sqlstr:string;
begin
  ksh:=InputBox('�����룺','�����뿼����Ϣ(׼��֤�š������š����֤��)','');
  if ksh<>'' then
  begin
    sqlstr := 'select * from У����������רҵ�� where ������='+quotedstr(ksh)+
                                               ' or ���֤��='+quotedstr(ksh)+
                                               ' or ׼��֤��='+quotedstr(ksh);
    cds_stu.XMLData := dm.OpenData(sqlstr);
    if cds_stu.RecordCount=0 then
      Application.MessageBox('������Ϣ�����ڣ�������������룡  ', 'ϵͳ��ʾ',
        MB_OK + MB_ICONSTOP + MB_TOPMOST)
    else
    begin
      aRch := Format('%.4d',[StrToIntDef(aRch,0)+1]);
      dbedt_Rch.Text := aRch;
      lbl_Rch.Caption := '���ڶ��볡��Ϊ��'+aRch+'���Ŀ����������֣�';
      cds_Cj.XMLData := DM.OpenData('select * from У������ɼ�¼��� where 1=0');
      with cds_Cj do
      begin
        Append;
        FieldByName('¼�����').Value := '0001';
        FieldByName('��ί').Value := '�¾�';
        FieldByName('���Կ�Ŀ').Value := '�赸�༴�˱���';
        Append;
        FieldByName('¼�����').Value := '0001';
        FieldByName('��ί').Value := '�¾�';
        FieldByName('���Կ�Ŀ').Value := '�赸�༼�ܲ���';

        Append;
        FieldByName('¼�����').Value := '0002';
        FieldByName('��ί').Value := '����';
        FieldByName('���Կ�Ŀ').Value := '�赸�༴�˱���';
        Append;
        FieldByName('¼�����').Value := '0002';
        FieldByName('��ί').Value := '����';
        FieldByName('���Կ�Ŀ').Value := '�赸�༼�ܲ���';

        Append;
        FieldByName('¼�����').Value := '0003';
        FieldByName('��ί').Value := '����';
        FieldByName('���Կ�Ŀ').Value := '�赸�༴�˱���';
        Append;
        FieldByName('¼�����').Value := '0003';
        FieldByName('��ί').Value := '����';
        FieldByName('���Կ�Ŀ').Value := '�赸�༼�ܲ���';
        Post;
      end;
      btn_3.Enabled := True;
    end;
  end
end;

procedure TXkpf.btn_3Click(Sender: TObject);
begin
  tmr1.Tag := 0;
  tmr1.Enabled := True;
  btn_2.Enabled := False;
  btn_4.Enabled := True;
end;

procedure TXkpf.btn_4Click(Sender: TObject);
begin
  tmr1.Enabled := False;
  btn_2.Enabled := False;
  btn_3.Enabled := False;
  btn_4.Enabled := False;
  btn_5.Enabled := True;
end;

procedure TXkpf.btn_5Click(Sender: TObject);
begin
  tmr1.Enabled := False;
  btn_2.Enabled := True;
  btn_3.Enabled := False;
  btn_4.Enabled := False;
  btn_5.Enabled := False;
end;

procedure TXkpf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkpf.SetParam(const yx, sf, kd, zy: string);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
end;

procedure TXkpf.tmr1Timer(Sender: TObject);
var
  lt:integer;
begin
  led_Time.Tag := led_Time.Tag+1;
  lt := led_Time.Tag;
  led_Time.Caption := Format('%-.2d:%-.2d',[lt div 60,lt mod 60]);
end;

end.
