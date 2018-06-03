#
# RISC-V bootup test
# Author: Daniele Lacamera <root@danielinux.net>
# 
# MIT License
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


CROSS_COMPILE:=riscv64-unknown-elf-
CC:=$(CROSS_COMPILE)gcc
LD:=$(CROSS_COMPILE)gcc
AS:=$(CROSS_COMPILE)gcc
GDB:=$(CROSS_COMPILE)gdb
OBJS:=startup.o main.o vector.o

LSCRIPT:=target.ld

OBJCOPY:=$(CROSS_COMPILE)objcopy


CFLAGS:=-g -ggdb -Wall -Wno-main -Wstack-usage=200 -ffreestanding -Wno-unused -nostdlib
CFLAGS+=-fno-builtin-printf -DUSE_PLIC -DUSE_M_TIME -g -march=rv32imac -mabi=ilp32 -mcmodel=medany
LDFLAGS:=-T $(LSCRIPT) -Wl,-gc-sections -Wl,-Map=image.map -nostdlib -march=rv32imac -mabi=ilp32 -mcmodel=medany
ASFLAGS:=$(CFLAGS)

#all: image.bin

image.bin: image.elf
	$(OBJCOPY) -O binary $^ $@

image.elf: $(OBJS) $(LSCRIPT)
	$(LD) $(LDFLAGS) $(OBJS) -o $@ 
	
startup.o: startup.c

main.o: main.c

clean:
	rm -f image.bin image.elf *.o image.map tags

#############################################################
# This Section is for uploading a program to SPI Flash
#############################################################
OPENOCDCFG ?= ./openocd.cfg
OPENOCDARGS += -f $(OPENOCDCFG)
RISCV_OPENOCD_PATH ?= /opt/toolchains/openocd-riscV
OPENOCD ?= $(RISCV_OPENOCD_PATH)/bin/openocd
GDB_PORT=3333

GDB_UPLOAD_ARGS ?= --batch

GDB_UPLOAD_CMDS += -ex "set remotetimeout 240"
GDB_UPLOAD_CMDS += -ex "target extended-remote localhost:$(GDB_PORT)"
GDB_UPLOAD_CMDS += -ex "monitor reset halt"
GDB_UPLOAD_CMDS += -ex "monitor flash protect 0 64 last off"
GDB_UPLOAD_CMDS += -ex "load"
GDB_UPLOAD_CMDS += -ex "monitor resume"
GDB_UPLOAD_CMDS += -ex "monitor shutdown"
GDB_UPLOAD_CMDS += -ex "quit"

upload:
	$(OPENOCD) $(OPENOCDARGS) & \
	$(GDB) image.elf $(GDB_UPLOAD_ARGS) $(GDB_UPLOAD_CMDS)

#############################################################
# This Section is for launching the debugger
#############################################################

debug:
	$(OPENOCD) $(OPENOCDARGS)
