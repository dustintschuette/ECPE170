//Dustin Schuette
//d_schuette@u.pacific.edu

#include "ship.h"
#include "board.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>




int main(){
    int input;
    int boardSize;
    char** board;
    printf("Welcome to Sploosh Kaboom \n");
    printf("How large do you want the board? (5 - 20) : ");

    scanf("%d", &input);
    boardSize = input;

    printf("size: %u\n", boardSize);
    board = initBoard(boardSize);
    printBoard(board, boardSize);

    
    struct ship carrier;
    //strcpy(carrier.name, 'carrier');
    carrier.tile = 'c';
    carrier.size = 5;


    printf("%d : carrier size", carrier.size);
    deleteBoard(board, boardSize);

}