#include <stdlib.h>
#include <stdio.h>


struct Node {
    int val;
    struct Node* next;

};
struct Node* createList(struct Node* head, int size);
void printList(struct Node * head);
void insert(struct Node* head, int index);
void freeList(struct Node* head);


int main(){

    struct Node* head = calloc(10, sizeof(struct Node));
    head->next = NULL;
    head->val = rand() %100;

    createList(head, 10);
    printList(head);
    insert(head, 6);
    printf("Inserting a new element at index 6 \n \n");
    printList(head);
    freeList(head);

    

}
//returns a new linked list of size number of elements when given the head of a linked list;
struct Node* createList(struct Node* head, int size){
        if(size == 0){
            return head;
        }
    head->next = calloc(1, sizeof(struct Node));
    head->next->next = NULL;
    head->next->val = rand() % 100;
    createList(head->next, (size-1));
    return head;

}

void printList(struct Node * head){
    struct Node * temp = head;
    int counter = 0;
    while(temp->next != NULL){
        printf("List at index %d is %d \n", counter, temp->val);
        counter++;
        temp = temp->next;
    }

}

void insert(struct Node* head, int index){
    struct Node * temp = head;
    while(index > 1){
        if(temp->next == NULL){
            printf("error in insert, index given is out of bounds");
            return;
        }
        temp = temp->next;
        index--;
    }
    struct Node* newNode = calloc(1, sizeof(struct Node));
    newNode->next = temp->next;
    newNode->val = rand() %100;
    temp->next = newNode;
    return;
}

void freeList(struct Node* head){
    if(head == NULL){return;}
    freeList(head->next);
    free(head);
}