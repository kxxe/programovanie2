program knightstour;
     
{$mode objfpc}{$H+}
     
uses
  cthreads, sysutils, classes;
     
const 
	N = 4; 
	M = 4;
	T = 3; 
  
type 
	TKocka = record
		X,Y: integer;
	end; 
	
	TTriomin = array [0..2] of TKocka;
     
var
	plocha: array [0..N-1,0..M-1] of integer;
   x1: array [0..T] of integer = (0,0,1,0); 
   x2: array [0..T] of integer = (1,0,1,1);
   x3: array [0..T] of integer = (1,1,0,0);
   y1: array [0..T] of integer = (0,0,0,0);
   y2: array [0..T] of integer = (0,1,1,0);
	y3: array [0..T] of integer = (1,1,1,1);              

function skontroluj: boolean;
var
	x,y: integer;
begin
	result:= true;
	for x:= 0 to N-1 do
		for y:= 0 to M-1 do
			if plocha[x,y] = 0 then
			begin
				result:= false;
				exit;
			end;
end;
  
procedure vytvor_plochu;
var
	x,y: integer;
begin
	for x:= 0 to N-1 do
		for y:= 0 to M-1 do
		begin
			plocha[x,y]:= 0;
		end;
end;  
 
procedure vypis_plochu;
var
	x,y: integer;
begin
	for x:= 0 to N-1 do begin
		for y:= 0 to M-1 do
			write(Format(' %2d ', [plocha[x,y]]));
		writeln;
	end;
end; 
                   
function je_volne(triomin: ttriomin): boolean;
var
	k: integer;
begin
	for k:= 0 to 2 do begin
		if ((triomin[k].x >= 0) and (triomin[k].x < N) and (triomin[k].y >= 0) 
		and (triomin[k].y < N) and (plocha[triomin[k].x,triomin[k].y] = 0)) then 
		begin
			result:= true;
		end
		else begin
			result:= false;
			exit;
		end;	
	end;
end;
        
           
function vyries(x, y, p: integer): boolean;
var
	k, next_x, next_y: integer;
	triomin: ttriomin;
begin
	result:= false;
           
	if skontroluj then begin
		result:= true;
		exit;  
	end;
           
	for k:= 0 to T do
	begin
		triomin[0].x:= x + x1[k];
		triomin[0].y:= y + y1[k];
		triomin[1].x:= x + x2[k];
  		triomin[1].y:= y + y2[k];
		triomin[2].x:= x + x3[k];
		triomin[2].y:= y + y3[k];
                   
		if je_volne(triomin) then
		begin      
			plocha[triomin[0].x,triomin[0].y]:= p;
			plocha[triomin[1].x,triomin[1].y]:= p;
			plocha[triomin[2].x,triomin[2].y]:= p;
				
			if(vyries(x+1,y,p+1) or vyries(x-1,y,p+1) or 
			vyries(x,y+1,p+1) or vyries(x,y-1,p+1)) then
			begin
				result:= true;
				exit;
			end
			else begin
				plocha[triomin[0].x,triomin[0].y]:= 0;
				plocha[triomin[1].x,triomin[1].y]:= 0;
				plocha[triomin[2].x,triomin[2].y]:= 0;
      	end;
		end;
	end;
	result:= false;
end;   
           
procedure trim_bt;
begin
     
	if not vyries(0,0,1) then
	begin
		writeln('Neexistuje riesenie!');
		exit;
	end
	else
		vypis_plochu;
end;           
    //*****************************************************        
begin
	vytvor_plochu;
	//vypis_plochu;
	trim_bt;
	writeln;
end.
