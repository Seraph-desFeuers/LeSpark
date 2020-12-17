#######################################
# Seraph's Hard makefile              #
#######################################

# Configuration
CC      := g++#          compiler path
SRC_EXT := cpp#            file extension to compile          | NOTE: only one file extension allowed

SRC_DIR := ./src#        directory with sources             | NOTE: only one directory allowed
OBJ_DIR := ./obj#        temporate directory with obj files | NOTE: only one directory allowed
PRC_DIR := ./prc
LDFLAGS :=
CFLAGS  :=

EXEC_NAME := main

RM    := rm -rf#          command to delete folder with files within
MKDIR := mkdir -p#       command to make a directory
PRC   := ./LeSpark/embedded_perl.pl
CAT   := cat


# DONT TOUCH THAT IF YOU CANT UNDERSTAND WHAT ARE HAPPENING
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

SRC_FILES := $(call rwildcard,$(SRC_DIR),*.$(SRC_EXT))
PRC_FILES := $(patsubst $(SRC_DIR)/%.$(SRC_EXT),$(PRC_DIR)/%.$(SRC_EXT), $(SRC_FILES))
OBJ_FILES := $(patsubst $(PRC_DIR)/%.$(SRC_EXT),$(OBJ_DIR)/%.o, $(PRC_FILES))

all: clean build clean_build

$(PRC_DIR)/%.$(SRC_EXT): $(SRC_FILES)
	$(MKDIR) $(@D)
	$(CAT) $^ | $(PRC) > $@

clean:
	$(RM) $(OBJ_DIR)/* $(PRC_DIR)/* $(EXEC_NAME)

clean_build:
	$(RM) $(OBJ_DIR) $(PRC_DIR)

build: $(OBJ_FILES)
	$(CC) $(LDFLAGS) -o $(EXEC_NAME) $^

$(OBJ_DIR)/%.o : $(PRC_DIR)/%.$(SRC_EXT)
	$(MKDIR) $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<
