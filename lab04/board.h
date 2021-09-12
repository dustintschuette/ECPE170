//Dustin Schuette
//d_schuette@u.pacific.edu

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>


char** initBoard(int size){
    char** board;
    board = calloc(size, sizeof(char*));
    for(int i = 0; i< size; i++){
        board[i] = calloc(size, sizeof(char));
    }
    if (board == NULL) {
    printf("FATAL ERROR: out of memory: %s\n", strerror(errno));
    exit(EXIT_FAILURE);
  }

    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            board[i][j] = '-';
            
        }
    }


    return board;

}

void printBoard(char** board, int size){
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            printf("%c ", board[i][j]);
        }
        printf("\n");
    }
    return;
}

void deleteBoard(char** board,  int size) {
  for (int i = 0; i < size; i++) {
    free(board[i]);
  }
  free(board);
  
  return;
}

