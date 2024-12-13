#include <iostream>
#include <cstring>
#include <fstream>
using namespace std;


int main(){
	ifstream fich;
	string linea;
	int nl;

	nl = 1;
	fich.open("texto.txt");
	if(fich.is_open()){
		getline(fich, linea);
		while(!fich.eof()){
			cout << nl << ": " << linea << endl;		
			nl++;	
			getline(fich, linea);
		}
	}
	return 0;
}
