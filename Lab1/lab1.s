
	area tcd,code,readonly
	export __main
		
__main
		ldr r2, =totals
		
		mov r0, #5 ; input of 5
		bl fact
		str r0, [r2]
		str r1, [r2, #4]
		
		mov r0, #14
		bl fact
		str r0, [r2, #8]
		str r1, [r2, #12]		
		
		mov r0, #20
		bl fact
		str r0, [r2, #16]
		str r1, [r2, #20]
		
		mov r0, #30
		bl fact
		str r0, [r2, #24]
		str r1, [r2, #28]
	
stop	B stop
	
; Factorial Subroutine
; R0 in - 32bit factorial in
; r0 out- MSB 32bit output
; r1 out- LSB 32bit output

fact
		stmfd sp!,{r2-r12,lr}
		
		cmp r0, #1
		ble endfact
		
		;cmp r0, #21
		;bge errorfact
		
		mov r4, r0
		sub r0, r0, #1
		bl fact
		mov r5, #0
		mov r3, r0
		mov r2, r1
		
		umull r1, r6, r2, r4
		umull r7, r8, r3, r4
		umull r4, r5, r2, r5
		adds r2, r7, r4
		;BHS errorfact
		adcs r0, r2, r6
		
		ldmfd sp!,{r2-r12,lr}
		bx lr
endfact
		mov R0, #0
		mov R1, #1
		
		ldmfd sp!, {r2-r12,lr}
		bx lr
errorfact
		mrs r0, cpsr
		ldr r1, =0x10000000
		orr r0, r1
		msr cpsr_f, r0
		ldr r0, =0
		ldr r1, =0
		
		ldmfd sp!, {r2-r12,lr}
		bx lr

		area tcddata, data, readwrite
totals	space	32

		end