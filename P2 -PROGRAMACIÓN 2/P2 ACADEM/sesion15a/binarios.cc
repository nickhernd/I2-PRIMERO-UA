#include <iostream>
#include <fstream>
#include <vector>
#include <cstring>
using namespace std;

struct Alumno{
	string nombre;
	int edad;
};

struct AlumnoBin{
	char nombre[100];
	int edad;
};

void show(vector<Alumno> alumnos){
	for(Alumno alu : alumnos){
		cout << alu.nombre << ":" << alu.edad << endl;
	}
}

Alumno getAlu(AlumnoBin alubin){
	Alumno leido;
	leido.nombre = alubin.nombre; 	 	// string <= char [] thats ok
	leido.edad = alubin.edad;
	return leido;
}

void loadData(vector<Alumno> &alumnos){
	AlumnoBin alubin;
	Alumno leido;
	ifstream fich;
	string filename;
	
	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str(), ios::binary);
	if(fich.is_open()){
		fich.read((char *) &alubin, sizeof(alubin));
		while(!fich.eof()){
			leido = getAlu(alubin);
			alumnos.push_back(leido);
			fich.read((char *) &alubin, sizeof(alubin));
		}
		fich.close();
	}
}

AlumnoBin getBin(Alumno alu){
	AlumnoBin alubin;

	alubin.edad = alu.edad;
	strncpy(alubin.nombre, alu.nombre.c_str(), 100); // char [] <= string
	alubin.nombre[99] = '\0';
	
	return alubin;
}

void saveData(vector<Alumno> alumnos){
	AlumnoBin alubin;
	ofstream fich;
	string filename;

	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str(), ios::binary);
	if(fich.is_open()){
		for(Alumno alu : alumnos){
			alubin = getBin(alu);
			fich.write((const char *) &alubin, sizeof(alubin));
		}
		fich.close();
	}
}




// los meto en texto.
void exportCsv(vector<Alumno> alumnos){
	string filename;
	ofstream fich;
	
	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str());
	if(fich.is_open()){ // si no existe lo crea y si existe los sobrescribe
		for(Alumno alu : alumnos){
			fich << alu.nombre << ":" << alu.edad << endl;
		}
		fich.close();
	}
	
}

void importCsv(vector<Alumno> &alumnos){
	string filename;
	ifstream fich;
	Alumno leido;
	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str());
	if(fich.is_open()){	// si no existe da error
		getline(fich, leido.nombre, ':');
		while(!fich.eof()){
			fich >> leido.edad;	// lee la secuencia de caracteres hasta el \n
			fich.get();		// me pongo al principio de la siguiente linea
			alumnos.push_back(leido);
			getline(fich, leido.nombre, ':');
		}
	}
}


int main(){
	char option;
	vector<Alumno> alumnos = {{"jose", 12}, {"juan", 34}, {"keko", 12}, {"elenuki", 12}, {"juanfran", 34}};
	
	do{
		cout << "1. Read from txt file" << endl;
		cout << "2. Write to txt file" << endl;
		cout << "3. Show in console" << endl;
		cout << "4. Save data in a binnary file" << endl;
		cout << "5. Load data from a binnary file" << endl;	
		cout << "q. quit level" << endl;
		cout << "Option: ";
		cin >> option;
		cin.get();
		switch(option){
			case '1':
				importCsv(alumnos);
				break;
			case '2':
				exportCsv(alumnos);
				break;
			case '3':
				show(alumnos);
				break;
			case '4':
				saveData(alumnos);
				break;
			case '5':
				loadData(alumnos);
				break;
			case 'q':
				break;
			default:
				cout << "Error in option" << endl;
				break;
		}
	}while(option != 'q');
	return 0;
}




