unit uSelectYxKdZy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,DBClient, DB, Mask, DBCtrlsEh;

type
  TSelectYxKdZy = class(TForm)
    cbb_yx: TDBComboBoxEh;
    cbb_Kd: TComboBox;
    cbb_Zy: TComboBox;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    pnl1: TPanel;
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure cbb_yxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_KdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure InitKdZyList(const yx:string);
  public
    { Public declarations }
  end;

var
  SelectYxKdZy: TSelectYxKdZy;

implementation
uses udm;
{$R *.dfm}

procedure TSelectYxKdZy.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSelectYxKdZy.cbb_KdChange(Sender: TObject);
begin
  btn_OK.Enabled := (cbb_yx.Text<>'') and (cbb_Kd.Text<>'') and (cbb_Zy.Text<>'');
end;

procedure TSelectYxKdZy.cbb_yxChange(Sender: TObject);
begin
  InitKdZyList(cbb_yx.Text);
end;

procedure TSelectYxKdZy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSelectYxKdZy.FormCreate(Sender: TObject);
begin
  dm.GetYxList(cbb_yx);
end;

procedure TSelectYxKdZy.InitKdZyList(const yx: string);
var
  sf,kd,zy,sqlstr:string;
  cds_temp:TClientDataSet;
begin
  cds_temp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select ʡ��,�������� from У���������ñ� where �п�Ժϵ='+quotedstr(yx)+' order by ʡ��,�п�Ժϵ';
    cds_temp.XmlData := dm.OpenData(sqlstr);
    cbb_Kd.Items.Clear;
    while not cds_temp.Eof do
    begin
      sf := cds_temp.fieldbyname('ʡ��').Asstring;
      kd := cds_temp.fieldbyname('��������').Asstring;
      cbb_Kd.Items.Add(sf+'|'+kd);
      cds_temp.Next;
    end;
    sqlstr := 'select רҵ from У��רҵ�� where �п�Ժϵ='+quotedstr(yx)+' order by רҵ';
    cds_temp.XmlData := dm.OpenData(sqlstr);
    cbb_zy.Items.Clear;
    while not cds_temp.Eof do
    begin
      zy := cds_temp.fieldbyname('רҵ').Asstring;
      cbb_zy.Items.Add(zy);
      cds_temp.Next;
    end;

  finally
    cds_temp.Free;
  end;
end;

end.
