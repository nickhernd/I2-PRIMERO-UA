#include<iostream>
#include<cstring>
#include<vector>
#include<fstream>
using namespace std;

struct Student{
	string name;
	int age;
};

struct StudentBin{
	char name[100];
	int age;
};

void show(vector<Student> alus){
	for(Student alu : alus){
		cout << alu.name << ":" << alu.age << endl; 
	}
}

// para el load:  fich => SudentBin => Student => vector<Student>
void bin2txt(StudentBin sb, Student &s){
	s.name = sb.name;
	s.age = sb.age;
}

// para el save: vector<Student> => StudentBin => fich
void txt2bin(Student s, StudentBin &sb){
	strncpy(sb.name, s.name.c_str(), 100);
	sb.age = s.age;
}

void loadData(vector<Student> &alus){
	ifstream fich;
	string filename;
	StudentBin sb;
	Student s;

	cout << "Enter filename: ";
	getline(cin, filename);
	fich.open(filename.c_str());
	if(fich.is_open()){
		fich.read((char *) &sb, sizeof(sb));
		while(!fich.eof()){
			bin2txt(sb, s); // sb => s			
			alus.push_back(s);
			fich.read((char *) &sb, sizeof(sb));		
		}
		fich.close();
	}

}

void saveData(vector<Student> alus){
	ofstream fich;
	char filename[100];
	StudentBin sbin;

	cout << "Enter filename: ";
	cin.getline(filename, 100);
	fich.open(filename, ios::binary);
	if(fich.is_open()){
		for(Student student : alus){
			txt2bin(student, sbin);			
			fich.write((const char *) &sbin, sizeof(sbin));
		}
		fich.close();
	}	
}

void exportToTxt(vector<Student> alus){
	char filename[100];
	ofstream fich;
	cout << "Enter filename: ";
	cin.getline(filename, 100);
	fich.open(filename);
	if(fich.is_open()){
		for(Student alu : alus){
			fich << alu.name << ":" << alu.age << endl;
		}
		fich.close();
	}
}

// name:age
// name:age
void importFromTxt(vector<Student> &alus){
	char filename[100];
	ifstream fich;
	Student leido;
	cout << "Enter filename: ";
	cin.getline(filename, 100);
	fich.open(filename);
	if(fich.is_open()){
		getline(fich, leido.name, ':');
		while(!fich.eof()){
			fich >> leido.age;
			fich.get(); // se salta el \n
			alus.push_back(leido);
			getline(fich, leido.name, ':');
		}	
		fich.close();
	}
}


int main(){
	vector<Student> alus = {{"jose", -1}, {"juan", 53}, {"seba", 32}};
	char option;
	do{
		cout << "1. Import from txt file" << endl;
		cout << "2. Export to txt file" << endl;
		cout << "3. Load from bin file" << endl;
		cout << "4. Save to bin file" << endl;
		cout << "5. Show on screen" << endl;
		cout << "Option: ";
		cin >> option;
		cin.get();
		switch(option){
			case '1':
				importFromTxt(alus);
			break;
			case '2':
				exportToTxt(alus);
			break;
			case '3':
			break;
			case '4':
				saveData(alus);
			break;
			case '5':
				show(alus);
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
