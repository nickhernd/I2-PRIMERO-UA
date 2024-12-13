#include <iostream>
#include <vector>
#include <fstream>
using namespace std;

struct Coordenada{
	int x, y;
};

// saca la informacion de la linea y la mete en la coordenada.
void procesarLinea(string linea, Coordenada &leida){
	int pos;

	pos = linea.find(',');
	leida.x = stoi(linea.substr(0, pos));
	leida.y = stoi(linea.substr(pos + 1));

/*	
	string aux;
	int i;
	aux = "";
	i = 0;
	while(linea[i] != ','){
		aux += linea[i++];
	}
	leida.x = stoi(aux);
	i++;
	aux = "";
	while(i < linea.length()){
		aux += linea[i++];
	}
	leida.y = stoi(aux);
*/
}

int main(){
	Coordenada leida;
	vector<Coordenada> coordenadas;
	char filename[100];
	ifstream fich;
	string linea;

	cout << "Enter filename: ";
	cin.getline(filename, 100);
	fich.open(filename);
	if(fich.is_open()){
		// el programa lee las coordenadas y las mete en el vector.
		getline(fich, linea);
		/*fich >> leida.x;
		fich.get();
		fich >> leida.y;*/
		while(fich.eof() == false){
			procesarLinea(linea, leida);
			coordenadas.push_back(leida);
			getline(fich, linea);
			/*fich >> leida.x;
			fich.get();
			fich >> leida.y;*/
		}  
		fich.close();
		for(Coordenada coord : coordenadas){
			cout << coord.x << ", " << coord.y << endl;
		}
	}



	return 0;
}
