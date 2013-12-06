unit uSelectZyKmPw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzLstBox, RzChkLst, ComCtrls, RzTreeVw,
  DB, DBClient;

type
  TSelectZyKmPw = class(TForm)
    GroupBox2: TGroupBox;
    RzCheckList1: TRzCheckList;
    Panel1: TPanel;
    Bevel1: TBevel;
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_OKClick(Sender: TObject);
  private
    { Private declarations }
    aYx,aSf,aKd,aZy,aKm:string;
    cds_Delta:TClientDataSet;
    procedure InitZyKmCheckList;
    procedure InitPwCheckList;
  public
    { Public declarations }
    procedure SetParam(const yx,sf,kd,zy,km:string;sDataSet:TClientDataSet);
  end;

var
  SelectZyKmPw: TSelectZyKmPw;

implementation
uses uDM;
{$R *.dfm}

procedure TSelectZyKmPw.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSelectZyKmPw.btn_OKClick(Sender: TObject);
var
  i:Integer;
  swhere,sqlstr,pw:string;
  bFound:Boolean;
begin
  for i := 0 to RzCheckList1.Count - 1 do
  begin
    pw := RzCheckList1.Items[i];
    bFound := cds_Delta.Locate('��ί',pw,[]);
    if RzCheckList1.ItemChecked[i] then
    begin
      if (not bFound) then
      with cds_Delta do
      begin
        Append;
        FieldByName('�п�Ժϵ').Value := ayx;
        FieldByName('ʡ��').Value := asf;
        FieldByName('��������').Value := akd;
        FieldByName('רҵ').Value := azy;
        FieldByName('��ί').Value := pw;
        FieldByName('�Ƿ�ǩ��').AsBoolean := False;
        //FieldByName('��Ŀ').Value := km;
        Post;
      end;
    end else
    begin
      if bFound then
        cds_Delta.Delete;
    end;
  end;
  if IsModified(cds_Delta) then
  begin
    if dm.UpdateData('Id','select top 0 * from У��������ί���ñ�',cds_Delta.Delta,True) then
      cds_Delta.MergeChangeLog;
  end;
end;

procedure TSelectZyKmPw.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSelectZyKmPw.InitPwCheckList;
var
  cds_Temp:TClientDataSet;
  i: Integer;
  pw :string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select ��ί from У����ί������ where �п�Ժϵ='+quotedstr(aYx)+' order by ��ί');
    RzCheckList1.Items.Clear;
    RzCheckList1.Items.BeginUpdate;
    while not cds_Temp.Eof do
    begin
      RzCheckList1.Add(cds_Temp.Fields[0].Asstring);
      cds_Temp.Next;
    end;
    for i := 0 to RzCheckList1.Count - 1 do
    begin
      pw := RzCheckList1.Items[i];
      if cds_Delta.Locate('��ί',pw,[]) then
        RzCheckList1.ItemState[i] := cbChecked;
    end;
  finally
    RzCheckList1.Items.EndUpdate;
    cds_Temp.Free;
  end;
end;

procedure TSelectZyKmPw.InitZyKmCheckList;
begin
end;

procedure TSelectZyKmPw.SetParam(const yx, sf, kd,zy,km: string;sDataSet:TClientDataSet);
begin
  aYx := yx;
  aSf := sf;
  aKd := kd;
  aZy := zy;
  aKm := km;
  cds_Delta := sDataSet;
  InitZyKmCheckList;
  InitPwCheckList;
end;

end.
