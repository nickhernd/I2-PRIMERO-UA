#include <iostream>
#include <vector>
#include <algorithm>
#include <fstream>


using namespace std;

const int KMAXSTRING = 50;
const int KMAXIP = 16;

enum Error {
  ERR_OPTION,
  ERR_NAME,
  ERR_EMAIL,
  ERR_ID,
  ERR_IP,
  ERR_FILE,
  ERR_ARGS
};

struct Subscriber {
  unsigned int id;
  string name;
  string email;
  string mainIp;
  vector<string> ips;
};

struct BinSubscriber {
  unsigned int id;
  char name[KMAXSTRING];
  char email[KMAXSTRING];
  char mainIp[KMAXIP];
};

struct Platform {
  string name;
  vector<Subscriber> subscribers;
  unsigned int nextId;
};

struct BinPlatform {
  char name[KMAXSTRING];
  unsigned int nextId;
};

void error(Error e) {
  switch (e) {
    case ERR_OPTION:
      cout << "ERROR: wrong menu option" << endl;
      break;
    case ERR_NAME:
      cout << "ERROR: wrong name" << endl;
      break;
    case ERR_EMAIL:
      cout << "ERROR: wrong email" << endl;
      break;
    case ERR_ID:
      cout << "ERROR: wrong subscriber id" << endl;
      break;
    case ERR_IP:
      cout << "ERROR: wrong IP" << endl;
      break;
    case ERR_FILE:
      cout << "ERROR: cannot open file" << endl;
      break;
    case ERR_ARGS:
      cout << "ERROR: wrong arguments" << endl;
      break;
  }
}

void showMainMenu() {
  cout << "[Options]" << endl
       << "1- Show subscribers" << endl
       << "2- Add subscriber" << endl
       << "3- Add subscriber IP" << endl
       << "4- Delete subscriber" << endl
       << "5- Import/export" << endl
       << "q- Quit" << endl
       << "Option: ";
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

void showSubscribers(const Platform &platform) {
	for(int i = 0; i < platform.subscribers.size(); i++){
		showSubscriber(platform.subscribers[i]);
		cout << endl;
	}
	/*for(Subscriber s : platform.subscribers){
		showSubscriber(s);
	}*/
}


// minimo 3 caracteres y que no tenga : sol
bool validateName(string name){
	int tam, i;
	bool correct = false;

	tam = name.length();
	if(tam >= 3){
		if(name.find(':') != string::npos){
			correct = false; 
		}
		else{
			correct = true;
		}
	}
	return correct;
	// return name.length() >= 3 && name.find(':') != string::npos;
}

bool validate(string left){
	int tam = left.length();
	bool valid = false;

	if(tam > 0){
		if(left[0] != '.' && left[tam - 1] != '.'){
			// letra digito _ o .
			valid = true;
			for(int i = 0; i < tam && valid; i++){
				if(left[i] != '_' && left[i] != '.' && isalnum(left[i]) == 0){
					valid = false;
				}
			}
		}
	}
	return valid;
}

bool validateEmailCool(string email){
	// auto pos = string::npos;
	bool valid = false;
	int pos;
	string izquierda, derecha;
	pos = email.find('@');
	if(pos != string::npos){
		izquierda = email.substr(0, pos); // desde 0 pos caracteres
		derecha = email.substr(pos + 1); // desde pos + 1 hasta el final
		// cout << izquierda << "   " << derecha << endl;
		if(validate(izquierda)){
			if(validate(derecha)){
				if(derecha.find('@') == string::npos){
					if(derecha.find('.') != string::npos){
						valid = true;
					}
				}
			}
		}		
	}
	return valid;
}


void addSubscriber(Platform &platform) {
	Subscriber nuevo;
	bool ok;
	do{
		cout << "Enter name: ";
		getline(cin, nuevo.name);
		ok = validateName(nuevo.name);	
		if(ok == false){
			error(ERR_NAME);
		}
	}while(ok == false);

	do{
		cout << "Enter email: ";
		getline(cin, nuevo.email);
		if(validateEmailCool(nuevo.email) == false){
			error(ERR_EMAIL);
		}
	}while(validateEmailCool(nuevo.email) == false);

	nuevo.mainIp = "";
	nuevo.id = platform.nextId;
	platform.nextId++;

	platform.subscribers.push_back(nuevo);
}

int searchSubscriber(const vector<Subscriber> subscribers, int id){
	int pos, i;
	pos = -1;
	for(i = 0; i < subscribers.size() && pos == -1; i++){
		if(subscribers[i].id == id){
			pos = i;
		}
	}
	return pos;
}

// devuelve la cantidad de veces que ip esta en la cadena.
int contar(const vector<string> &ips, string ip){
	int veces = 0;
	return veces;
}

void update(Subscriber &s, string s_ip){
	// contamos la cantidad de veces que se repite en el vector de ip s_ip
	// contamos la cantidad de veces que se repite en el vector de ip main_Ip
	// si es mayor s_ip que la mainIp actualizo....
	int cuantas1, cuantas2;

	cuantas1 = 0;
	cuantas2 = 0;
	for(int i = 0; i < s.ips.size(); i++){
		if(s_ip == s.ips[i]){
			cuantas1++;
		}
		if(s.mainIp == s.ips[i]){
			cuantas2++;
		}
	}
	if(cuantas1 > cuantas2){
		s.mainIp = s_ip;
	}
}

void update2(Subscriber &s, string s_ip){
	int cuantas1, cuantas2;
	cuantas1 = count(s.ips.begin(), s.ips.end(), s_ip);
	cuantas2 = count(s.ips.begin(), s.ips.end(), s.mainIp);
	if(cuantas1 > cuantas2){
		s.mainIp = s_ip;
	}
}

bool todoDigitos(string numero){
	bool todo = true;
	
	for(int i = 0; i < numero.length() && todo; i++){
		if(numero[i] < '0' || numero[i] > '9'){ // if(isdigit(numero[i]) == 0){
			todo = false;
		}
	}	
	return todo;
}

/*
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
*/

bool validateIp(string ip){
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


void addSubscriberIp(Platform &platform) {
	string s_ip, s_id;
	int id, pos;	

	cout << "Enter subscriber id: ";
	getline(cin, s_id);
	if(s_id == ""){
		error(ERR_ID);
	}
	else{
		id = stoi(s_id);
		pos = searchSubscriber(platform.subscribers, id);
		if(pos == -1){
			error(ERR_ID);
		}
		else{
			cout << "Enter IP: ";
			getline(cin, s_ip);
			if(validateIp(s_ip) == false){
				error(ERR_IP);
			}
			else{
				platform.subscribers[pos].ips.push_back(s_ip);
				// hay que comprobar si hay que actualizar
				// la mainIp,
				update(platform.subscribers[pos], s_ip);
			}		
		}	
	}
}


void deleteSubscriber(Platform &platform) {
	string s_id;
	int id, pos;

	cout << "Enter subscriber id: ";
	getline(cin, s_id);
	if(s_id == ""){
		error(ERR_ID);
	}
	else{
		id = stoi(s_id);
		pos = searchSubscriber(platform.subscribers, id);
		if(pos != -1){
			platform.subscribers.erase(platform.subscribers.begin() + pos);
		}
		else{
			error(ERR_ID);	
		}
	}
}

bool procesarLinea(Subscriber &sub, string linea){
	bool correcto = false;
	stringstream buffy;
	string ip;

	buffy << linea;
	getline(buffy, sub.name, ':');
	if(validateName(sub.name)){
		getline(buffy, sub.email, ':');
		if(validateEmailCool(sub.email)){
			getline(buffy, sub.mainIp, ':');
			if(validateIp(sub.mainIp)){
				correcto = true;
				do{
					getline(buffy, ip, '|');
					correcto = validateIp(ip);
					if(!correcto){
						error(ERR_IP);
					}
					else{
						sub.ips.push_back(ip);
					}			
				}while(!buffy.eof() && correcto);	
			}
			else{
				error(ERR_IP);
			}
		}
		else{
			error(ERR_EMAIL);
		}
	}
	else{
		error(ERR_NAME);
	}

	return correcto;
}

void importFromCsv(Platform &platform) {
	ifstream fich;
	string filename;
	string linea;
	Subscriber nuevo;

	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str());
	if(fich.is_open()){
		getline(fich, linea);
		while(!fich.eof()){
			// saco la informacion de la linea y la meto en el struct
			if(procesarLinea(nuevo, linea) == true){
				nuevo.id = platform.nextId;
				platform.nextId++;
				platform.subscribers.push_back(nuevo);
			}
			getline(fich, linea);		
		}
		fich.close();
	}
	else{
		error(ERR_FILE);
	}	
	
}

/*
ostream &operator<<(ostream &os, const Subscriber &os){
	os << s.name << os << s.email << ":";
	os << s.mainIp << ":";
	for(int i = 0; i < s.ips.size(); i++){
		os << s.ips[i];
		if(i != s.ips.size() - 1){
			os << "|";
		}
	}		
}
*/

void exportSubscriberToCsv(const Subscriber &sub, ofstream &fich){
	fich << s.name << ":";
	fich << s.email << ":";
	fich << s.mainIp << ":";
	for(int i = 0; i < s.ips.size(); i++){
		fich << s.ips[i];
		if(i != s.ips.size() - 1){
			cout << "|";
		}
	}	
}

void exportToCsv(const Platform &platform) {
	string filename;
	ofstream fich;

	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str()); 	// string => char []
	if(fich.is_open()){
		for(int i = 0; i < (int) platform.subscribers.size(); i++){
			exportSubscriberToCsv(platform.subscribers[i], fich); // fich  << platform.subscribers[i] << endl;
		}
		fich.close();
	}
	else{
		error(ERR_FILE);	
	}
}

void loadData(Platform &platform) {
}

void saveData(const Platform &platform) {
}

void showImportExportMenu(){
	cout << "[Import/export options]" << endl
	<< "1- Import from CSV" << endl
	<< "2- Export to CSV" << endl
	<< "3- Load data" << endl
	<< "4- Save data" << endl
	<< "b- Back to main menu" << endl
	<< "Option: ";
}

void importExportMenu(Platform &platform) {
	char option;
	do{
		showImportExportMenu();
		cin >> option;
		cin.get();
		switch(option){
			case '1':
				
			break;
			case '2':
				exportToCsv(platform);
			break;
			case '3':

			break;
			case '4':

			break;
			case 'b':

			break;
			default:
				error(ERR_OPTION);
		}

	}while(option != 'b');
}

int main(int argc, char *argv[]) {
  Platform platform;
  platform.name = "Streamflix";
  platform.nextId = 1;

  char option;
  do {
    showMainMenu();
    cin >> option;
    cin.get();

    switch (option) {
      case '1':
        showSubscribers(platform);
        break;
      case '2':
        addSubscriber(platform);
        break;
      case '3':
        addSubscriberIp(platform);
        break;
      case '4':
        deleteSubscriber(platform);
        break;
      case '5':
        importExportMenu(platform);
        break;
      case 'q':
        break;
      default:
        error(ERR_OPTION);
    }
  } while (option != 'q');

  return 0;
}
