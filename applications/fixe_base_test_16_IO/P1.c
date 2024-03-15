#include <api.h>
#include <stdlib.h>


#define FIXE 4 /*nb de chiffres après la virgule*/
#define MAX 1000000000 /*10^PU*/
#define PU 9 /*puissance de 10 max supportée ici 2³¹->2 000 000 000 donc 10⁹*/
#define size 16
#define data 64
#define data_val 640000 /*valeur de data et size avec FIXE chiffres après la virgule*/
#define size_val 160000
#define region 1





int mult(int a, int b)
{
	int i,res;
	int cpt1=0;  /*détermine l'ordre de grandeur en puissance de 10 de a*/
	int cpt2=0;  /*détermine l'ordre de grandeur en puissance de 10 de b*/
	int cpt =2*FIXE; /*compte le nombre de décimales*/
	int a2,b2;

	a2=a;
	b2=b;

	/*détermine l'ordre de grandeur en puissance de 10 de a*/
	while(a2!=0)
	{
		a2=a2/10;
		cpt1++;
	}
	cpt1--;

	/*détermine l'ordre de grandeur en puissance de 10 de b*/
	while(b2!=0)
	{
		b2=b2/10;
		cpt2++;
	}
	cpt2--;

	/*divise a et b en conséquence lorsque ceux-ci sont trop grand*/
	/*on sacrifie en précision pour pouvoir effectuer le calcul*/
	while((cpt1+cpt2)>=PU-1)
	{
		a=a/10;
		cpt1--;
		cpt--;
		if((cpt1+cpt2)>=PU-1)
		{
			b=b/10;
			cpt2--;
			cpt--;
		}
	}

	/*calcul de la multiplication*/
	res=a*b;

	/*retire les derniers chiffres après la virgule pour n'en garder que FIXE*/
	if(cpt>FIXE)
	{
		for(i=0;i<(cpt-FIXE);i++)
		{
			res=res/10;
		}
	}
	else
	{
		while(cpt<FIXE)
		{
			res=res*10;
			cpt++;
		}
	}
	return res;
}

int div(int a, int b)
{
	int i;
	int res=0;
	int entier,nb=1;
	int reste;
	int cpt=0;
	int cpt2=FIXE;
	int cpt3=0;
	int reste2;

	if (b==0)
	{
		return -1;
	}

    /*récupère la partie entière du résultat de la division*/
	entier=a/b;

	/*calcul le résultat entier avec FIXE zéros derrières*/
	for(i=0;i<FIXE;i++)
		{
			entier=entier*10;
		}

	if(a!=b)
	{
		reste=sub(a,mult(entier,b));
	}
	else
	{return entier;}

	if(reste==0)
	{return entier;}

	for(i=0;i<FIXE;i++)
	{
		nb=nb*10;
	}
	reste2=reste;
	while(reste2!=0)
	{
		reste2=reste2/10;
		cpt++;
	}
	cpt--;
		/*calcul nb*a jusqu'à ce qu'on ait un res>(1000*entier) on a alors les quatre décimales*/
		/*while((res<val)&&((reste*nb)<MAX))
		{
			nb=nb*10;
			res=reste*nb/b;
		} */
	while((cpt+cpt2)>=PU)
	{
		nb=nb/10;
		cpt2--;
		cpt3++;
		if((cpt+cpt2)>=PU)
		{
			reste=reste/10;
			cpt--;
			cpt3++;
		}
	}
	res=nb*reste/b;
	for(i=0;i<cpt3;i++)
	{
		res=res*10;
	}
	/*res=normalise(res);*/
	res=add(res,entier);
	return res;
}

int sommeXYZ(int* moyenne,int* tabref)
{
        int i;
        int sum=0;
        for(i=0;i<size;i++)
        {
               sum=add(mult(tabref[i],moyenne[i]),sum);

        }
        return sum;
}


Message msg1,msg2,msgIO;

/*int tabdata[data]={490000,490000,489990,489990,489980,489980,489970,489970,
					489960,489960,489950,489950,489940,489940,489930,489930};*/

int tabdata[data]={490000,490000,489990,489990,489980,489980,489970,489970,
					489960,489960,489950,489950,489940,489940,489930,489930,
					489920,489920,489910,489910,489900,489900,489890,489890,
					489880,489880,489870,489870,489860,489860,489850,489850,
					489840,489840,489830,489830,489820,489820,489810,489810,
					489800,489800,489790,489790,489790,489780,489780,489770,
					489770,489760,489760,489750,489750,489740,489740,489730,
					489730,489720,489720,489710,489710,489700,489700,489690};


int tabrefX[size]={1,2,2,3,5,6,8,11,14,18,23,29,37,47,58,72};
int tabrefY[size]={0,0,0,0,0,0,0,1,1,2,3,3,4,5,6,8};
int tabrefZ[size]={7,9,12,17,22,29,38,50,64,82,105,133,167,210,261,323};

void calcul_moyenne(int* moyenne)
 {
	 int m,j,sum;
     for(m=0;m<size;m++)
     {
          sum=0;
          for(j=0;j<data;j++)
		  {
		     	sum=add(sum,tabdata[j]);
		  }
          moyenne[m]=div(sum,data_val);
	    }
}


int main()
{
	Echo("start Processeur 1");
	Echo(itoa(GetTick()));

    int moyenne[size],i,j;

	//msgIO.length = 16;
	/* IO_READ */
    msgIO.length = 3;      // Message size = 3 words (IO Header)
    msgIO.msg[0] = 0x1010; // OpCode = 0x1010 (IO_READ)
    msgIO.msg[1] = 0xc4ff; // Address = 0xc4ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
	IOReceive(&msgIO, IO_PERIPHERAL);

	calcul_moyenne(moyenne);

	msg1.length=size;
	for(i=0;i<size;i++)
		 msg1.msg[i]=moyenne[i];

	Echo("Valeur de la moyenne :");
	Echo(fixetoa(moyenne[0]));

	Send(&msg1,RMS);
	Send(&msg1,WRMS);
	Send(&msg1,GFC);
	Send(&msg1,XYZ1);

    Echo(itoa(GetTick()));
	Echo("Communication Processeur 1 finished.");

exit();
}
