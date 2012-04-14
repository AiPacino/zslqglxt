unit uIniFile;

interface

uses
  Classes, SysUtils, IniFiles, Forms, Windows;

const
  csIniSYSSETSection = 'SYSSET';

  {Section: SYSSET}
  csIniSYSSETINITPATH = 'INITPATH';
  csIniSYSSETRotate = 'ROTATE';
  
type
  TIniOptions = class(TObject)
  private
    {Section: SYSSET}
    FSYSSETINITPATH: string;
    FSYSSETRotate: Integer;
  public
    procedure LoadSettings(Ini: TIniFile);
    procedure SaveSettings(Ini: TIniFile);

    {Section: SYSSET}
    property SYSSETINITPATH: string read FSYSSETINITPATH write FSYSSETINITPATH;
    property SYSSETRotate: Integer read FSYSSETRotate write FSYSSETRotate;
  end;

var
  IniOptions: TIniOptions = nil;

implementation

procedure TIniOptions.LoadSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: SYSSET}
    FSYSSETINITPATH := Ini.ReadString(csIniSYSSETSection, csIniSYSSETINITPATH, '');
    FSYSSETRotate := Ini.ReadInteger(csIniSYSSETSection, csIniSYSSETRotate, 0);
  end;
end;

procedure TIniOptions.SaveSettings(Ini: TIniFile);
begin
  if Ini <> nil then
  begin
    {Section: SYSSET}
    Ini.WriteString(csIniSYSSETSection, csIniSYSSETINITPATH, FSYSSETINITPATH);
    Ini.WriteInteger(csIniSYSSETSection, csIniSYSSETRotate, FSYSSETRotate);
  end;
end;

initialization
  IniOptions := TIniOptions.Create;

finalization
  IniOptions.Free;

end.

