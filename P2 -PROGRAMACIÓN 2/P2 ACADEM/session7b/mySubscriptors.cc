#include <iostream>
#include <vector>
using namespace std;

struct Subscriber {
  unsigned int id;
  string name;
  string email;
  string mainIp;
  vector<string> ips;
};

struct Platform {
  string name;
  vector<Subscriber> subscribers;
  unsigned int nextId;
};

void printSubscriber(Subscriber sub){
	cout << sub.id << ":";
	cout << sub.name << ":";
	cout << sub.email << ":";
	cout << sub.mainIp << ":";
	for(int i = 0; i < sub.ips.size(); i++){
		cout << sub.ips[i];
		if(i != sub.ips.size() - 1){			
			cout << "|";
		}
	}
}

void printSubscriber2(Subscriber sub){
	cout << sub.id << ":";
	cout << sub.name << ":";
	cout << sub.email << ":";
	cout << sub.mainIp << ":";
	for(int i = 0; i < sub.ips.size(); i++){
		if(i != 0){
			cout << "|";
		}
		cout << sub.ips[i];
	}
}


int countIps(vector<string> vips, string ip){
	int veces = 0;
	for(string i : vips){
		if(i == ip){
			veces++;
		}
	}
	return veces;
}

int main(){
	Platform platform = {"chai-platform", {}, 1};
	char option;
	Subscriber nuevo;
	int id, pos, veces_actual, veces_antigua;
	string s_id, s_ip;

	do{
		cout << "1. Add subscriptor" << endl;
		cout << "2. Show platform" << endl;
		cout << "3. Add id" << endl;
		cout << "4. Delete subscriptor" << endl;
		cout << "5. " << endl;
		cout << "q. Quit" << endl;
		cout << "Option: ";
		cin >> option;
		cin.get();
		switch(option){
			case '1':
				nuevo.id = platform.nextId++;
				cout << "Enter name: ";
				getline(cin, nuevo.name);
				cout << "Enter email: ";
				getline(cin, nuevo.email);
				nuevo.mainIp = "";
				platform.subscribers.push_back(nuevo);
			break;
			case '2':
				for(Subscriber s : platform.subscribers){
					printSubscriber(s);
					cout << endl;
				}
				/*
				for(int i = 0; i < platform.subscribers.size(); i++){
					showSubscriber(platform.subscribers[i]);
					cout << endl;				
				}*/
			break;
			case '3':
				cout << "Enter subscriber id: ";
				getline(cin, s_id);
				id = stoi(s_id); // paso la cadena a entero.
				// busco el id en el vector de subscribers.
				pos = -1;
				for(int i = 0; i < platform.subscribers.size() && pos == -1; i++){
					if(id == platform.subscribers[i].id){
						pos = i;
					}
				}
				if(pos == -1){
					cout << "Error, subscriber not found" << endl;
				}
				else{
					cout << "Enter IP: ";
					getline(cin, s_ip);
					platform.subscribers[pos].ips.push_back(s_ip);
					// comparar las veces que se repite la nueva
					// con las veces que se repite la mainIp de ahora.
					veces_antigua = countIps(platform.subscribers[pos].ips, platform.subscribers[pos].mainIp);
					veces_actual = countIps(platform.subscribers[pos].ips, s_ip);
					if(veces_actual > veces_antigua){
						platform.subscribers[pos].mainIp = s_ip;
					}
				}
			break;
			case '4':
			break;
			case '5':
			break;
			case 'q':
			break;
			default:
				cout << "Error in option" << endl;
			break;
		}
	}while(option != 'q');
	return 0;
}
