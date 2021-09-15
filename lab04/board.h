//Dustin Schuette
//d_schuette@u.pacific.edu

#include "score.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include <ctype.h>

#ifndef BOARD_H
#define BOARD_H



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
    printf("    ");
    char row = 'A';
    for(int i = 0; i < size; i++){
        
        printf("%c ", row);
        row = row+1;

    }
    printf("\n+~~~");
    for(int i = 0; i < size; i++){
        char count = '~';
        printf("%c%c", count, count);
    }
    printf("\n");
    int count = 1;
    for(int i = 0; i < size; i++){
        
        if(count > 9){
            printf("%d| ", count); 
        }else{
            printf("%d | ", count);  
        }

        
        for(int j = 0; j < size; j++){
            //don't print hidden ships
            if(board[i][j] == 'B' || board[i][j] == 'F' || board[i][j] == 'C'){
                //printf("%c ", board[i][j]);
                printf("- ");

            }else{
               printf("%c ", board[i][j]); 
            }

            
        }
        count ++;
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

bool addToBoard(char** board, int row, int col, int size, bool vert, char tile){
    //check to see if spaces are open
    for(int i = 0; i < size; i++){
        if(vert){
            if(board[row+i][col] != '-'){
                return false;
            }

        }else{
            if(board[row][col+i] != '-'){
                return false;
            }

        }


    }
    for(int i = 0; i < size; i++){
        if(vert){
            //printf("ship added at %d ,%d tile : %c\n", row + i, col, tile);
            board[row+i][col] = tile;

        }else{
            //printf("ship added at %d ,%d tile : %c \n", row , col+ i, tile);
            board[row][col+i] = tile;

        }


    }
    return true;

}
void addDemoShip(char** board, char type, bool vert, int row, int col){
    int size;
    if(type == 'f'){
        size = 2;
    }else if(type == 'c'){
        size = 5;
    }else if(type == 'b'){
        size = 4;
    }else{
        printf("error no size found for demo ship");
    }
    type = toupper(type);
    for(int i = 0; i < size; i++){
        if(vert){
            //up/down
            board[row][col + i] = type;
            printf("ship added at %d ,%d tile : %c\n", row + i, col, type);

        }else{
            //left/right
             printf("ship added at %d ,%d tile : %c \n", row , col+ i, type);
            board[row + i][col] = type;

        }
    }
}

bool checkBoard(char** board, int row, int col, struct Score* currScore){
    printf("Checking board[%d][%d] value : %c\n", row, col, board[row][col]);
    if(board[row][col] == '-'){
        board[row][col] = 'X';
        printf("SPLOOOOSH, You Missed\n");
        return true;
    }else if(board[row][col] == 'C'){
        board[row][col] = 'c';
        printf("KABOOOOOM, direct hit!\n");
        updateScore(currScore, 1, 0, 0);
        return true;
    }else if(board[row][col] == 'B'){
        board[row][col] = 'b';
        printf("KABOOOOOM, direct hit!\n");
        updateScore(currScore, 0, 1, 0);
        return true;
    }else if(board[row][col] == 'F'){
        board[row][col] = 'f';
        updateScore(currScore, 0, 0, 1);
        printf("KABOOOOOM, direct hit!\n");
        return true;
    }else{
        return false;
    }
}

#endif

