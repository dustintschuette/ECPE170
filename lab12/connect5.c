#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
//9x6 board
char board[54];
uint32_t m_z;
uint32_t m_w;



uint32_t get_random()
{
  uint32_t result;
  m_z = 36969 * (m_z & 65535) + (m_z >> 16);
  m_w = 18000 * (m_w & 65535) + (m_w >> 16);
  result = (m_z << 16) + m_w;  /* 32-bit result */
  return result;
}

void printBoard(){
    printf("   1 2 3 4 5 6 7  \n");
    printf(" _________________ \n|");
    for(int i = 0; i < 54; i++){
        printf("%c ", board[i]);

        if(i%9 == 8 && i != 53){
            printf("|\n|");
        }
    }
    printf("|\n ------------------\n");
}

//returns if game is won
//if 1 true
//if 0 false
int checkSpace(int lastSpace, int dx){
    int nextSpace = lastSpace;
    char player = board[lastSpace];
    int col = lastSpace % 9; //starting col to make sure it doesnt wrap
    //printf("Player: %c \n", player);
    int nextCol = col + 1;
    int counter = 0;
    if(dx == 9){
        col = 0;
    }
    while(nextSpace > -1 && nextSpace < 54 && board[nextSpace] == player && nextCol < 9){
        counter++;
        nextSpace += dx;
    }
    col = col -1;
    nextSpace = lastSpace - dx;
    if(dx == 9){
        col = 8;
    }
    while(nextSpace > -1 && nextSpace < 54 && board[nextSpace] == player && col > -1){
        counter++;
        nextSpace -= dx;
    }


    if(counter > 4){
        printf("Counter for checker: %d \n", counter);
        return 1;
    }
    //no win found
    return 0;
}
int checkWin(int lastSpace){
    
    //up left
    if(checkSpace(lastSpace, 10)){
        return 1;
    }
    //up
    if(checkSpace(lastSpace, 9)){
        return 1;
    }
    //up right
    if(checkSpace(lastSpace, -8)){
        return 1;
    }
    //left 
    if(checkSpace(lastSpace, 1)){
        return 1;
    }
    return 0;

}

/*
[0-8]   00 01 02 03 04 05 06 07 08
[9-17]  09 10 11 12 13 14 15 16 17
[18-26] 18 19 20 21 22 23 24 25 26
[27-35] 27 28 29 30 31 32 33 34 35
[36-44] 36 37 38 39 40 41 42 43 44
[45-53] 45 46 47 48 49 50 51 52 53
*/
int checkMove(int move, char player){
    for(int i = 5; i > -1; i --){
        if(board[i*9 + move] == '.' ){
            board[i*9 + move] = player;
            return i*9 + move;
        }
    }
    return 0;
}
//setup starting board
void setupBoard(){
    for(int i = 0; i < 54; i++){
        board[i] = '.';
    }
    board[0] = 'C';
    board[8] = 'C';
    board[9] = 'H';
    board[17] = 'H';
    board[18] = 'C';
    board[26] = 'C';
    board[27] = 'H';
    board[35] = 'H';
    board[36] = 'C';
    board[44] = 'C';
    board[45] = 'H';
    board[53] = 'H'; 
}
int takeTurnH(){
    int gotInput = 0;
        while (gotInput == 0){
            int turn = -1;
            printf("\n Please input hUmAn move: ");
            scanf("%u", &turn);

            if(turn > 0 && turn < 8){
                turn = checkMove(turn, 'H');
                if(turn != 0){
                    gotInput = 1;
                    return turn;
                }
            }    
        }
    return -1;
}
int takeTurnC(){
    int flag = 1;
    while(flag){
        int turn = (int) get_random();
        if(turn < 0){
            turn = turn * -1;
        }
        turn = turn % 8;
        int turnHolder = turn;
        turn = checkMove(turn, 'C');
        if(turn != 0){
            printf("Computer places chip in col: %u \n", turnHolder);
            return turn;
            
        }
    }
    return -1;

}
int checkTie(){
    for(int i = 0; i < 54; i++){
        if(board[i] == '.'){
            return 0;
        }
    }
    return 1;
}

int main (){
    setupBoard();
    int randSeed1 = 50000;
    int randSeed2 = 60000;
    printf("Please input first seed for random number: ");
    scanf("%u", &randSeed1);
    printf("Please input first seed for random number: ");
    scanf("%u", &randSeed2);
    m_w = randSeed1;
    m_z = randSeed2;
    int coin = (int) get_random();
    if(coin < 0){
        coin = coin * -1;
    }
    coin = coin % 2;
    if(coin){
        printf("fEeBlE hUmAn wInS cOiN tOsS. \n");
        takeTurnH();
        printBoard();
    }else{
        printf("Computer is glorious in random computation, computer moves first!\n");
    }
    int game = 1;
    while(game){
        int turn;
        turn = takeTurnC();
        printBoard();
        if(checkWin(turn)){
            printf("Computer Wins! \n");
        }
        if(checkTie()){
            printf("Draw \n");
            game = 0;
        }
        turn = takeTurnH();
        printBoard();
        if(checkWin(turn)){
            printf("hUmAn wInS ... \n");
            game = 0;
        }
        if(checkTie()){
            printf("Draw \n");
            game = 0;
        }

    }


}