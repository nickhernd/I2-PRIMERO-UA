#include <iostream>
#include <fstream>
#include <cstring>
using namespace std;


// extrae la informacion de la linea y la mete en sub.
void procesarLinea(string linea, Subscriber &sub){

}

int main(){
	string linea;
	ifstream fich;
	vector<Subscriber> subscribers;
	Subscriber sub;

	fich.open("subscribers.txt");
	if(fich.is_open()){
		getline(fich, linea);
		while(!fich.eof()){
			procesarLinea(linea, sub);
			subscribers.push_back(sub);
			getline(fich, linea);
		}
		for(Subscriber sus: subscribers){
			showSubscriber(sus);
		}
	}
	return 0;
}


