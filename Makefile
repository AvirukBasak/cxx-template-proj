# Compiler and flags
CC            := gcc # -Xanalyzer
CFLAGS        := -Wall -Werror -Wextra -std=c99 -fsanitize=address -g
CRELFLAGS     := -Wall -Werror -Wextra -std=c99 -O2

# Directories
INC_DIR       := include
SRC_DIR       := src
LIB_DIR       := lib
OBJ_DIR       := obj
BIN_DIR       := bin

INCLUDES      := -I$(INC_DIR)

# Libraries
LIBS          := -L$(LIB_DIR) -lm -lecho -lmatrix
LIBECHO       := $(LIB_DIR)/libecho.a
LIBMATRIX     := $(LIB_DIR)/libmatrix.a

# Project executable
TARGET        := $(BIN_DIR)/target-dbg

# Sources and objects
TARGET_SRC    := $(wildcard $(SRC_DIR)/*.c)
TARGET_OBJ    := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(TARGET_SRC))

# Targets
.PHONY: all release clean

all: directories $(TARGET)

release: CFLAGS := $(CRELFLAGS) TARGET := $(BIN_DIR)/target

# Main code

$(TARGET): $(TARGET_OBJ) $(LIBECHO) $(LIBMATRIX)
	$(CC) $(CFLAGS) $(INCLUDES) $(TARGET_OBJ) $(LIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Supporting code

directories:
	@mkdir -p $(BIN_DIR)
	@mkdir -p $(LIB_DIR)
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(OBJ_DIR)/libecho
	@mkdir -p $(OBJ_DIR)/libmatrix

clean:
	rm -rf $(BIN_DIR)
	rm -rf $(LIB_DIR)
	rm -rf $(OBJ_DIR)

# Library specific code

## libecho

LIBECHO_SRC := $(wildcard $(SRC_DIR)/libecho/*.c)
LIBECHO_OBJ := $(patsubst $(SRC_DIR)/libecho/%.c,$(OBJ_DIR)/libecho/%.o,$(LIBECHO_SRC))

$(LIBECHO): $(LIBECHO_OBJ)
	ar rcs $@ $^

$(OBJ_DIR)/libecho/%.o: $(SRC_DIR)/libecho/%.c
	$(CC) $(CFLAGS) -I $(INC_DIR) -c $< -o $@

## libmatrix

LIBMATRIX_SRC := $(wildcard $(SRC_DIR)/libmatrix/*.c)
LIBMATRIX_OBJ := $(patsubst $(SRC_DIR)/libmatrix/%.c,$(OBJ_DIR)/libmatrix/%.o,$(LIBMATRIX_SRC))

$(LIBMATRIX): $(LIBMATRIX_OBJ)
	ar rcs $@ $^

$(OBJ_DIR)/libmatrix/%.o: $(SRC_DIR)/libmatrix/%.c
	$(CC) $(CFLAGS) -I $(INC_DIR) -c $< -o $@
