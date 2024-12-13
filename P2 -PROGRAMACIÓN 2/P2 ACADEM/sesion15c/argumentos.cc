#include <iostream>
using namespace std;

/*
	argc = 3
	argv[0] = "./argumentos"
	argv[1] = "puto"
	argv[2] = "keko"
*/

int main(int argc, char *argv[]){
	cout << "Numero de argumentos: "  << argc << endl;
	for(int i = 0; i < argc; i++){
		cout << i << " => " << argv[i] << endl;
	}
	return 0;
}
