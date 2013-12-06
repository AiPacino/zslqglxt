unit uXkKdEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrlsEh, Mask, Buttons, DB, DBClient;

type
  TXkKdEdit = class(TForm)
    GroupBox1: TGroupBox;
    btn_Save: TBitBtn;
    btn_Cancel: TBitBtn;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edt_BmStart: TDBDateTimeEditEh;
    edt_KsStart: TDBDateTimeEditEh;
    edt_lxr: TEdit;
    edt_Tel: TEdit;
    edt_BmEnd: TDBDateTimeEditEh;
    edt_KsEnd: TDBDateTimeEditEh;
    lbl7: TLabel;
    lbl8: TLabel;
    edt_Kdmc: TEdit;
    DataSource1: TDataSource;
    lbl1: TLabel;
    cbb_Sf: TDBComboBoxEh;
    lbl9: TLabel;
    lbl10: TLabel;
    edt_addr: TEdit;
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure cbb_SfChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Old_Kdmc:string;
    fEditType:Integer; //EditType= 0 :增加，1:编辑
    procedure GetYxList;
    procedure GetSfList;
    procedure LoadData;
    procedure SaveData;
  public
    { Public declarations }
    procedure SetEditType(const EditType:Integer); //EditType= 0 :增加，1:编辑
  end;

var
  XkKdEdit: TXkKdEdit;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKdEdit.btn_CancelClick(Sender: TObject);
begin
  DataSource1.DataSet.Cancel;
  Self.Close;
end;

procedure TXkKdEdit.btn_SaveClick(Sender: TObject);
begin
  SaveData;
  Close;
end;

procedure TXkKdEdit.cbb_SfChange(Sender: TObject);
begin
  if Sender is TDBComboBoxEh then
  begin
    if (cbb_Sf.Text<>'') and (edt_Kdmc.Text='') then
    begin
      edt_Kdmc.Text := cbb_Sf.Text+edt_kdmc.Text;
      edt_Kdmc.SetFocus;
    end;
  end;

  btn_Save.Enabled := (cbb_Sf.Text<>'') and (edt_Kdmc.Text<>'') and (edt_lxr.Text<>'') and (edt_Tel.Text<>'') and
                      (edt_BmStart.Text<>'') and (edt_BmEnd.Text<>'') and (edt_KsStart.Text<>'') and (edt_KsEnd.Text<>'');
end;

procedure TXkKdEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Action := caFree;
end;

procedure TXkKdEdit.FormCreate(Sender: TObject);
begin
  GetSfList;
end;

procedure TXkKdEdit.FormShow(Sender: TObject);
begin
  LoadData;
  cbb_Sf.SetFocus;
end;

procedure TXkKdEdit.GetSfList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select 短名称 from view_省份表');
    cbb_Sf.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('短名称').AsString);
      cds_Temp.Next;
    end;
    cbb_Sf.Items.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkKdEdit.GetYxList;
begin
end;

procedure TXkKdEdit.LoadData;
var
  DataSet:TDataSet;
begin

  DataSet := DataSource1.DataSet;
  with DataSet do
  begin
    if fEditType=0 then
    begin
      edt_Kdmc.Text := '';
      cbb_Sf.Text := '';
      edt_BmStart.Value := FieldByName('报考开始时间').AsDateTime;
      edt_BmEnd.Value := FieldByName('报考截止时间').AsDateTime;
      edt_KsStart.Value := FieldByName('考试开始时间').AsDateTime;
      edt_KsEnd.Value := FieldByName('考试截止时间').AsDateTime;
      edt_lxr.Text := '';
      edt_Tel.Text := '';
    end
    else
    begin
      edt_Kdmc.Text := FieldbyName('考点名称').AsString;
      edt_addr.Text := FieldByName('地址').AsString;
      Old_Kdmc := edt_Kdmc.Text;
      cbb_Sf.Text := FieldByName('省份').AsString;
      edt_BmStart.Value := FieldByName('报考开始时间').AsDateTime;
      edt_BmEnd.Value := FieldByName('报考截止时间').AsDateTime;
      edt_KsStart.Value := FieldByName('考试开始时间').AsDateTime;
      edt_KsEnd.Value := FieldByName('考试截止时间').AsDateTime;
      edt_lxr.Text := FieldByName('联系人').AsString;
      edt_Tel.Text := FieldByName('联系电话').AsString;
    end;
  end;
end;

procedure TXkKdEdit.SaveData;
var
  DataSet:TDataSet;
begin
  DataSet := DataSource1.DataSet;
  with DataSet do
  begin
    if fEditType=0 then
      Append
    else
      Edit;
    FieldbyName('考点名称').AsString := edt_Kdmc.Text;
    FieldByName('地址').AsString := edt_addr.Text;
    FieldByName('省份').AsString := cbb_Sf.Text;
    FieldByName('报考开始时间').AsDateTime := edt_BmStart.Value;
    FieldByName('报考截止时间').AsDateTime := edt_BmEnd.Value;
    FieldByName('考试开始时间').AsDateTime := edt_KsStart.Value;
    FieldByName('考试截止时间').AsDateTime := edt_KsEnd.Value;
    FieldByName('联系人').AsString := edt_lxr.Text;
    FieldByName('联系电话').AsString := edt_Tel.Text;
    Post;

    if (fEditType=1) and (Old_Kdmc<>edt_Kdmc.Text) then
    begin
      dm.ExecSql('update 校考考生信息表 set 考点名称='+quotedstr(edt_Kdmc.Text)+' where 考点名称='+quotedstr(Old_Kdmc));
    end;
  end;
end;

procedure TXkKdEdit.SetEditType(const EditType: Integer);
begin
  fEditType := EditType;
end;

end.
