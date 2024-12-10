NAME					= 	libasm.a
BONUS_NAME				=	libasm_bonus.a

BUILD_DIR				=	build/
DIR						=	src/
BONUS_DIR				=	bonus/
TEST_DIR				=	tests/
INC_DIR					=	include/

SRC						=	ft_strlen.s \
							ft_strcpy.s \
							ft_strcmp.s \
							ft_write.s \
							ft_read.s \
							ft_strdup.s \

SRC_BONUS				=	ft_atoi_base.s \
							ft_list.s \
							ft_list_create_elem.s \
							ft_list_push_front.s \
							ft_list_size.s \
							ft_list_sort.s \
							ft_list_remove_if.s \

TEST_SRC				=	test.c \
							test_strcmp.c \
							test_strlen.c \
							test_strcpy.c \
							test_write.c \
							test_read.c \
							test_strdup.c \


TEST_SRC_BONUS			=	test_atoi_base.c \
							test_list_push_front.c \
							test_list_size.c \
							test_list_sort.c \
							test_list_remove_if.c


TEST_EXEC				=	test
TEST_EXEC_BONUS			=	test_bonus

CC						=	gcc
CFLAGS					=	-Wall -Wextra -Werror
IFLAGS					=	-I $(INC_DIR)

OBJECTS					= $(patsubst %.s, $(BUILD_DIR)%.o, $(SRC))
TEST_OBJECTS 			= $(patsubst %.c, $(BUILD_DIR)%.o, $(TEST_SRC))
OBJECTS_BONUS			= $(patsubst %.s, $(BUILD_DIR)%.o, $(SRC_BONUS))
TEST_OBJECTS_BONUS 		= $(patsubst %.c, $(BUILD_DIR)%.o, $(TEST_SRC_BONUS))

ASM						= nasm
ASMFLAGS				= -f elf64 -i $(DIR)

RM						= rm -rf
CLEAR					= clear

$(BUILD_DIR)%.o :		$(DIR)%.s Makefile
						@mkdir -p $(shell dirname $@)
						$(ASM) $(ASMFLAGS) $< -o $@

$(BUILD_DIR)%.o :		$(BONUS_DIR)%.s Makefile
						@mkdir -p $(shell dirname $@)
						$(ASM) $(ASMFLAGS) $< -o $@

$(BUILD_DIR)%.o :		$(TEST_DIR)%.c
						@mkdir -p $(shell dirname $@)
						$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@

.PHONY: all
all: clear
	$(MAKE) $(NAME)

.PHONY: bonus
bonus: clear $(NAME_BONUS)

.PHONY: clear
clear:
						$(CLEAR)
						
$(NAME):				 $(OBJECTS)
						rm -rf $(NAME)
						ar rcs $(NAME) $(OBJECTS)

$(NAME_BONUS):				 $(OBJECTS) $(OBJECTS_BONUS)
						rm -rf $(NAME_BONUS)
						ar rcs $(NAME_BONUS) $(OBJECTS) $(OBJECTS_BONUS)

.PHONY: clean
clean:
						@${RM} $(BUILD_DIR)

.PHONY: fclean
fclean:					clean
						@${RM} ${NAME} ${NAME_BONUS}
						@$(RM) $(TEST_EXEC) $(TEST_EXEC_BONUS)

.PHONY: re
re:						fclean
						$(MAKE) all

.PHONY: test
test: 					$(NAME) $(TEST_OBJECTS)
						$(CC) $(CFLAGS) -o $(TEST_EXEC) $(TEST_OBJECTS) $(NAME)

.PHONY: test_bonus
test_bonus:				$(NAME_BONUS) $(TEST_OBJECTS) $(TEST_OBJECTS_BONUS)
						$(CC) $(CFLAGS) -DBONUS -o $(TEST_EXEC_BONUS) $(TEST_OBJECTS) $(TEST_OBJECTS_BONUS) $(NAME_BONUS)
