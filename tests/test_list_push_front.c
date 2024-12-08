#include "list.h"

#include <stdio.h>
#include <stdlib.h>
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
    // Case 1: Add first element
    ft_list_push_front(list, "First");
    if (!*list || strcmp((*list)->data, "First") != 0 || (*list)->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Adding 'First' failed.\n");
        return;
    }

    // Case 2: Add second element
    ft_list_push_front(list, "Second");
    if (!*list || strcmp((*list)->data, "Second") != 0 || !(*list)->next || strcmp((*list)->next->data, "First") != 0 || (*list)->next->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Adding 'Second' failed.\n");
        return;
    }

    // Case 3: Add third element
    ft_list_push_front(list, "Third");
    if (!*list || strcmp((*list)->data, "Third") != 0 || !(*list)->next || strcmp((*list)->next->data, "Second") != 0 || !(*list)->next->next || strcmp((*list)->next->next->data, "First") != 0 || (*list)->next->next->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Adding 'Third' failed.\n");
        return;
    }

    // Case 4: Add NULL data
    ft_list_push_front(list, NULL);
    if (!*list || (*list)->data != NULL || !(*list)->next || strcmp((*list)->next->data, "Third") != 0) {
        printf("\033[1;31mFAIL\033[0m: Adding 'NULL' failed.\n");
        return;
    }

    free_list(list);
    printf("\033[1;32mPASS: All tests passed for ft_list_push_front!\033[0m\n");
}
