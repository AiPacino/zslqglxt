program pTest;

uses
  Forms,
  uTest in 'uTest.pas' {Form1},
  Net in '..\public\Net.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
