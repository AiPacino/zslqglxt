unit uSelectYxKdZy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,DBClient, DB, Mask, DBCtrlsEh;

type
  TSelectYxKdZy = class(TForm)
    cbb_yx: TDBComboBoxEh;
    cbb_Kd: TDBComboBoxEh;
    cbb_Zy: TDBComboBoxEh;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    pnl1: TPanel;
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    lbl2: TLabel;
    cbb_Sf: TDBComboBoxEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_KdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbb_SfButtonDown(Sender: TObject; TopButton: Boolean;
      var AutoRepeat, Handled: Boolean);
    procedure cbb_KdButtonDown(Sender: TObject; TopButton: Boolean;
      var AutoRepeat, Handled: Boolean);
    procedure cbb_ZyButtonDown(Sender: TObject; TopButton: Boolean;
      var AutoRepeat, Handled: Boolean);
  private
    { Private declarations }
    procedure InitSfList(const yx:string);
    procedure InitKdList(const yx,sf:string);
    procedure InitZyList(const yx:string);
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

procedure TSelectYxKdZy.cbb_KdButtonDown(Sender: TObject; TopButton: Boolean;
  var AutoRepeat, Handled: Boolean);
begin
  InitKdList(cbb_yx.Text,cbb_Sf.Text);
end;

procedure TSelectYxKdZy.cbb_KdChange(Sender: TObject);
begin
  btn_OK.Enabled := (cbb_yx.Text<>'') and (cbb_sf.Text<>'') and (cbb_Kd.Text<>'') and (cbb_Zy.Text<>'');
end;

procedure TSelectYxKdZy.cbb_SfButtonDown(Sender: TObject; TopButton: Boolean;
  var AutoRepeat, Handled: Boolean);
begin
  InitSfList(cbb_yx.Text);
end;

procedure TSelectYxKdZy.cbb_ZyButtonDown(Sender: TObject; TopButton: Boolean;
  var AutoRepeat, Handled: Boolean);
begin
  InitZyList(cbb_yx.Text);
end;

procedure TSelectYxKdZy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSelectYxKdZy.FormCreate(Sender: TObject);
begin
  dm.GetYxList(cbb_yx);
end;

procedure TSelectYxKdZy.InitKdList(const yx,sf: string);
var
  kd,sqlstr:string;
  cds_temp:TClientDataSet;
begin
  cds_temp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select �������� from У���������ñ� where �п�Ժϵ='+quotedstr(yx)+' and ʡ��='+quotedstr(sf)+' order by �п�Ժϵ';
    cds_temp.XmlData := dm.OpenData(sqlstr);
    cbb_Kd.Items.Clear;
    while not cds_temp.Eof do
    begin
      kd := cds_temp.fieldbyname('��������').Asstring;
      cbb_Kd.Items.Add(kd);
      cds_temp.Next;
    end;
  finally
    cds_temp.Free;
  end;
end;

procedure TSelectYxKdZy.InitZyList(const yx: string);
var
  zy,sqlstr:string;
  cds_temp:TClientDataSet;
begin
  cds_temp := TClientDataSet.Create(nil);
  try
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

procedure TSelectYxKdZy.InitSfList(const yx: string);
var
  sf,sqlstr:string;
  cds_temp:TClientDataSet;
begin
  cds_temp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select distinct ʡ�� from У���������ñ� where �п�Ժϵ='+quotedstr(yx)+' order by ʡ��';
    cds_temp.XmlData := dm.OpenData(sqlstr);
    cbb_sf.Items.Clear;
    while not cds_temp.Eof do
    begin
      sf := cds_temp.fieldbyname('ʡ��').Asstring;
      cbb_sf.Items.Add(sf);
      cds_temp.Next;
    end;
  finally
    cds_temp.Free;
  end;
end;

end.
