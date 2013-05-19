procedure TGraf.UrobKomponenty(C:TCanvas);
var
  I,J,V,P,X: Integer;
  Pom: set of byte;
begin
  setLength(Komponenty, Length(G));
  Visited:= [];
  Pom := [];
  P:= 1;
  for I := 0 to High(G) do
    if not (I in Visited) then
    begin
       Dohlbky(I);
       if i = 0 then
       pom :=  visited;
        if i>0 then
          visited:= visited - pom;
      for J in Visited do
      begin
        Komponenty[J] := P;
      end;
      inc(P);
      visited:= visited + pom;
      pom:=visited + pom;
    end;



   X:=10;
   for i :=0 to high(komponenty) do begin
       c.textout(X,400,inttostr(Komponenty[i]));
       x:= x+15;

   end;
end; 
