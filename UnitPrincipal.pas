unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Ani,
  System.ImageList, FMX.ImgList, FMX.Gestures;

type
  TfrmPrincipal = class(TForm)
    img_notification: TImage;
    img_add: TImage;
    Circle1: TCircle;
    Circle2: TCircle;
    Label1: TLabel;
    lbPlants: TListBox;
    lay_1: TLayout;
    rect_fundoSel: TRectangle;
    img_plantsSel: TImage;
    rect_buttom: TRectangle;
    Circle3: TCircle;
    Image1: TImage;
    Circle4: TCircle;
    Image2: TImage;
    Circle5: TCircle;
    Image3: TImage;
    rect_tb: TRectangle;
    AnimaWidth: TFloatAnimation;
    AnimaHeight: TFloatAnimation;
    AnimaX: TFloatAnimation;
    AnimaY: TFloatAnimation;
    animaRectBtn: TFloatAnimation;
    animaTb: TFloatAnimation;
    rect_buttomFull: TRectangle;
    animaBtnFull: TFloatAnimation;
    Label2: TLabel;
    rect_tbFull: TRectangle;
    Circle6: TCircle;
    Image4: TImage;
    Circle7: TCircle;
    Image5: TImage;
    animatbFull: TFloatAnimation;
    animaOpacityLB: TFloatAnimation;
    procedure FormShow(Sender: TObject);
    procedure lbPlantsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure AnimaHeightFinish(Sender: TObject);
    procedure Circle6Click(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
    procedure Circle2Click(Sender: TObject);
    procedure Circle7Click(Sender: TObject);
    procedure animatbFullFinish(Sender: TObject);
  private
    procedure CarregarPlantas;
    procedure ExibePlanta(item : TListBoxItem);
    procedure EscondePlanta;
    procedure EfeitoClick(obj: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses UnitFramePlants;



procedure TfrmPrincipal.AnimaHeightFinish(Sender: TObject);
begin
  if rect_fundoSel.Tag = 0 then
  begin
    rect_fundoSel.Visible := False;
    rect_buttomFull.Visible := False;
    rect_tbFull.Visible := False;
  end;

end;

procedure TfrmPrincipal.animatbFullFinish(Sender: TObject);
begin
  if rect_fundoSel.Tag = 1 then
  begin
    Circle6.Fill.Kind         := TBrushKind.Solid;
    Circle7.Fill.Kind         := TBrushKind.Solid;
  end;

end;

procedure TfrmPrincipal.CarregarPlantas;
var Item  : TListBoxItem;
    Frame : TfrmFramePlants;
    I     : Integer;
    img : TObject;
begin
  lbPlants.Clear;

  for I := 1 to 10 do
  begin
    Item := TListBoxItem.Create(lbPlants);
    Item.Text := '';
    Item.Selectable := False;
    Item.Height := 160;
    Item.Width := Trunc(lbPlants.Width / 2 );
    if (I mod 2) > 0 then
    begin
      Item.Margins.Left   := 10;
      Item.Margins.Right   := 5;

    end
    else begin
      Item.Margins.Right   := 10;
    end;
    Item.Margins.Bottom := 5;
    Item.Tag := I;

    Frame := TfrmFramePlants.Create(Item);
    Frame.Parent := Item;
    Frame.Align := TAlignLayout.Client;

    Frame.img_plantsFrame.Tag := I ;
    if (I mod 2) > 0  then
    begin
      Frame.rect_fundoFrame.Fill.Color := $ffDFE3E9;
      Frame.rect_fundoFrame.Stroke.Color := $ffDFE3E9;
    end;

    lbPlants.AddObject(Item);

  end;

end;

procedure TfrmPrincipal.EfeitoClick(obj : TObject);
var cor : TColor;
begin
  cor := TCircle(obj).Fill.Color; //para voltar para a cor anterior...
  if obj.ClassType = TCircle then begin
    TCircle(obj).Fill.Color := $FFE75C5C;
    TCircle(obj).AnimateColor('Fill.Color',cor,0.3,TAnimationType.&In,TInterpolationType.Circular);
  end;
end;


procedure TfrmPrincipal.Circle1Click(Sender: TObject);
begin
  EfeitoClick(Sender);
end;

procedure TfrmPrincipal.Circle2Click(Sender: TObject);
begin
  EfeitoClick(Sender);
end;

procedure TfrmPrincipal.Circle6Click(Sender: TObject);
begin
  Circle6.Fill.Kind         := TBrushKind.None;
  Circle7.Fill.Kind         := TBrushKind.None;
  EscondePlanta;
end;

procedure TfrmPrincipal.Circle7Click(Sender: TObject);
begin
  EfeitoClick(Sender);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  CarregarPlantas;
end;


procedure TfrmPrincipal.lbPlantsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var rect : TRectangle;
    img  : TImage;
begin
  rect := TRectangle(TFrame(Item.Components[0]).Components[0]); //pegando o rentagulo do item que foi clicado...
  img  := TImage(rect.Controls[0]);//pegando a imagem do item clicado...

  rect_fundoSel.Position.X   := 0;
  rect_fundoSel.Position.Y   := frmPrincipal.Height;
  rect_fundoSel.Width        := Item.Width;
  rect_fundoSel.Fill.Color   := rect.Fill.Color;
  Circle6.Fill.Color         := rect.Fill.Color;
  Circle7.Fill.Color         := rect.Fill.Color;
  rect_fundoSel.Stroke.Color := rect.Stroke.Color;
  img_plantsSel.Bitmap       := img.Bitmap;
  rect_fundoSel.Visible      := True;
  ExibePlanta(item);
end;

procedure TfrmPrincipal.ExibePlanta(item : TListBoxItem);
begin
  rect_fundoSel.Tag      := 1;

  animaOpacityLB.StartValue := 1;
  animaOpacityLB.StopValue  := 0;
  animaOpacityLB.Inverse := False;
  animaOpacityLB.Start;

  animaRectBtn.StartValue := 0;
  animaRectBtn.StopValue  := - rect_buttom.Height;
  animaRectBtn.Inverse := False;
  animaRectBtn.Start;

  animaTb.StartValue := 0;
  animaTb.StopValue  := - rect_tb.Height;
  animaTb.Inverse    := False;
  animaTb.Start;

  rect_buttomFull.Visible := True;
  animaBtnFull.StartValue := - rect_buttomFull.Height;
  animaBtnFull.StopValue  := 0;
  animaBtnFull.Inverse    := False;
  animaBtnFull.Start;

  rect_tbFull.Visible    := True;
  animatbFull.StartValue := - rect_tbFull.Height;
  animatbFull.StopValue  := 0;
  animatbFull.Inverse    := False;
  animatbFull.Start;

  AnimaHeight.StartValue := Item.Height;
  AnimaHeight.StopValue  := frmPrincipal.Height;
  AnimaHeight.Inverse    := False;
  AnimaHeight.Start;

  AnimaWidth.StartValue := Item.Width;
  AnimaWidth.StopValue  := frmPrincipal.Width;
  AnimaWidth.Inverse    := False;
  AnimaWidth.Start;

//desativado pois o eixo x é fixo nessa animação...
//  AnimaX.StartValue := frmPrincipal.Width;
//  AnimaX.StopValue  := 0;
//  AnimaX.Inverse    := False;
//  AnimaX.Start;

  AnimaY.StartValue := frmPrincipal.Height;
  AnimaY.StopValue  := 0;
  AnimaY.Inverse    := False;
  AnimaY.Start;

  rect_fundoSel.XRadius := 0;
  rect_fundoSel.YRadius := 0;

end;
procedure TfrmPrincipal.EscondePlanta;
begin
  rect_fundoSel.Tag := 0;
  rect_fundoSel.XRadius := 10;
  rect_fundoSel.YRadius := 10;

  AnimaHeight.Inverse := True;
  AnimaHeight.Start;

  AnimaWidth.Inverse := True;
  AnimaWidth.Start;

//desativado pois o eixo x é fixo nessa animação...
//  AnimaX.Inverse := True;
//  AnimaX.Start;

  AnimaY.Inverse := True;
  AnimaY.Start;

  animaRectBtn.Inverse := True;
  animaRectBtn.Start;

  animaTb.Inverse := True;
  animaTb.Start;

  animaBtnFull.Inverse := True;
  animaBtnFull.Start;

  animatbFull.Inverse := True;
  animatbFull.Start;

  animaOpacityLB.Inverse := True;
  animaOpacityLB.Start;


end;

end.
