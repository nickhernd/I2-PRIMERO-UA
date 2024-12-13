#include <iostream>
#include <fstream>
using namespace std;


int main(){
	ifstream fich;
	string linea;
	int nl;

	fich.open("lineas.txt"); 
	if(fich.is_open()){ // si existe el fichero lineas.txt
		nl = 1;		
		getline(fich, linea);
		while(fich.eof() == false){
			cout << nl << ": " << linea << endl;
			getline(fich, linea);
			nl++;
		}
		fich.close();
	}
	return 0;
}
