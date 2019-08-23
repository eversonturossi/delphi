unit MyClasses;

interface

uses
  SysUtils, Classes, Dialogs;

type
  IFoo = interface
    procedure Execute;
  end;

  IBar = interface
    procedure Execute;
  end;

  TFoo = class(TInterfacedObject, IFoo)
  private
    fBar: IBar;
  public
    constructor Create(const aBar: IBar);
    procedure Execute;
  end;

  TBar = class(TInterfacedObject, IBar)
  public
    procedure Execute;
  end;

implementation

{ TFoo }

constructor TFoo.Create(const aBar: IBar);
begin
  inherited Create;
  fBar := aBar;
end;

procedure TFoo.Execute;
begin
  fBar.Execute;
end;

{ TBar }

procedure TBar.Execute;
begin
  //raise Exception.Create('exception!!!');
   ShowMessage('executou');
end;

end.
