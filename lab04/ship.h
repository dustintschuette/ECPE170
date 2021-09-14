//Dustin Schuette
//d_schuette@u.pacific.edu

#include <stdlib.h>
#include <time.h>
#include "board.h"
#include <stdbool.h>


struct ship{
    int size;
    char tile;
    char name[11];
    
};
//creates a battleship
struct ship createBs(){
    struct ship bs;
    bs.name[0] = 'b';
    bs.name[1] = 'a';
    bs.name[2] = 't';
    bs.name[3] = 't';
    bs.name[4] = 'l';
    bs.name[5] = 'e';
    bs.name[6] = 's';
    bs.name[7] = 'h';
    bs.name[8] = 'i';
    bs.name[9] = 'p';
    bs.name[10] = '\0';

    bs.tile = 'B';
    bs.size = 4;
    return bs;
}
//creates a carrier
struct ship createCar(){
    struct ship bs;
    bs.name[0] = 'c';
    bs.name[1] = 'a';
    bs.name[2] = 'r';
    bs.name[3] = 'r';
    bs.name[4] = 'i';
    bs.name[5] = 'e';
    bs.name[6] = 'r';
    bs.name[7] = '\0';

    bs.tile = 'C';
    bs.size = 5;
    return bs;
}
//creates a frigate
struct ship createFr(){
    struct ship bs;
    bs.name[0] = 'f';
    bs.name[1] = 'r';
    bs.name[2] = 'i';
    bs.name[3] = 'g';
    bs.name[4] = 'a';
    bs.name[5] = 't';
    bs.name[6] = 'e';
    bs.name[7] = '\0';

    bs.tile = 'F';
    bs.size = 2;
    return bs;
}
//adds ship to map, retries until successful
void addShip(struct ship currShip, int boardSize, char**board){
    srand(time(0));
    int rotate = rand() %2 ;
    int row = rand() % (boardSize - currShip.size + 1);
    int col = rand() % (boardSize);
    bool vert = false;
    bool shipPass = false;
    //veritcal

    while(!shipPass){
        if(rotate == 0){
            row = rand() % (boardSize - currShip.size + 1);
            col = rand() % (boardSize);
            vert = true;
        
    //horizontal
        }else{
            row = rand() % (boardSize - currShip.size + 1);
            col = rand() % (boardSize);

        }

        shipPass = addToBoard(board, row, col, currShip.size, vert, currShip.tile);

    }
    

}