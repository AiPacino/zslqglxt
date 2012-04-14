unit uZySelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst, DB, RzLstBox,
  RzChkLst, Mask, DBCtrlsEh;

type
  TZySelect = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    btn_Select: TBitBtn;
    btn_Close: TBitBtn;
    chklst_Zy: TRzCheckList;
    cbb_Lb: TDBComboBoxEh;
    Label1: TLabel;
    procedure btn_SelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chklst_ZyClick(Sender: TObject);
    procedure chklst_ZyChange(Sender: TObject; Index: Integer;
      NewState: TCheckBoxState);
    procedure cbb_LbChange(Sender: TObject);
  private
    { Private declarations }
    sXlcc,sZyLb:string;
    aList:TStrings;
    procedure InitCheckList;
  public
    { Public declarations }
    ZyList:TStrings;
    procedure SetData(const Xlcc,ZyLb:string;const sList:TStrings);
  end;

var
  ZySelect: TZySelect;

implementation
uses uDM;
{$R *.dfm}

{ TZySelect }

procedure TZySelect.btn_SelectClick(Sender: TObject);
var
  i:Integer;
begin
  for i := chklst_Zy.Count - 1 downto 0 do
  begin
    if not chklst_Zy.ItemChecked[i] then
      ZyList.Delete(i);
  end;
end;

procedure TZySelect.cbb_LbChange(Sender: TObject);
begin
  if Self.Showing then InitCheckList;
end;

procedure TZySelect.chklst_ZyChange(Sender: TObject; Index: Integer;
  NewState: TCheckBoxState);
var
  i: Integer;
begin
  btn_Select.Enabled := False;
  for i := 0 to chklst_Zy.Count - 1 do
    if chklst_Zy.ItemChecked[i] then
    begin
      btn_Select.Enabled := True;
      Exit;
    end;
end;

procedure TZySelect.chklst_ZyClick(Sender: TObject);
var
  i: Integer;
begin
  btn_Select.Enabled := False;
  for i := 0 to chklst_Zy.Count - 1 do
    if chklst_Zy.ItemChecked[i] then
    begin
      btn_Select.Enabled := True;
      Exit;
    end;
end;

procedure TZySelect.FormCreate(Sender: TObject);
begin
  aList := TStringList.Create;
  ZyList := TStringList.Create;
  dm.SetLbComboBox(cbb_Lb);
end;

procedure TZySelect.FormDestroy(Sender: TObject);
begin
  aList.Free;
  ZyList.Free;
end;

procedure TZySelect.InitCheckList;
var
  sLb:string;
  i,ii: Integer;
begin
  if cbb_Lb.Text<>'==不限==' then
    sLb := cbb_Lb.Text
  else
    sLb := '';

  dm.getZyWithIdList(sXlcc,sLb,ZyList);
  for i := 0 to aList.Count - 1 do
  begin
    ii := ZyList.IndexOfName(aList.Strings[i]);
    if ii<>-1 then
      ZyList.Delete(ii);
  end;

  chklst_Zy.Items.Clear;
  for i:=0 to ZyList.Count-1 do
    chklst_Zy.Items.Add(ZyList.ValueFromIndex[i]);

  if Self.Showing then
    chklst_Zy.SetFocus;
end;

procedure TZySelect.SetData(const Xlcc,ZyLb:string;const sList:TStrings);
begin
  sXlcc := Xlcc;
  sZyLb := ZyLb;
  if sZyLb<>'' then
    cbb_Lb.Text := sZyLb;
  Self.Caption := '请勾选要增加的【'+sXlcc+'】专业';
  aList.Assign(sList);
  InitCheckList;

end;

end.
