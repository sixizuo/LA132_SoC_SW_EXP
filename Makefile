# **********************************************
# ls1x project
# **********************************************
# Name of application

# **********************************************
# Tools
# **********************************************
CC        = $(CROSS_COMPILE)gcc$(EXE)
LD        = $(CROSS_COMPILE)ld$(EXE)
OBJCOPY   = $(CROSS_COMPILE)objcopy$(EXE)
OBJDUMP   = $(CROSS_COMPILE)objdump$(EXE)
STRIP     = $(CROSS_COMPILE)strip$(EXE)
SIZE      = $(CROSS_COMPILE)size$(EXE)

# **********************************************
# Directories
# **********************************************
BASE_DIR  = $(ROOT_DIR)/../00_base
BUILD_DIR = $(ROOT_DIR)/build

# SOURCE    = $(BASE_DIR)/driver $(BASE_DIR)/bsp $(ROOT_DIR)/user
SOURCE    = $(ROOT_DIR)/driver $(ROOT_DIR)/bsp $(ROOT_DIR)/user

BOARD     = $(MCU)
BOARDNAME = $(MCU)
IMAGENAME = $(MCU)_demo

SRCDIR    = $(shell find $(SOURCE) -type d)
VPATH     = $(SRCDIR)

# **********************************************
# Image file names and map file
# **********************************************
IMAGE_ELF = $(BUILD_DIR)/$(IMAGENAME).elf
IMAGE_BIN = $(BUILD_DIR)/$(IMAGENAME).bin
IMAGE_MAP = $(BUILD_DIR)/$(IMAGENAME).map

# **********************************************
# Compiler and linker options
# **********************************************
# INCLUDE_PATH = $(BASE_DIR)/driver $(BASE_DIR)/bsp $(BASE_DIR)/include $(ROOT_DIR)/user
INCLUDE_PATH = $(ROOT_DIR)/driver $(ROOT_DIR)/bsp $(ROOT_DIR)/include $(ROOT_DIR)/user
INCLUDE  += $(foreach dir, $(INCLUDE_PATH), -I$(dir))

FLAGS   = -std=gnu99 -O0 -ffunction-sections -fdata-sections -msoft-float -fsched-pressure -fno-builtin -D $(BOARDNAME) 

CC_OPTS  = $(DEBUG) $(FLAGS) $(INCLUDE) 
CC_COPTS = $(DEBUG) $(FLAGS) $(INCLUDE) 

LD_SCRIPT = ld.script
LD_OPTS   = -G 0 -static -T $(LD_SCRIPT) -Map $(IMAGE_MAP) --gc-sections

# **********************************************
# Files to be compiled
# **********************************************

SRC_C  = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.c))
SRC_S  = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.S))
SRC    = $(SRC_C) $(SRC_S)
OBJ_C  = $(notdir $(patsubst %.c, %.o, $(SRC_C)))
OBJ_S  = start.o $(filter-out start.o, $(notdir $(patsubst %.S, %.o, $(SRC_S))))
LS1C1X_OBJ = $(OBJ_S) $(OBJ_C)
OBJ = $(patsubst %.o, $(BUILD_DIR)/%.o, $(LS1C1X_OBJ))

# **********************************************
# Rules
# **********************************************
.PHONY : all
all : $(BUILD_DIR) $(IMAGE_BIN)
$(IMAGE_BIN) : $(LS1C1X_OBJ) 
	$(LD) $(LD_OPTS) -o $(IMAGE_ELF) $(OBJ) -Map $(IMAGE_MAP)
	$(OBJCOPY) -O binary $(IMAGE_ELF) $(IMAGE_BIN)
	$(SIZE) $(IMAGE_ELF)
	$(OBJDUMP) -alD $(IMAGE_ELF) > $(BUILD_DIR)/$(IMAGENAME).s

$(OBJ_C) : %.o : %.c 
	$(CC) $(CC_COPTS) -g -Og -c -o $(BUILD_DIR)/$@ $^
$(OBJ_S) : %.o : %.S 
	$(CC) $(CC_OPTS) -g -Og -c -o $(BUILD_DIR)/$@ $^
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
.PHONY : clean 
clean :
	rm -rf $(BUILD_DIR)/*
