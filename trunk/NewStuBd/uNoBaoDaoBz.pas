unit uNoBaoDaoBz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzPanel, RzRadGrp;

type
  TNoBaoDaoBz = class(TForm)
    RadioGroup1: TRzRadioGroup;
    btn_OK: TBitBtn;
    btn_Close: TBitBtn;
    Memo1: TMemo;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TNoBaoDaoBz.Memo1Change(Sender: TObject);
begin
  btn_OK.Enabled := Trim(Memo1.Text)<>'';
end;

procedure TNoBaoDaoBz.RadioGroup1Click(Sender: TObject);
var
  ii:Integer;
begin
  ii := RadioGroup1.ItemIndex;
  btn_OK.Enabled := ii<>-1;
  Memo1.Enabled := ii = 3;
  if ii<>3 then
    Memo1.Text := RadioGroup1.Items[ii]
  else
  begin
    Memo1.Text := '请输入未报到原因！';
    Memo1.SetFocus;
  end;
end;

end.
