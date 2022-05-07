#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#define N 1000
#define get(i,j) (i*N+j)
void print(double *x)
{
	int i,j;
	for(i=0;i<N;i++){
		for(j=0;j<N;j++){
			printf("%lf",x[i]);}
		printf("\n");}
	printf("\n");
}
void MatrixMultiply(double *a,double *b,double *c)
{
	int i,j,k;
	for(i=0;i<N;i++)
	{
		for(j=0;j<N;j++)
		{
			for(k=0;k<N;k++)
			{
				c[get(i,j)]+=a[get(i,k)]*b[get(k,j)];
			}
		}
	}
	/*
	printf("Mtrix A:\n");
	print(a);
	printf("Mtrix B:\n");
	print(b);
	printf("Mtrix C:\n");
	print(c);
	*/
}
int main()
{
	int i;
	double *a,*b,*c,time;
	struct timeval start,stop;
	a = (double*)malloc(N*N*sizeof(double));
	b = (double*)malloc(N*N*sizeof(double));
	c = (double*)malloc(N*N*sizeof(double));
	for(i=0;i<N*N;i++)
	{
		a[i]=drand48()*2-1;
		b[i]=drand48()*2-1;
		c[i]=0;
	}
	gettimeofday(&start,NULL);
	MatrixMultiply(a,b,c);
	gettimeofday(&stop,NULL);
	time = (stop.tv_sec-start.tv_sec) + (stop.tv_usec-start.tv_usec)*1e-06;
	printf("For N = %d\n",N);
	printf("Time elapsed for Computation:\n%lf milliseconds\n",time*1000);
	printf("GFLOPS is \n %lf \n",(N*N*N)/time*2e-9);
	return 0;
}
