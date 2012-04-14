unit uSetNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StatusBarEx, StdCtrls, Buttons, DB, ADODB,
  DBClient, RzPanel, RzRadGrp;

type
  TSetNumber = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    edt1: TEdit;
    Label2: TLabel;
    edt2: TEdit;
    StatusBarEx1: TStatusBarEx;
    rg1: TRzRadioGroup;
    cds_Temp: TClientDataSet;
    pnl1: TPanel;
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    lbl3: TLabel;
    lbl1: TLabel;
    ds_lqmd: TDataSource;
    procedure edt2DblClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure edt2Change(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure edt1Change(Sender: TObject);
  private
    { Private declarations }
    start_id:Integer;
    aXlcc:string;
    procedure SetMaxNumber;
  public
    { Public declarations }
    procedure SetData(const xlcc:string;const aDataSet:TDataSet);
  end;

var
  SetNumber: TSetNumber;

implementation
uses uDM;
{$R *.dfm}

procedure TSetNumber.edt2DblClick(Sender: TObject);
var
  s :string;
  ii:integer;
begin
  begin
    close;
    cds_Temp.Close;
    cds_Temp.XMLData := DM.OpenData('select max(��ˮ��) from lqmd where ��ˮ�� like '+quotedstr(Trim(edt1.Text)+'%'));
    if cds_Temp.Fields[0].IsNull then
      ii := 1
    else begin
      s := cds_Temp.Fields[0].AsString;
      s := Copy(s,Length(edt1.Text)+1,10);
      ii := StrToIntDef(s,0)+1;
    end;

    edt2.Text := FormatFloat('00000',ii);
    cds_Temp.Close;
  end;
end;

procedure TSetNumber.SetMaxNumber;
var
  s,sqlstr :string;
  ii:integer;
begin
  begin
    close;
    cds_Temp.Close;
    sqlstr := 'select max(��ˮ��) from lqmd where ѧ�����='+quotedstr(aXlcc);
    cds_Temp.XMLData := DM.OpenData(sqlstr);
    if cds_Temp.Fields[0].IsNull then
      ii := 1
    else begin
      s := cds_Temp.Fields[0].AsString;
      s := Copy(s,Length(edt1.Text)+1,10);
      ii := StrToIntDef(s,0)+1;
    end;
    edt2.Text := FormatFloat('00000',ii);
    cds_Temp.Close;
  end;
end;

procedure TSetNumber.SetData(const xlcc: string;
  const aDataSet: TDataSet);
begin
  aXlcc := xlcc;
  ds_lqmd.DataSet := aDataSet;
  if aXlcc='����' then
    edt1.Text := 'B'
  else
    edt1.Text := 'Z';
  SetMaxNumber;
end;

procedure TSetNumber.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSetNumber.btn_OKClick(Sender: TObject);
var
  vflag :Boolean;
  iCount :Integer;
  //sDate :string;
begin
  if Application.MessageBox('��Ŀ�ʼ����𣿡���', '���ȷ��', MB_YESNO +
    MB_ICONINFORMATION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  try
    Screen.Cursor := crHourGlass;
    ds_lqmd.DataSet.DisableControls;
    btn_OK.Enabled := False;
    start_id := StrToIntDef(edt2.Text,1);
    ds_lqmd.DataSet.First;
    iCount := 0;
    with ds_lqmd.DataSet do
    begin
      if rg1.ItemIndex = 1 then
      begin
        if Application.MessageBox('���Ҫ�Ե�ǰ��ʾ�ļ�¼����ͳһ��ʼ����𣿡���', '���ȷ��', MB_YESNO +
          MB_ICONINFORMATION + MB_DEFBUTTON2) = IDNO then
        begin
          Exit;
        end;
        if UPPERCASE(InputBox('��ʼ���ȷ��','������OK�ַ�ȷ�ϣ�',''))<>'OK' then
          Exit;
        First;
      end;
      while not eof do
      begin
        //sDate := FormatDateTime('yyyy-mm-dd',FieldByName('Action_Time').AsDateTime);
        vflag := True;
        if (rg1.ItemIndex = 0) and (Trim(FieldByName('��ˮ��').AsString)<>'') then
          vflag := False
        else
          vflag := True;
        if vflag then
        begin
          Inc(iCount);
          Edit;
          FieldByName('��ˮ��').AsString := edt1.Text+formatfloat('00000',start_id);
          //FieldByName('¼ȡ��������').AsString := sDate;
          Post;
        end;

        start_id := start_id+1;
        Next;
        StatusBarEx1.Panels.Items[1].Text := IntToStr(RecNo)+'/'+Inttostr(RecordCount);
        Application.ProcessMessages;
      end;
//-------------------------------------------------//
      if not DataSetNoSave(TClientDataSet(ds_lqmd.DataSet)) then Exit;
      if dm.UpdateData('������','select top 0 * from ¼ȡ��Ϣ��',TClientDataSet(ds_lqmd.DataSet).Delta,False) then
         TClientDataSet(ds_lqmd.DataSet).MergeChangeLog;
      //Open_Access_Table;
//-------------------------------------------------//
    end;
    btn_Exit.SetFocus;
  finally
    ds_lqmd.DataSet.EnableControls;
    Application.MessageBox(PChar('������ɣ�����'+IntToStr(iCount)+'����¼�ѱ�ţ�����'), '�������',
      MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
    btn_OK.Enabled := True;

    Screen.Cursor := crDefault;
  end;
end;

procedure TSetNumber.edt1Change(Sender: TObject);
begin
  lbl3.Caption := '������ʽ��'+edt1.Text+edt2.Text;
end;

procedure TSetNumber.edt2Change(Sender: TObject);
begin
  start_id := StrToIntDef(edt2.Text,1);
  lbl3.Caption := '������ʽ��'+edt1.Text+edt2.Text;
end;

end.
