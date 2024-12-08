#include "list.h"

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>  // Include for strcmp

// Declare your custom function
extern void ft_list_push_front(list_t **begin_list, void *data);

// Helper function to print the list (for debugging purposes)
void print_list_t(list_t *list) {
    while (list) {
        if (list->data)
            printf("%s -> ", (char *)list->data);
        else
            printf("NULL -> ");
        list = list->next;
    }
    printf("NULL\n");
}

// Helper function to free the list
void free_list(list_t **list) {
    list_t *current = *list;
    list_t *next;

    while (current) {
        next = current->next;
        free(current);
        current = next;
    }

    *list = NULL;
}

// Test function
void test_list_push_front(list_t **list) {

    ft_list_push_front(list, "First");
    assert(*list != NULL && strcmp((*list)->data, "First") == 0 && (*list)->next == NULL);

    ft_list_push_front(list, "Second");
    assert(*list != NULL && strcmp((*list)->data, "Second") == 0 && (*list)->next != NULL);
    assert(strcmp((*list)->next->data, "First") == 0 && (*list)->next->next == NULL);

    ft_list_push_front(list, "Third");
    assert(*list != NULL && strcmp((*list)->data, "Third") == 0 && (*list)->next != NULL);
    assert(strcmp((*list)->next->data, "Second") == 0 && (*list)->next->next != NULL);
    assert(strcmp((*list)->next->next->data, "First") == 0 && (*list)->next->next->next == NULL);

    ft_list_push_front(list, NULL);
    assert(*list != NULL && (*list)->data == NULL && (*list)->next != NULL);
    assert(strcmp((*list)->next->data, "Third") == 0);

    free_list(list);
    printf("\033[1;32mPASS: All tests passed for ft_list_push_front!\033[0m\n");
}