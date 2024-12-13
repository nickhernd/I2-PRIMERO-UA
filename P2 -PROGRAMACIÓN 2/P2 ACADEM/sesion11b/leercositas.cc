#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
using namespace std;

struct Subscriber {
  unsigned int id;
  string name;
  string email;
  string mainIp;
  vector<string> ips;
};

void showSubscriber(const Subscriber &s){
	cout << s.id << ":";
	cout << s.name << ":";
	cout << s.email << ":";
	cout << s.mainIp << ":";
	for(int i = 0; i < s.ips.size(); i++){
		cout << s.ips[i];
		if(i != s.ips.size() - 1){
			cout << "|";
		}
	}
}

bool validateName(string name){
	int tam = name.length();
	bool valido = false;
	if(tam >= 3 && name.find(':') == string::npos){
		valido = true;
	}
	return valido;
}


bool procesarLinea(string linea, Subscriber &sub){
	bool ok = false;
	string aux;
	stringstream buf;

	buf << linea;
	getline(buf, sub.name, ':');
	if(validateName(sub.name) == false){
		cout << "Error name" << endl;	
	}
	else{
		ok = true;
		getline(buf, sub.email, ':');
		getline(buf, sub.mainIp, ':');
		do{
			getline(buf, aux, '|');
			sub.ips.push_back(aux);
		}while(buf.eof() == false);
	}
	return ok;
}

int main(){
	string linea;
	ifstream fich;
	Subscriber sub;
	vector<Subscriber> subscribers;
	string filename;	

	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str());
	if(fich.is_open()){
		getline(fich, linea);
		while(!fich.eof()){
			sub.ips.clear();
			if(procesarLinea(linea, sub) == true){
				subscribers.push_back(sub);
			}
			getline(fich, linea);
		}
		fich.close();
		for(Subscriber sub : subscribers){
			showSubscriber(sub);
			cout << endl;
		}
	}			
	return 0;
}
