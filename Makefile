.PHONY:					all $(NAME) clear mkbuild clear clean fclean re

NAME					= libasm

BUILD_DIR				= build/
		
DIR						=	src/
SRC						=	main.s \
							ft_strlen.s

OBJECTS					= $(SRC:%.s=$(BUILD_DIR)%.o)

ASM						= nasm
ASMFLAGS				= -f macho64

RM						= rm -rf
CLEAR					= clear

$(BUILD_DIR)%.o:		$(DIR)%.s $(HEADER_DIR)* Makefile
						@mkdir -p $(@D)
						$(ASM) $(ASMFLAGS) $< -o $@


all:					 clear mkbuild $(HEADER_DIR) $(NAME) 
						
mkbuild:
						@mkdir -p build $(NAME)

init:
						@mkdir -p $(DIR)
						@touch $(DIR)main.s

clear:
						$(CLEAR)
						
$(NAME):				 $(OBJECTS)
						$(ASM) $(OBJECTS) -o $(NAME)
						
clean:					
						@${RM} $(BUILD_DIR)

fclean:					clean
						@${RM} ${NAME}
						@${RM} $(BUILD_DIR)

re:						fclean all
						$(MAKE) all