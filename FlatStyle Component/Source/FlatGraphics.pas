unit FlatGraphics;

{ *************************************************************** }
{ }
{ FlatStyle Graphics Unit }
{ Copyright ©2000 Lloyd Kinsella. }
{ }
{ FlatStyle is Copyright ©1998-2000 Maik Porkert. }
{ }
{ E-Mail: lloydk@iname.com }
{ Web:    http://www.flatstyle.de/ }
{ }
{ *************************************************************** }
{$C PRELOAD}
{ Unit Version 1.0.3 (There have been 3 versions of this file including this one) }

interface

{ Color Constants }

uses Classes, Controls, Graphics, Forms;

{ NOTE: All Colors have the 'ec' prefix which means Encarta Color }

const
  { Standard Encarta & FlatStyle Color Constants }
  ecDarkBlue = TColor($00996633);
  ecBlue = TColor($00CF9030);
  ecLightBlue = TColor($00CFB78F);

  ecDarkRed = TColor($00302794);
  ecRed = TColor($005F58B0);
  ecLightRed = TColor($006963B6);

  ecDarkGreen = TColor($00385937);
  ecGreen = TColor($00518150);
  ecLightGreen = TColor($0093CAB1);

  ecDarkYellow = TColor($004EB6CF);
  ecYellow = TColor($0057D1FF);
  ecLightYellow = TColor($00B3F8FF);

  ecDarkBrown = TColor($00394D4D);
  ecBrown = TColor($00555E66);
  ecLightBrown = TColor($00829AA2);

  ecDarkKaki = TColor($00D3D3D3);
  ecKaki = TColor($00C8D7D7);
  ecLightKaki = TColor($00E0E9EF);

  { Encarta & FlatStyle Interface Color Constants }
  ecBtnHighlight = clWhite;
  ecBtnShadow = clBlack;
  ecBtnFace = ecLightKaki;
  ecBtnFaceDown = ecKaki;

  ecFocused = clWhite;

  ecScrollbar = ecLightKaki;
  ecScrollbarThumb = ecLightBrown;

  ecBackground = clWhite;

  ecHint = ecYellow;
  ecHintArrow = clBlack;

  ecDot = clBlack;
  ecTick = clBlack;

  ecMenuBorder = ecDarkBrown;
  ecMenu = clBlack;
  ecMenuSelected = ecDarkYellow;

  ecProgressBlock = ecBlue;
  ecUnselectedTab = ecBlue;

  ecSelection = clNavy;

  ecCaptionBackground = clBlack;
  ecActiveCaption = clWhite;
  ecInactiveCaption = ecLightBrown;

implementation

end.
