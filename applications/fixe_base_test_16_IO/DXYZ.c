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

int sqrt(int x)
{
	int racine=10000;
	int i,a;
	a=x;
	for(i=0;i<20;i++)
	{
		racine=mult(5000,add(racine,div(a,racine)));
	}
	return racine;
}

int pow(int x,int y)
{

	int puissance = 10000;


	int i;

	for(i = 0 ; i < (y/10000); i++)
		puissance = mult(puissance,x);
	return puissance;

}



Message msg1,msg2,msgIO;

int main()
{
	Echo("start dis_XYZ");
	Echo(itoa(GetTick()));

	int i;
	int distance=0;

    Receive(&msg1,XYZ1);
    Receive(&msg2,XYZ2);

    for (i=0;i<3;i++)
    {
        distance= add(pow(sub(msg1.msg[i],msg2.msg[i]),20000),distance);
    }

   	distance=sqrt(distance);

   	Echo("la distance XYZ est : ");
   	Echo(fixetoa(distance));

	//msgIO.length = 128;
	/* IO_WRITE */
    msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
    msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
    msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
    msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
    for(i=3; i<13; i++)
       msgIO.msg[i] = i-3; // Fill the 10 words of data
	IOSend(&msgIO, IO_PERIPHERAL3);

    Echo(itoa(GetTick()));
    Echo("Communication dis_XYZ finished.");

exit();
}
