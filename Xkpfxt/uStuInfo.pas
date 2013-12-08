unit uStuInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, DBCtrls, Menus, ExtDlgs, DB,
  frxpngimage, CnAAFont, CnAACtrls, dxGDIPlusClasses, Mask, DBClient;

type
  TStuInfo = class(TForm)
    Image1: TImage;
    img_Photo: TImage;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    DataSource1: TDataSource;
    chk_OverWrite: TCheckBox;
    albl1: TCnAALabel;
    cds_1: TClientDataSet;
    cds_1Id: TAutoIncField;
    cds_1StringField: TStringField;
    cds_1StringField2: TStringField;
    cds_1StringField3: TStringField;
    cds_1StringField4: TStringField;
    cds_1StringField5: TStringField;
    cds_1StringField6: TStringField;
    cds_1StringField7: TStringField;
    cds_1StringField8: TStringField;
    cds_1StringField9: TStringField;
    cds_1StringField10: TStringField;
    cds_1DateTimeField: TDateTimeField;
    cds_1DateTimeField2: TDateTimeField;
    cds_1StringField11: TStringField;
    cds_1StringField12: TStringField;
    cds_1StringField13: TStringField;
    cds_1StringField14: TStringField;
    cds_1StringField15: TStringField;
    cds_1FloatField: TFloatField;
    lbl1: TLabel;
    dbedt1: TDBText;
    lbl2: TLabel;
    dbtxt_Ksh: TDBText;
    lbl3: TLabel;
    dbedt3: TDBText;
    lbl4: TLabel;
    dbedt4: TDBText;
    lbl5: TLabel;
    dbedt5: TDBText;
    lbl6: TLabel;
    dbedt6: TDBText;
    lbl7: TLabel;
    dbedt7: TDBText;
    lbl8: TLabel;
    dbedt8: TDBText;
    lbl9: TLabel;
    dbedt9: TDBText;
    lbl10: TLabel;
    dbedt10: TDBText;
    lbl11: TLabel;
    dbedt11: TDBText;
    lbl12: TLabel;
    dbedt12: TDBText;
    lbl13: TLabel;
    dbedt13: TDBText;
    lbl14: TLabel;
    lbl15: TLabel;
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
  SavePictureDialog1.FileName := dbtxt_Ksh.Caption+'.jpg';
  if SavePictureDialog1.Execute then
  begin
    img_Photo.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

end.
