unit SP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, XPLabel;

type
  TScreenLogoFrm = class(TForm)
    logo: TImage;
    procedure FormDestroy(Sender: TObject);

  private

  public

  end;

var
  ScreenLogoFrm: TScreenLogoFrm;

implementation

uses NP;

{$R *.dfm}

procedure TScreenLogoFrm.FormDestroy(Sender: TObject);
begin
logo.Free;
end;

end.
