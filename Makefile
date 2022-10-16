TARGET		:= libimgui

CPPSOURCES	:= .

CFILES	 := 
CPPFILES := $(foreach dir,$(CPPSOURCES), $(wildcard $(dir)/*.cpp))
BINFILES := $(foreach dir,$(DATA), $(wildcard $(dir)/*.bin))
OBJS     := $(addsuffix .o,$(BINFILES)) $(CFILES:.c=.o) $(CPPFILES:.cpp=.o)

PREFIX   = $(DEVKITARM)/bin/arm-none-eabi
CC       = $(PREFIX)-gcc
CXX      = $(PREFIX)-g++
ARCH     = -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CFLAGS   = -g -Wall -O2 -mword-relocations -fomit-frame-pointer -ffunction-sections $(ARCH) \
           -I$(DEVKITPRO)/libctru/include -I$(DEVKITPRO)/picaGL/include
CXXFLAGS = $(CFLAGS) -fno-exceptions -std=gnu++11
ASFLAGS  = $(CFLAGS)
AR       = $(PREFIX)-gcc-ar

all: $(TARGET).a

$(TARGET).a: $(OBJS)
	$(AR) -rc $@ $^

install: $(TARGET).a
	@mkdir -p $(DEVKITPRO)/portlibs/3ds/lib/
	cp $(TARGET).a $(DEVKITPRO)/portlibs/3ds/lib/
	cp *.h $(DEVKITPRO)/portlibs/3ds/include/

clean:
	@rm -rf $(TARGET).a $(TARGET).elf $(OBJS)