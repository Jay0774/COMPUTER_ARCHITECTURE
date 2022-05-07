#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

/* The naive transpose function as a reference. */
void transpose_naive(long long int n,long long int blocksize,long long int *dst,long long int *src) {
    printf("Running Naive Transpose\n");
    for (long long int x = 0; x < n; x++) {
        for (long long int y = 0; y < n; y++) {
            dst[y + x * n] = src[x + y * n];
        }
    }
    printf("Naive Transpose Complete\n");
}

/* Implement cache blocking below. You should NOT assume that n is a multiple of the block size. */
void transpose_blocking(long long int n,long long int blocksize,long long int *dst,long long int *src) {
    printf("Running Blocking Transpose\n");
    long long int x,y,i,j;
    //dividing the array into blocksize*blocksize and transposing each block at a time
    //this is because for each block the elements are alredy in cache.
    for(x=0;x<n;x+=blocksize)
    {
        for(y=0;y<n;y+=blocksize)
        {
            // for each block containing blocksize * blocksize elements
            // transpose the elements of the matrix and store them in destination
            for(i=x;i<x+blocksize;i++)
            {
                for(j=y;j<y+blocksize;j++)
                {
                    dst[i+j*n]=src[j+i*n];
                }
            }
        }
    }
    printf("Blocking Transpose Complete\n");
}

//function for printing the matrix
void print(long long int n,long long int *src)
{
    long long int i,j;
    for(i=0;i<n;i++)
    {
        for(j=0;j<n;j++)
        {
            printf("%lld ",src[i+j*n]);
        }
        printf("\n");
    }
}

int main(int argc,char *argv[])
{
    long long int n,blocksize,i,j;
    struct timeval start1,stop1,start2,stop2;
    // if user input need to be added interactively
    /*
    printf("Enter n:\n");
    scanf("%d",&n);
    printf("Enter blocksize:\n");
    scanf("%d",&blocksize);
    */
    // using arguments provided by user for input
    if(argc==3)
    {
        //converting the character output to integer using atoi function
        // argv[1] contain the value of n 
        // argv[2] contain the value of blocksize
        n = atoi(argv[1]);
        blocksize = atoi(argv[2]);
    }
    //printf("%d,%d\n",n,blocksize);
    //creating matrices using malloc since size is larger malloc is useful 
    // a => original matrice
    // b => matrice after naive transpose
    // c => matrice after blocking transpose
    long long int *a,*b,*c;
    a = (long long int*)malloc(n*n*sizeof(long long int));
    b = (long long int*)malloc(n*n*sizeof(long long int));
    c = (long long int*)malloc(n*n*sizeof(long long int));
    // inserting random elements in a matrice 
    for(i=0;i<n*n;i++)
    {
        a[i]=rand()%n+1;
    }
    //printf("Matrix is:\n");
    //print(n,a);
    //storing time required for execution using timeval struct and gettimeofday function
    gettimeofday(&start1,NULL);
    transpose_naive(n,blocksize,b,a);
    gettimeofday(&stop1,NULL);
    printf("-------------------------------------------------------------\n");
    //printf("Matrix after Naive transpose is:\n");
    //print(n,b);
    gettimeofday(&start2,NULL);
    transpose_blocking(n,blocksize,c,a);
    gettimeofday(&stop2,NULL);
    printf("-------------------------------------------------------------\n");
    //printf("Matrix after Modified transpose is:\n");
    //print(n,c);
    //calculating the time required for execution
    double t1 = (stop1.tv_sec-start1.tv_sec) + (stop1.tv_usec-start1.tv_usec)*1e-06;
    double t2 = (stop2.tv_sec-start2.tv_sec) + (stop2.tv_usec-start2.tv_usec)*1e-06;
    printf("For n = %lld\n",n);
    printf("Time elapsed for Naive Computation:\n%lf milliseconds\n",t1*1000);
    printf("Time elapsed for Modified Computation:\n%lf milliseconds\n",t2*1000);
    return 0;
}
