/**
 * RISC-V bootup test
 * Author: Daniele Lacamera <root@danielinux.net>
 *
 * MIT License
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <stdint.h>

extern uint32_t  _stored_data;
extern uint32_t  _start_data;
extern uint32_t  _end_data;
extern uint32_t  _start_bss;
extern uint32_t  _end_bss;
extern uint32_t  _end_stack;
extern uint32_t  _start_heap;
extern uint32_t  _global_pointer;

static int zeroed_variable_in_bss;
static int initialized_variable_in_data = 42;

static inline void _trap_entry(void)
{
    /* Move stack pointer down 16 words */
    asm volatile ("addi sp, sp, -64\n");
    /* Save registers in the stack */
    asm volatile ("sw x1, 0(sp)\n"); 
    asm volatile ("sw x5, 4(sp)"); 
    asm volatile ("sw x6, 8(sp)"); 
    asm volatile ("sw x7, 12(sp)"); 
    asm volatile ("sw x10, 16(sp)"); 
    asm volatile ("sw x11, 20(sp)"); 
    asm volatile ("sw x12, 24(sp)"); 
    asm volatile ("sw x13, 28(sp)"); 
    asm volatile ("sw x14, 32(sp)"); 
    asm volatile ("sw x15, 36(sp)"); 
    asm volatile ("sw x16, 40(sp)"); 
    asm volatile ("sw x17, 44(sp)"); 
    asm volatile ("sw x28, 48(sp)"); 
    asm volatile ("sw x29, 52(sp)"); 
    asm volatile ("sw x30, 56(sp)"); 
    asm volatile ("sw x31, 60(sp)"); 
}

extern void main(void);
void __attribute__((section(".init"))) _reset(void) {
    register uint32_t *src, *dst;
    asm volatile("la gp, _global_pointer");
    asm volatile("la sp, _end_stack");

    src = (uint32_t *) &_stored_data;
    dst = (uint32_t *) &_start_data;
    /* Copy the .data section from flash to RAM. */
    while (dst < (uint32_t *)&_end_data) {
        *dst = *src;
        dst++;
        src++;
    }

    /* Initialize the BSS section to 0 */
    dst = &_start_bss;
    while (dst < (uint32_t *)&_end_bss) {
        *dst = 0U;
        dst++;
    }

    /* Run the program! */
    main();
}

void isr_empty(void)
{
    /* Ignore the event and continue */
}

void __attribute__((weak)) isr_synctrap(void)
{
    /* panic */
    while(1);
}

void __attribute__((weak)) isr_vmsi(void)
{
    /* panic */
    while(1);
}

void __attribute__((weak)) isr_vmti(void)
{
    /* panic */
    while(1);
}

void __attribute__((weak)) isr_vmei(void)
{
    /* panic */
    while(1);
}

void __attribute__((weak)) isr_irq0(void)
{
    /* panic */
    while(1);
}

void __attribute__((weak)) isr_irq1(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq2(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq3(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq4(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq5(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq6(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq7(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq8(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq9(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq10(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq11(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq12(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq13(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq14(void)
{
    /* panic */
    while(1);
}
void __attribute__((weak)) isr_irq15(void)
{
    /* panic */
    while(1);
}

__attribute__ ((section(".isr_vector")))
void (* const IV[])(void) =
{
	isr_synctrap,                   // Reset
	0,                              
	0,                   
    isr_vmsi,
    0,
    0,
    0,
    isr_vmti,
    0,
    0,
    0,
    isr_vmei,
    0,
    0,
    0,
    0,
    isr_irq0,
    isr_irq1,
    isr_irq2,
    isr_irq3,
    isr_irq4,
    isr_irq5,
    isr_irq6,
    isr_irq7,
    isr_irq8,
    isr_irq9,
    isr_irq10,
    isr_irq11,
    isr_irq12,
    isr_irq13,
    isr_irq14,
    isr_irq15
};
