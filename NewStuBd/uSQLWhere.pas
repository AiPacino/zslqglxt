unit uSQLWhere;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, DBFieldComboBox, Buttons, DB;

type
  TSQLWhere = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    cbb_Field: TDBFieldComboBox;
    cbb_Compare: TDBComboBoxEh;
    cbb_Value: TDBComboBoxEh;
    btn_Add: TBitBtn;
    rg_1: TRadioGroup;
    btn_Clear: TBitBtn;
    mmo1: TMemo;
    DataSource1: TDataSource;
    procedure btn_ClearClick(Sender: TObject);
    procedure cbb_CompareChange(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetSqlWhere(const aDataSet:TDataSet;var sList:Tstrings):Boolean;

implementation

{$R *.dfm}

function GetSqlWhere(const aDataSet:TDataSet;var sList:Tstrings):Boolean;
begin
  with TSQLWhere.Create(Application) do
  begin
    DataSource1.DataSet := aDataSet;
    mmo1.Lines.Assign(sList);
    if ShowModal=mrOk then
    begin
      Result := True;
      sList.Assign(mmo1.Lines);
    end else
    begin
      Result := False;
    end;
    Free;
  end;
end;

procedure TSQLWhere.btn_AddClick(Sender: TObject);
var
  sWhere,sTemp,sValue:string;
begin
  if cbb_Compare.KeyItems[cbb_Compare.ItemIndex]='Like' then
    sValue := '%'+cbb_Value.Text+'%'
  else
    sValue := cbb_Value.Text;
    
  if rg_1.ItemIndex=0 then
    sTemp := ' and '
  else
    sTemp := ' or ';
  if mmo1.Lines.Text='' then
    sTemp := '';
    
  if cbb_Value.Enabled then
    sWhere := sTemp+'('+cbb_Field.GetField+' '+cbb_Compare.KeyItems[cbb_Compare.ItemIndex]+' '+quotedstr(sValue)+')'
  else
    sWhere := sTemp+'('+cbb_Field.GetField+' '+cbb_Compare.KeyItems[cbb_Compare.ItemIndex]+')';
    
  mmo1.Lines.Add(sWhere);
end;

procedure TSQLWhere.btn_ClearClick(Sender: TObject);
begin
  mmo1.Clear;
end;

procedure TSQLWhere.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSQLWhere.cbb_CompareChange(Sender: TObject);
begin
  cbb_Value.Enabled := (cbb_Compare.ItemIndex<>7) and (cbb_Compare.ItemIndex<>8);
end;

end.
