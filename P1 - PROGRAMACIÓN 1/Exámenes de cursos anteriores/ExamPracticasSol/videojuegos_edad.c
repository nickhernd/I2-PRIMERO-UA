#include <iostream>
#include <cstring>
using namespace std;

const int kTAMTIT = 25;
const int kNUMOPI = 10;
const int kNUMJUEGOS = 150;
const int OPCION_SALIR = 4;

// Estructura Fecha de lanzamiento
typedef struct {
	int mes, anyo;
} TFechaLanzamiento;

// Estructura Ficha Videojuego
typedef struct {
    char titulo[kTAMTIT];
    char genero; // A=acción; C=carreras; D=deportes
	TFechaLanzamiento fecha_lanzamiento;
    int num_opiniones;
    int opiniones[kNUMOPI]; // Cada opinion tiene un valor entre 0 y 10
    int clasificacion; 
   // 0:pendiente de clasificar; 3:3 o más; 12:12 o más; 18:mayores de 18; 
} TFichaVideojuego;

// Declaración del tipo TVideojuegos como array de TFichaVideojuego
typedef TFichaVideojuego TVideojuegos[kNUMJUEGOS];

// Cabecera de las funciones
int menu();
void introducirVideojuego(TVideojuegos, int &);
void establecerClasificacion(TVideojuegos, int, char []);
void listarClasificados(TVideojuegos, int);

// Programa principal
main() {
    TVideojuegos videojuegos;
    int numVideojuegos=0, opcion;
    char titulo[kTAMTIT];
    
    do {
        opcion = menu();
        switch(opcion) {
            case 1: introducirVideojuego(videojuegos, numVideojuegos);
                    break;
            case 2: if (numVideojuegos>0)
	                { 
					    cout << "\n***** CLASIFICAR UN VIDEOJUEGO POR EDAD *****" << endl;
		                cout << "Introduce el título del videojuego a clasificar: ";
                        cin.getline(titulo, kTAMTIT);
                        establecerClasificacion(videojuegos, numVideojuegos, titulo);
		            }
		            else cout << "\n* ERROR: Todavía NO se ha introducido ningún videojuego\n"; 
                    break;
            case 3: if (numVideojuegos>0)
	               listarClasificados(videojuegos, numVideojuegos);
		    else cout << "\n* ERROR: Todavía NO se ha introducido ningún videojuego\n";
                    break;
            case 4: break;
        }
    } while (opcion!=OPCION_SALIR);
    cout << endl << "FIN DEL PROGRAMA" << endl << endl;
}

// Función para mostrar el menu de opciones en pantalla
int menu()
{
    int elec;
    do {
           cout << "\n********** TIENDAS FRIQUIGAMES **********\n";
           cout << "Seleccione una opción del menú:\n";
           cout << "1.- Introducir un nuevo videojuego\n";
           cout << "2.- Clasificar un videojuego por edad\n";
           cout << "3.- Listar los videojuegos ya clasificados\n";
           cout << "4.- Salir\n";
           cout << "Opción: ";
           cin >> elec;
		   cin.get();
    } while ((elec<1) || (elec>4));

   return(elec);
}

// Módulo para introducir los datos de un nuevo videojuego
void introducirVideojuego(TVideojuegos videojuegos, int &numVideojuegos)
{
    TFichaVideojuego fichaVideojuego;
    int i;
   
    cout << "\n***** ALTA DE VIDEOJUEGO *****" << endl;
    cout << "Título: ";
    cin.getline(fichaVideojuego.titulo, kTAMTIT);
    do {
           cout << "Género (A/C/D): ";
           cin >> fichaVideojuego.genero;
    } while ((fichaVideojuego.genero!='A') && (fichaVideojuego.genero!='C') && (fichaVideojuego.genero!='D'));
	cout << "Fecha de lanzamiento (MM AAAA): ";
    cin >> fichaVideojuego.fecha_lanzamiento.mes >> fichaVideojuego.fecha_lanzamiento.anyo;
    do {
           cout << "Número de opiniones de revistas a introducir (1..10): ";
           cin >> fichaVideojuego.num_opiniones;
	} while ((fichaVideojuego.num_opiniones<1) || (fichaVideojuego.num_opiniones>10));
    for (i=0; i<fichaVideojuego.num_opiniones; i++)
        do {
              cout << "Opinión " << i+1 << " (3,12,18): ";
              cin >> fichaVideojuego.opiniones[i];
        } while ((fichaVideojuego.opiniones[i]!=3) && (fichaVideojuego.opiniones[i]!=12) && (fichaVideojuego.opiniones[i]!=18));
    fichaVideojuego.clasificacion=0; // se inicializa a 0
       
    videojuegos[numVideojuegos]=fichaVideojuego;
    numVideojuegos+=1;
    cout << "\nALTA DE VIDEOJUEGO CORRECTA" << endl;
}

void establecerClasificacion(TVideojuegos videojuegos, int numVideojuegos, char titulo[kTAMTIT])
{
   int i, j, pos, numero_opiniones, suma=0;
   bool encontrado=false;
   float media;
   
   for (i=0; ((i<numVideojuegos) && (!encontrado)); i++)
   {
       if (strcmp(titulo,videojuegos[i].titulo)==0) 
       {
           pos=i;
           encontrado=true;
       }
   }
   if (encontrado)
   {
       numero_opiniones=videojuegos[pos].num_opiniones;
       for (j=0; j<numero_opiniones; j++)
           suma= suma + videojuegos[pos].opiniones[j];
       media = suma/numero_opiniones;
       if (media<12) videojuegos[pos].clasificacion=3;
       else if (media<18) videojuegos[pos].clasificacion=12;
            else videojuegos[pos].clasificacion=18;
       cout << "\n* El videojuego " << titulo << " obtiene una clasificación de ";
       cout << videojuegos[pos].clasificacion << endl << endl;
	   cout << "CLASIFICACIÓN DE VIDEOJUEGO CORRECTA" << endl; 
   }
   else cout << "\n* ERROR: El videojuego " << titulo << " NO se ha introducido todavía" << endl;
}

void listarClasificados(TVideojuegos videojuegos, int numVideojuegos)
{
   int i, j, vez=1;
   
   cout << endl;
   for (i=0; i<numVideojuegos; i++)
   {
       if (videojuegos[i].clasificacion!=0)
       {
		   if (vez==1)
		   {
			   cout << "***** VIDEOJUEGOS YA CLASIFICADOS POR EDAD *****" << endl;
			   vez=0;
		   }
	       cout << "Título: " << videojuegos[i].titulo << endl;
		   cout << "Fecha de lanzamiento: " << videojuegos[i].fecha_lanzamiento.mes << "/";
		   cout << videojuegos[i].fecha_lanzamiento.anyo << endl;
		   cout << "Clasificación: ";
           switch(videojuegos[i].clasificacion)
	       {
	           case  3: cout << "Mayores de 3 años";
					    break;
	           case 12: cout << "Mayores de 12 años";
						break;
	           case 18: cout << "Mayores de 18 años";
						break;
	       }
	       cout << endl;
	       cout << "*****" << endl;
       }
    }
	if (vez==1) cout << "* AVISO: Todavía NO se ha clasificado ningún videojuego" << endl;
}
