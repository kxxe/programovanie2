program Triomin;

{$mode objfpc}{$H+}

uses
	cthreads, sysutils, classes;

const 
	N = 3;
	M = 3;	

type
	TMove = array [1..3] of Integer;

var
	plocha: array [1..N,1..M] of Integer;
	x1: array[1..12] of Integer = (-1,-1,0,0,0,0,1,1,0,0,0,0);
	x2: array[1..12] of Integer = (-1,-1,0,0,0,0,1,1,1,1,-1,-1);
	x3: array[1..12] of Integer = (0,0,-1,1,-1,1,0,0,1,1,-1,-1);
	y1: array[1..12] of Integer = (0,0,0,0,0,0,0,0,0,0,0,0);
	y2: array[1..12] of Integer = (-1,1,-1,-1,1,1,-1,1,0,0,0,0);
	y3: array[1..12] of Integer = (-1,1,-1,-1,1,1,-1,1,-1,1,-1,1);

procedure VytvorPlochu;
var
	x,y: integer;
begin
	for x:= 1 to N do 
	begin
		for y:= 1 to M do 
			plocha[x,y]:= 0;
	end;
end; // koniec funkcie

procedure VypisPlochu;
var
	x,y: integer;
begin
	for x:= 1 to N do 
	begin
		for y:= 1 to M do 
			write(Format(' %2d ', [plocha[x,y]]));
	writeln;
	end;
end;

function Skontroluj: Boolean;
var
	x, y: Integer;
begin
	for x:= 1 to N do
		for y:= 1 to M do 
			if plocha[x,y] = 0 then 
			begin
				Result:= False;
				Exit;
			end;
	Result:= True;
end;

function VolnyStvorec(X, Y: Integer): Boolean;
begin	
	if ( (X > 0) and (X <= N) and (Y>0) and (Y<=M) and (plocha[x,y] = 0)) then
		Result:= True
	else
		Result:= False;	
end;

function UlozTriominy(X, Y, TrimID: Integer): Boolean;
var
	k,j: Integer;
	dalsiX, dalsiY : TMove;
begin
	if Skontroluj then begin
		Result:= True;
		Exit;
	end;
	
	for k:= 1 to 12 do 
	begin
		dalsiX[1]:= X + x1[k];
		dalsiX[2]:= X + x2[k];
		dalsiX[3]:= X + x3[k];
		dalsiY[1]:= Y + y1[k];
		dalsiY[2]:= Y + y2[k];
		dalsiY[3]:= Y + y3[k];
		
		if(VolnyStvorec(dalsiX[1],dalsiY[1]) and VolnyStvorec(dalsiX[2],dalsiY[2]) and VolnyStvorec(dalsiX[3],dalsiY[3])) then
		begin
			plocha[dalsiX[1],dalsiY[1]]:= TrimID;
			plocha[dalsiX[2],dalsiY[2]]:= TrimID;
			plocha[dalsiX[3],dalsiY[3]]:= TrimID;
			
			//if(UlozTriominy(dalsiX[1],dalsiY[1],TrimID+1) or UlozTriominy(dalsiX[2],dalsiY[2],TrimID+1) or UlozTriominy(dalsiX[3],dalsiY[3],TrimID+1)) then
			if(UlozTriominy(X+1,Y+1,TrimID+1) or UlozTriominy(X+1,Y-1,TrimID+1) or UlozTriominy(X-1,Y+1,TrimID+1) or UlozTriominy(X-1,Y-1,TrimID+1)) then
			begin
				Result:= True;
				Exit;
			end
			else 
			begin
				plocha[dalsiX[1],dalsiY[1]]:= 0;
				plocha[dalsiX[2],dalsiY[2]]:= 0;
				plocha[dalsiX[3],dalsiY[3]]:= 0;
			end;
		end;	
	end;
	Result:= False;
end;

begin
	VytvorPlochu;
	Plocha[1,1]:= -1; // -1 = prekazky
	Plocha[1,3]:= -1;
	Plocha[3,1]:= -1;
	writeln('Pred vyplnenim: ');
	VypisPlochu;
	writeln;
	if UlozTriominy(1,1,1) then begin
		writeln('Po vyplneni: ');
		VypisPlochu;
	end
	else
		writeln('Triominy sa nedaju poukladat!!');
end.
