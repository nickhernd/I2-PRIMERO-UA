#include <sstream>
#include <iostream>
#include <vector>
#include <algorithm>
#include <fstream>
#include <cstring>

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


char preguntar(){
	char r;
	do{
		cout << "All data will be erased. Continue? [y/n]: ";
		cin >> r;
		cin.get();
	}while(r != 'y' && r != 'Y' && r != 'n' && r !='N');
	return r;
}

BinPlatform getBinPlatform(const Platform &platform){
	BinPlatform bff;

	bff.nextId = platform.nextId;
	strncpy(bff.name, platform.name.c_str(), KMAXSTRING);
	bff.name[KMAXSTRING - 1] = '\0';

	return bff;
}

BinSubscriber getBinSubscriber(const Subscriber &s){
	BinSubscriber bs;	

	bs.id = s.id;
	strncpy(bs.name, s.name.c_str(), KMAXSTRING);
	bs.name[KMAXSTRING - 1] = '\0';
	strncpy(bs.email, s.email.c_str(), KMAXSTRING);
	bs.email[KMAXSTRING - 1] = '\0';
	strncpy(bs.mainIp, s.mainIp.c_str(), KMAXIP);
	bs.mainIp[KMAXIP - 1] = '\0';

	return bs;	
}

void saveData(const Platform &platform){
	ofstream fich;
	string filename;
	BinSubscriber bs;	
	BinPlatform bff;
	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str(), ios::binary);
	if(fich.is_open()){
		bff = getBinPlatform(platform);
		fich.write((const char *) &bff, sizeof(bff));
		for(Subscriber s : platform.subscribers){
			bs = getBinSubscriber(s);
			fich.write((const char *) &bs, sizeof(bs));	
		}
		fich.close();
	}
	else{
		error(ERR_FILE);
	}
}

Platform getPlatform(const BinPlatform &bff){
	Platform platform;

	platform.name = bff.name;
	platform.nextId = bff.nextId;

	return platform;
}

Subscriber getSubscriber(const BinSubscriber &bs){
	Subscriber s;
	s.id = bs.id;
	s.name = bs.name;
	s.email = bs.email;
	s.mainIp = bs.mainIp;
	if(s.mainIp != ""){
		s.ips.push_back(s.mainIp);
	}
	return s;
}

void loadData(Platform &platform, string filename){
	ifstream fich;
	Subscriber s;
	BinSubscriber bs;
	BinPlatform bff;
	char continuar;
	
	if(filename == ""){
		continuar = preguntar();
	}
	else{
		continuar = 'y';
	}
	if(continuar == 'y' || continuar == 'Y'){	
		if(filename == ""){		
			cout << "Enter filename: ";
			getline(cin, filename);
		}
		fich.open(filename.c_str(), ios::binary);
		if(fich.is_open()){
			platform.subscribers.clear();
			fich.read((char *) &bff, sizeof(bff));
			platform = getPlatform(bff);
			fich.read((char *) &bs, sizeof(bs));
			while(!fich.eof()){		
				// BinSubscriber => subscriber.
				s = getSubscriber(bs);
				platform.subscribers.push_back(s);
				fich.read((char *) &bs, sizeof(bs));
			}		
			fich.close();
		}
		else{
			error(ERR_FILE);		
		}
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
	cout << s.id << ":" << s.name << ":";
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
		showSubscriber(platform.subscribers[i]); // cout << platform.subscribers[i].name << ":";
		cout << endl;
	}
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
	bool valid = false;
	int pos;
	string izquierda, derecha;
	pos = email.find('@');
	if(pos != string::npos){
		izquierda = email.substr(0, pos); // desde 0 pos caracteres
		derecha = email.substr(pos + 1); // desde pos + 1 hasta el final
		if(validate(izquierda) && validate(derecha) && derecha.find('@') == string::npos && derecha.find('.') != string::npos){
			valid = true;
		}		
	}
	return valid;
}


void addSubscriber(Platform &platform) {
	Subscriber nuevo;

	do{
		cout << "Enter name: ";
		getline(cin, nuevo.name);
		if(validateName(nuevo.name) == false){
			error(ERR_NAME);
		}
	}while(validateName(nuevo.name) == false);

	do{
		cout << "Enter email: ";
		getline(cin, nuevo.email);
		if(validateEmailCool(nuevo.email) == false){
			error(ERR_EMAIL);
		}
	}while(validateEmailCool(nuevo.email) == false);

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


bool todoDigitos(string numero){
	bool todo = true;
	
	for(int i = 0; i < numero.length() && todo; i++){
		if(numero[i] < '0' || numero[i] > '9'){
			todo = false;
		}
	}	
	return todo;
}


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


void update(Subscriber &s){
	// contamos la cantidad de veces que se repite en el vector de ip s_ip
	// contamos la cantidad de veces que se repite en el vector de ip main_Ip
	// si es mayor s_ip que la mainIp actualizo....
	int cuantas1, cuantas2;
	string s_ip = s.ips[s.ips.size() - 1]; // la ultima que he añadido

	cuantas1 = 0;
	cuantas2 = 0;
	for(int i = 0; i < s.ips.size(); i++){
		if(s_ip == s.ips[i]){		// cuento las veces que aparece la nueva, ultima anydadida.
			cuantas1++;
		}
		if(s.mainIp == s.ips[i]){	// cuento las veces que aparece la mainIp
			cuantas2++;
		}
	}
	if(cuantas1 > cuantas2){
		s.mainIp = s_ip;
	}
}

void update2(Subscriber &s){
	int cuantas1, cuantas2;
 	string s_ip = s.ips[s.ips.size() - 1];
	cuantas1 = count(s.ips.begin(), s.ips.end(), s_ip);
	cuantas2 = count(s.ips.begin(), s.ips.end(), s.mainIp);
	if(cuantas1 > cuantas2){
		s.mainIp = s_ip;
	}
}

void addSubscriberIp(Platform &platform) {
	string s_ip, s_id;
	int id, pos;
	bool ip_ok;

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
			do{
				cout << "Enter IP: ";
				getline(cin, s_ip);
				ip_ok = validateIp(s_ip);				
				if(!ip_ok){
					error(ERR_IP);
				}
			}while(!ip_ok);
			platform.subscribers[pos].ips.push_back(s_ip);
			update(platform.subscribers[pos]);
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

bool validateSubscriber(Subscriber sub){
	bool valid = false;
	if(!validateName(sub.name)){
		error(ERR_NAME);
	}
	else{
		if(!validateEmailCool(sub.email)){
			error(ERR_EMAIL);
		}
		else{
			if(sub.mainIp != "" && !validateIp(sub.mainIp)){
				error(ERR_IP);
			}
			else{
				// queda comprobar las ips del vector de ips.
				valid = true; // supongo que es valida y si encuentro
				// alguna no valida para el bucle.	
				for(int i = 0; i < sub.ips.size() && valid; i++){
					valid = validateIp(sub.ips[i]);
				}
				if(!valid){
					error(ERR_IP);
				}	
			}
		}
	}
	return valid;
}


void procesarLinea(Platform &platform, string linea){
	Subscriber sub;
	stringstream buffy(linea);	// meto la linea en el buffer.
	string aux;

	getline(buffy, sub.name, ':');
	getline(buffy, sub.email, ':');
	getline(buffy, sub.mainIp, ':');
	do{
		aux = "";
		getline(buffy, aux, '|');
		if(aux != ""){
			sub.ips.push_back(aux);
		}
	}while(buffy.eof() == false);
	if(validateSubscriber(sub)){
		sub.id = platform.nextId;
		platform.nextId++;
		platform.subscribers.push_back(sub);
	}
}

void importFromCsv(Platform &platform, string filename) {
	string linea;
	ifstream fich;
	
	if(filename == ""){
		cout << "Enter filename: ";
		getline(cin, filename);
	}
	fich.open(filename.c_str());
	if(fich.is_open()){
		getline(fich, linea);
		while(fich.eof() == false){
			// hacemos cosas nazis con la linea que hemos leido.			
			procesarLinea(platform, linea);		
			getline(fich, linea);
		}
	}
	else{
		error(ERR_FILE);
	}
	
	
}

#include <fstream>

void exportToCsv(const Platform &platform) {
	string filename;
	ofstream fich;

	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str()); 	// string => char []
	if(fich.is_open()){
		for(int i = 0; i < platform.subscribers.size(); i++){
			fich	<< platform.subscribers[i].name << ":"
					<< platform.subscribers[i].email << ":"
					<< platform.subscribers[i].mainIp << ":";
					for(int j = 0; j < platform.subscribers[i].ips.size(); j++){
						fich << platform.subscribers[i].ips[j];
						if(j != platform.subscribers[i].ips.size() - 1){
							fich << "|";
						}
					}
			fich << endl;
		}
		fich.close();
	}
	else{
		error(ERR_FILE);	
	}
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
				importFromCsv(platform, "");
			break;
			case '2':
				exportToCsv(platform);
			break;
			case '3':
				loadData(platform, "");
			break;
			case '4':
				saveData(platform);
			break;
			case 'b':
			break;
			default:
				error(ERR_OPTION);
			break;
		}
	}while(option != 'b');
}


bool procesarArgumentos(int argc, char *argv[], Platform &platform){
	bool correctos = false;
	
	switch(argc){
		case 1:
			correctos = true;
			break;
		case 3:
			if(strcmp(argv[1], "-i") == 0){
				correctos = true;				
				// argv[2] => nombre texto	
				importFromCsv(platform, argv[2]);	
			}
			if(strcmp(argv[1], "-l") == 0){
				correctos = true;
				// argv[2] => nombre binario
				loadData(platform, argv[2]);
			}
			break;
		case 5:
			if(strcmp(argv[1], "-i") == 0 && strcmp(argv[3], "-l") == 0){
				loadData(platform, argv[4]);
				importFromCsv(platform, argv[2]);
			}
			if(strcmp(argv[1], "-l") == 0 && strcmp(argv[3], "-i") == 0){
				loadData(platform, argv[2]);
				importFromCsv(platform, argv[4]);
			}
			break;
	 	default:
			error(ERR_ARGS);
			break;
	}

	return correctos;
}

int main(int argc, char *argv[]) {
  Platform platform;
  platform.name = "Streamflix";
  platform.nextId = 1;
  bool okArgs;
  char option;

  okArgs = procesarArgumentos(argc, argv, platform);
  if(okArgs){
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
  }
  return 0;
}
