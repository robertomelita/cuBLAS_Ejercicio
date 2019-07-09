#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include "cublas_v2.h"

#define IDX2C(i,j,ld) (((j)*(ld))+(i)) 

#define m 6 // a - mxk matrix
#define n 4 // b - kxn matrix
#define k 5 // c - mxn matrix

__host__ void printMatrix(float *c, int m_, int n_);
__host__ void initMatrix(float *c, int m_, int n_, int ind);

int main(void){
    cudaError_t cudaStat ; // cudaMalloc status
    cublasStatus_t stat ; // CUBLAS functions status
    cublasHandle_t handle ; // CUBLAS context

    float *a; // m x k matrix a on the host
    float *b; // k x n matrix b on the host
    float *c; // m x n matrix c on the host

    float al =  1.0f; // alpha
    float bet = 0.0f; // beta

    a =(float*)malloc(m*k*sizeof(float)); // host memory for a
    b =(float*)malloc(k*n*sizeof(float)); // host memory for b
    c =(float*)malloc(m*n*sizeof(float)); // host memory for c

    // define an mxk matrix a
    initMatrix(a,m,k,11);
    printMatrix(a,m,k);

    // define a kxn matrix b 
    initMatrix(b,k,n,11);
    printMatrix(b,k,n);

    // define an mxn matrix c 
    initMatrix(c,m,n,11);    
    printMatrix(c,m,n);



    

    // 1) Crear Matrices en GPU y reservarles memoria
    //


    // 2) Inicializar cuBLAS
    //


    // 3) Copiar matrices desde host a device (RAM -> VRAM)
    //


    // 4) Realizar la multiplicacion de matrices
    //
    // AYUDA:
    /*

    cublasStatus_t cublasSgemm(cublasHandle_t handle,
                            cublasOperation_t transa, 
                            cublasOperation_t transb,
                            int m, 
                            int n, 
                            int k,
                            const float *alpha,
                            const float *A, int lda,
                            const float *B, int ldb,
                            const float *beta,
                            float *C, int ldc)
    */

    // 5) Copiar matriz resultado desde device a host (VRAM -> RAM)
    //

    // 6) Destruir CUBLAS context
    //





    // print result
    printf("Result:\n");
    printMatrix(c,m,n);

    free(a); // free host memory
    free(b); // free host memory
    free(c); // free host memory
    
    return EXIT_SUCCESS;
}


__host__ void printMatrix(float *c, int m_, int n_){
    for(int i = 0; i < m_; i++){
        for(int j = 0;j < n_; j++){
            printf(" %7.0f",c[IDX2C(i,j,m_)]); // print c after Sgemm
        }
        printf("\n");
    }
    printf("\n");
}
__host__ void initMatrix(float *c, int m_, int n_, int ind){
    for(int i = 0; i < m_; i++){    
        for(int j = 0; j < n_; j++){ 
            c[IDX2C(i,j,m_)] =(float)ind++;
        }    
    }
}

