uses crt, GraphABC;

const
  u = 10;
  p = 5;

var
  scaleFactor: real = 1.0;
  depth: integer = p;
  xOffset: integer = 100;
  yOffset: integer = 100;

procedure LineRel(dx, dy: integer);
begin
  LineTo(PenX + dx, PenY + dy);
end;

procedure a(i: integer; scale: real); forward;
procedure b(i: integer; scale: real); forward;
procedure c(i: integer; scale: real); forward;
procedure d(i: integer; scale: real); forward;
procedure a(i: integer; scale: real);
begin
  if i > 0 then
  begin
    d(i - 1, scale);
    LineRel(Round(u * scale), 0);
    a(i - 1, scale);
    LineRel(0, Round(u * scale));
    a(i - 1, scale);
    LineRel(-Round(u * scale), 0);
    c(i - 1, scale);
  end;
end;

procedure b(i: integer; scale: real);
begin
  if i > 0 then
  begin
    c(i - 1, scale);
    LineRel(-Round(u * scale), 0);
    b(i - 1, scale);
    LineRel(0, -Round(u * scale));
    b(i - 1, scale);
    LineRel(Round(u * scale), 0);
    d(i - 1, scale);
  end;
end;

procedure c(i: integer; scale: real);
begin
  if i > 0 then
  begin
    b(i - 1, scale);
    LineRel(0, -Round(u * scale));
    c(i - 1, scale);
    LineRel(-Round(u * scale), 0);
    c(i - 1, scale);
    LineRel(0, Round(u * scale));
    a(i - 1, scale);
  end;
end;

procedure d(i: integer; scale: real);
begin
  if i > 0 then
  begin
    a(i - 1, scale);
    LineRel(0, Round(u * scale));
    d(i - 1, scale);
    LineRel(Round(u * scale), 0);
    d(i - 1, scale);
    LineRel(0, -Round(u * scale));
    b(i - 1, scale);
  end;
end;

procedure DrawFractal;
begin
  ClearWindow;
  MoveTo(xOffset, yOffset);
  a(depth, scaleFactor);
end;

procedure UpdateSettings(key: integer);
begin
  case key of
    VK_W: Inc(depth);
    VK_S: if depth > 1 then Dec(depth);
    VK_LEFT: Dec(xOffset, 10);
    VK_RIGHT: Inc(xOffset, 10);
    VK_UP: Dec(yOffset, 10);
    VK_DOWN: Inc(yOffset, 10);
    VK_A: scaleFactor := scaleFactor * 1.1; //  +масштаб
    VK_D: scaleFactor := scaleFactor / 1.1; //  -масштаб
  end;
  DrawFractal;
end;

begin
  SetWindowCaption('Фракталы: Кривая Гильберта');
  SetWindowSize(500, 500);
  ClearWindow;
  OnKeyDown := UpdateSettings;
  DrawFractal;
  repeat
  until KeyPressed;
end.