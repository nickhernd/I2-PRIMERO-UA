#include<iostream>
#include<string.h>
using namespace std;

//Declaración de constantes
const int kvuelo = 7;
const int kciudad = 25;
const int klista = 50;

//Declaracion de tipos
typedef struct{
	char origen[kciudad];
	char destino[kciudad];
}TDatosViaje;

typedef struct{
	char nombre[klista];
	int edad;
}TPasajero;

typedef TPasajero TListaP[klista];

typedef struct{
	char nVuelo[kvuelo];
	char linea[kciudad];
	TDatosViaje datosViaje;
	TListaP listaPas;
	int totalPas;
}TVuelo;

typedef TVuelo TListaV[50];

//Módulo para dar de alta un vuelo
void altaVuelo(TListaV listaV, int &contV){
  int i;
  char opcion;

  i=0;
  cin.get(); // Limpia el buffer
  cout<<"Indique el número de vuelo (máximo 6 caracteres): ";
  cin.getline(listaV[contV].nVuelo,kvuelo);
  cout<<endl;
  cout<<"Indique la aerolinea a la que pertenece el vuelo: ";
  cin.getline(listaV[contV].linea,kciudad);
  cout<<endl;
  cout<<"Indique los datos del viaje: "<<endl;
  cout<<"		Ciudad de origen: ";
  cin.getline(listaV[contV].datosViaje.origen, kciudad);
  cout<<endl;
  cout<<"		Ciudad de destino: ";
  cin.getline(listaV[contV].datosViaje.destino, kciudad);
  cout<<endl;
  cout<<"Lista de pasajeros: "<<endl;
  do{
	cout<<"¿Desea introducir un pasajero? (s/n) ";
	cin>>opcion;
	switch(opcion){
		case 's': cout<<"Nombre del pasajero: ";
				cin.get();
				cin.getline(listaV[contV].listaPas[i].nombre,klista);
				cout<<endl;
				cout<<"Edad del pasajero: ";
				cin>>listaV[contV].listaPas[i].edad;
				cout<<endl;
				i++;
				break;
		case 'n': break;
	}
  }while(opcion == 's');
listaV[contV].totalPas=i;	
contV++;
}

//Módulo para mostrar la información de un vuelo en concreto
void muestraVuelo(TListaV listaV, int contV){

  char nVuelo[kvuelo];
  int i, j;

  cout<<"Introduce el número de vuelo del vuelo que deseas comprobar: ";
  cin.get();
  cin.getline(nVuelo, kvuelo);

  for(i=0; i<contV; i++){
	 if(strcmp(listaV[i].nVuelo, nVuelo) == 0){
		cout<<"Número de vuelo: "<<listaV[i].nVuelo<<endl;
		cout<<"Aeronlínea: "<<listaV[i].linea<<endl;
		cout<<"Datos del viaje: "<<endl;
		cout<<"		Ciudad de origen: "<<listaV[i].datosViaje.origen<<endl;
		cout<<"		Ciudad de destino: "<<listaV[i].datosViaje.destino<<endl;
		cout<<"Lista de pasajeros: "<<endl;
		for(j=0; j<klista; j++)
			if(listaV[i].listaPas[j].edad != 0)
				cout<<listaV[i].listaPas[j].nombre<<" "<<listaV[i].listaPas[j].edad<<endl;
			
	 }
  }
}

//Módulo para comprobar si hay algun pasajero menor de 10 años
void compruebaNinyo(TListaV listaV, int contV){

  int i, j;

  for(i=0; i<contV; i++){
	cout<<listaV[i].nVuelo<<"  "<<listaV[i].datosViaje.origen<<"-"<<listaV[i].datosViaje.destino<<endl;
	for(j=0; j<listaV[i].totalPas; j++)
		if(listaV[i].listaPas[j].edad < 10)
			cout<<"     "<<listaV[i].listaPas[j].nombre<<" "<<listaV[i].listaPas[j].edad<<endl;
			
  }
}


int main(){

  int opcion, contV;
  TListaV listaV;

  contV = 0;
  do{
		cout<<"******** AEROPUERTO DE ALICANTE ********"<<endl;
		cout<<"Seleccione una opción del menú:"<<endl;
		cout<<"1. Alta de vuelo"<<endl;
		cout<<"2. Listar información de un vuelo"<<endl;
		cout<<"3. Buscar niños"<<endl;
		cout<<"4. Salir"<<endl;
		cout<<endl;
		cin>>opcion;
		cout<<endl;
		switch(opcion){
			case 1: altaVuelo(listaV, contV);
					  break;
			case 2: muestraVuelo(listaV, contV);
					  break;
			case 3: compruebaNinyo(listaV, contV);
					  break;
		};
	}while(opcion != 4);
}