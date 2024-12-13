#include <iostream>
#include <vector>
using namespace std;

int main(){
	string nfs[] = {"platano", "cereza", "banana", "pera", "melon", "sandias"};
	vector<string> frutas;
	int r, veces;

	for(int i = 1; i <= 10; i++){
		r = rand() % 6;
		frutas.push_back(nfs[r]);
	}

	for(string s : frutas){
		cout << s << " ";
	}
	cout << endl;

	int vecesMayor = 0;
	int posMayor = -1;
	for(int i = 0; i < frutas.size(); i++){
		veces = 0;	
		for(int j = 0; j < frutas.size(); j++){
			cout << "(" << i << "): " << frutas[i] << " (" << j << "): " << frutas[j];
			if(frutas[i] == frutas[j]){
				veces++;
				cout << " **** (" << veces << ")" ;
			}
			cout << endl;
		}
		if(veces > vecesMayor){
			vecesMayor = veces;
			posMayor = i;
		}
		cout << frutas[i] << " se repite " << veces << " veces. " << endl;	
	}
	cout << "La que mas se repite es " << frutas[posMayor] << " y se repite " << vecesMayor << " veces" << endl;

}
