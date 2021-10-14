#include <stdio.h>
int array1[3][5]; // 2D array
int array2[3][5][7];  // 3D array
int sizeX = 3;
int sizeY = 5;
int sizeZ = 7;



int main(){
    int x = 1;
    printf("2d array as a block \n");
    for (int i = 0;i < sizeX; i++  ){
        for(int j = 0; j < sizeY; j++){
            if(x < 10){
                printf("%d |", x);
            }else{
                printf("%d|", x);
            }
            
            x++;
        }
        printf("\n");
    }

    printf("2d array as one line \n");
    x = 1;
    for (int i = 0;i < sizeX; i++  ){
        for(int j = 0; j < sizeY; j++){
            if(x < 10){
                printf("%d |", x);
            }else{
                printf("%d|", x);
            }
            
            x++;
        }
        
    }
    printf("\n");
    x = 1;
    printf("3d array as a block \n");
    for (int i = 0;i < sizeX; i++  ){
        for(int j = 0; j < sizeY; j++){
            for(int k = 0; k < sizeZ; k++){
               if(x < 10){
                printf("%d  |", x);
            }else{
                printf("%d |", x);
            }
            
            x++;
            }
            printf("\n");
            
        }
        printf("\n");
    }
    
    x = 1;
    printf("3d array as one line \n");
    for (int i = 0;i < sizeX; i++  ){
        for(int j = 0; j < sizeY; j++){
            for(int k = 0; k < sizeZ; k++){
               if(x < 10){
                printf("%d  |", x);
            }else{
                printf("%d |", x);
            }
            
            x++;
            }
        }
        
    }
    printf("\n");


}