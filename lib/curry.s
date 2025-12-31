	.syntax unified
	.thumb
	.arch armv8-m.main
	.fpu fpv5-sp-d16

@ OCaml register aliases
alloc_ptr	.req	r10
domain_state_ptr	.req	r11
trap_ptr	.req	r8

	.globl	caml_curry8
	.thumb
	.type	caml_curry8, %function
caml_curry8:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L194:
.L194:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L196
.L197:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L198 @ caml_curry8_1_app
	ldr	r4, .L199 @ caml_curry8_1
	movs	r5, #0x7
	movt	r5, #0x700
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L199:	.word	caml_curry8_1
.L198:	.word	caml_curry8_1_app
.L196:	bl	caml_call_gc
.L195:	b	.L197
	.cfi_endproc
	.type	caml_curry8, %function
	.size	caml_curry8, .-caml_curry8
	.text
	.align	2
	.globl	caml_curry8_1_app
	.thumb
	.type	caml_curry8_1_app, %function
caml_curry8_1_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L200:
.L200:
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L202
.L203:
	ldr	r1, [r7, #16]
	ldr	r6, [sp, #20]
	ldr	r12, [r1, #8]
	str	r1, [sp, #28]
	str	r12, [sp, #32]
	ldr	r12, [sp, #28]
	ldr	r1, [sp, #0]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #32]
	ldr	r5, [sp, #16]
	ldr	r4, [sp, #12]
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #4]
	ldr	r0, [r7, #12]
	ldr	r7, [sp, #24]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L202:	bl	caml_call_gc
.L201:	b	.L203
	.cfi_endproc
	.type	caml_curry8_1_app, %function
	.size	caml_curry8_1_app, .-caml_curry8_1_app
	.text
	.align	2
	.globl	caml_curry8_1
	.thumb
	.type	caml_curry8_1, %function
caml_curry8_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L204:
.L204:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L206
.L207:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L208 @ caml_curry8_2_app
	ldr	r4, .L209 @ caml_curry8_2
	movs	r5, #0x7
	movt	r5, #0x600
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L209:	.word	caml_curry8_2
.L208:	.word	caml_curry8_2_app
.L206:	bl	caml_call_gc
.L205:	b	.L207
	.cfi_endproc
	.type	caml_curry8_1, %function
	.size	caml_curry8_1, .-caml_curry8_1
	.text
	.align	2
	.globl	caml_curry8_2_app
	.thumb
	.type	caml_curry8_2_app, %function
caml_curry8_2_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L210:
.L210:
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L212
.L213:
	ldr	r12, [r6, #16]
	ldr	r7, [sp, #20]
	ldr	r2, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r12, [r2, #8]
	str	r2, [sp, #24]
	str	r12, [sp, #28]
	ldr	r12, [sp, #24]
	ldr	r2, [sp, #0]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #28]
	ldr	r5, [sp, #12]
	ldr	r4, [sp, #8]
	ldr	r3, [sp, #4]
	ldr	r1, [r6, #12]
	ldr	r6, [sp, #16]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L212:	bl	caml_call_gc
.L211:	b	.L213
	.cfi_endproc
	.type	caml_curry8_2_app, %function
	.size	caml_curry8_2_app, .-caml_curry8_2_app
	.text
	.align	2
	.globl	caml_curry8_2
	.thumb
	.type	caml_curry8_2, %function
caml_curry8_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L214:
.L214:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L216
.L217:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L218 @ caml_curry8_3_app
	ldr	r4, .L219 @ caml_curry8_3
	movs	r5, #0x7
	movt	r5, #0x500
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L219:	.word	caml_curry8_3
.L218:	.word	caml_curry8_3_app
.L216:	bl	caml_call_gc
.L215:	b	.L217
	.cfi_endproc
	.type	caml_curry8_2, %function
	.size	caml_curry8_2, .-caml_curry8_2
	.text
	.align	2
	.globl	caml_curry8_3_app
	.thumb
	.type	caml_curry8_3_app, %function
caml_curry8_3_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L220:
.L220:
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L222
.L223:
	ldr	r7, [r5, #16]
	ldr	r6, [sp, #12]
	ldr	r12, [r7, #16]
	ldr	r1, [r7, #12]
	ldr	r3, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r12, [r3, #8]
	str	r3, [sp, #20]
	str	r12, [sp, #24]
	ldr	r12, [sp, #20]
	ldr	r3, [sp, #0]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #24]
	ldr	r7, [sp, #16]
	ldr	r4, [sp, #4]
	ldr	r2, [r5, #12]
	ldr	r5, [sp, #8]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L222:	bl	caml_call_gc
.L221:	b	.L223
	.cfi_endproc
	.type	caml_curry8_3_app, %function
	.size	caml_curry8_3_app, .-caml_curry8_3_app
	.text
	.align	2
	.globl	caml_curry8_3
	.thumb
	.type	caml_curry8_3, %function
caml_curry8_3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L224:
.L224:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L226
.L227:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L228 @ caml_curry8_4_app
	ldr	r4, .L229 @ caml_curry8_4
	movs	r5, #0x7
	movt	r5, #0x400
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L229:	.word	caml_curry8_4
.L228:	.word	caml_curry8_4_app
.L226:	bl	caml_call_gc
.L225:	b	.L227
	.cfi_endproc
	.type	caml_curry8_3, %function
	.size	caml_curry8_3, .-caml_curry8_3
	.text
	.align	2
	.globl	caml_curry8_4_app
	.thumb
	.type	caml_curry8_4_app, %function
caml_curry8_4_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L230:
.L230:
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L232
.L233:
	ldr	r12, [r4, #16]
	ldr	r7, [sp, #12]
	ldr	r0, [r12, #16]
	ldr	r2, [r12, #12]
	ldr	r5, [r0, #16]
	ldr	r1, [r0, #12]
	ldr	r6, [r5, #16]
	ldr	r0, [r5, #12]
	ldr	r12, [r6, #8]
	str	r6, [sp, #16]
	str	r12, [sp, #20]
	ldr	r12, [sp, #16]
	ldr	r6, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #20]
	ldr	r5, [sp, #4]
	ldr	r3, [r4, #12]
	ldr	r4, [sp, #0]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L232:	bl	caml_call_gc
.L231:	b	.L233
	.cfi_endproc
	.type	caml_curry8_4_app, %function
	.size	caml_curry8_4_app, .-caml_curry8_4_app
	.text
	.align	2
	.globl	caml_curry8_4
	.thumb
	.type	caml_curry8_4, %function
caml_curry8_4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L234:
.L234:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L236
.L237:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L238 @ caml_curry8_5_app
	ldr	r4, .L239 @ caml_curry8_5
	movs	r5, #0x7
	movt	r5, #0x300
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L239:	.word	caml_curry8_5
.L238:	.word	caml_curry8_5_app
.L236:	bl	caml_call_gc
.L235:	b	.L237
	.cfi_endproc
	.type	caml_curry8_4, %function
	.size	caml_curry8_4, .-caml_curry8_4
	.text
	.align	2
	.globl	caml_curry8_5_app
	.thumb
	.type	caml_curry8_5_app, %function
caml_curry8_5_app:
	.cfi_startproc
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L240:
.L240:
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L242
.L243:
	ldr	r1, [r3, #16]
	ldr	r4, [r3, #12]
	ldr	r2, [r1, #16]
	ldr	r3, [r1, #12]
	ldr	r7, [r2, #16]
	ldr	r2, [r2, #12]
	ldr	r5, [r7, #16]
	ldr	r1, [r7, #12]
	ldr	r6, [r5, #16]
	ldr	r7, [sp, #8]
	ldr	r12, [r6, #8]
	str	r6, [sp, #12]
	str	r12, [sp, #16]
	ldr	r12, [sp, #12]
	ldr	r6, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #16]
	ldr	r0, [r5, #12]
	ldr	r5, [sp, #0]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	24
.L242:	bl	caml_call_gc
.L241:	b	.L243
	.cfi_endproc
	.type	caml_curry8_5_app, %function
	.size	caml_curry8_5_app, .-caml_curry8_5_app
	.text
	.align	2
	.globl	caml_curry8_5
	.thumb
	.type	caml_curry8_5, %function
caml_curry8_5:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L244:
.L244:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L246
.L247:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L248 @ caml_curry8_6_app
	ldr	r4, .L249 @ caml_curry8_6
	movs	r5, #0x7
	movt	r5, #0x200
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L249:	.word	caml_curry8_6
.L248:	.word	caml_curry8_6_app
.L246:	bl	caml_call_gc
.L245:	b	.L247
	.cfi_endproc
	.type	caml_curry8_5, %function
	.size	caml_curry8_5, .-caml_curry8_5
	.text
	.align	2
	.globl	caml_curry8_6_app
	.thumb
	.type	caml_curry8_6_app, %function
caml_curry8_6_app:
	.cfi_startproc
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L250:
.L250:
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L252
.L253:
	ldr	r4, [r2, #16]
	ldr	r5, [r2, #12]
	ldr	r0, [r4, #16]
	ldr	r4, [r4, #12]
	ldr	r1, [r0, #16]
	ldr	r3, [r0, #12]
	ldr	r6, [r1, #16]
	ldr	r2, [r1, #12]
	ldr	r7, [r6, #16]
	ldr	r1, [r6, #12]
	ldr	r12, [r7, #16]
	ldr	r6, [sp, #0]
	str	r12, [sp, #8]
	ldr	r12, [r12, #8]
	ldr	r0, [r7, #12]
	str	r12, [sp, #12]
	ldr	r12, [sp, #8]
	ldr	r7, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #12]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	24
.L252:	bl	caml_call_gc
.L251:	b	.L253
	.cfi_endproc
	.type	caml_curry8_6_app, %function
	.size	caml_curry8_6_app, .-caml_curry8_6_app
	.text
	.align	2
	.globl	caml_curry8_6
	.thumb
	.type	caml_curry8_6, %function
caml_curry8_6:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L254:
.L254:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L256
.L257:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L258 @ caml_curry8_7
	movs	r5, #0x5
	movt	r5, #0x100
	movw	r3, #0x10f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r0, [r2, #8]
	str	r1, [r2, #12]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L258:	.word	caml_curry8_7
.L256:	bl	caml_call_gc
.L255:	b	.L257
	.cfi_endproc
	.type	caml_curry8_6, %function
	.size	caml_curry8_6, .-caml_curry8_6
	.text
	.align	2
	.globl	caml_curry8_7
	.thumb
	.type	caml_curry8_7, %function
caml_curry8_7:
	.cfi_startproc
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L259:
.L259:
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L261
.L262:
	ldr	r5, [r1, #12]
	ldr	r6, [r1, #8]
	ldr	r2, [r5, #16]
	ldr	r5, [r5, #12]
	ldr	r3, [r2, #16]
	str	r5, [sp, #12]
	ldr	r7, [r3, #16]
	ldr	r5, [r2, #12]
	ldr	r12, [r7, #16]
	str	r6, [sp, #16]
	ldr	r0, [r12, #16]
	ldr	r1, [r12, #12]
	ldr	r4, [r0, #16]
	ldr	r0, [r0, #12]
	ldr	r12, [r4, #8]
	str	r4, [sp, #4]
	str	r12, [sp, #8]
	ldr	r12, [sp, #4]
	mov	r4, r5
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #8]
	ldr	r5, [sp, #12]
	ldr	r6, [sp, #16]
	ldr	r2, [r7, #12]
	ldr	r7, [sp, #0]
	ldr	r3, [r3, #12]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	24
.L261:	bl	caml_call_gc
.L260:	b	.L262
	.cfi_endproc
	.type	caml_curry8_7, %function
	.size	caml_curry8_7, .-caml_curry8_7
	.text
	.align	2
	.globl	caml_curry7
	.thumb
	.type	caml_curry7, %function
caml_curry7:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L263:
.L263:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L265
.L266:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L267 @ caml_curry7_1_app
	ldr	r4, .L268 @ caml_curry7_1
	movs	r5, #0x7
	movt	r5, #0x600
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L268:	.word	caml_curry7_1
.L267:	.word	caml_curry7_1_app
.L265:	bl	caml_call_gc
.L264:	b	.L266
	.cfi_endproc
	.type	caml_curry7, %function
	.size	caml_curry7, .-caml_curry7
	.text
	.align	2
	.globl	caml_curry7_1_app
	.thumb
	.type	caml_curry7_1_app, %function
caml_curry7_1_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L269:
.L269:
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L271
.L272:
	ldr	r7, [r6, #16]
	ldr	r5, [sp, #16]
	ldr	r12, [r7, #8]
	ldr	r4, [sp, #12]
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #4]
	ldr	r1, [sp, #0]
	ldr	r0, [r6, #12]
	ldr	r6, [sp, #20]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L271:	bl	caml_call_gc
.L270:	b	.L272
	.cfi_endproc
	.type	caml_curry7_1_app, %function
	.size	caml_curry7_1_app, .-caml_curry7_1_app
	.text
	.align	2
	.globl	caml_curry7_1
	.thumb
	.type	caml_curry7_1, %function
caml_curry7_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L273:
.L273:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L275
.L276:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L277 @ caml_curry7_2_app
	ldr	r4, .L278 @ caml_curry7_2
	movs	r5, #0x7
	movt	r5, #0x500
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L278:	.word	caml_curry7_2
.L277:	.word	caml_curry7_2_app
.L275:	bl	caml_call_gc
.L274:	b	.L276
	.cfi_endproc
	.type	caml_curry7_1, %function
	.size	caml_curry7_1, .-caml_curry7_1
	.text
	.align	2
	.globl	caml_curry7_2_app
	.thumb
	.type	caml_curry7_2_app, %function
caml_curry7_2_app:
	.cfi_startproc
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L279:
.L279:
	str	r4, [sp, #12]
	str	r3, [sp, #8]
	str	r2, [sp, #4]
	str	r1, [sp, #0]
	mov	r6, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L281
.L282:
	ldr	r12, [r5, #16]
	ldr	r4, [sp, #4]
	ldr	r7, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r12, [r7, #8]
	ldr	r3, [sp, #0]
	mov	r2, r6
	ldr	r6, [sp, #12]
	ldr	r1, [r5, #12]
	ldr	r5, [sp, #8]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	24
.L281:	bl	caml_call_gc
.L280:	b	.L282
	.cfi_endproc
	.type	caml_curry7_2_app, %function
	.size	caml_curry7_2_app, .-caml_curry7_2_app
	.text
	.align	2
	.globl	caml_curry7_2
	.thumb
	.type	caml_curry7_2, %function
caml_curry7_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L283:
.L283:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L285
.L286:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L287 @ caml_curry7_3_app
	ldr	r4, .L288 @ caml_curry7_3
	movs	r5, #0x7
	movt	r5, #0x400
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L288:	.word	caml_curry7_3
.L287:	.word	caml_curry7_3_app
.L285:	bl	caml_call_gc
.L284:	b	.L286
	.cfi_endproc
	.type	caml_curry7_2, %function
	.size	caml_curry7_2, .-caml_curry7_2
	.text
	.align	2
	.globl	caml_curry7_3_app
	.thumb
	.type	caml_curry7_3_app, %function
caml_curry7_3_app:
	.cfi_startproc
	sub	sp, sp, #0x10
	.cfi_adjust_cfa_offset	16
	.cfi_offset 14, -4
	str	lr, [sp, #12]
.L289:
.L289:
	str	r3, [sp, #4]
	str	r2, [sp, #0]
	mov	r6, r1
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L291
.L292:
	ldr	r12, [r4, #16]
	mov	r3, r5
	ldr	r0, [r12, #16]
	ldr	r1, [r12, #12]
	ldr	r7, [r0, #16]
	ldr	r0, [r0, #12]
	ldr	r12, [r7, #8]
	ldr	r5, [sp, #0]
	ldr	r2, [r4, #12]
	mov	r4, r6
	ldr	r6, [sp, #4]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	16
.L291:	bl	caml_call_gc
.L290:	b	.L292
	.cfi_endproc
	.type	caml_curry7_3_app, %function
	.size	caml_curry7_3_app, .-caml_curry7_3_app
	.text
	.align	2
	.globl	caml_curry7_3
	.thumb
	.type	caml_curry7_3, %function
caml_curry7_3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L293:
.L293:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L295
.L296:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L297 @ caml_curry7_4_app
	ldr	r4, .L298 @ caml_curry7_4
	movs	r5, #0x7
	movt	r5, #0x300
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L298:	.word	caml_curry7_4
.L297:	.word	caml_curry7_4_app
.L295:	bl	caml_call_gc
.L294:	b	.L296
	.cfi_endproc
	.type	caml_curry7_3, %function
	.size	caml_curry7_3, .-caml_curry7_3
	.text
	.align	2
	.globl	caml_curry7_4_app
	.thumb
	.type	caml_curry7_4_app, %function
caml_curry7_4_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L299:
.L299:
	mov	r6, r2
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L301
.L302:
	ldr	r2, [r3, #16]
	ldr	r3, [r3, #12]
	ldr	r0, [r2, #16]
	ldr	r2, [r2, #12]
	ldr	r12, [r0, #16]
	ldr	r1, [r0, #12]
	ldr	r7, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r12, [r7, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	8
.L301:	bl	caml_call_gc
.L300:	b	.L302
	.cfi_endproc
	.type	caml_curry7_4_app, %function
	.size	caml_curry7_4_app, .-caml_curry7_4_app
	.text
	.align	2
	.globl	caml_curry7_4
	.thumb
	.type	caml_curry7_4, %function
caml_curry7_4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L303:
.L303:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L305
.L306:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L307 @ caml_curry7_5_app
	ldr	r4, .L308 @ caml_curry7_5
	movs	r5, #0x7
	movt	r5, #0x200
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L308:	.word	caml_curry7_5
.L307:	.word	caml_curry7_5_app
.L305:	bl	caml_call_gc
.L304:	b	.L306
	.cfi_endproc
	.type	caml_curry7_4, %function
	.size	caml_curry7_4, .-caml_curry7_4
	.text
	.align	2
	.globl	caml_curry7_5_app
	.thumb
	.type	caml_curry7_5_app, %function
caml_curry7_5_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L309:
.L309:
	mov	r6, r1
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L311
.L312:
	ldr	r3, [r2, #16]
	ldr	r4, [r2, #12]
	ldr	r0, [r3, #16]
	ldr	r3, [r3, #12]
	ldr	r1, [r0, #16]
	ldr	r2, [r0, #12]
	ldr	r12, [r1, #16]
	ldr	r1, [r1, #12]
	ldr	r7, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r12, [r7, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	8
.L311:	bl	caml_call_gc
.L310:	b	.L312
	.cfi_endproc
	.type	caml_curry7_5_app, %function
	.size	caml_curry7_5_app, .-caml_curry7_5_app
	.text
	.align	2
	.globl	caml_curry7_5
	.thumb
	.type	caml_curry7_5, %function
caml_curry7_5:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L313:
.L313:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L315
.L316:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L317 @ caml_curry7_6
	movs	r5, #0x5
	movt	r5, #0x100
	movw	r3, #0x10f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r0, [r2, #8]
	str	r1, [r2, #12]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L317:	.word	caml_curry7_6
.L315:	bl	caml_call_gc
.L314:	b	.L316
	.cfi_endproc
	.type	caml_curry7_5, %function
	.size	caml_curry7_5, .-caml_curry7_5
	.text
	.align	2
	.globl	caml_curry7_6
	.thumb
	.type	caml_curry7_6, %function
caml_curry7_6:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L318:
.L318:
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L320
.L321:
	ldr	r4, [r1, #12]
	ldr	r6, [r1, #8]
	ldr	r0, [r4, #16]
	ldr	r5, [r4, #12]
	ldr	r2, [r0, #16]
	ldr	r4, [r0, #12]
	ldr	r12, [r2, #16]
	ldr	r2, [r2, #12]
	ldr	r3, [r12, #16]
	ldr	r1, [r12, #12]
	ldr	r7, [r3, #16]
	ldr	r0, [r3, #12]
	ldr	r12, [r7, #8]
	mov	r3, r4
	mov	r4, r5
	mov	r5, r6
	ldr	r6, [sp, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	8
.L320:	bl	caml_call_gc
.L319:	b	.L321
	.cfi_endproc
	.type	caml_curry7_6, %function
	.size	caml_curry7_6, .-caml_curry7_6
	.text
	.align	2
	.globl	caml_curry6
	.thumb
	.type	caml_curry6, %function
caml_curry6:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L322:
.L322:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L324
.L325:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L326 @ caml_curry6_1_app
	ldr	r4, .L327 @ caml_curry6_1
	movs	r5, #0x7
	movt	r5, #0x500
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L327:	.word	caml_curry6_1
.L326:	.word	caml_curry6_1_app
.L324:	bl	caml_call_gc
.L323:	b	.L325
	.cfi_endproc
	.type	caml_curry6, %function
	.size	caml_curry6, .-caml_curry6
	.text
	.align	2
	.globl	caml_curry6_1_app
	.thumb
	.type	caml_curry6_1_app, %function
caml_curry6_1_app:
	.cfi_startproc
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L328:
.L328:
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L330
.L331:
	ldr	r6, [r5, #16]
	ldr	r4, [sp, #12]
	ldr	r7, [r6, #8]
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #4]
	ldr	r1, [sp, #0]
	ldr	r0, [r5, #12]
	ldr	r5, [sp, #16]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	24
.L330:	bl	caml_call_gc
.L329:	b	.L331
	.cfi_endproc
	.type	caml_curry6_1_app, %function
	.size	caml_curry6_1_app, .-caml_curry6_1_app
	.text
	.align	2
	.globl	caml_curry6_1
	.thumb
	.type	caml_curry6_1, %function
caml_curry6_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L332:
.L332:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L334
.L335:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L336 @ caml_curry6_2_app
	ldr	r4, .L337 @ caml_curry6_2
	movs	r5, #0x7
	movt	r5, #0x400
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L337:	.word	caml_curry6_2
.L336:	.word	caml_curry6_2_app
.L334:	bl	caml_call_gc
.L333:	b	.L335
	.cfi_endproc
	.type	caml_curry6_1, %function
	.size	caml_curry6_1, .-caml_curry6_1
	.text
	.align	2
	.globl	caml_curry6_2_app
	.thumb
	.type	caml_curry6_2_app, %function
caml_curry6_2_app:
	.cfi_startproc
	sub	sp, sp, #0x10
	.cfi_adjust_cfa_offset	16
	.cfi_offset 14, -4
	str	lr, [sp, #12]
.L338:
.L338:
	str	r3, [sp, #8]
	str	r2, [sp, #4]
	str	r1, [sp, #0]
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L340
.L341:
	ldr	r7, [r4, #16]
	ldr	r3, [sp, #0]
	ldr	r6, [r7, #16]
	ldr	r0, [r7, #12]
	ldr	r7, [r6, #8]
	mov	r2, r5
	ldr	r5, [sp, #8]
	ldr	r1, [r4, #12]
	ldr	r4, [sp, #4]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	16
.L340:	bl	caml_call_gc
.L339:	b	.L341
	.cfi_endproc
	.type	caml_curry6_2_app, %function
	.size	caml_curry6_2_app, .-caml_curry6_2_app
	.text
	.align	2
	.globl	caml_curry6_2
	.thumb
	.type	caml_curry6_2, %function
caml_curry6_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L342:
.L342:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L344
.L345:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L346 @ caml_curry6_3_app
	ldr	r4, .L347 @ caml_curry6_3
	movs	r5, #0x7
	movt	r5, #0x300
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L347:	.word	caml_curry6_3
.L346:	.word	caml_curry6_3_app
.L344:	bl	caml_call_gc
.L343:	b	.L345
	.cfi_endproc
	.type	caml_curry6_2, %function
	.size	caml_curry6_2, .-caml_curry6_2
	.text
	.align	2
	.globl	caml_curry6_3_app
	.thumb
	.type	caml_curry6_3_app, %function
caml_curry6_3_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L348:
.L348:
	str	r2, [sp, #0]
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L350
.L351:
	ldr	r7, [r3, #16]
	ldr	r2, [r3, #12]
	ldr	r12, [r7, #16]
	ldr	r1, [r7, #12]
	ldr	r6, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r7, [r6, #8]
	mov	r3, r4
	mov	r4, r5
	ldr	r5, [sp, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	8
.L350:	bl	caml_call_gc
.L349:	b	.L351
	.cfi_endproc
	.type	caml_curry6_3_app, %function
	.size	caml_curry6_3_app, .-caml_curry6_3_app
	.text
	.align	2
	.globl	caml_curry6_3
	.thumb
	.type	caml_curry6_3, %function
caml_curry6_3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L352:
.L352:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L354
.L355:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L356 @ caml_curry6_4_app
	ldr	r4, .L357 @ caml_curry6_4
	movs	r5, #0x7
	movt	r5, #0x200
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L357:	.word	caml_curry6_4
.L356:	.word	caml_curry6_4_app
.L354:	bl	caml_call_gc
.L353:	b	.L355
	.cfi_endproc
	.type	caml_curry6_3, %function
	.size	caml_curry6_3, .-caml_curry6_3
	.text
	.align	2
	.globl	caml_curry6_4_app
	.thumb
	.type	caml_curry6_4_app, %function
caml_curry6_4_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L358:
.L358:
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L360
.L361:
	ldr	r1, [r2, #16]
	ldr	r3, [r2, #12]
	ldr	r7, [r1, #16]
	ldr	r2, [r1, #12]
	ldr	r0, [r7, #16]
	ldr	r1, [r7, #12]
	ldr	r6, [r0, #16]
	ldr	r0, [r0, #12]
	ldr	r7, [r6, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	8
.L360:	bl	caml_call_gc
.L359:	b	.L361
	.cfi_endproc
	.type	caml_curry6_4_app, %function
	.size	caml_curry6_4_app, .-caml_curry6_4_app
	.text
	.align	2
	.globl	caml_curry6_4
	.thumb
	.type	caml_curry6_4, %function
caml_curry6_4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L362:
.L362:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L364
.L365:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L366 @ caml_curry6_5
	movs	r5, #0x5
	movt	r5, #0x100
	movw	r3, #0x10f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r0, [r2, #8]
	str	r1, [r2, #12]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L366:	.word	caml_curry6_5
.L364:	bl	caml_call_gc
.L363:	b	.L365
	.cfi_endproc
	.type	caml_curry6_4, %function
	.size	caml_curry6_4, .-caml_curry6_4
	.text
	.align	2
	.globl	caml_curry6_5
	.thumb
	.type	caml_curry6_5, %function
caml_curry6_5:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L367:
.L367:
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L369
.L370:
	ldr	r2, [r1, #12]
	ldr	r4, [r1, #8]
	ldr	r12, [r2, #16]
	ldr	r3, [r2, #12]
	ldr	r0, [r12, #16]
	ldr	r2, [r12, #12]
	ldr	r7, [r0, #16]
	ldr	r1, [r0, #12]
	ldr	r6, [r7, #16]
	ldr	r0, [r7, #12]
	ldr	r7, [r6, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	8
.L369:	bl	caml_call_gc
.L368:	b	.L370
	.cfi_endproc
	.type	caml_curry6_5, %function
	.size	caml_curry6_5, .-caml_curry6_5
	.text
	.align	2
	.globl	caml_curry5
	.thumb
	.type	caml_curry5, %function
caml_curry5:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L371:
.L371:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L373
.L374:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L375 @ caml_curry5_1_app
	ldr	r4, .L376 @ caml_curry5_1
	movs	r5, #0x7
	movt	r5, #0x400
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L376:	.word	caml_curry5_1
.L375:	.word	caml_curry5_1_app
.L373:	bl	caml_call_gc
.L372:	b	.L374
	.cfi_endproc
	.type	caml_curry5, %function
	.size	caml_curry5, .-caml_curry5
	.text
	.align	2
	.globl	caml_curry5_1_app
	.thumb
	.type	caml_curry5_1_app, %function
caml_curry5_1_app:
	.cfi_startproc
	sub	sp, sp, #0x10
	.cfi_adjust_cfa_offset	16
	.cfi_offset 14, -4
	str	lr, [sp, #12]
.L377:
.L377:
	str	r3, [sp, #8]
	str	r2, [sp, #4]
	str	r1, [sp, #0]
	mov	r7, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L379
.L380:
	ldr	r5, [r4, #16]
	ldr	r3, [sp, #4]
	ldr	r6, [r5, #8]
	ldr	r2, [sp, #0]
	mov	r1, r7
	ldr	r0, [r4, #12]
	ldr	r4, [sp, #8]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	16
.L379:	bl	caml_call_gc
.L378:	b	.L380
	.cfi_endproc
	.type	caml_curry5_1_app, %function
	.size	caml_curry5_1_app, .-caml_curry5_1_app
	.text
	.align	2
	.globl	caml_curry5_1
	.thumb
	.type	caml_curry5_1, %function
caml_curry5_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L381:
.L381:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L383
.L384:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L385 @ caml_curry5_2_app
	ldr	r4, .L386 @ caml_curry5_2
	movs	r5, #0x7
	movt	r5, #0x300
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L386:	.word	caml_curry5_2
.L385:	.word	caml_curry5_2_app
.L383:	bl	caml_call_gc
.L382:	b	.L384
	.cfi_endproc
	.type	caml_curry5_1, %function
	.size	caml_curry5_1, .-caml_curry5_1
	.text
	.align	2
	.globl	caml_curry5_2_app
	.thumb
	.type	caml_curry5_2_app, %function
caml_curry5_2_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L387:
.L387:
	str	r2, [sp, #0]
	mov	r4, r1
	mov	r7, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L389
.L390:
	ldr	r6, [r3, #16]
	mov	r2, r7
	ldr	r5, [r6, #16]
	ldr	r0, [r6, #12]
	ldr	r6, [r5, #8]
	ldr	r1, [r3, #12]
	mov	r3, r4
	ldr	r4, [sp, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	8
.L389:	bl	caml_call_gc
.L388:	b	.L390
	.cfi_endproc
	.type	caml_curry5_2_app, %function
	.size	caml_curry5_2_app, .-caml_curry5_2_app
	.text
	.align	2
	.globl	caml_curry5_2
	.thumb
	.type	caml_curry5_2, %function
caml_curry5_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L391:
.L391:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L393
.L394:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L395 @ caml_curry5_3_app
	ldr	r4, .L396 @ caml_curry5_3
	movs	r5, #0x7
	movt	r5, #0x200
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L396:	.word	caml_curry5_3
.L395:	.word	caml_curry5_3_app
.L393:	bl	caml_call_gc
.L392:	b	.L394
	.cfi_endproc
	.type	caml_curry5_2, %function
	.size	caml_curry5_2, .-caml_curry5_2
	.text
	.align	2
	.globl	caml_curry5_3_app
	.thumb
	.type	caml_curry5_3_app, %function
caml_curry5_3_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L397:
.L397:
	mov	r4, r1
	mov	r3, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L399
.L400:
	ldr	r6, [r2, #16]
	ldr	r2, [r2, #12]
	ldr	r7, [r6, #16]
	ldr	r1, [r6, #12]
	ldr	r5, [r7, #16]
	ldr	r0, [r7, #12]
	ldr	r6, [r5, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	8
.L399:	bl	caml_call_gc
.L398:	b	.L400
	.cfi_endproc
	.type	caml_curry5_3_app, %function
	.size	caml_curry5_3_app, .-caml_curry5_3_app
	.text
	.align	2
	.globl	caml_curry5_3
	.thumb
	.type	caml_curry5_3, %function
caml_curry5_3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L401:
.L401:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L403
.L404:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L405 @ caml_curry5_4
	movs	r5, #0x5
	movt	r5, #0x100
	movw	r3, #0x10f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r0, [r2, #8]
	str	r1, [r2, #12]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L405:	.word	caml_curry5_4
.L403:	bl	caml_call_gc
.L402:	b	.L404
	.cfi_endproc
	.type	caml_curry5_3, %function
	.size	caml_curry5_3, .-caml_curry5_3
	.text
	.align	2
	.globl	caml_curry5_4
	.thumb
	.type	caml_curry5_4, %function
caml_curry5_4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L406:
.L406:
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L408
.L409:
	ldr	r6, [r1, #12]
	ldr	r3, [r1, #8]
	ldr	r7, [r6, #16]
	ldr	r2, [r6, #12]
	ldr	r12, [r7, #16]
	ldr	r1, [r7, #12]
	ldr	r5, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r6, [r5, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	8
.L408:	bl	caml_call_gc
.L407:	b	.L409
	.cfi_endproc
	.type	caml_curry5_4, %function
	.size	caml_curry5_4, .-caml_curry5_4
	.text
	.align	2
	.globl	caml_curry4
	.thumb
	.type	caml_curry4, %function
caml_curry4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L410:
.L410:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L412
.L413:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L414 @ caml_curry4_1_app
	ldr	r4, .L415 @ caml_curry4_1
	movs	r5, #0x7
	movt	r5, #0x300
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L415:	.word	caml_curry4_1
.L414:	.word	caml_curry4_1_app
.L412:	bl	caml_call_gc
.L411:	b	.L413
	.cfi_endproc
	.type	caml_curry4, %function
	.size	caml_curry4, .-caml_curry4
	.text
	.align	2
	.globl	caml_curry4_1_app
	.thumb
	.type	caml_curry4_1_app, %function
caml_curry4_1_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L416:
.L416:
	str	r2, [sp, #0]
	mov	r7, r1
	mov	r6, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L418
.L419:
	ldr	r4, [r3, #16]
	mov	r2, r7
	ldr	r5, [r4, #8]
	mov	r1, r6
	ldr	r0, [r3, #12]
	ldr	r3, [sp, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	8
.L418:	bl	caml_call_gc
.L417:	b	.L419
	.cfi_endproc
	.type	caml_curry4_1_app, %function
	.size	caml_curry4_1_app, .-caml_curry4_1_app
	.text
	.align	2
	.globl	caml_curry4_1
	.thumb
	.type	caml_curry4_1, %function
caml_curry4_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L420:
.L420:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L422
.L423:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L424 @ caml_curry4_2_app
	ldr	r4, .L425 @ caml_curry4_2
	movs	r5, #0x7
	movt	r5, #0x200
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L425:	.word	caml_curry4_2
.L424:	.word	caml_curry4_2_app
.L422:	bl	caml_call_gc
.L421:	b	.L423
	.cfi_endproc
	.type	caml_curry4_1, %function
	.size	caml_curry4_1, .-caml_curry4_1
	.text
	.align	2
	.globl	caml_curry4_2_app
	.thumb
	.type	caml_curry4_2_app, %function
caml_curry4_2_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L426:
.L426:
	mov	r3, r1
	mov	r6, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L428
.L429:
	ldr	r5, [r2, #16]
	ldr	r1, [r2, #12]
	ldr	r4, [r5, #16]
	ldr	r0, [r5, #12]
	ldr	r5, [r4, #8]
	mov	r2, r6
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	8
.L428:	bl	caml_call_gc
.L427:	b	.L429
	.cfi_endproc
	.type	caml_curry4_2_app, %function
	.size	caml_curry4_2_app, .-caml_curry4_2_app
	.text
	.align	2
	.globl	caml_curry4_2
	.thumb
	.type	caml_curry4_2, %function
caml_curry4_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L430:
.L430:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L432
.L433:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L434 @ caml_curry4_3
	movs	r5, #0x5
	movt	r5, #0x100
	movw	r3, #0x10f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r0, [r2, #8]
	str	r1, [r2, #12]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L434:	.word	caml_curry4_3
.L432:	bl	caml_call_gc
.L431:	b	.L433
	.cfi_endproc
	.type	caml_curry4_2, %function
	.size	caml_curry4_2, .-caml_curry4_2
	.text
	.align	2
	.globl	caml_curry4_3
	.thumb
	.type	caml_curry4_3, %function
caml_curry4_3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L435:
.L435:
	mov	r3, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L437
.L438:
	ldr	r5, [r1, #12]
	ldr	r2, [r1, #8]
	ldr	r6, [r5, #16]
	ldr	r1, [r5, #12]
	ldr	r4, [r6, #16]
	ldr	r0, [r6, #12]
	ldr	r5, [r4, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	8
.L437:	bl	caml_call_gc
.L436:	b	.L438
	.cfi_endproc
	.type	caml_curry4_3, %function
	.size	caml_curry4_3, .-caml_curry4_3
	.text
	.align	2
	.globl	caml_curry3
	.thumb
	.type	caml_curry3, %function
caml_curry3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L439:
.L439:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L441
.L442:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L443 @ caml_curry3_1_app
	ldr	r4, .L444 @ caml_curry3_1
	movs	r5, #0x7
	movt	r5, #0x200
	movw	r3, #0x14f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r6, [r2, #8]
	str	r0, [r2, #12]
	str	r1, [r2, #16]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L444:	.word	caml_curry3_1
.L443:	.word	caml_curry3_1_app
.L441:	bl	caml_call_gc
.L440:	b	.L442
	.cfi_endproc
	.type	caml_curry3, %function
	.size	caml_curry3, .-caml_curry3
	.text
	.align	2
	.globl	caml_curry3_1_app
	.thumb
	.type	caml_curry3_1_app, %function
caml_curry3_1_app:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L445:
.L445:
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L447
.L448:
	ldr	r3, [r2, #16]
	mov	r1, r4
	ldr	r6, [r3, #8]
	ldr	r0, [r2, #12]
	mov	r2, r5
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	8
.L447:	bl	caml_call_gc
.L446:	b	.L448
	.cfi_endproc
	.type	caml_curry3_1_app, %function
	.size	caml_curry3_1_app, .-caml_curry3_1_app
	.text
	.align	2
	.globl	caml_curry3_1
	.thumb
	.type	caml_curry3_1, %function
caml_curry3_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L449:
.L449:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L451
.L452:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L453 @ caml_curry3_2
	movs	r5, #0x5
	movt	r5, #0x100
	movw	r3, #0x10f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r0, [r2, #8]
	str	r1, [r2, #12]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L453:	.word	caml_curry3_2
.L451:	bl	caml_call_gc
.L450:	b	.L452
	.cfi_endproc
	.type	caml_curry3_1, %function
	.size	caml_curry3_1, .-caml_curry3_1
	.text
	.align	2
	.globl	caml_curry3_2
	.thumb
	.type	caml_curry3_2, %function
caml_curry3_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L454:
.L454:
	mov	r2, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L456
.L457:
	ldr	r4, [r1, #12]
	ldr	r1, [r1, #8]
	ldr	r3, [r4, #16]
	ldr	r0, [r4, #12]
	ldr	r6, [r3, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	8
.L456:	bl	caml_call_gc
.L455:	b	.L457
	.cfi_endproc
	.type	caml_curry3_2, %function
	.size	caml_curry3_2, .-caml_curry3_2
	.text
	.align	2
	.globl	caml_curry2
	.thumb
	.type	caml_curry2, %function
caml_curry2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L458:
.L458:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L460
.L461:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L462 @ caml_curry2_1
	movs	r5, #0x5
	movt	r5, #0x100
	movw	r3, #0x10f7
	str	r3, [r2, #-4]
	str	r4, [r2, #0]
	str	r5, [r2, #4]
	str	r0, [r2, #8]
	str	r1, [r2, #12]
	mov	r0, r2
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	bx	lr
	.cfi_adjust_cfa_offset	8
	.align	2
.L462:	.word	caml_curry2_1
.L460:	bl	caml_call_gc
.L459:	b	.L461
	.cfi_endproc
	.type	caml_curry2, %function
	.size	caml_curry2, .-caml_curry2
	.text
	.align	2
	.globl	caml_curry2_1
	.thumb
	.type	caml_curry2_1, %function
caml_curry2_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L463:
.L463:
	mov	r3, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L465
.L466:
	ldr	r2, [r1, #12]
	ldr	r0, [r1, #8]
	ldr	r4, [r2, #8]
	mov	r1, r3
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r4
	.cfi_adjust_cfa_offset	8
.L465:	bl	caml_call_gc
.L464:	b	.L466
	.cfi_endproc
	.type	caml_curry2_1, %function
	.size	caml_curry2_1, .-caml_curry2_1
	.text
	.align	2
	.globl	caml_tuplify2
	.thumb
	.type	caml_tuplify2, %function
caml_tuplify2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L467:
.L467:
	mov	r2, r1
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L469
.L470:
	ldr	r4, [r2, #8]
	ldr	r1, [r0, #4]
	ldr	r0, [r0, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r4
	.cfi_adjust_cfa_offset	8
.L469:	bl	caml_call_gc
.L468:	b	.L470
	.cfi_endproc
	.type	caml_tuplify2, %function
	.size	caml_tuplify2, .-caml_tuplify2
	.text
	.align	2
	.globl	caml_tuplify3
	.thumb
	.type	caml_tuplify3, %function
caml_tuplify3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L471:
.L471:
	mov	r3, r1
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L473
.L474:
	ldr	r5, [r3, #8]
	ldr	r1, [r0, #4]
	ldr	r2, [r0, #8]
	ldr	r0, [r0, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	8
.L473:	bl	caml_call_gc
.L472:	b	.L474
	.cfi_endproc
	.type	caml_tuplify3, %function
	.size	caml_tuplify3, .-caml_tuplify3
	.text
	.align	2
	.globl	caml_tuplify4
	.thumb
	.type	caml_tuplify4, %function
caml_tuplify4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L475:
.L475:
	mov	r4, r1
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L477
.L478:
	ldr	r5, [r4, #8]
	ldr	r1, [r0, #4]
	ldr	r2, [r0, #8]
	ldr	r3, [r0, #12]
	ldr	r0, [r0, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	8
.L477:	bl	caml_call_gc
.L476:	b	.L478
	.cfi_endproc
	.type	caml_tuplify4, %function
	.size	caml_tuplify4, .-caml_tuplify4
	.text
	.align	2
	.globl	caml_apply8
	.thumb
	.type	caml_apply8, %function
.L481:
	movs	r12, #0x26
	push	{r12, lr}
	bl	caml_call_realloc_stack
	pop	{r12, lr}
caml_apply8:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x170
	cmp	sp, r12
	bcc	.L481
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L480:
.L480:
	str	r1, [sp, #8]
	ldr	r1, [domain_state_ptr, #520]
	str	r2, [sp, #12]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	asrs	r2, r2, #24
	str	r6, [sp, #28]
	str	r5, [sp, #24]
	str	r4, [sp, #20]
	str	r3, [sp, #16]
	str	r0, [sp, #4]
	cmp	r2, #8
	bne	.L479
	ldr	r12, [r1, #8]
	str	r1, [sp, #0]
	str	r12, [sp, #36]
	ldr	r12, [sp, #0]
	ldr	r1, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #36]
	ldr	r7, [sp, #32]
	ldr	r6, [sp, #28]
	ldr	r5, [sp, #24]
	ldr	r4, [sp, #20]
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #12]
	ldr	r0, [sp, #4]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	48
.L479:
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #4]
	str	r3, [sp, #0]
	ldr	r2, [sp, #0]
	blx	r2
.L482:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #8]
	blx	r5
.L483:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #12]
	blx	r7
.L484:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #16]
	blx	r2
.L485:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #20]
	blx	r2
.L486:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #24]
	blx	r4
.L487:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #28]
	blx	r6
.L488:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #32]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	48
	.cfi_endproc
	.type	caml_apply8, %function
	.size	caml_apply8, .-caml_apply8
	.text
	.align	2
	.globl	caml_apply7
	.thumb
	.type	caml_apply7, %function
.L491:
	movs	r12, #0x24
	push	{r12, lr}
	bl	caml_call_realloc_stack
	pop	{r12, lr}
caml_apply7:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x160
	cmp	sp, r12
	bcc	.L491
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L490:
.L490:
	ldr	r12, [r7, #4]
	asrs	r12, r12, #24
	cmp	r12, #7
	bne	.L489
	ldr	r12, [r7, #8]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L489:
	str	r2, [sp, #4]
	ldr	r2, [r7, #0]
	str	r1, [sp, #0]
	mov	r1, r7
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	str	r5, [sp, #16]
	str	r6, [sp, #20]
	blx	r2
.L492:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #0]
	blx	r4
.L493:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #4]
	blx	r6
.L494:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #8]
	blx	r12
.L495:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #12]
	blx	r2
.L496:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #16]
	blx	r3
.L497:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #20]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	32
	.cfi_endproc
	.type	caml_apply7, %function
	.size	caml_apply7, .-caml_apply7
	.text
	.align	2
	.globl	caml_apply6
	.thumb
	.type	caml_apply6, %function
.L500:
	movs	r12, #0x23
	push	{r12, lr}
	bl	caml_call_realloc_stack
	pop	{r12, lr}
caml_apply6:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x158
	cmp	sp, r12
	bcc	.L500
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L499:
.L499:
	ldr	r12, [r6, #4]
	asrs	r7, r12, #24
	cmp	r7, #6
	bne	.L498
	ldr	r7, [r6, #8]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	24
.L498:
	str	r2, [sp, #4]
	ldr	r2, [r6, #0]
	str	r1, [sp, #0]
	mov	r1, r6
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	str	r5, [sp, #16]
	blx	r2
.L501:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #0]
	blx	r3
.L502:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #4]
	blx	r5
.L503:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #8]
	blx	r7
.L504:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #12]
	blx	r2
.L505:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #16]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r2
	.cfi_adjust_cfa_offset	24
	.cfi_endproc
	.type	caml_apply6, %function
	.size	caml_apply6, .-caml_apply6
	.text
	.align	2
	.globl	caml_apply5
	.thumb
	.type	caml_apply5, %function
.L508:
	movs	r12, #0x23
	push	{r12, lr}
	bl	caml_call_realloc_stack
	pop	{r12, lr}
caml_apply5:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x158
	cmp	sp, r12
	bcc	.L508
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L507:
.L507:
	ldr	r7, [r5, #4]
	asrs	r12, r7, #24
	cmp	r12, #5
	bne	.L506
	ldr	r6, [r5, #8]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	24
.L506:
	str	r2, [sp, #4]
	ldr	r2, [r5, #0]
	str	r1, [sp, #0]
	mov	r1, r5
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	blx	r2
.L509:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #0]
	blx	r2
.L510:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #4]
	blx	r4
.L511:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #8]
	blx	r6
.L512:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #12]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	24
	.cfi_endproc
	.type	caml_apply5, %function
	.size	caml_apply5, .-caml_apply5
	.text
	.align	2
	.globl	caml_apply4
	.thumb
	.type	caml_apply4, %function
.L515:
	movs	r12, #0x22
	push	{r12, lr}
	bl	caml_call_realloc_stack
	pop	{r12, lr}
caml_apply4:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x150
	cmp	sp, r12
	bcc	.L515
	sub	sp, sp, #0x10
	.cfi_adjust_cfa_offset	16
	.cfi_offset 14, -4
	str	lr, [sp, #12]
.L514:
.L514:
	ldr	r6, [r4, #4]
	asrs	r7, r6, #24
	cmp	r7, #4
	bne	.L513
	ldr	r5, [r4, #8]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	16
.L513:
	ldr	r12, [r4, #0]
	str	r1, [sp, #0]
	mov	r1, r4
	str	r2, [sp, #4]
	str	r3, [sp, #8]
	blx	r12
.L516:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #0]
	blx	r2
.L517:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #4]
	blx	r3
.L518:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #8]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	16
	.cfi_endproc
	.type	caml_apply4, %function
	.size	caml_apply4, .-caml_apply4
	.text
	.align	2
	.globl	caml_apply3
	.thumb
	.type	caml_apply3, %function
.L521:
	movs	r12, #0x22
	push	{r12, lr}
	bl	caml_call_realloc_stack
	pop	{r12, lr}
caml_apply3:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x150
	cmp	sp, r12
	bcc	.L521
	sub	sp, sp, #0x10
	.cfi_adjust_cfa_offset	16
	.cfi_offset 14, -4
	str	lr, [sp, #12]
.L520:
.L520:
	ldr	r4, [r3, #4]
	asrs	r5, r4, #24
	cmp	r5, #3
	bne	.L519
	ldr	r4, [r3, #8]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r4
	.cfi_adjust_cfa_offset	16
.L519:
	ldr	r6, [r3, #0]
	str	r1, [sp, #0]
	mov	r1, r3
	str	r2, [sp, #4]
	blx	r6
.L522:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #0]
	blx	r12
.L523:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #4]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r2
	.cfi_adjust_cfa_offset	16
	.cfi_endproc
	.type	caml_apply3, %function
	.size	caml_apply3, .-caml_apply3
	.text
	.align	2
	.globl	caml_apply2
	.thumb
	.type	caml_apply2, %function
.L526:
	movs	r12, #0x21
	push	{r12, lr}
	bl	caml_call_realloc_stack
	pop	{r12, lr}
caml_apply2:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x148
	cmp	sp, r12
	bcc	.L526
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L525:
.L525:
	ldr	r3, [r2, #4]
	asrs	r4, r3, #24
	cmp	r4, #2
	bne	.L524
	ldr	r12, [r2, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	8
.L524:
	ldr	r5, [r2, #0]
	str	r1, [sp, #0]
	mov	r1, r2
	blx	r5
.L527:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	8
	.cfi_endproc
	.type	caml_apply2, %function
	.size	caml_apply2, .-caml_apply2
