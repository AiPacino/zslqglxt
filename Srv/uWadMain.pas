unit uWadMain;

interface

uses
  SysUtils, Classes, Forms, Controls, StdCtrls;

type
  TWadMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WadMain: TWadMain;

implementation

uses SockApp;

{$R *.dfm}

initialization
  TWebAppSockObjectFactory.Create('NewStuLqBd')

end.
