CC = gcc
CFLAGS = -Wall -Wextra -std=c11

# Archivos fuente estándar
SRC = ast.c eval.c data.c error.c string.c

# Archivos generados por Bison y Flex
PARSER = tree.tab.c
LEXER = lex.yy.c

OBJ = $(SRC:.c=.o) $(PARSER:.c=.o) $(LEXER:.c=.o)

TARGET = tree

all: $(TARGET)

# Ejecutable final
$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET)

# Regla de Bison
tree.tab.c tree.tab.h: tree.y
	bison -d tree.y

# Regla de Flex
lex.yy.c: tree.lx tree.tab.h
	flex tree.lx

# Regla general de compilación
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
