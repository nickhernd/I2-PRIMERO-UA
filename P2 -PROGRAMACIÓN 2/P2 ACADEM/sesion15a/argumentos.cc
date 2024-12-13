#include <iostream>
#include <cstring>
using namespace std;

// ./argumentos hola juancarlos hazme puto caso
// argc = 6
// argv[0] = "./argumentos"
// argv[1] = "hola"
// argv[2] = "juancarlos"
// argv[3] = "hazme"
// argv[4] = "puto"
// argv[5] = "caso"

int main(int argc, char *argv[]){
	
	cout << "El numero de argumentos: " << argc << endl;
	for(int i = 0; i < argc; i++){
		cout << i << " => " << argv[i] << endl;
	}

	return 0;
}
