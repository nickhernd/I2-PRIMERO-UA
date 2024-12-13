#include <iostream>
#include <vector>
#include <fstream>
#include <sstream>
using namespace std;

struct Subscriber {
  unsigned int id;
  string name;
  string email;
  string mainIp;
  vector<string> ips;
};

bool testName(string name){
	return true;
}

bool procesarLinea(string linea, Subscriber &sub){
	bool ok = false;
	stringstream buf;
	string ipaux;	

	buf << linea;
	getline(buf, sub.name, ':');
	ok = testName(sub.name);
	if(ok == false){
		cout << "error" << endl;
	}
	else{
		ok = true;
		getline(buf, sub.email, ':');
		getline(buf, sub.mainIp, ':');
		sub.ips.clear();
		do{
			getline(buf, ipaux, '|');
			sub.ips.push_back(ipaux);
		}while(!buf.eof());
	 }
	return ok;
}

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


int main(){
	vector<Subscriber> subscribers;
	string filename;
	ifstream fich;
	Subscriber sub;
	string linea;
	bool ok;

	cout << "Enter filename: ";
	getline(cin, filename);
	
	fich.open(filename.c_str()); // string => char []
	if(fich.is_open()){
		getline(fich, linea);
		while(!fich.eof()){
			ok = procesarLinea(linea, sub);
			if(ok == true){
				subscribers.push_back(sub);
			}
			getline(fich, linea);
		}
		fich.close();
		for(Subscriber s : subscribers){
			showSubscriber(s);
			cout << endl;
		}
		for(int i = 0; i < subscribers.size(); i++){
			Subscriber s = subscribers[i];
			showSubscriber(s);
			cout << endl;
		}
	}
	
	
	return 0;
}
