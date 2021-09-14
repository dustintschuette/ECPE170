//Dustin Schuette
//d_schuette@u.pacific.edu

#include "ship.h"
#include "board.h"
#include "score.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h>
#include <math.h>




int main(int argc, char *argv[]){
    //int input;
    FILE *file;
    //see if program is supplied a test file
    bool isDemo = false;
    if(argc > 1){
        isDemo = true;
        file = fopen(argv[1], "r");
        if(file == NULL){
            printf("Error opening file %s", argv[1]);
        }
        
    }
    int boardSize;
    char** board;
    char input [10];
    int maxL = 5;
    bool gameOver = false;
    bool programOver = false;
    int wins = 0;
    printf("Welcome to Sploosh Kaboom \n");

    while(!programOver){
    printf("How large do you want the board? (5 - 20) : ");

    bool inputPass = false;
    //input checking 
    while(!inputPass){
        fgets(input, maxL, stdin);
        sscanf(input, "%d *[^\n]", &boardSize);

        if(boardSize > 4 && boardSize < 21){
            inputPass = true;
        }else{
            printf("Invalid choice, must be between (5-20)\n Board Size:  ");
        }
    }

    //initialize score
    struct Score* scoreBoard;
    struct Score theScore;
    scoreBoard = &theScore;
    initScore(scoreBoard);


    //make the board
    printf("size: %u\n", boardSize);
    board = initBoard(boardSize);
    
    //initialize number of shots
    double shots = (double) boardSize;
    shots = pow(shots, 2);
    shots = shots/2;
    int shotsLeft = (int) shots;

    //setup ships
    struct ship bs = createBs();
    struct ship carrier = createCar();
    struct ship frig1 = createFr();
    struct ship frig2 = createFr();
    //if no file is supplied then ships are added manually
    if(!isDemo){
        addShip(carrier, boardSize, board);
        addShip(bs, boardSize, board);
        addShip(frig1, boardSize, board);
        addShip(frig2, boardSize, board);
    }else{
        // demo file was supplied so ship placement is read in
        char fileIn [100];
        int row, col;
        char colAlpha, type, rotate;
        bool vert;
        while(fgets(fileIn, 100, file) != NULL){
            if(fileIn[0] == '#'){
                //skips line
            }else{
                //processes one ship
                sscanf(fileIn, " %c %c %c%d", &type, &rotate, &colAlpha, &row );
                if(rotate == 'c'){
                    vert = true;
                }else{
                    vert = false;
                }
                col = (int) colAlpha - 'a';
                row = row-1;
                addDemoShip(board, type, vert, row, col);

            }

        }


    }
    
    char colAlpha;
    bool charPass  = false;
    int row;
    int col;

    while(!gameOver){
        //begin game loop
        printBoard(board, boardSize);
        printf("Shots left : %d \n", shotsLeft);
        charPass = false;
        colAlpha = 'z';
        row = 100;
        inputPass = false;

        while(!inputPass){
            //get input for player's move
            row = 25;
            fgets(input, maxL, stdin);
            //printf("\n input is : %c%c \n", input[0], input[1]);
            if (input[strlen(input)-1] != '\n') {
                for (int c; (c = getchar()) != EOF && c != '\n';)
                    ;
            }
            sscanf(input, " %c%d",&colAlpha, &row);
            if(row == 25){
                sscanf(input, " %d%c", &row, &colAlpha);
            }

            row = row -1;

            //validate character input
            if(colAlpha >= 'a' && colAlpha < 'a' + boardSize){
                charPass = true;
                col = (int) colAlpha - 'a';
            }else if(colAlpha >= 'A' && colAlpha < 'A' + boardSize){
                charPass = true;
                col = (int) colAlpha - 'A';

            }

            //validate digit input
            if(row > -1 && row < (boardSize) && charPass){
                inputPass = true;
             }else{
                printf("Invalid choice, must be between (A - %c) (1 - %d) \n ", ('A' + boardSize -1) ,  boardSize);
             }
        }
        printf("your move : col %c, row %d \n", colAlpha, (row+1));
        //see if it's a valid move
        if(checkBoard(board, row, col, scoreBoard)){
            shotsLeft = shotsLeft - 1;
        }else{
            printf("You've already shot here! Pick another tile!\n");
        }
        printf("Score : %d carrier hits, %d battleship hits, %d frigate hits \n", scoreBoard->cHits, scoreBoard->bHits, scoreBoard->fHits);
        if(checkWin(scoreBoard, board, boardSize)){
            gameOver = true;
            printf("You Win! \n");
            wins = wins +1;
        }
        
        if(shotsLeft == 0){
            gameOver = true;
        }
    }
    //ask to play again

    char again;
    inputPass = false;
    printBoard(board, boardSize);
    deleteBoard(board, boardSize);
    while(!inputPass){
        printf("Game Over! your wins : %d \n Play again?(y/n): ", wins);
        fgets(input, maxL, stdin);
        sscanf(input, " %c", &again);
        //printf("input is %c \n", again);
        

        if(again == 'y' || again == 'Y'){
            inputPass = true;
            gameOver = false;
        }else if(again == 'n' || again == 'N'){
            inputPass = true;
            programOver = true;
        }
    }

    }
    //game end
    printf("Thanks for playing!\n");

}