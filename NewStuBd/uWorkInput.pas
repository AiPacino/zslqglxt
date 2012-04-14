unit uWorkInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrlsEh, Mask, Buttons, ExtCtrls, DB, DBClient, DBCtrls;

type
  TWorkInput = class(TForm)
    pnl1: TPanel;
    btn_Close: TBitBtn;
    btn_Save: TBitBtn;
    ds_Work: TDataSource;
    lbl29: TLabel;
    dbedt21: TDBMemo;
    lbl30: TLabel;
    dbedt22: TDBMemo;
    grp1: TGroupBox;
    lbl11: TLabel;
    dbedt3: TDBEditEh;
    lbl12: TLabel;
    dt_wlStart: TDBDateTimeEditEh;
    lbl13: TLabel;
    dbedt5: TDBEditEh;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dbedt6: TDBEditEh;
    dbedt7: TDBEditEh;
    dt_msStart: TDBDateTimeEditEh;
    dbedt9: TDBEditEh;
    lbl6: TLabel;
    grp3: TGroupBox;
    lbl3: TLabel;
    lbl8: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    dbedt10: TDBEditEh;
    dbedt11: TDBEditEh;
    dt_yyStart: TDBDateTimeEditEh;
    dbedt13: TDBEditEh;
    grp4: TGroupBox;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    dbedt14: TDBEditEh;
    dbedt15: TDBEditEh;
    dt_TyStart: TDBDateTimeEditEh;
    dbedt17: TDBEditEh;
    grp5: TGroupBox;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    dbedt18: TDBEditEh;
    dt_ykStart: TDBDateTimeEditEh;
    dbedt20: TDBEditEh;
    dbedt23: TDBEditEh;
    lbl24: TLabel;
    dbedt24: TDBEditEh;
    bvl2: TBevel;
    grp6: TGroupBox;
    lbl1: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    cbb_Sf: TDBComboBoxEh;
    dbedt1: TDBEditEh;
    dbedt2: TDBEditEh;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure cbb_SfChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    aXlCc,aSf:string;
    aIsAppend:Boolean;
    procedure SaveData;
  public
    { Public declarations }
    procedure FillData(const sXlcc,sSf:string;const cds_Temp: TClientDataSet;const iOpType:Integer);
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TWorkInput.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWorkInput.btn_SaveClick(Sender: TObject);
begin
  SaveData;
  Close;
end;

procedure TWorkInput.cbb_SfChange(Sender: TObject);
begin
  btn_Save.Enabled := (cbb_Sf.Text<>'');
end;

procedure TWorkInput.FillData(const sXlcc,sSf:string;const cds_Temp: TClientDataSet;const iOpType:Integer);
var
  i: Integer;
begin
  aXlCc := sXlcc;
  aSf := sSf;
  Self.Caption := '【'+aXlcc+'】录取工作日程安排';
  ds_Work.DataSet := cds_Temp;
  cbb_Sf.Text := aSf;
  case iOpType of
    0:
    begin
      ds_Work.DataSet.Append;
      ds_Work.DataSet.FieldByName('学历层次').AsString := aXlCc;
    end;
    1:
    begin
      ds_Work.DataSet.Edit;
      ds_Work.DataSet.FieldByName('学历层次').AsString := aXlCc;
    end;
    else
    begin
      for i := 0 to Self.ComponentCount - 1 do
      begin
        if Self.Components[i].ClassType = TCustomEdit then
          TCustomEdit(Self.Components[i]).Enabled := False;
      end;
    end;
  end;
end;

procedure TWorkInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ds_Work.DataSet.Cancel;
end;

procedure TWorkInput.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetSfList(sList);
    cbb_Sf.Items.Assign(sList);
  finally
    sList.Free;
  end;
end;

procedure TWorkInput.SaveData;
begin
  if ds_Work.DataSet.State in [dsInsert,dsEdit] then
    ds_Work.DataSet.Post;
end;

end.
