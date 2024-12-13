#include <iostream>
#include <vector>
using namespace std;


// 0 - 255
// y en caso de ser 0 solamente puede ser "0"
bool testNumero(string s){
	bool tested;
	int numero;	

	tested = false;
	if(s.length() > 0){
		tested = true;
		for(int i = 0; i < s.length() && tested; i++){
			if(s[i] < '0' || s[i] > '9'){
				tested = false;
			}
		}
		if(tested){
			numero = stoi(s);
			if(numero < 0 || numero > 255){
				tested = false;
			}
		}
	}
	return tested;
}

// 127.0.0.1.123
bool testIp(string ip){
	string s;
	int i;
	bool ok;	
	ok = true;
	
	i = 0;
	for(int k = 0; k < 4 && ok; k++){
		s = "";
		while(i < ip.length() && ip[i] != '.'){
			s = s + ip[i];
			i++;
		}
		i++;
		ok = testNumero(s);
	}
	if(i < ip.length()){
		ok = false;
	}
	return ok;
}

int main(){
	string ip;
	bool tested;	
	
	cout << "introduceme la ip: ";
	getline(cin, ip);
	
	tested = testIp(ip);
	if(tested){
		cout << "todo ok" << endl;
	}
	else{
		cout << "no todo ok" << endl;
	}

	return 0;
}
