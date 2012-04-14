unit uStuInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, DBCtrls, Menus, ExtDlgs, DB,
  frxpngimage;

type
  TStuInfo = class(TForm)
    Image1: TImage;
    img_Photo: TImage;
    DBEdit1: TDBText;
    DBEdit2: TDBText;
    DBEdit3: TDBText;
    DBEdit4: TDBText;
    DBEdit5: TDBText;
    DBEdit6: TDBText;
    DBEdit7: TDBText;
    DBEdit8: TDBText;
    DBEdit9: TDBText;
    DBEdit10: TDBText;
    DBEdit11: TDBText;
    DBEdit12: TDBText;
    DBEdit13: TDBText;
    DBEdit14: TDBText;
    DBEdit15: TDBText;
    DBEdit16: TDBText;
    DBEdit17: TDBText;
    lbl1: TLabel;
    Label1: TLabel;
    lbl_Csrq: TLabel;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    DataSource1: TDataSource;
    chk_OverWrite: TCheckBox;
    dbtxt_XH: TDBText;
    dbtxt_Bj: TDBText;
    procedure N1Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    sWebSrvUrl:string;
  public
    { Public declarations }
    function DownLoadPhotoFromUrl(const Photo_Url:string;aImage:TImage=nil;const OverPhoto:Boolean=True):Boolean;
  end;

implementation
uses udm;
{$R *.dfm}

procedure TStuInfo.DataSource1DataChange(Sender: TObject; Field: TField);
var
  sfzh,fn,ksh,sPath:string;
  sBmNo:string;
  Photo_fn:string;
begin
  sfzh := DataSource1.DataSet.FieldByName('身份证号').AsString;
  if Length(Sfzh)=18 then
    lbl_Csrq.Caption := Copy(sfzh,7,4)+'年'+copy(sfzh,11,2)+'月'+Copy(sfzh,13,2)+'日'
  else if Length(sfzh)=15 then
    lbl_Csrq.Caption := '19'+Copy(sfzh,7,2)+'年'+copy(sfzh,9,2)+'月'+Copy(sfzh,11,2)+'日'
  else
    lbl_Csrq.Caption := '    /  /  /';

  Ksh := DataSource1.DataSet.FieldByName('考生号').AsString;
  fn := DataSource1.DataSet.FieldByName('照片文件').AsString;
  sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
  sBmNo := DataSource1.DataSet.FieldByName('通知书编号').AsString;
  if Self.Showing then
  begin
    img_Photo.Picture := nil;
    dm.DownLoadKsPhotoByKSH(ksh,sPath+fn,img_Photo,chk_OverWrite.Checked);
    //DownLoadPhotoFromUrl(Photo_Url,img_Photo,False);
  end;
end;

function TStuInfo.DownLoadPhotoFromUrl(const Photo_Url: string; aImage: TImage;
  const OverPhoto: Boolean): Boolean;
var
  sUrl:string;
begin
  sUrl := Trim(Photo_Url);
  if sUrl='' then Exit;
  
  if LowerCase(Copy(sUrl,1,7))<>'http:// 'then
    sUrl := sWebSrvUrl+sUrl;

  dm.DownLoadKsPhoto(sUrl,aImage,OverPhoto);
end;

procedure TStuInfo.FormCreate(Sender: TObject);
begin
  sWebSrvUrl := dm.GetWebSrvUrl;
end;

procedure TStuInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP:
      if not DataSource1.DataSet.Bof then DataSource1.DataSet.Prior;
    VK_DOWN:
      if not DataSource1.DataSet.Eof then DataSource1.DataSet.Next;
  end;
end;

procedure TStuInfo.FormShow(Sender: TObject);
var
  ksh,fn,sPath:string;
begin
  Ksh := DataSource1.DataSet.FieldByName('考生号').AsString;
  fn := DataSource1.DataSet.FieldByName('照片文件').AsString;
  sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
  img_Photo.Picture := nil;
  dm.DownLoadKsPhotoByKSH(ksh,sPath+fn,img_Photo,chk_OverWrite.Checked);
end;

procedure TStuInfo.N1Click(Sender: TObject);
begin
  SavePictureDialog1.FileName := TEdit(DBEdit2).Text+'.jpg';
  if SavePictureDialog1.Execute then
  begin
    img_Photo.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

end.
