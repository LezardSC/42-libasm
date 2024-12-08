#ifndef LIST_H
#define LIST_H

typedef struct list_s {
	void	*data;
	struct list_s	*next;
} list_t;

#endif //LIST_H
