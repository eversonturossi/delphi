unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.DBCGrids;

type
  TForm7 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSetPessoa: TClientDataSet;
    ClientDataSetPessoaID: TLargeintField;
    ClientDataSetPessoaNOME: TStringField;
    ClientDataSetPessoaATIVO: TStringField;
    DBCtrlGrid1: TDBCtrlGrid;
    DBText1: TDBText;
    DBText2: TDBText;
    DBCheckBox1: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
  private
    procedure GerarDados;
    procedure Inserir(ANome: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  StrUtils;

{$R *.dfm}

procedure TForm7.Inserir(ANome: String);
begin
  ClientDataSetPessoa.Append;
  ClientDataSetPessoaID.AsLargeInt := ClientDataSetPessoa.RecordCount + 1;
  ClientDataSetPessoaNOME.AsString := UpperCase(ANome);
  ClientDataSetPessoaATIVO.AsString := 'N';
  ClientDataSetPessoa.Post;
end;

procedure TForm7.GerarDados;
begin
  Self.Inserir('Abbott Abernathy Adair');
  Self.Inserir('Adams Adkins Aguirre');
  Self.Inserir('Alexander Allen Allen');
  Self.Inserir('Allison Almeida Alvarado');
  Self.Inserir('Alvarez Andersen Anderson');
  Self.Inserir('Anderson Andrews Archer');
  Self.Inserir('Armstrong Arnold Arsenault');
  Self.Inserir('Ashby Ashworth Atkinson');
  Self.Inserir('Austin Ayers Bailey');
  Self.Inserir('Bain Baird Baker');
  Self.Inserir('Baldwin Ball Ballard');
  Self.Inserir('Banks Barker Barnes');
  Self.Inserir('Barnett Barr Barrett');
  Self.Inserir('Barry Bartlett Barton');
  Self.Inserir('Batchelor Bateman Bates');
  Self.Inserir('Bauer Baxter Beach');
  Self.Inserir('Beasley Beck Beebe');
  Self.Inserir('Bell Bender Bennett');
  Self.Inserir('Benson Bentley Benton');
  Self.Inserir('Berry Bird Bishop');
  Self.Inserir('Black Blackburn Blackwell');
  Self.Inserir('Blair Blake Blevins');
  Self.Inserir('Bolton Bond Boone');
  Self.Inserir('Bowen Bowers Bowman');
  Self.Inserir('Boyd Boyd Boyle');
  Self.Inserir('Bradford Bradley Bradshaw');
  Self.Inserir('Brady Bragg Breen');
  Self.Inserir('Brennan Brewer Briggs');
  Self.Inserir('Brooks Broussard Brown');
  Self.Inserir('Brown Browne Bruce');
  Self.Inserir('Bryant Buchanan Buckley');
  Self.Inserir('Bullock Burgess Burke');
  Self.Inserir('Burnham Burns Burton');
  Self.Inserir('Butcher Butler Byrd');
  Self.Inserir('Byrne Cahill Caldwell');
  Self.Inserir('Calhoun Callahan Cameron');
  Self.Inserir('Campbell Cannon Cantrell');
  Self.Inserir('Cantu Cardenas Carey');
  Self.Inserir('Carlson Carney Carpenter');
  Self.Inserir('Carr Carroll Carson');
  Self.Inserir('Carter Carver Casey');
  Self.Inserir('Cassidy Castillo Castro');
  Self.Inserir('Chandler Chaney Chapman');
  Self.Inserir('Chase Chavez Childers');
  Self.Inserir('Choate Christian Christie');
  Self.Inserir('Church Churchill Clancy');
  Self.Inserir('Clark Clark Clarke');
  Self.Inserir('Clay Clayton Cleveland');
  Self.Inserir('Clifford Cobb Cochran');
  Self.Inserir('Cochrane Coffey Cole');
  Self.Inserir('Coleman Coleman Collier');
  Self.Inserir('Collins Combs Compton');
  Self.Inserir('Conley Connell Connolly');
  Self.Inserir('Conrad Conway Cook');
  Self.Inserir('Cooke Cooley Cooney');
  Self.Inserir('Cooper Copeland Corbett');
  Self.Inserir('Corcoran Cormier Costello');
  Self.Inserir('Coughlin Cowan Cox');
  Self.Inserir('Coyle Coyne Crabtree');
  Self.Inserir('Craig Crawford Crockett');
  Self.Inserir('Cross Crouch Crowley');
  Self.Inserir('Cruz Cullen Cunningham');
  Self.Inserir('Curran Curtis Daley');
  Self.Inserir('Dalrymple Dalton Daly');
  Self.Inserir('Daniel Daniels Daugherty');
  Self.Inserir('Davenport Davidson Davies');
  Self.Inserir('Davis Dawson Day');
  Self.Inserir('Dean Delaney Dempsey');
  Self.Inserir('Devine Diaz Dickey');
  Self.Inserir('Dickinson Dickson Dillon');
  Self.Inserir('Dixon Dobson Dodd');
  Self.Inserir('Doherty Dolan Dominguez');
  Self.Inserir('Donahue Donaldson Donnelly');
  Self.Inserir('Donovan Dougherty Douglas');
  Self.Inserir('Dowd Dowling Downey');
  Self.Inserir('Doyle Drake Drew');
  Self.Inserir('Driscoll Duckworth Dudley');
  Self.Inserir('Duffy Dugan Duggan');
  Self.Inserir('Duncan Dunlap Dunn');
  Self.Inserir('Dwyer Eaton Edmondson');
  Self.Inserir('Edwards Egan Elliott');
  Self.Inserir('Ellis Emery England');
  Self.Inserir('English Erickson Evans');
  Self.Inserir('Ewing Fagan Fallon');
  Self.Inserir('Fanning Farley Farrell');
  Self.Inserir('Faulkner Ferguson Fernandez');
  Self.Inserir('Figueroa Finch Finn');
  Self.Inserir('Finnegan Fischer Fisher');
  Self.Inserir('Fitch Fitzgerald Fitzpatrick');
  Self.Inserir('Fitzsimmons Flanagan Fletcher');
  Self.Inserir('Flood Flores Floyd');
  Self.Inserir('Flynn Foley Forbes');
  Self.Inserir('Ford Forsyth Foster');
  Self.Inserir('Fournier Fowler Fox');
  Self.Inserir('Franklin Fraser Frazier');
  Self.Inserir('Freeman Frost Fry');
  Self.Inserir('Fuller Galbraith Gallagher');
  Self.Inserir('Gallegos Galloway Garcia');
  Self.Inserir('Gardner Garner Garrett');
  Self.Inserir('Garrison Garza Gauthier');
  Self.Inserir('Gentry George Gibbons');
  Self.Inserir('Gibbs Gibson Gilbert');
  Self.Inserir('Gill Gillespie Gillespie');
  Self.Inserir('Gilliam Glass Gleason');
  Self.Inserir('Glover Gomez Gonzales');
  Self.Inserir('Gonzalez Goode Goodman');
  Self.Inserir('Goodwin Gordon Gorman');
  Self.Inserir('Grace Grady Graham');
  Self.Inserir('Grant Grantham Graves');
  Self.Inserir('Gray Green Greene');
  Self.Inserir('Greenwood Greer Gregory');
  Self.Inserir('Griffin Griffith Gunn');
  Self.Inserir('Gustafson Guthrie Gutierrez');
  Self.Inserir('Guzman Hackett Hagan');
  Self.Inserir('Hahn Hale Haley');
  Self.Inserir('Hall Halsey Hamilton');
  Self.Inserir('Hammond Hampton Hancock');
  Self.Inserir('Hanley Hanna Hansen');
  Self.Inserir('Harding Hardy Harper');
  Self.Inserir('Harrington Harris Harrison');
  Self.Inserir('Hart Hartley Harvey');
  Self.Inserir('Hastings Hatch Hawkins');
  Self.Inserir('Hay Hayden Hayes');
  Self.Inserir('Haynes Hays Head');
  Self.Inserir('Healy Heath Henderson');
  Self.Inserir('Henry Hensley Hernandez');
  Self.Inserir('Herndon Hess Hewitt');
  Self.Inserir('Hickey Hickman Hicks');
  Self.Inserir('Higgins Hill Hodges');
  Self.Inserir('Hoffman Hogan Holbrook');
  Self.Inserir('Holden Holder Holland');
  Self.Inserir('Hollis Holloway Holman');
  Self.Inserir('Holmes Holt Hood');
  Self.Inserir('Hooper Hoover Hopkins');
  Self.Inserir('Hopper Horton Houghton');
  Self.Inserir('House Houston Howard');
  Self.Inserir('Howe Howell Hubbard');
  Self.Inserir('Huber Hudson Huffman');
  Self.Inserir('Hughes Hull Humphrey');
  Self.Inserir('Humphries Hunt Hunter');
  Self.Inserir('Hurley Hurst Hutchinson');
  Self.Inserir('Hutchison Ingram Jackson');
  Self.Inserir('Jacobs James Jamison');
  Self.Inserir('Jarvis Jenkins Jenkins');
  Self.Inserir('Jensen Jimenez Johnson');
  Self.Inserir('Johnson Johnston Johnston');
  Self.Inserir('Jones Jordan Jorgensen');
  Self.Inserir('Joyce Kane Kearney');
  Self.Inserir('Kearns Keating Keegan');
  Self.Inserir('Keene Kehoe Keith');
  Self.Inserir('Kelleher Keller Kelley');
  Self.Inserir('Kelly Kemp Kendall');
  Self.Inserir('Kennedy Kenney Kenny');
  Self.Inserir('Kent Kerr Kidd');
  Self.Inserir('Kilgore Kincaid King');
  Self.Inserir('Kinney Kirby Kirk');
  Self.Inserir('Kirkland Kirkpatrick Klein');
  Self.Inserir('Knight Koch Koenig');
  Self.Inserir('Krause Lake Lamb');
  Self.Inserir('Lamont Lancaster Lane');
  Self.Inserir('Larkin Larsen Larson');
  Self.Inserir('Law Lawrence Lawson');
  Self.Inserir('Leach Leblanc Lee');
  Self.Inserir('Leonard Leslie Levesque');
  Self.Inserir('Lewis Lewis Lindsay');
  Self.Inserir('Lindsey Little Lloyd');
  Self.Inserir('Lockhart Long Loomis');
  Self.Inserir('Lopez Love Lowe');
  Self.Inserir('Lucas Lynch Lyon');
  Self.Inserir('MacDonald MacGregor MacKay');
  Self.Inserir('MacKenzie MacKinnon MacLean');
  Self.Inserir('MacLeod MacMillan MacPherson');
  Self.Inserir('Madden Maher Mahoney');
  Self.Inserir('Maldonado Malloy Malone');
  Self.Inserir('Maloney Manning Marsh');
  Self.Inserir('Marshall Martin Martinez');
  Self.Inserir('Mason Massey Matthews');
  Self.Inserir('Mattingly Maurer Maxwell');
  Self.Inserir('May Maynard McAllister');
  Self.Inserir('McBride McCabe McCaffrey');
  Self.Inserir('McCain McCall McCallum');
  Self.Inserir('McCann McCarthy McCartney');
  Self.Inserir('McCarty McClanahan McCleary');
  Self.Inserir('McClellan McClure McCollum');
  Self.Inserir('McConnell McCormack McCormick');
  Self.Inserir('McCoy McCracken McCulloch');
  Self.Inserir('McCullough McCurdy McDaniel');
  Self.Inserir('McDermott McDonald McDonough');
  Self.Inserir('McDougall McDowell McElroy');
  Self.Inserir('McFadden McFarland McGarry');
  Self.Inserir('McGee McGinnis McGrath');
  Self.Inserir('McGraw McGregor McGuire');
  Self.Inserir('McHugh McIntosh McIntyre');
  Self.Inserir('McKay McKee McKenna');
  Self.Inserir('McKenzie McKinley McKinney');
  Self.Inserir('McKinnon McKnight McLain');
  Self.Inserir('McLaughlin McLean McLeod');
  Self.Inserir('McMahan McMahon McManus');
  Self.Inserir('McMillan McNally McNamara');
  Self.Inserir('McNeil McNeill McNulty');
  Self.Inserir('McPherson McQueen McWilliams');
  Self.Inserir('Mead Meadows Medeiros');
  Self.Inserir('Medina Meier Melton');
  Self.Inserir('Mendoza Meredith Merritt');
  Self.Inserir('Meyer Middleton Miles');
  Self.Inserir('Miller Mills Milne');
  Self.Inserir('Miranda Mitchell MolloyIrish');
  Self.Inserir('Monaghan Monahan Monroe');
  Self.Inserir('Montgomery Moody Mooney');
  Self.Inserir('Moore Morales Moran');
  Self.Inserir('Moreno Morgan Morris');
  Self.Inserir('Morris Morrison Morrow');
  Self.Inserir('Morse Moser Moss');
  Self.Inserir('Mueller Muir Munn');
  Self.Inserir('Munoz Munro Murdock');
  Self.Inserir('Murphy Murphy Murray');
  Self.Inserir('Murray Myers Myrick');
  Self.Inserir('Napier Nash Neal');
  Self.Inserir('Nelson Neville Newman');
  Self.Inserir('Newton Nichols Nicholson');
  Self.Inserir('Nicholson Nielsen Noble');
  Self.Inserir('Nolan Noonan Norris');
  Self.Inserir('North Norwood Nunez');
  Self.Inserir('O’Brien O’Connell O’Connor');
  Self.Inserir('O’Donnell Ogden Ogle');
  Self.Inserir('O’Grady O’Hara O’Keefe');
  Self.Inserir('O’Leary Oliver Olson');
  Self.Inserir('Olson O’Neal O’Neil');
  Self.Inserir('O’Neill O’Reilly O’Rourke');
  Self.Inserir('Orr Ortega Ortiz');
  Self.Inserir('O’Sullivan Owen Padilla');
  Self.Inserir('Page Palmer Parker');
  Self.Inserir('Parks Parrish Parsons');
  Self.Inserir('Patterson Patton Payne');
  Self.Inserir('Peacock Pearson Peck');
  Self.Inserir('Penn Pennington Pereira');
  Self.Inserir('Perez Perkins Perry');
  Self.Inserir('Peters Peterson Phillips');
  Self.Inserir('Pierce Pike Piperh');
  Self.Inserir('Pittman Pollard Pollock');
  Self.Inserir('Poole Pope Porter');
  Self.Inserir('Porter Porterfield Potter');
  Self.Inserir('Powell Power Powers');
  Self.Inserir('Prater Pratt Preston');
  Self.Inserir('Price Prince Pritchard');
  Self.Inserir('Proctor Pruitt Puckett');
  Self.Inserir('Pugh Purcell Putnam');
  Self.Inserir('Quinlan Quinn Rafferty');
  Self.Inserir('Ralston Ramirez Ramos');
  Self.Inserir('Ramsey Randall Rankin');
  Self.Inserir('Rasmussen Ray Reece');
  Self.Inserir('Reed Rees Reese');
  Self.Inserir('Reeves Regan Reid');
  Self.Inserir('Reid Reilly Reyes');
  Self.Inserir('Reynolds Reynolds Rhodes');
  Self.Inserir('Rice Richards Richardson');
  Self.Inserir('Riley Ritchie Rivera');
  Self.Inserir('Roach Robb Roberts');
  Self.Inserir('Roberts Robertson Robinson');
  Self.Inserir('Robles Roche Rodgers');
  Self.Inserir('Rodriguez Rogers Rollins');
  Self.Inserir('Romero Rooney Rose');
  Self.Inserir('Ross Rossi Roth');
  Self.Inserir('Rowe Roy Ruiz');
  Self.Inserir('Russell Russo Ryan');
  Self.Inserir('Salazar Salisbury Sampson');
  Self.Inserir('Sanchez Sanders Sandoval');
  Self.Inserir('Santiago Saunders Sawyer');
  Self.Inserir('Schaefer Schmidt Schmitt');
  Self.Inserir('Schneider Schofield Schroeder');
  Self.Inserir('Schultz Schwartz Scott');
  Self.Inserir('Sears Self Serrano');
  Self.Inserir('Shaffer Sharp Sharpe');
  Self.Inserir('Shaw Shea Sheehan');
  Self.Inserir('Shelton Shepherd Sheridan');
  Self.Inserir('Sherwood Shields Shoemaker');
  Self.Inserir('Short Silva Simmons');
  Self.Inserir('Simpson Sims Sinclair');
  Self.Inserir('Skinner Slattery Slaughter');
  Self.Inserir('Sloan Smart Smith');
  Self.Inserir('Snow Snyder Somerville');
  Self.Inserir('Soto Sparks Spears');
  Self.Inserir('Spence Spencer Stack');
  Self.Inserir('Stafford Stanley Stanton');
  Self.Inserir('Steele Stephens Stephenson');
  Self.Inserir('Stevens Stevenson Stewart');
  Self.Inserir('Stiles Stokes Stone');
  Self.Inserir('Stout Strickland Strong');
  Self.Inserir('Stuart Suarez Sullivan');
  Self.Inserir('Sutherland Sutton Sweeney');
  Self.Inserir('Taylor Temple Templeton');
  Self.Inserir('Tennant Terry Thomas');
  Self.Inserir('Thompson Thomson Thornton');
  Self.Inserir('Thorpe Thurston Tierney');
  Self.Inserir('Tilley Timmons Tobin');
  Self.Inserir('Todd Torres Townsend');
  Self.Inserir('Trevino Trujillo Tucker');
  Self.Inserir('Tucker Turner Underwood');
  Self.Inserir('Upton Urquhart Vance');
  Self.Inserir('Vargas Vaughan Vaughn');
  Self.Inserir('Vega Velez Vogel');
  Self.Inserir('Waddell Wade Wagner');
  Self.Inserir('Walker Wallace Walsh');
  Self.Inserir('Walton Ward Ward');
  Self.Inserir('Ware Warner Warren');
  Self.Inserir('Watkins Watson Waugh');
  Self.Inserir('Weaver Webb Weber');
  Self.Inserir('Webster Weeks Welch');
  Self.Inserir('Wells Welsh Wentworth');
  Self.Inserir('West Whalen Wheeler');
  Self.Inserir('Whitaker White Whitehead');
  Self.Inserir('Whittaker Wiley Wilkinson');
  Self.Inserir('Williams Williamson Willis');
  Self.Inserir('Willoughby Wilson Wise');
  Self.Inserir('Wood Woodard Woodruff');
  Self.Inserir('Woods Woodward Wooten');
  Self.Inserir('Wren Wright Wyatt');
  Self.Inserir('Ziegler Zuckerberg Zimmerman');
end;

procedure TForm7.DBGrid1DblClick(Sender: TObject);
begin
  if not(TDBGrid(Sender).DataSource.Dataset.IsEmpty) then
  begin
    TDBGrid(Sender).DataSource.Dataset.Edit;
    TDBGrid(Sender).DataSource.Dataset.FieldByName('ATIVO').AsString := IfThen(TDBGrid(Sender).DataSource.Dataset.FieldByName('ATIVO').AsString = 'S', 'N', 'S');
    TDBGrid(Sender).DataSource.Dataset.Post;
  end;
end;

procedure TForm7.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  LCheck: Integer;
  LRect: TRect;
begin
  if (TDBGrid(Sender).DataSource.Dataset.IsEmpty) then
    Exit;

  LRect := Rect;

  if (Column.FieldName = 'ATIVO') then
  begin
    TDBGrid(Sender).Canvas.FillRect(LRect);

    if (TDBGrid(Sender).DataSource.Dataset.FieldByName('ATIVO').AsString = 'S') then
      LCheck := DFCS_CHECKED
    else
      LCheck := 0;

    // ajusta o tamanho do CheckBox
    InflateRect(LRect, -2, -2); { Diminue o tamanho do CheckBox }

    // desenha o CheckBox conforme a condição acima
    DrawFrameControl(TDBGrid(Sender).Canvas.Handle, LRect, DFC_BUTTON, DFCS_BUTTONCHECK or LCheck);

    if (gdFocused in State) or (gdSelected in State) then
    begin
      TDBGrid(Sender).Canvas.Brush.Color := clWhite;
      TDBGrid(Sender).Canvas.font.Color := clNavy;

      TDBGrid(Sender).Canvas.FillRect(LRect);
    end;

    TDBGrid(Sender).EditorMode := False;
  end
  else
  begin
    TDBGrid(Sender).DefaultDrawColumnCell(LRect, DataCol, Column, State);
  end;
end;

procedure TForm7.DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  if field.FieldName = 'id' then


end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  ClientDataSetPessoa.CreateDataSet;
  ClientDataSetPessoa.Open;
  Self.GerarDados;
end;

end.

{
  https://www.andrecelestino.com/delphi-dicas-do-componente-dbgrid/
  https://stackoverflow.com/questions/22086594/adding-a-checkbox-in-a-grid-whose-ondrawcolumncell-handler-is-generic
  http://www.activedelphi.com.br/forum/viewtopic.php?t=92027&sid=32a7378fa437778a4d4ed9095378ea30
  https://showdelphi.com.br/como-colocar-um-checkbox-em-uma-coluna-do-dbgrid/
  https://www.devmedia.com.br/checkbox-dentro-de-um-dbgrid/1539


}
