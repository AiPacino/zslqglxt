unit uTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses ShlObj,net;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Caption := IntToStr(SysUtils.Win32MajorVersion);
  Edit1.Text := GetSpecialFolderDir(CSIDL_PERSONAL);//我的文档目录
  Edit2.Text := GetSpecialFolderDir(CSIDL_MYDOCUMENTS);//我的文档目录
end;

end.
