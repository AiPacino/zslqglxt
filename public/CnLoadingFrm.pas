{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2008 CnPack 开发组                       }
{                   ------------------------------------                       }
{                                                                              }
{            本开发包是开源的自由软件，您可以遵照 CnPack 的发布协议来修        }
{        改和重新发布这一程序。                                                }
{                                                                              }
{            发布这一开发包的目的是希望它有用，但没有任何担保。甚至没有        }
{        适合特定目的而隐含的担保。更详细的情况请参阅 CnPack 发布协议。        }
{                                                                              }
{            您应该已经和开发包一起收到一份 CnPack 发布协议的副本。如果        }
{        还没有，可访问我们的网站：                                            }
{                                                                              }
{            网站地址：http://www.cnpack.org                                   }
{            电子邮件：master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnLoadingFrm;
{* |<PRE>
================================================================================
* 软件名称：公共窗体库
* 单元名称：通用进度条窗体单元
* 单元作者：周劲羽 (zjy@cnpack.org)
* 备    注：该窗体由程序内部控制开启和关闭，请勿直接创建窗体实例
*           该单元提供以下几个过程用于显示动态提示窗体：
*             ShowLoading   - 显示进度条窗体
*             HideLoading   - 隐藏进度条窗体
*             UpdateLoading - 更新当前进度
*             UpdateLoadingTitle  - 更新窗体标题
* 使用方法：在需要显示提示窗口的单元中uses本单元，当需要显示提示信息时直接
*           直接调用ShowXXXX过程即可。
* 注意事项：同一时间屏幕上只能显示一个进度窗体，窗体显示时其它所有窗体均不
*           能使用，但显示该窗体的代码仍可以继续运行。
* 开发平台：PWin98SE + Delphi 5.0
* 兼容测试：PWin9X/2000/XP + Delphi 5/6
* 本 地 化：该单元中的字符串尚不符合本地化处理方式
* 单元标识：$Id: CnProgressFrm.pas,v 1.9 2008/08/04 14:31:38 liuxiao Exp $
* 修改记录：2008.03.08 V1.1
*                xierenxixi 修改其禁用方式
*           2002.04.03 V1.0
*                创建单元
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
{* 显示进度条窗体，参数为窗体标题以及最大值，默认 100（百分比形式），可自定义成其他值}
procedure HideLoading;
{* 关闭进度条窗体}
procedure UpdateLoading(Value: Integer);
{* 更新当前进度，参数为进度值：当 Max 为 100 时可接受范围为 0..100，此时 Value 代表百分比}
procedure UpdateLoadingTitle(const Title: string);
{* 更新进度条窗体标题，参数为标题}
procedure UpdateLoadingMax(Value: Integer);
{* 更新进度条最大值，参数为新的最大值}

implementation

{$R *.DFM}

var
  LoadingForm: TLoadingForm = nil;  // 进度条窗体实例
  FormList: Pointer;   // 被禁用的窗体列表指针

// 显示窗体
procedure ShowLoading(const Title: string; AMax: Integer = 100);
begin
  if not Assigned(LoadingForm) then
    LoadingForm := TLoadingForm.Create(Application.MainForm)
  else
    LoadingForm.BringToFront;
  LoadingForm.lblTitle.Caption := Title;
  LoadingForm.ProgressBar.Max := AMax;
  LoadingForm.Show;

  // xierenxixi 修改
  FormList := DisableTaskWindows(LoadingForm.Handle);
  LoadingForm.Update;
end;

// 关闭窗体
procedure HideLoading;
begin
  if not Assigned(LoadingForm) then Exit;

  // xierenxixi 修改
  EnableTaskWindows(FormList);
  
  LoadingForm.Hide;
  Application.ProcessMessages;
  LoadingForm.Free;
  LoadingForm := nil;
end;

// 更新进度
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

// 更新标题
procedure UpdateLoadingTitle(const Title: string);
begin
  if Assigned(LoadingForm) then
  begin
    LoadingForm.lblTitle.Caption := Title;
    LoadingForm.Update;
    Application.ProcessMessages;
  end;
end;

// 更新进度条最大值
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
  // AnimationSpeed 设定动画速度，值越大，速度越快；
  TGIFImage(Image1.Picture.Graphic).AnimationSpeed := 15000;
  TGIFImage(Image1.Picture.Graphic).Animate := True;
end;

end.
