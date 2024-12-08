#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

// Declare your custom function
extern void ft_list_push_front(t_list **begin_list, void *data);

// Helper function to print the list (for debugging purposes)
void print_list(t_list *list) {
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
void free_list(t_list **list) {
    t_list *current = *list;
    t_list *next;

    while (current) {
        next = current->next;
        free(current);
        current = next;
    }

    *list = NULL;
}

// Test function
void test_ft_list_push_front(t_list **list) {
    printf("Running tests for ft_list_push_front...\n");

    ft_list_push_front(list, "First");
    assert(*list != NULL && (*list)->data == "First" && (*list)->next == NULL);
    printf("\033[1;32mPASS\033[0m: Added to empty list.\n");

    ft_list_push_front(list, "Second");
    assert(*list != NULL && (*list)->data == "Second" && (*list)->next != NULL);
    assert((*list)->next->data == "First" && (*list)->next->next == NULL);
    printf("\033[1;32mPASS\033[0m: Added to list with one element.\n");

    ft_list_push_front(list, "Third");
    assert(*list != NULL && (*list)->data == "Third" && (*list)->next != NULL);
    assert((*list)->next->data == "Second" && (*list)->next->next != NULL);
    assert((*list)->next->next->data == "First" && (*list)->next->next->next == NULL);
    printf("\033[1;32mPASS\033[0m: Added multiple elements.\n");

    ft_list_push_front(list, NULL);
    assert(*list != NULL && (*list)->data == NULL && (*list)->next != NULL);
    assert((*list)->next->data == "Third");
    printf("\033[1;32mPASS\033[0m: Added NULL data.\n");

    free_list(list);
    printf("\033[1;32mAll tests passed for ft_list_push_front!\033[0m\n");
}
