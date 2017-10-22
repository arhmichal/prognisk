#include <stdio.h>

char f(char a, char b, char c);

int main(){
	int a, b;
	char c;
	printf(" Podaj dwie liczby (0-127) i znak : ");
	scanf("%d %d %c", &a, &b, &c);	
	printf(" Wynik : %c \n", f(a, b, c));
	return 0;
}
