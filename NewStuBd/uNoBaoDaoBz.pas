unit uNoBaoDaoBz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzPanel, RzRadGrp, DB, DBClient;

type
  TNoBaoDaoBz = class(TForm)
    RadioGroup1: TRzRadioGroup;
    btn_OK: TBitBtn;
    btn_Close: TBitBtn;
    Memo1: TMemo;
    cds_Temp: TClientDataSet;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TNoBaoDaoBz.FormCreate(Sender: TObject);
begin
  cds_Temp.XMLData := dm.OpenData('select 项目内容 from 未报到原因项目表 order by 显示顺序',False);
  RadioGroup1.Items.Clear;
  while not cds_Temp.Eof do
  begin
    RadioGroup1.Items.Add(cds_Temp.Fields[0].AsString);
    cds_Temp.Next;
  end;
  Memo1.Top := cds_Temp.RecordCount*25+10;
  Memo1.Height := RadioGroup1.Height-cds_Temp.RecordCount*25+10-30;
end;

procedure TNoBaoDaoBz.Memo1Change(Sender: TObject);
begin
  btn_OK.Enabled := (Trim(Memo1.Text)<>'') and (Trim(Memo1.Text)<>'请输入未报到原因！');
end;

procedure TNoBaoDaoBz.RadioGroup1Click(Sender: TObject);
var
  ii:Integer;
begin
  ii := RadioGroup1.ItemIndex;
  btn_OK.Enabled := ii<>-1;
  if ii=-1 then Exit;

  Memo1.Enabled := Pos('其他原因',RadioGroup1.Items[ii])>0;
  if not Memo1.Enabled then
    Memo1.Text := RadioGroup1.Items[ii]
  else
  begin
    Memo1.Text := '请输入未报到原因！';
    Memo1.SetFocus;
  end;
end;

end.
