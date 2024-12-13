#include <iostream>
#include <sstream>
using namespace std;


bool todoDigitos(string numero){
	bool todo = true;
	
	for(int i = 0; i < numero.length() && todo; i++){
		if(numero[i] < '0' || numero[i] > '9'){
			todo = false;
		}
	}	
	return todo;
}

// ip = "123.2342.1234.12344"
bool testIp(string ip){
	bool ok = false;
	stringstream ss;
	string parte1, parte2, parte3, parte4;
	int num1, num2, num3, num4;

	ss << ip;
	getline(ss, parte1, '.');
	getline(ss, parte2, '.');
	getline(ss, parte3, '.');
	getline(ss, parte4);

	if(todoDigitos(parte1) && todoDigitos(parte2) && todoDigitos(parte3) && todoDigitos(parte4)){
		if(parte1 != "" && parte2 != "" && parte3 != "" && parte4 != ""){
			num1 = stoi(parte1);
			num2 = stoi(parte2);
			num3 = stoi(parte3);
			num4 = stoi(parte4);
			if(num1 >= 0 && num1 <= 255 && num2 >= 0 && num2 <= 255 && num3 >= 0 && num3 <= 255 && num4 >= 0 && num4 <= 255){
				ok = true;
			}
		}
	}
	return ok;
}


bool testIp(string ip){
	bool ok = false;
	string parte1, parte2, parte3, parte4;
	int num1, num2, num3, num4, i;

	i = 0;
	parte1 = "";	
	while(i < ip.length() && ip[i] != '.'){
		parte1 += ip[i];
		i++;
	}
	i++;

	parte2 = "";	
	while(i < ip.length() && ip[i] != '.'){
		parte2 += ip[i];
		i++;
	}
	i++;

	parte3 = "";	
	while(i < ip.length() && ip[i] != '.'){
		parte3 += ip[i];
		i++;
	}
	i++;

	parte4 = "";	
	while(i < ip.length()){
		parte4 += ip[i];
		i++;
	}

	if(todoDigitos(parte1) && todoDigitos(parte2) && todoDigitos(parte3) && todoDigitos(parte4)){
		if(parte1 != "" && parte2 != "" && parte3 != "" && parte4 != ""){
			num1 = stoi(parte1);
			num2 = stoi(parte2);
			num3 = stoi(parte3);
			num4 = stoi(parte4);
			if(num1 >= 0 && num1 <= 255 && num2 >= 0 && num2 <= 255 && num3 >= 0 && num3 <= 255 && num4 >= 0 && num4 <= 255){
				ok = true;
			}
		}
	}
	return ok;
}


int main(){
	string ip;
	bool ok_ip;

	cout << "ip: ";
	getline(cin, ip);
	ok_ip = testIp(ip);
	if(ok_ip){
		cout << "ok" << endl;
	}
	else{
		cout << "no ok" << endl;
	}

	return 0;
}
