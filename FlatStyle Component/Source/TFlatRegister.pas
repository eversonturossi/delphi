unit TFlatRegister;

interface

{$I DFS.inc}

uses
  Classes, Controls, Graphics, Forms;

procedure Register;

implementation

uses
  TFlatButtonUnit, TFlatSpeedButtonUnit, TFlatEditUnit, TFlatMemoUnit,
  TFlatRadioButtonUnit, TFlatCheckBoxUnit, TFlatProgressBarUnit, TFlatHintUnit,
  TFlatTabControlUnit, TFlatListBoxUnit, TFlatComboBoxUnit, TFlatAnimWndUnit,
  TFlatSoundUnit, TFlatGaugeUnit, TFlatSplitterUnit, TFlatAnimationUnit,
  TFlatCheckListBoxUnit, TFlatGroupBoxUnit, TFlatMaskEditUnit, TFlatPanelUnit,
  TFlatColorComboBoxUnit,
  TFlatScrollBarUnit, TFlatTitleBarUnit,
  TFlatSpinEditUnit;

procedure Register;
begin
  RegisterComponents('FlatStyle', [TFlatButton, TFlatSpeedButton, TFlatCheckBox, TFlatRadioButton]);
  RegisterComponents('FlatStyle', [TFlatEdit, TFlatMaskEdit, TFlatSpinEditInteger, TFlatSpinEditFloat]);
  RegisterComponents('FlatStyle', [TFlatMemo, TFlatProgressBar, TFlatTabControl]);
  RegisterComponents('FlatStyle', [TFlatListBox, TFlatCheckListBox, TFlatComboBox, TFlatColorComboBox]);
  RegisterComponents('FlatStyle', [TFlatGroupBox, TFlatPanel]);
  RegisterComponents('FlatStyle', [TFlatHint, TFlatAnimWnd, TFlatSound, TFlatGauge, TFlatSplitter, TFlatAnimation]);
  RegisterComponents('FlatStyle', [TFlatScrollBar, TFlatTitleBar]);
end;

end.
