unit uStuInfoConfirm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, DBCtrls, Menus, ExtDlgs, DB,
  frxpngimage, CnAAFont, CnAACtrls, dxGDIPlusClasses, Mask, DBClient, RzButton;

type
  TStuInfoConfirm = class(TForm)
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
    pnl_bottom: TPanel;
    btn_Yes: TRzBitBtn;
    btn_No: TRzBitBtn;
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

procedure TStuInfoConfirm.DataSource1DataChange(Sender: TObject; Field: TField);
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

function TStuInfoConfirm.DownLoadPhotoFromUrl(const Photo_Url: string; aImage: TImage;
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

procedure TStuInfoConfirm.FormCreate(Sender: TObject);
begin
  sWebSrvUrl := dm.GetWebSrvUrl;
end;

procedure TStuInfoConfirm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP:
      if not DataSource1.DataSet.Bof then DataSource1.DataSet.Prior;
    VK_DOWN:
      if not DataSource1.DataSet.Eof then DataSource1.DataSet.Next;
  end;
end;

procedure TStuInfoConfirm.FormShow(Sender: TObject);
var
  ksh,zkzh,sfzh,fn,sPath:string;
begin
  img_Photo.Picture := nil;

  Ksh := DataSource1.DataSet.FieldByName('考生号').AsString;
  fn := ksh+'.jpg';
  if PhotoIsExists(fn) then
  begin
    sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
    img_Photo.Picture.LoadFromFile(sPath+fn);
    Exit;
  end;
  
  zkzh := DataSource1.DataSet.FieldByName('准考证号').AsString;
  fn := zkzh+'.jpg';
  if PhotoIsExists(fn) then
  begin
    sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
    img_Photo.Picture.LoadFromFile(sPath+fn);
    Exit;
  end;

  sfzh := DataSource1.DataSet.FieldByName('身份证号').AsString;
  fn := sfzh+'.jpg';
  if PhotoIsExists(fn) then
  begin
    sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
    img_Photo.Picture.LoadFromFile(sPath+fn);
    Exit;
  end;




  //fn := DataSource1.DataSet.FieldByName('照片文件').AsString;
  //sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
  //dm.DownLoadKsPhotoByKSH(ksh,sPath+fn,img_Photo,chk_OverWrite.Checked);
end;

procedure TStuInfoConfirm.N1Click(Sender: TObject);
begin
  SavePictureDialog1.FileName := dbtxt_Ksh.Caption+'.jpg';
  if SavePictureDialog1.Execute then
  begin
    img_Photo.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

end.
