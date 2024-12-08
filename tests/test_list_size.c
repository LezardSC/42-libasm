#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "list.h"

// Declare your custom function
extern int ft_list_size(list_t *begin_list);
extern void ft_list_push_front(list_t **begin_list, void *data);
void free_list(list_t **list);

// Test function
void test_list_size() {
    list_t *list = NULL;

    // Case 1: Empty list
    if (ft_list_size(list) != 0) {
        printf("\033[1;31mFAIL\033[0m: List size is not 0 for an empty list.\n");
        return;
    }

    // Case 2: List with one element
    ft_list_push_front(&list, "First");
    if (ft_list_size(list) != 1) {
        printf("\033[1;31mFAIL\033[0m: List size is not 1 for a list with one element.\n");
        return;
    }

    // Case 3: List with multiple elements
    ft_list_push_front(&list, "Second");
    ft_list_push_front(&list, "Third");
    if (ft_list_size(list) != 3) {
        printf("\033[1;31mFAIL\033[0m: List size is not 3 for a list with three elements.\n");
        return;
    }

    // Cleanup
    free_list(&list);
    if (ft_list_size(list) != 0) {
        printf("\033[1;31mFAIL\033[0m: List size is not 0 after clearing the list.\n");
        return;
    }

    printf("\033[1;32mPASS: All ft_list_size tests passed!\033[0m\n");
}
