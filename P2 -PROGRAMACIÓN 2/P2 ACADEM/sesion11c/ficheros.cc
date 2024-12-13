#include <iostream>
#include <fstream>
using namespace std;


int main(){
	ifstream fich; 		// para leer un fichero
	char filename[100];
	string linea;
	int nl;

	cout << "Introduce el nombre del fichero: ";
	cin.getline(filename, 100);
	fich.open(filename);
	if(fich.is_open()){
		nl = 1;
		getline(fich, linea);
		while(!fich.eof()){
			cout << fich.tellg() << endl;
			cout << nl << ": " << linea << endl;
			getline(fich, linea);
			nl++;
		}
		fich.close();
	}	
	return 0;
}
