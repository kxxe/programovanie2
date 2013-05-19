program DomacaUloha01;
{$mode objfpc}{$H+}

uses
  Cthreads, Classes, SysUtils;
	
type
  TStudent = record
    Meno: string[15];
    Rocnik: Byte;
    Priemer: Real;
  end;

var
  wFile, Subor: TFileStream;
  rFile: TextFile;
  Student: array of TStudent;
  Riadok: String;
  Y, Rocnik: Byte;	
  Priemer: real;
  Meno: string[15];
  I: Integer;
begin
  	
  	// nacitanie suboru do recordu
	AssignFile(rFile,'studenti.txt');
	Reset(rFile); 
	while not seekEoF(rFile) do 
	begin
		SetLength(Student, Length(Student) + 1);	
		ReadLn(rFile,Riadok);
		Student[High(Student)].Meno := Copy(Riadok,0 , Pos(';',Riadok) - 1) ;
		Riadok:= Copy(Riadok, Pos(';',Riadok)+1, MaxInt); 
		Y:= StrToInt(Copy(Riadok,0 , Pos(' ',Riadok) -1));
		Student[High(Student)].Rocnik := Y;
		Riadok:= Copy(Riadok, Pos(' ',Riadok)+1, MaxInt); 
		Student[High(Student)].Priemer:= StrToFloat((Copy(Riadok, 0, MaxInt)));
	end;
	CloseFile(rFile);
  
	// zapisanie recordu do bin. suboru
	wFile:= TFileStream.Create('studenti.dat', fmCreate);
  	for I:= 0 to High(Student) do 
  	begin
		wFile.WriteBuffer(Student[I].Meno, Sizeof(TStudent.Meno));
		wFile.WriteBuffer(Student[I].Rocnik, SizeOf(Byte));
		wFile.WriteBuffer(Student[I].Priemer, SizeOf(Real));
	end;
	wFile.Free;
  
	Subor := TFileStream.Create('studenti.dat', fmOpenRead);
	while Subor.Position < Subor.Size do 
	begin
		Subor.ReadBuffer(Meno, Sizeof(TStudent.Meno));
		Writeln('Meno ziaka: ',Meno);
		Subor.ReadBuffer(Rocnik, SizeOf(Byte));
		Writeln('Rocnik    : ',Rocnik);
		Subor.ReadBuffer(Priemer, SizeOf(Real));
		Writeln('Priemer   : ',floattostr(priemer));
		Writeln('/////////////////////////////////////////////');
	end;
	Subor.Free;
end.
