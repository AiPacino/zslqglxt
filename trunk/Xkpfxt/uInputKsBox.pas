unit uInputKsBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, CnButtons, CnAAFont, CnAACtrls, RzButton;

type
  TInputKsBox = class(TForm)
    albl1: TCnAALabel;
    edt_Value: TEdit;
    bvl1: TBevel;
    lbl_Len: TLabel;
    btn_OK: TRzBitBtn;
    btn_Cancel: TRzBitBtn;
    procedure edt_ValueChange(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InputKsBox: TInputKsBox;

implementation

{$R *.dfm}

procedure TInputKsBox.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := Format('(%d)',[Length(edt_Value.Text)]);
  btn_OK.Enabled := edt_Value.Text<>'';
end;

procedure TInputKsBox.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and (btn_OK.CanFocus) then
     btn_OK.Click;
end;

end.
