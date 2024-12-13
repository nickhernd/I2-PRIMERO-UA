#include <iostream>
#include <cstring>
#include <vector>
using namespace std;

// Es un numero entre 0 y 255, que no esta vacia
// y la unica forma de poner 0 es "0". "00" "000" estarian mal 012, 0134
bool esNumero(string num){
	bool ok;
	int i, valor_numerico;

	if(num.length() > 0){
		if(num[0] == '0' && num.length() > 1){
			ok = false;
		}
		else{
			ok = true;
			i = 0;
			while(i < num.length() && ok == true){
				if(isdigit(num[i]) == 0){
					ok = false;
				}
				else{
					i++;
				}
			}
			if(ok == true){
				valor_numerico = stoi(num);
				if(valor_numerico < 0 || valor_numerico > 255){
					ok = false;
				}
			}
		}
	}
	else{
		ok = false;
	}
	return ok;
}


// ip = "123"
// ip = "123.23.0.123.3243"
bool comprobarIp(string ip){
	int i, tam;
	bool ok = false;
	vector<string> ips; // vector<string> ips = {"", "", "", ""};
				// vector<string> ips(4, "");
	// string ips [] = {"", "", "", ""};
	string ipAux;
	

	tam = ip.length();
	i = 0;
	for(int k = 0; k < 4; k++){
		ipAux = ""; 
		while(i < tam && ip[i] != '.'){
			ipAux += ip[i]; // ips[k] += ip[i];
			i++;
		}
		i++; // me salto el .
		ips.push_back(ipAux); // la meto
		// ips[k] = ipAux;
		/*switch(k){
			case 0:
				ip0 = ipAux;
				break;
			//...
		}*/
	}
	bool correctas = true;
	for(int k = 0; k < 4 && correctas; k++){
		correctas = esNumero(ips[k]);
		cout << ips[k] << " => " << correctas << endl;	
	}
/*	
	tam = ip.length();
	i = 0;
	ipAux = "";
	ips.push_back("");
	while(i < tam && ip[i] != '.'){
		ips[0] += ip[i]; // la voy metieindo poco a poco
		i++;
	}
*/
	return correctas;
}

int main(){
	vector<string> ips = {
		"127.0.0.1",
		"232",
		"3434.123.1234.213.232",
		"0.0.0.0",
		"123.02.23.21",
		"ad.dfd.fds.adf"
	};
	for(string i : ips){
		cout << i << endl << (comprobarIp(i)?" ok":" no ok") << endl
<<endl ;
	}
	

}
