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
.section .isr_vector
.align 8

.global IV

IV:
    j isr_synctrap
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_vmsi
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_vmti
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_vmei
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_empty
    .align 2
    j isr_irq0
    .align 2
    j isr_irq1
    .align 2
    j isr_irq2
    .align 2
    j isr_irq3
    .align 2
    j isr_irq4
    .align 2
    j isr_irq5
    .align 2
    j isr_irq6
    .align 2
    j isr_irq7
    .align 2
    j isr_irq8
    .align 2
    j isr_irq9
    .align 2
    j isr_irq10
    .align 2
    j isr_irq11
    .align 2
    j isr_irq12
    .align 2
    j isr_irq13
    .align 2
    j isr_irq14
    .align 2
    j isr_irq15
    .align 2

     
