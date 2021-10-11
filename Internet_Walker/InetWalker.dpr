program InetWalker;

uses
  Forms,
  NP in 'NP.pas' {MainFrm},
  OpenAddress in 'OpenAddress.pas' {OpenFrm},
  ListFav in 'ListFav.pas' {OrgFavFrm},
  AddFav in 'AddFav.pas' {AddFavFrm},
  AP in 'AP.pas' {AboutFrm},
  YDP in 'YDP.pas' {DatesFrm},
  OP in 'OP.pas' {SetFrm},
  LP in 'LP.pas' {LicFrm},
  SP in 'SP.pas' {ScreenLogoFrm},
  AddHTML in 'AddHTML.pas' {AddHTMLFrm},
  ListLink in 'ListLink.pas' {LinksFrm},
  MyPrinter in 'MyPrinter.pas' {PrintFrm},
  IMPPR in 'IMPPR.pas' {ImportFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Internet Walker';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TSetFrm, SetFrm);
  Application.CreateForm(TOpenFrm, OpenFrm);
  Application.CreateForm(TOrgFavFrm, OrgFavFrm);
  Application.CreateForm(TAddFavFrm, AddFavFrm);
  Application.CreateForm(TAboutFrm, AboutFrm);
  Application.CreateForm(TDatesFrm, DatesFrm);
  Application.CreateForm(TLicFrm, LicFrm);
  Application.CreateForm(TScreenLogoFrm, ScreenLogoFrm);
  Application.CreateForm(TAddHTMLFrm, AddHTMLFrm);
  Application.CreateForm(TLinksFrm, LinksFrm);
  Application.CreateForm(TPrintFrm, PrintFrm);
  Application.CreateForm(TImportFrm, ImportFrm);
  Application.Run;
end.
