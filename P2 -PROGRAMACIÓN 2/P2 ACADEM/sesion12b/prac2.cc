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
	cout << s.id << ":" << s.name << ":" << s.email << ":" << s.mainIp << ":";
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

bool testParte(string parte){
	bool valid;
	int tam, i;
	valid = false;
	tam = parte.length();
	if(tam > 0 && parte[0] != '.' && parte[tam-1] != '.'){
		valid = true;
		for(i = 0; i < tam && valid == true; i++){
			if(parte[i] != '_' && parte[i] != '.' && isalnum(parte[i]) == 0){
				valid = false;
			}
		}
	}
	return valid;
}

bool testEmail(string email){
	bool valid;
	int posArroba;
	string izquierda, derecha;		
	
	valid = false;	
	posArroba = email.find('@');
	if(posArroba != string::npos){
		izquierda = email.substr(0, posArroba);
		derecha = email.substr(posArroba + 1);
		if(testParte(izquierda) == true){
			if(testParte(derecha) == true){
				if(derecha.find('.') != string::npos){
					valid = true;
				}
			}
		}
	}
	return valid;
}


bool testName(string name){
	bool valid = false;
	if(name.length() >= 3 && name.find(':') == string::npos){
		valid = true;
	}	
	/*if(name.length() < 3 || name.find(':') != string::npos){
		valid = false;
	}
	else{
		valid  = true;
	}*/
	return valid;
}


void askName(string &name){
	bool okname;	
	do{
		cout << "Enter name: ";
		getline(cin, name);
		okname = testName(name); 		
		if(!okname){
			error(ERR_NAME);		
		}
	}while(!okname);
}

void askEmail(string &email){
	bool okemail;
	do{
		cout << "Enter email: ";
		getline(cin, email);
		okemail = testEmail(email);
		if(okemail == false){ // if(!okemail){
			error(ERR_EMAIL);
		}
	}while(okemail == false);
}

void addSubscriber(Platform &platform) {
	Subscriber nuevo;
	bool okname, okemail;

	nuevo.id = platform.nextId;
	platform.nextId++;
	askName(nuevo.name);
	askEmail(nuevo.email);
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

// s_ip es la ip que acabo de añadir
// s.main_ip es la que mas se repite actualmente
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
		if(numero[i] < '0' || numero[i] > '9'){
			todo = false;
		}
	}	
	return todo;
}

/*
bool validateIp(string ip){
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


//                iiiii
// ip = "123.2342.1234.44"
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
	bool ok_ip;

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
			// donde esta el subscriber al cual le tiengo que añadir la nueva ip?? pos
			do{
				cout << "Enter IP: ";
				getline(cin, s_ip);
				ok_ip = validateIp(s_ip); 		
				if(ok_ip == false){
					error(ERR_IP);
				}
			}while(ok_ip == false);
			platform.subscribers[pos].ips.push_back(s_ip);
			update(platform.subscribers[pos], s_ip);		
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

bool procesarLinea(string linea, Subscriber &sus){
	bool ok = false;
	string ip_aux;
	stringstream buffy;

	buffy << linea;
	getline(buffy, sus.name, ':');
	getline(buffy, sus.email, ':');
	getline(buffy, sus.mainIp, ':');
	do{
		getline(buffy, ip_aux, '|');
		sus.ips.push_back(ip_aux);
	}while(buffy.eof() == false);
	ok = true;

	return ok;
}

void importFromCsv(Platform &platform) {
	ifstream fich;
	string linea, filename;
	Subscriber sub;
	
	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str());
	if(fich.is_open()){
		getline(fich, linea);
		while(fich.eof() == false){
			// relleno sub con los datos de la linea		
			valid = procesarLinea(linea, sub);
			// si la informacion estaba ok
			if(valid == true){
				// le asigno un id
				sub.id = platform.nextId;
				platform.nextId++;
				// lo guardo en el vector
				platform.push_back(sub);
			}
		}
	}
	else{
		error(ERR_FILE);
	}
}


void showSubscriber(const Subscriber &s, ofstream &fich){
	fich << s.name << ":" << s.email << ":" << s.mainIp << ":";
	for(int i = 0; i < s.ips.size(); i++){
		fich << s.ips[i];
		if(i != s.ips.size() - 1){
			fich << "|";
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
		for(int i = 0; i < platform.subscribers.size(); i++){
			showSubscriber(platform.subscribers[i], fich);
			fich << endl;
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
			case '1': break;
			case '2': 
				exportToCsv(platform);
			break;
			case '3': break;
			case '4': break;
			case 'b': break;
			default:
				error(ERR_OPTION);
				break;
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
