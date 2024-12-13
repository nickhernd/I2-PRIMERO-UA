#include <iostream>
#include <cstring>
using namespace std;



// ./argumentos hola valentin 34 -f buu
// argc = 6
// argv[0] = "./argumentos"
// argv[1] = "hola"
// argv[2] = "valentin"
// argv[3] = "34"
// argv[4] = "-f"
// argv[5] = "buu"



int main(int argc, char *argv[]){
	cout << "cantidad de argumentos: " << argc << endl;
	for(int i = 0; i < argc; i++){
		cout << i << " => " << argv[i] << endl;
	}
	
	return 0;
}
