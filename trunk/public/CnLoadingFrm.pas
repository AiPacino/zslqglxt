{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2008 CnPack ������                       }
{                   ------------------------------------                       }
{                                                                              }
{            ���������ǿ�Դ��������������������� CnPack �ķ���Э������        }
{        �ĺ����·�����һ����                                                }
{                                                                              }
{            ������һ��������Ŀ����ϣ�������ã���û���κε���������û��        }
{        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� CnPack ����Э�顣        }
{                                                                              }
{            ��Ӧ���Ѿ��Ϳ�����һ���յ�һ�� CnPack ����Э��ĸ��������        }
{        ��û�У��ɷ������ǵ���վ��                                            }
{                                                                              }
{            ��վ��ַ��http://www.cnpack.org                                   }
{            �����ʼ���master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnLoadingFrm;
{* |<PRE>
================================================================================
* ������ƣ����������
* ��Ԫ���ƣ�ͨ�ý��������嵥Ԫ
* ��Ԫ���ߣ��ܾ��� (zjy@cnpack.org)
* ��    ע���ô����ɳ����ڲ����ƿ����͹رգ�����ֱ�Ӵ�������ʵ��
*           �õ�Ԫ�ṩ���¼�������������ʾ��̬��ʾ���壺
*             ShowLoading   - ��ʾ����������
*             HideLoading   - ���ؽ���������
*             UpdateLoading - ���µ�ǰ����
*             UpdateLoadingTitle  - ���´������
* ʹ�÷���������Ҫ��ʾ��ʾ���ڵĵ�Ԫ��uses����Ԫ������Ҫ��ʾ��ʾ��Ϣʱֱ��
*           ֱ�ӵ���ShowXXXX���̼��ɡ�
* ע�����ͬһʱ����Ļ��ֻ����ʾһ�����ȴ��壬������ʾʱ�������д������
*           ��ʹ�ã�����ʾ�ô���Ĵ����Կ��Լ������С�
* ����ƽ̨��PWin98SE + Delphi 5.0
* ���ݲ��ԣ�PWin9X/2000/XP + Delphi 5/6
* �� �� �����õ�Ԫ�е��ַ����в����ϱ��ػ�����ʽ
* ��Ԫ��ʶ��$Id: CnProgressFrm.pas,v 1.9 2008/08/04 14:31:38 liuxiao Exp $
* �޸ļ�¼��2008.03.08 V1.1
*                xierenxixi �޸�����÷�ʽ
*           2002.04.03 V1.0
*                ������Ԫ
================================================================================
|</PRE>}

interface

{$I CnPack.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls, GIFImg, ExtCtrls;

type

{ TProgressForm }

  TLoadingForm = class(TForm)
    SpeedButton1: TSpeedButton;
    lblTitle: TLabel;
    Label1: TLabel;
    Image1: TImage;
    ProgressBar: TProgressBar;
  private
    { Private declarations }
    FPerLabel: TLabel;
  public
    { Public declarations }
    procedure DoCreate; override;

  end;

procedure ShowLoading(const Title: string; AMax: Integer = 100);
{* ��ʾ���������壬����Ϊ��������Լ����ֵ��Ĭ�� 100���ٷֱ���ʽ�������Զ��������ֵ}
procedure HideLoading;
{* �رս���������}
procedure UpdateLoading(Value: Integer);
{* ���µ�ǰ���ȣ�����Ϊ����ֵ���� Max Ϊ 100 ʱ�ɽ��ܷ�ΧΪ 0..100����ʱ Value ����ٷֱ�}
procedure UpdateLoadingTitle(const Title: string);
{* ���½�����������⣬����Ϊ����}
procedure UpdateLoadingMax(Value: Integer);
{* ���½��������ֵ������Ϊ�µ����ֵ}

implementation

{$R *.DFM}

var
  LoadingForm: TLoadingForm = nil;  // ����������ʵ��
  FormList: Pointer;   // �����õĴ����б�ָ��

// ��ʾ����
procedure ShowLoading(const Title: string; AMax: Integer = 100);
begin
  if not Assigned(LoadingForm) then
    LoadingForm := TLoadingForm.Create(Application.MainForm)
  else
    LoadingForm.BringToFront;
  LoadingForm.lblTitle.Caption := Title;
  LoadingForm.ProgressBar.Max := AMax;
  LoadingForm.Show;

  // xierenxixi �޸�
  FormList := DisableTaskWindows(LoadingForm.Handle);
  LoadingForm.Update;
end;

// �رմ���
procedure HideLoading;
begin
  if not Assigned(LoadingForm) then Exit;

  // xierenxixi �޸�
  EnableTaskWindows(FormList);
  
  LoadingForm.Hide;
  Application.ProcessMessages;
  LoadingForm.Free;
  LoadingForm := nil;
end;

// ���½���
procedure UpdateLoading(Value: Integer);
begin
  if Assigned(LoadingForm) then
  begin
    LoadingForm.ProgressBar.Position := Value;
    //LoadingForm.FPerLabel.Caption := Format('%3d%%', [Round(Value/LoadingForm.ProgressBar.Max * 100)]);
    LoadingForm.Update;
    Application.ProcessMessages;
  end;
end;

// ���±���
procedure UpdateLoadingTitle(const Title: string);
begin
  if Assigned(LoadingForm) then
  begin
    LoadingForm.lblTitle.Caption := Title;
    LoadingForm.Update;
    Application.ProcessMessages;
  end;
end;

// ���½��������ֵ
procedure UpdateLoadingMax(Value: Integer);
begin
  if Assigned(LoadingForm) then
  begin
    LoadingForm.ProgressBar.Max:=Value;
    LoadingForm.Update;
    Application.ProcessMessages;
  end;
end;

{ TLoadingForm }

procedure TLoadingForm.DoCreate;
begin
  inherited;
  FPerLabel := TLabel.Create(Self);
  FPerLabel.Caption := '    '; // 100%
  FPerLabel.Parent := Label1.Parent;
  FPerLabel.Top := Label1.Top;
  FPerLabel.Left := ProgressBar.Left + ProgressBar.Width - FPerLabel.Width-15;
  //Image1.Picture.LoadFromFile('C:\Example.gif');
  // AnimationSpeed �趨�����ٶȣ�ֵԽ���ٶ�Խ�죻
  TGIFImage(Image1.Picture.Graphic).AnimationSpeed := 15000;
  TGIFImage(Image1.Picture.Graphic).Animate := True;
end;

end.
