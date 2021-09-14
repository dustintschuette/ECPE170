//Dustin Schuette
//d_schuette@u.pacific.edu

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>


#ifndef SCORE_H
#define SCORE_H

struct Score{
    int fHits;
    int cHits;
    int bHits;

    bool fFlag;
    bool cFlag;
    bool bFlag;
};

void updateScore( struct Score* currScore, int c, int b, int f){
    currScore->fHits = currScore->fHits + f;
    currScore->cHits = currScore->cHits + c;
    currScore->bHits = currScore->bHits + b;
    //debug
    printf("Score Updated : %d, %d, %d \n",(currScore->fHits), (currScore->cHits), (currScore->bHits) );
    return;
}
bool checkWin(struct Score* currScore, char** board, int size){
    bool check = true;
    if(currScore->fHits != 4 && !(currScore->fFlag) ){
        check = false;
    }else {
        if(!currScore->fFlag){
            printf("All frigates sunk\n");
            currScore->fFlag = true;
        }
        

    }
    if (currScore->bHits != 3 && currScore->bFlag == false){
        check = false;
    }else{
        if(!currScore->bFlag){
            printf("Battleship sunk\n");
            currScore->bFlag = true;
            for(int i = 0; i < size; i++){
                for(int j = 0; j < size; j++){
                    if(board[i][j] == 'B'){
                        board[i][j] = 'b';
                    }
                }
            }
        }
        
    }
    if (currScore->cHits != 4 && currScore->cFlag == false){
        check = false;
    }else{
        if(!currScore->cFlag){
            printf("Carrier sunk\n");
            currScore->cFlag = true;
            for(int i = 0; i < size; i++){
                for(int j = 0; j < size; j++){
                    if(board[i][j] == 'C'){
                        board[i][j] = 'c';
                    }
                }
            }
        }
        
    }
    return check;


}
void initScore(struct Score* currScore){
    currScore->fHits = 0;
    currScore->cHits = 0;
    currScore->bHits = 0;

    currScore->fFlag = false;
    currScore->cFlag = false;
    currScore->bFlag = false;
    return;
}


#endif