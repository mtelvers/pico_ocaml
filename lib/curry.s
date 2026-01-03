	.syntax unified
	.thumb
	.arch armv8-m.main
	.fpu softvfp

@ OCaml register aliases
alloc_ptr	.req	r10
domain_state_ptr	.req	r11
trap_ptr	.req	r8

	.text
	.align	2
	.globl	caml_curry11
	.thumb
	.type	caml_curry11, %function
caml_curry11:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L221:
.L221:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L223
.L224:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L225 @ caml_curry11_1_app
	ldr	r4, .L226 @ caml_curry11_1
	movs	r5, #0x7 @ 0xa000007
	adds	r5, r5, #0xa000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L226:	.word	caml_curry11_1
.L225:	.word	caml_curry11_1_app
.L223:	bl	caml_call_gc(PLT)
.L222:	b	.L224
	.cfi_endproc
	.type	caml_curry11, %function
	.size	caml_curry11, .-caml_curry11
	.text
	.align	2
	.globl	caml_curry11_1_app
	.thumb
	.type	caml_curry11_1_app, %function
caml_curry11_1_app:
	.cfi_startproc
	sub	sp, sp, #0x38
	.cfi_adjust_cfa_offset	56
	.cfi_offset 14, -4
	str	lr, [sp, #52]
.L227:
.L227:
	str	r4, [sp, #16]
	ldr	r4, [domain_state_ptr, #524]
	str	r3, [sp, #12]
	ldr	r3, [domain_state_ptr, #520]
	str	r3, [sp, #32]
	str	r4, [sp, #36]
	str	r7, [sp, #28]
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	ldr	r5, [domain_state_ptr, #528]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L229
.L230:
	ldr	r6, [r5, #16]
	ldr	r7, [sp, #24]
	ldr	r12, [r6, #8]
	str	r6, [sp, #40]
	str	r12, [sp, #44]
	ldr	r12, [sp, #28]
	ldr	r6, [sp, #20]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #32]
	ldr	r4, [sp, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #36]
	ldr	r3, [sp, #8]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #40]
	ldr	r2, [sp, #4]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #44]
	ldr	r1, [sp, #0]
	ldr	r0, [r5, #12]
	ldr	r5, [sp, #16]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	56
.L229:	bl	caml_call_gc(PLT)
.L228:	b	.L230
	.cfi_endproc
	.type	caml_curry11_1_app, %function
	.size	caml_curry11_1_app, .-caml_curry11_1_app
	.text
	.align	2
	.globl	caml_curry11_1
	.thumb
	.type	caml_curry11_1, %function
caml_curry11_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L231:
.L231:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L233
.L234:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L235 @ caml_curry11_2_app
	ldr	r4, .L236 @ caml_curry11_2
	movs	r5, #0x7 @ 0x9000007
	adds	r5, r5, #0x9000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L236:	.word	caml_curry11_2
.L235:	.word	caml_curry11_2_app
.L233:	bl	caml_call_gc(PLT)
.L232:	b	.L234
	.cfi_endproc
	.type	caml_curry11_1, %function
	.size	caml_curry11_1, .-caml_curry11_1
	.text
	.align	2
	.globl	caml_curry11_2_app
	.thumb
	.type	caml_curry11_2_app, %function
caml_curry11_2_app:
	.cfi_startproc
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L237:
.L237:
	str	r3, [sp, #12]
	ldr	r3, [domain_state_ptr, #520]
	str	r3, [sp, #32]
	str	r7, [sp, #28]
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	ldr	r4, [domain_state_ptr, #524]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L239
.L240:
	ldr	r5, [r4, #16]
	ldr	r7, [sp, #20]
	ldr	r6, [r5, #16]
	ldr	r0, [r5, #12]
	ldr	r12, [r6, #8]
	str	r6, [sp, #36]
	str	r12, [sp, #40]
	ldr	r12, [sp, #24]
	ldr	r6, [sp, #16]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #28]
	ldr	r5, [sp, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #32]
	ldr	r3, [sp, #4]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #36]
	ldr	r2, [sp, #0]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #40]
	ldr	r1, [r4, #12]
	ldr	r4, [sp, #8]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	48
.L239:	bl	caml_call_gc(PLT)
.L238:	b	.L240
	.cfi_endproc
	.type	caml_curry11_2_app, %function
	.size	caml_curry11_2_app, .-caml_curry11_2_app
	.text
	.align	2
	.globl	caml_curry11_2
	.thumb
	.type	caml_curry11_2, %function
caml_curry11_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L241:
.L241:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L243
.L244:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L245 @ caml_curry11_3_app
	ldr	r4, .L246 @ caml_curry11_3
	movs	r5, #0x7 @ 0x8000007
	adds	r5, r5, #0x8000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L246:	.word	caml_curry11_3
.L245:	.word	caml_curry11_3_app
.L243:	bl	caml_call_gc(PLT)
.L242:	b	.L244
	.cfi_endproc
	.type	caml_curry11_2, %function
	.size	caml_curry11_2, .-caml_curry11_2
	.text
	.align	2
	.globl	caml_curry11_3_app
	.thumb
	.type	caml_curry11_3_app, %function
caml_curry11_3_app:
	.cfi_startproc
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L247:
.L247:
	str	r7, [sp, #28]
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	ldr	r3, [domain_state_ptr, #520]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L249
.L250:
	ldr	r4, [r3, #16]
	ldr	r7, [sp, #16]
	ldr	r5, [r4, #16]
	ldr	r1, [r4, #12]
	ldr	r6, [r5, #16]
	ldr	r4, [sp, #4]
	ldr	r12, [r6, #8]
	str	r6, [sp, #32]
	str	r12, [sp, #36]
	ldr	r12, [sp, #20]
	ldr	r6, [sp, #12]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #24]
	ldr	r0, [r5, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #28]
	ldr	r5, [sp, #8]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #32]
	ldr	r2, [r3, #12]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #36]
	ldr	r3, [sp, #0]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	48
.L249:	bl	caml_call_gc(PLT)
.L248:	b	.L250
	.cfi_endproc
	.type	caml_curry11_3_app, %function
	.size	caml_curry11_3_app, .-caml_curry11_3_app
	.text
	.align	2
	.globl	caml_curry11_3
	.thumb
	.type	caml_curry11_3, %function
caml_curry11_3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L251:
.L251:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L253
.L254:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L255 @ caml_curry11_4_app
	ldr	r4, .L256 @ caml_curry11_4
	movs	r5, #0x7 @ 0x7000007
	adds	r5, r5, #0x7000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L256:	.word	caml_curry11_4
.L255:	.word	caml_curry11_4_app
.L253:	bl	caml_call_gc(PLT)
.L252:	b	.L254
	.cfi_endproc
	.type	caml_curry11_3, %function
	.size	caml_curry11_3, .-caml_curry11_3
	.text
	.align	2
	.globl	caml_curry11_4_app
	.thumb
	.type	caml_curry11_4_app, %function
caml_curry11_4_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L257:
.L257:
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L259
.L260:
	ldr	r5, [r7, #16]
	ldr	r3, [r7, #12]
	ldr	r6, [r5, #16]
	ldr	r7, [sp, #12]
	ldr	r12, [r6, #16]
	ldr	r1, [r6, #12]
	ldr	r4, [r12, #16]
	ldr	r0, [r12, #12]
	ldr	r12, [r4, #8]
	str	r4, [sp, #28]
	str	r12, [sp, #32]
	ldr	r12, [sp, #16]
	ldr	r4, [sp, #0]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #20]
	ldr	r6, [sp, #8]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #24]
	ldr	r2, [r5, #12]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #28]
	ldr	r5, [sp, #4]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #32]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L259:	bl	caml_call_gc(PLT)
.L258:	b	.L260
	.cfi_endproc
	.type	caml_curry11_4_app, %function
	.size	caml_curry11_4_app, .-caml_curry11_4_app
	.text
	.align	2
	.globl	caml_curry11_4
	.thumb
	.type	caml_curry11_4, %function
caml_curry11_4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L261:
.L261:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L263
.L264:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L265 @ caml_curry11_5_app
	ldr	r4, .L266 @ caml_curry11_5
	movs	r5, #0x7 @ 0x6000007
	adds	r5, r5, #0x6000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L266:	.word	caml_curry11_5
.L265:	.word	caml_curry11_5_app
.L263:	bl	caml_call_gc(PLT)
.L262:	b	.L264
	.cfi_endproc
	.type	caml_curry11_4, %function
	.size	caml_curry11_4, .-caml_curry11_4
	.text
	.align	2
	.globl	caml_curry11_5_app
	.thumb
	.type	caml_curry11_5_app, %function
caml_curry11_5_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L267:
.L267:
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L269
.L270:
	ldr	r12, [r6, #16]
	ldr	r4, [r6, #12]
	ldr	r0, [r12, #16]
	ldr	r3, [r12, #12]
	ldr	r1, [r0, #16]
	ldr	r2, [r0, #12]
	ldr	r5, [r1, #16]
	ldr	r1, [r1, #12]
	ldr	r7, [r5, #16]
	ldr	r0, [r5, #12]
	ldr	r12, [r7, #8]
	str	r7, [sp, #24]
	str	r12, [sp, #28]
	ldr	r12, [sp, #12]
	ldr	r7, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #16]
	ldr	r5, [sp, #0]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #20]
	ldr	r6, [sp, #4]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #24]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #28]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L269:	bl	caml_call_gc(PLT)
.L268:	b	.L270
	.cfi_endproc
	.type	caml_curry11_5_app, %function
	.size	caml_curry11_5_app, .-caml_curry11_5_app
	.text
	.align	2
	.globl	caml_curry11_5
	.thumb
	.type	caml_curry11_5, %function
caml_curry11_5:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L271:
.L271:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L273
.L274:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L275 @ caml_curry11_6_app
	ldr	r4, .L276 @ caml_curry11_6
	movs	r5, #0x7 @ 0x5000007
	adds	r5, r5, #0x5000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L276:	.word	caml_curry11_6
.L275:	.word	caml_curry11_6_app
.L273:	bl	caml_call_gc(PLT)
.L272:	b	.L274
	.cfi_endproc
	.type	caml_curry11_5, %function
	.size	caml_curry11_5, .-caml_curry11_5
	.text
	.align	2
	.globl	caml_curry11_6_app
	.thumb
	.type	caml_curry11_6_app, %function
caml_curry11_6_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L277:
.L277:
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L279
.L280:
	ldr	r2, [r5, #16]
	ldr	r5, [r5, #12]
	ldr	r3, [r2, #16]
	ldr	r4, [r2, #12]
	ldr	r1, [r3, #16]
	ldr	r3, [r3, #12]
	ldr	r6, [r1, #16]
	ldr	r2, [r1, #12]
	ldr	r7, [r6, #16]
	ldr	r1, [r6, #12]
	ldr	r12, [r7, #16]
	ldr	r6, [sp, #0]
	str	r12, [sp, #20]
	ldr	r12, [r12, #8]
	ldr	r0, [r7, #12]
	str	r12, [sp, #24]
	ldr	r12, [sp, #8]
	ldr	r7, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #16]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #20]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #24]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L279:	bl	caml_call_gc(PLT)
.L278:	b	.L280
	.cfi_endproc
	.type	caml_curry11_6_app, %function
	.size	caml_curry11_6_app, .-caml_curry11_6_app
	.text
	.align	2
	.globl	caml_curry11_6
	.thumb
	.type	caml_curry11_6, %function
caml_curry11_6:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L281:
.L281:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L283
.L284:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L285 @ caml_curry11_7_app
	ldr	r4, .L286 @ caml_curry11_7
	movs	r5, #0x7 @ 0x4000007
	adds	r5, r5, #0x4000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L286:	.word	caml_curry11_7
.L285:	.word	caml_curry11_7_app
.L283:	bl	caml_call_gc(PLT)
.L282:	b	.L284
	.cfi_endproc
	.type	caml_curry11_6, %function
	.size	caml_curry11_6, .-caml_curry11_6
	.text
	.align	2
	.globl	caml_curry11_7_app
	.thumb
	.type	caml_curry11_7_app, %function
caml_curry11_7_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L287:
.L287:
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L289
.L290:
	ldr	r5, [r4, #16]
	ldr	r6, [r4, #12]
	ldr	r1, [r5, #16]
	str	r6, [sp, #24]
	ldr	r2, [r1, #16]
	ldr	r6, [r5, #12]
	ldr	r7, [r2, #16]
	ldr	r5, [r1, #12]
	ldr	r12, [r7, #16]
	ldr	r4, [r2, #12]
	ldr	r0, [r12, #16]
	ldr	r1, [r12, #12]
	ldr	r3, [r0, #16]
	ldr	r0, [r0, #12]
	ldr	r12, [r3, #8]
	str	r3, [sp, #16]
	str	r12, [sp, #20]
	ldr	r12, [sp, #4]
	mov	r3, r4
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #8]
	mov	r4, r5
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #12]
	mov	r5, r6
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #16]
	ldr	r6, [sp, #24]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #20]
	ldr	r2, [r7, #12]
	ldr	r7, [sp, #0]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L289:	bl	caml_call_gc(PLT)
.L288:	b	.L290
	.cfi_endproc
	.type	caml_curry11_7_app, %function
	.size	caml_curry11_7_app, .-caml_curry11_7_app
	.text
	.align	2
	.globl	caml_curry11_7
	.thumb
	.type	caml_curry11_7, %function
caml_curry11_7:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L291:
.L291:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L293
.L294:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L295 @ caml_curry11_8_app
	ldr	r4, .L296 @ caml_curry11_8
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L296:	.word	caml_curry11_8
.L295:	.word	caml_curry11_8_app
.L293:	bl	caml_call_gc(PLT)
.L292:	b	.L294
	.cfi_endproc
	.type	caml_curry11_7, %function
	.size	caml_curry11_7, .-caml_curry11_7
	.text
	.align	2
	.globl	caml_curry11_8_app
	.thumb
	.type	caml_curry11_8_app, %function
caml_curry11_8_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L297:
.L297:
	str	r2, [sp, #12]
	str	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L299
.L300:
	ldr	r2, [r3, #16]
	ldr	r3, [r3, #12]
	ldr	r4, [r2, #16]
	str	r3, [sp, #0]
	ldr	r7, [r4, #16]
	ldr	r3, [r4, #12]
	ldr	r12, [r7, #16]
	str	r3, [sp, #24]
	ldr	r0, [r12, #16]
	ldr	r3, [r12, #12]
	ldr	r1, [r0, #16]
	ldr	r2, [r2, #12]
	ldr	r5, [r1, #16]
	str	r2, [sp, #28]
	ldr	r6, [r5, #16]
	ldr	r2, [r0, #12]
	ldr	r12, [r6, #8]
	str	r6, [sp, #16]
	str	r12, [sp, #20]
	ldr	r12, [sp, #4]
	ldr	r6, [sp, #28]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #8]
	ldr	r0, [r5, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #12]
	ldr	r5, [sp, #24]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #16]
	ldr	r1, [r1, #12]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #20]
	ldr	r4, [r7, #12]
	ldr	r7, [sp, #0]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L299:	bl	caml_call_gc(PLT)
.L298:	b	.L300
	.cfi_endproc
	.type	caml_curry11_8_app, %function
	.size	caml_curry11_8_app, .-caml_curry11_8_app
	.text
	.align	2
	.globl	caml_curry11_8
	.thumb
	.type	caml_curry11_8, %function
caml_curry11_8:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L301:
.L301:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L303
.L304:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L305 @ caml_curry11_9_app
	ldr	r4, .L306 @ caml_curry11_9
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L306:	.word	caml_curry11_9
.L305:	.word	caml_curry11_9_app
.L303:	bl	caml_call_gc(PLT)
.L302:	b	.L304
	.cfi_endproc
	.type	caml_curry11_8, %function
	.size	caml_curry11_8, .-caml_curry11_8
	.text
	.align	2
	.globl	caml_curry11_9_app
	.thumb
	.type	caml_curry11_9_app, %function
caml_curry11_9_app:
	.cfi_startproc
	sub	sp, sp, #0x38
	.cfi_adjust_cfa_offset	56
	.cfi_offset 14, -4
	str	lr, [sp, #52]
.L307:
.L307:
	str	r2, [sp, #0]
	str	r1, [sp, #44]
	str	r0, [sp, #40]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L309
.L310:
	ldr	r4, [r2, #16]
	ldr	r5, [r4, #16]
	str	r4, [sp, #4]
	ldr	r6, [r5, #16]
	str	r5, [sp, #8]
	ldr	r7, [r6, #16]
	str	r6, [sp, #12]
	ldr	r12, [r7, #16]
	str	r7, [sp, #16]
	ldr	r0, [r12, #16]
	ldr	r7, [sp, #0]
	ldr	r1, [r0, #16]
	str	r0, [sp, #24]
	ldr	r2, [r1, #16]
	ldr	r4, [r7, #12]
	ldr	r7, [sp, #24]
	str	r2, [sp, #32]
	ldr	r3, [r2, #16]
	ldr	r2, [sp, #16]
	str	r12, [sp, #20]
	ldr	r12, [sp, #4]
	str	r1, [sp, #28]
	ldr	r1, [sp, #12]
	ldr	r5, [r12, #12]
	str	r4, [sp, #36]
	ldr	r4, [r2, #12]
	ldr	r2, [r7, #12]
	ldr	r7, [sp, #28]
	str	r5, [sp, #0]
	ldr	r5, [r1, #12]
	ldr	r1, [r7, #12]
	ldr	r7, [sp, #32]
	ldr	r0, [sp, #8]
	str	r3, [sp, #48]
	ldr	r6, [r0, #12]
	ldr	r0, [r7, #12]
	ldr	r7, [sp, #48]
	ldr	r3, [sp, #20]
	ldr	r12, [r7, #8]
	ldr	r7, [sp, #0]
	str	r12, [sp, #4]
	ldr	r12, [sp, #36]
	ldr	r3, [r3, #12]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #40]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #44]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #48]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #4]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	56
.L309:	bl	caml_call_gc(PLT)
.L308:	b	.L310
	.cfi_endproc
	.type	caml_curry11_9_app, %function
	.size	caml_curry11_9_app, .-caml_curry11_9_app
	.text
	.align	2
	.globl	caml_curry11_9
	.thumb
	.type	caml_curry11_9, %function
caml_curry11_9:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L311:
.L311:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L313
.L314:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L315 @ caml_curry11_10
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L315:	.word	caml_curry11_10
.L313:	bl	caml_call_gc(PLT)
.L312:	b	.L314
	.cfi_endproc
	.type	caml_curry11_9, %function
	.size	caml_curry11_9, .-caml_curry11_9
	.text
	.align	2
	.globl	caml_curry11_10
	.thumb
	.type	caml_curry11_10, %function
caml_curry11_10:
	.cfi_startproc
	sub	sp, sp, #0x38
	.cfi_adjust_cfa_offset	56
	.cfi_offset 14, -4
	str	lr, [sp, #52]
.L316:
.L316:
	str	r1, [sp, #0]
	str	r0, [sp, #44]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L318
.L319:
	ldr	r3, [r1, #12]
	ldr	r4, [r3, #16]
	str	r3, [sp, #4]
	ldr	r5, [r4, #16]
	str	r4, [sp, #8]
	ldr	r6, [r5, #16]
	str	r5, [sp, #12]
	ldr	r7, [r6, #16]
	str	r6, [sp, #16]
	ldr	r12, [r7, #16]
	str	r7, [sp, #20]
	ldr	r0, [r12, #16]
	str	r12, [sp, #24]
	ldr	r1, [r0, #16]
	str	r0, [sp, #28]
	ldr	r2, [r1, #16]
	ldr	r0, [sp, #4]
	ldr	r3, [r2, #16]
	ldr	r5, [r0, #12]
	str	r3, [sp, #48]
	ldr	r3, [sp, #16]
	str	r1, [sp, #32]
	ldr	r1, [sp, #8]
	ldr	r7, [sp, #24]
	ldr	r6, [r1, #12]
	str	r5, [sp, #4]
	ldr	r5, [r3, #12]
	ldr	r3, [r7, #12]
	ldr	r7, [sp, #28]
	str	r2, [sp, #36]
	ldr	r2, [sp, #12]
	ldr	r12, [sp, #0]
	str	r6, [sp, #0]
	ldr	r6, [r2, #12]
	ldr	r2, [r7, #12]
	ldr	r7, [sp, #32]
	ldr	r4, [r12, #8]
	ldr	r12, [sp, #36]
	ldr	r1, [r7, #12]
	ldr	r7, [sp, #48]
	ldr	r0, [r12, #12]
	ldr	r12, [r7, #8]
	str	r4, [sp, #40]
	str	r12, [sp, #8]
	ldr	r12, [sp, #4]
	ldr	r4, [sp, #20]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #40]
	ldr	r4, [r4, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #44]
	ldr	r7, [sp, #0]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #48]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #8]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	56
.L318:	bl	caml_call_gc(PLT)
.L317:	b	.L319
	.cfi_endproc
	.type	caml_curry11_10, %function
	.size	caml_curry11_10, .-caml_curry11_10
	.text
	.align	2
	.globl	caml_curry10
	.thumb
	.type	caml_curry10, %function
caml_curry10:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L320:
.L320:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L322
.L323:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L324 @ caml_curry10_1_app
	ldr	r4, .L325 @ caml_curry10_1
	movs	r5, #0x7 @ 0x9000007
	adds	r5, r5, #0x9000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L325:	.word	caml_curry10_1
.L324:	.word	caml_curry10_1_app
.L322:	bl	caml_call_gc(PLT)
.L321:	b	.L323
	.cfi_endproc
	.type	caml_curry10, %function
	.size	caml_curry10, .-caml_curry10
	.text
	.align	2
	.globl	caml_curry10_1_app
	.thumb
	.type	caml_curry10_1_app, %function
caml_curry10_1_app:
	.cfi_startproc
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L326:
.L326:
	str	r2, [sp, #8]
	ldr	r2, [domain_state_ptr, #520]
	str	r2, [sp, #32]
	str	r7, [sp, #28]
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	ldr	r3, [domain_state_ptr, #524]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L328
.L329:
	ldr	r4, [r3, #16]
	ldr	r7, [sp, #24]
	ldr	r12, [r4, #8]
	str	r4, [sp, #36]
	str	r12, [sp, #40]
	ldr	r12, [sp, #28]
	ldr	r4, [sp, #12]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #32]
	ldr	r6, [sp, #20]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #36]
	ldr	r5, [sp, #16]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #40]
	ldr	r2, [sp, #4]
	ldr	r1, [sp, #0]
	ldr	r0, [r3, #12]
	ldr	r3, [sp, #8]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	48
.L328:	bl	caml_call_gc(PLT)
.L327:	b	.L329
	.cfi_endproc
	.type	caml_curry10_1_app, %function
	.size	caml_curry10_1_app, .-caml_curry10_1_app
	.text
	.align	2
	.globl	caml_curry10_1
	.thumb
	.type	caml_curry10_1, %function
caml_curry10_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L330:
.L330:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L332
.L333:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L334 @ caml_curry10_2_app
	ldr	r4, .L335 @ caml_curry10_2
	movs	r5, #0x7 @ 0x8000007
	adds	r5, r5, #0x8000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L335:	.word	caml_curry10_2
.L334:	.word	caml_curry10_2_app
.L332:	bl	caml_call_gc(PLT)
.L331:	b	.L333
	.cfi_endproc
	.type	caml_curry10_1, %function
	.size	caml_curry10_1, .-caml_curry10_1
	.text
	.align	2
	.globl	caml_curry10_2_app
	.thumb
	.type	caml_curry10_2_app, %function
caml_curry10_2_app:
	.cfi_startproc
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L336:
.L336:
	str	r7, [sp, #28]
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	ldr	r2, [domain_state_ptr, #520]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L338
.L339:
	ldr	r3, [r2, #16]
	ldr	r7, [sp, #20]
	ldr	r4, [r3, #16]
	ldr	r0, [r3, #12]
	ldr	r12, [r4, #8]
	str	r4, [sp, #32]
	str	r12, [sp, #36]
	ldr	r12, [sp, #24]
	ldr	r4, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #28]
	ldr	r3, [sp, #4]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #32]
	ldr	r6, [sp, #16]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #36]
	ldr	r5, [sp, #12]
	ldr	r1, [r2, #12]
	ldr	r2, [sp, #0]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	48
.L338:	bl	caml_call_gc(PLT)
.L337:	b	.L339
	.cfi_endproc
	.type	caml_curry10_2_app, %function
	.size	caml_curry10_2_app, .-caml_curry10_2_app
	.text
	.align	2
	.globl	caml_curry10_2
	.thumb
	.type	caml_curry10_2, %function
caml_curry10_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L340:
.L340:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L342
.L343:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L344 @ caml_curry10_3_app
	ldr	r4, .L345 @ caml_curry10_3
	movs	r5, #0x7 @ 0x7000007
	adds	r5, r5, #0x7000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L345:	.word	caml_curry10_3
.L344:	.word	caml_curry10_3_app
.L342:	bl	caml_call_gc(PLT)
.L341:	b	.L343
	.cfi_endproc
	.type	caml_curry10_2, %function
	.size	caml_curry10_2, .-caml_curry10_2
	.text
	.align	2
	.globl	caml_curry10_3_app
	.thumb
	.type	caml_curry10_3_app, %function
caml_curry10_3_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L346:
.L346:
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L348
.L349:
	ldr	r3, [r7, #16]
	ldr	r6, [sp, #12]
	ldr	r4, [r3, #16]
	ldr	r1, [r3, #12]
	ldr	r5, [r4, #16]
	ldr	r3, [sp, #0]
	ldr	r12, [r5, #8]
	str	r5, [sp, #28]
	str	r12, [sp, #32]
	ldr	r12, [sp, #20]
	ldr	r5, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #24]
	ldr	r0, [r4, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #28]
	ldr	r4, [sp, #4]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #32]
	ldr	r2, [r7, #12]
	ldr	r7, [sp, #16]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L348:	bl	caml_call_gc(PLT)
.L347:	b	.L349
	.cfi_endproc
	.type	caml_curry10_3_app, %function
	.size	caml_curry10_3_app, .-caml_curry10_3_app
	.text
	.align	2
	.globl	caml_curry10_3
	.thumb
	.type	caml_curry10_3, %function
caml_curry10_3:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L350:
.L350:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L352
.L353:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L354 @ caml_curry10_4_app
	ldr	r4, .L355 @ caml_curry10_4
	movs	r5, #0x7 @ 0x6000007
	adds	r5, r5, #0x6000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L355:	.word	caml_curry10_4
.L354:	.word	caml_curry10_4_app
.L352:	bl	caml_call_gc(PLT)
.L351:	b	.L353
	.cfi_endproc
	.type	caml_curry10_3, %function
	.size	caml_curry10_3, .-caml_curry10_3
	.text
	.align	2
	.globl	caml_curry10_4_app
	.thumb
	.type	caml_curry10_4_app, %function
caml_curry10_4_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L356:
.L356:
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L358
.L359:
	ldr	r4, [r6, #16]
	ldr	r3, [r6, #12]
	ldr	r5, [r4, #16]
	ldr	r6, [sp, #8]
	ldr	r7, [r5, #16]
	ldr	r1, [r5, #12]
	ldr	r12, [r7, #16]
	ldr	r5, [sp, #4]
	str	r12, [sp, #24]
	ldr	r12, [r12, #8]
	ldr	r0, [r7, #12]
	str	r12, [sp, #28]
	ldr	r12, [sp, #16]
	ldr	r7, [sp, #12]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #20]
	ldr	r2, [r4, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #24]
	ldr	r4, [sp, #0]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #28]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L358:	bl	caml_call_gc(PLT)
.L357:	b	.L359
	.cfi_endproc
	.type	caml_curry10_4_app, %function
	.size	caml_curry10_4_app, .-caml_curry10_4_app
	.text
	.align	2
	.globl	caml_curry10_4
	.thumb
	.type	caml_curry10_4, %function
caml_curry10_4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L360:
.L360:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L362
.L363:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L364 @ caml_curry10_5_app
	ldr	r4, .L365 @ caml_curry10_5
	movs	r5, #0x7 @ 0x5000007
	adds	r5, r5, #0x5000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L365:	.word	caml_curry10_5
.L364:	.word	caml_curry10_5_app
.L362:	bl	caml_call_gc(PLT)
.L361:	b	.L363
	.cfi_endproc
	.type	caml_curry10_4, %function
	.size	caml_curry10_4, .-caml_curry10_4
	.text
	.align	2
	.globl	caml_curry10_5_app
	.thumb
	.type	caml_curry10_5_app, %function
caml_curry10_5_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L366:
.L366:
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L368
.L369:
	ldr	r12, [r5, #16]
	ldr	r4, [r5, #12]
	ldr	r0, [r12, #16]
	ldr	r3, [r12, #12]
	ldr	r1, [r0, #16]
	ldr	r2, [r0, #12]
	ldr	r6, [r1, #16]
	ldr	r1, [r1, #12]
	ldr	r7, [r6, #16]
	ldr	r0, [r6, #12]
	ldr	r12, [r7, #8]
	str	r7, [sp, #20]
	str	r12, [sp, #24]
	ldr	r12, [sp, #12]
	ldr	r7, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #16]
	ldr	r6, [sp, #4]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #20]
	ldr	r5, [sp, #0]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #24]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L368:	bl	caml_call_gc(PLT)
.L367:	b	.L369
	.cfi_endproc
	.type	caml_curry10_5_app, %function
	.size	caml_curry10_5_app, .-caml_curry10_5_app
	.text
	.align	2
	.globl	caml_curry10_5
	.thumb
	.type	caml_curry10_5, %function
caml_curry10_5:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L370:
.L370:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L372
.L373:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L374 @ caml_curry10_6_app
	ldr	r4, .L375 @ caml_curry10_6
	movs	r5, #0x7 @ 0x4000007
	adds	r5, r5, #0x4000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L375:	.word	caml_curry10_6
.L374:	.word	caml_curry10_6_app
.L372:	bl	caml_call_gc(PLT)
.L371:	b	.L373
	.cfi_endproc
	.type	caml_curry10_5, %function
	.size	caml_curry10_5, .-caml_curry10_5
	.text
	.align	2
	.globl	caml_curry10_6_app
	.thumb
	.type	caml_curry10_6_app, %function
caml_curry10_6_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L376:
.L376:
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L378
.L379:
	ldr	r0, [r4, #16]
	ldr	r5, [r4, #12]
	ldr	r2, [r0, #16]
	ldr	r4, [r0, #12]
	ldr	r1, [r2, #16]
	ldr	r3, [r2, #12]
	ldr	r6, [r1, #16]
	ldr	r2, [r1, #12]
	ldr	r7, [r6, #16]
	ldr	r1, [r6, #12]
	ldr	r12, [r7, #16]
	ldr	r6, [sp, #0]
	str	r12, [sp, #16]
	ldr	r12, [r12, #8]
	ldr	r0, [r7, #12]
	str	r12, [sp, #20]
	ldr	r12, [sp, #8]
	ldr	r7, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #16]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #20]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L378:	bl	caml_call_gc(PLT)
.L377:	b	.L379
	.cfi_endproc
	.type	caml_curry10_6_app, %function
	.size	caml_curry10_6_app, .-caml_curry10_6_app
	.text
	.align	2
	.globl	caml_curry10_6
	.thumb
	.type	caml_curry10_6, %function
caml_curry10_6:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L380:
.L380:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L382
.L383:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L384 @ caml_curry10_7_app
	ldr	r4, .L385 @ caml_curry10_7
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L385:	.word	caml_curry10_7
.L384:	.word	caml_curry10_7_app
.L382:	bl	caml_call_gc(PLT)
.L381:	b	.L383
	.cfi_endproc
	.type	caml_curry10_6, %function
	.size	caml_curry10_6, .-caml_curry10_6
	.text
	.align	2
	.globl	caml_curry10_7_app
	.thumb
	.type	caml_curry10_7_app, %function
caml_curry10_7_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L386:
.L386:
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L388
.L389:
	ldr	r5, [r3, #16]
	ldr	r6, [r3, #12]
	ldr	r1, [r5, #16]
	str	r6, [sp, #20]
	ldr	r2, [r1, #16]
	ldr	r6, [r5, #12]
	ldr	r7, [r2, #16]
	ldr	r5, [r1, #12]
	ldr	r12, [r7, #16]
	ldr	r3, [r2, #12]
	ldr	r0, [r12, #16]
	ldr	r1, [r12, #12]
	ldr	r4, [r0, #16]
	ldr	r0, [r0, #12]
	ldr	r12, [r4, #8]
	str	r4, [sp, #12]
	str	r12, [sp, #16]
	ldr	r12, [sp, #4]
	mov	r4, r5
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #8]
	mov	r5, r6
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #12]
	ldr	r6, [sp, #20]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #16]
	ldr	r2, [r7, #12]
	ldr	r7, [sp, #0]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L388:	bl	caml_call_gc(PLT)
.L387:	b	.L389
	.cfi_endproc
	.type	caml_curry10_7_app, %function
	.size	caml_curry10_7_app, .-caml_curry10_7_app
	.text
	.align	2
	.globl	caml_curry10_7
	.thumb
	.type	caml_curry10_7, %function
caml_curry10_7:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L390:
.L390:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L392
.L393:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L394 @ caml_curry10_8_app
	ldr	r4, .L395 @ caml_curry10_8
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L395:	.word	caml_curry10_8
.L394:	.word	caml_curry10_8_app
.L392:	bl	caml_call_gc(PLT)
.L391:	b	.L393
	.cfi_endproc
	.type	caml_curry10_7, %function
	.size	caml_curry10_7, .-caml_curry10_7
	.text
	.align	2
	.globl	caml_curry10_8_app
	.thumb
	.type	caml_curry10_8_app, %function
caml_curry10_8_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L396:
.L396:
	str	r1, [sp, #8]
	str	r0, [sp, #4]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L398
.L399:
	ldr	r3, [r2, #16]
	ldr	r2, [r2, #12]
	ldr	r4, [r3, #16]
	str	r2, [sp, #0]
	ldr	r7, [r4, #16]
	ldr	r2, [r3, #12]
	ldr	r12, [r7, #16]
	ldr	r3, [r4, #12]
	ldr	r0, [r12, #16]
	str	r3, [sp, #20]
	ldr	r1, [r0, #16]
	ldr	r3, [r12, #12]
	ldr	r5, [r1, #16]
	str	r2, [sp, #24]
	ldr	r6, [r5, #16]
	ldr	r2, [r0, #12]
	ldr	r12, [r6, #8]
	str	r6, [sp, #12]
	str	r12, [sp, #16]
	ldr	r12, [sp, #4]
	ldr	r6, [sp, #24]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #8]
	ldr	r0, [r5, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #12]
	ldr	r5, [sp, #20]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #16]
	ldr	r1, [r1, #12]
	ldr	r4, [r7, #12]
	ldr	r7, [sp, #0]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L398:	bl	caml_call_gc(PLT)
.L397:	b	.L399
	.cfi_endproc
	.type	caml_curry10_8_app, %function
	.size	caml_curry10_8_app, .-caml_curry10_8_app
	.text
	.align	2
	.globl	caml_curry10_8
	.thumb
	.type	caml_curry10_8, %function
caml_curry10_8:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L400:
.L400:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L402
.L403:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L404 @ caml_curry10_9
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L404:	.word	caml_curry10_9
.L402:	bl	caml_call_gc(PLT)
.L401:	b	.L403
	.cfi_endproc
	.type	caml_curry10_8, %function
	.size	caml_curry10_8, .-caml_curry10_8
	.text
	.align	2
	.globl	caml_curry10_9
	.thumb
	.type	caml_curry10_9, %function
caml_curry10_9:
	.cfi_startproc
	sub	sp, sp, #0x38
	.cfi_adjust_cfa_offset	56
	.cfi_offset 14, -4
	str	lr, [sp, #52]
.L405:
.L405:
	str	r1, [sp, #0]
	str	r0, [sp, #40]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L407
.L408:
	ldr	r2, [r1, #12]
	ldr	r3, [r2, #16]
	str	r2, [sp, #4]
	ldr	r4, [r3, #16]
	str	r3, [sp, #8]
	ldr	r5, [r4, #16]
	str	r4, [sp, #12]
	ldr	r6, [r5, #16]
	str	r5, [sp, #16]
	ldr	r7, [r6, #16]
	str	r6, [sp, #20]
	ldr	r12, [r7, #16]
	ldr	r6, [sp, #4]
	ldr	r0, [r12, #16]
	str	r7, [sp, #24]
	ldr	r7, [sp, #8]
	ldr	r1, [r0, #16]
	str	r12, [sp, #28]
	str	r1, [sp, #44]
	ldr	r1, [sp, #20]
	ldr	r3, [r6, #12]
	ldr	r6, [r7, #12]
	ldr	r7, [sp, #28]
	str	r0, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r5, [sp, #0]
	str	r3, [sp, #0]
	ldr	r3, [r1, #12]
	ldr	r1, [r7, #12]
	ldr	r7, [sp, #32]
	ldr	r4, [r0, #12]
	ldr	r0, [r7, #12]
	ldr	r7, [sp, #44]
	ldr	r12, [sp, #12]
	ldr	r2, [r5, #8]
	ldr	r5, [r12, #12]
	ldr	r12, [r7, #8]
	str	r2, [sp, #36]
	str	r12, [sp, #4]
	ldr	r12, [sp, #36]
	ldr	r2, [sp, #24]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #40]
	ldr	r2, [r2, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #44]
	ldr	r7, [sp, #0]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #4]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	56
.L407:	bl	caml_call_gc(PLT)
.L406:	b	.L408
	.cfi_endproc
	.type	caml_curry10_9, %function
	.size	caml_curry10_9, .-caml_curry10_9
	.text
	.align	2
	.globl	caml_curry9
	.thumb
	.type	caml_curry9, %function
caml_curry9:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L409:
.L409:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L411
.L412:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L413 @ caml_curry9_1_app
	ldr	r4, .L414 @ caml_curry9_1
	movs	r5, #0x7 @ 0x8000007
	adds	r5, r5, #0x8000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L414:	.word	caml_curry9_1
.L413:	.word	caml_curry9_1_app
.L411:	bl	caml_call_gc(PLT)
.L410:	b	.L412
	.cfi_endproc
	.type	caml_curry9, %function
	.size	caml_curry9, .-caml_curry9
	.text
	.align	2
	.globl	caml_curry9_1_app
	.thumb
	.type	caml_curry9_1_app, %function
caml_curry9_1_app:
	.cfi_startproc
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L415:
.L415:
	str	r7, [sp, #28]
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	ldr	r1, [domain_state_ptr, #520]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L417
.L418:
	ldr	r2, [r1, #16]
	ldr	r7, [sp, #24]
	ldr	r12, [r2, #8]
	str	r2, [sp, #32]
	str	r12, [sp, #36]
	ldr	r12, [sp, #28]
	ldr	r2, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #32]
	ldr	r6, [sp, #20]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #36]
	ldr	r5, [sp, #16]
	ldr	r4, [sp, #12]
	ldr	r3, [sp, #8]
	ldr	r0, [r1, #12]
	ldr	r1, [sp, #0]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	48
.L417:	bl	caml_call_gc(PLT)
.L416:	b	.L418
	.cfi_endproc
	.type	caml_curry9_1_app, %function
	.size	caml_curry9_1_app, .-caml_curry9_1_app
	.text
	.align	2
	.globl	caml_curry9_1
	.thumb
	.type	caml_curry9_1, %function
caml_curry9_1:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L419:
.L419:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L421
.L422:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L423 @ caml_curry9_2_app
	ldr	r4, .L424 @ caml_curry9_2
	movs	r5, #0x7 @ 0x7000007
	adds	r5, r5, #0x7000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L424:	.word	caml_curry9_2
.L423:	.word	caml_curry9_2_app
.L421:	bl	caml_call_gc(PLT)
.L420:	b	.L422
	.cfi_endproc
	.type	caml_curry9_1, %function
	.size	caml_curry9_1, .-caml_curry9_1
	.text
	.align	2
	.globl	caml_curry9_2_app
	.thumb
	.type	caml_curry9_2_app, %function
caml_curry9_2_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L425:
.L425:
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L427
.L428:
	ldr	r2, [r7, #16]
	ldr	r6, [sp, #16]
	ldr	r3, [r2, #16]
	ldr	r0, [r2, #12]
	ldr	r12, [r3, #8]
	str	r3, [sp, #28]
	str	r12, [sp, #32]
	ldr	r12, [sp, #24]
	ldr	r3, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #28]
	ldr	r2, [sp, #0]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #32]
	ldr	r5, [sp, #12]
	ldr	r4, [sp, #8]
	ldr	r1, [r7, #12]
	ldr	r7, [sp, #20]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L427:	bl	caml_call_gc(PLT)
.L426:	b	.L428
	.cfi_endproc
	.type	caml_curry9_2_app, %function
	.size	caml_curry9_2_app, .-caml_curry9_2_app
	.text
	.align	2
	.globl	caml_curry9_2
	.thumb
	.type	caml_curry9_2, %function
caml_curry9_2:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L429:
.L429:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L431
.L432:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L433 @ caml_curry9_3_app
	ldr	r4, .L434 @ caml_curry9_3
	movs	r5, #0x7 @ 0x6000007
	adds	r5, r5, #0x6000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L434:	.word	caml_curry9_3
.L433:	.word	caml_curry9_3_app
.L431:	bl	caml_call_gc(PLT)
.L430:	b	.L432
	.cfi_endproc
	.type	caml_curry9_2, %function
	.size	caml_curry9_2, .-caml_curry9_2
	.text
	.align	2
	.globl	caml_curry9_3_app
	.thumb
	.type	caml_curry9_3_app, %function
caml_curry9_3_app:
	.cfi_startproc
	sub	sp, sp, #0x28
	.cfi_adjust_cfa_offset	40
	.cfi_offset 14, -4
	str	lr, [sp, #36]
.L435:
.L435:
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L437
.L438:
	ldr	r0, [r6, #16]
	ldr	r7, [sp, #16]
	ldr	r3, [r0, #16]
	ldr	r1, [r0, #12]
	ldr	r4, [r3, #16]
	ldr	r0, [r3, #12]
	ldr	r12, [r4, #8]
	str	r4, [sp, #24]
	str	r12, [sp, #28]
	ldr	r12, [sp, #20]
	ldr	r4, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #24]
	ldr	r3, [sp, #0]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #28]
	ldr	r5, [sp, #8]
	ldr	r2, [r6, #12]
	ldr	r6, [sp, #12]
	add	sp, sp, #0x28
	.cfi_adjust_cfa_offset	-40
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	40
.L437:	bl	caml_call_gc(PLT)
.L436:	b	.L438
	.cfi_endproc
	.type	caml_curry9_3_app, %function
	.size	caml_curry9_3_app, .-caml_curry9_3_app
	.text
	.align	2
	.globl	caml_curry9_3
	.thumb
	.type	caml_curry9_3, %function
caml_curry9_3:
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
	ldr	r6, .L443 @ caml_curry9_4_app
	ldr	r4, .L444 @ caml_curry9_4
	movs	r5, #0x7 @ 0x5000007
	adds	r5, r5, #0x5000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L444:	.word	caml_curry9_4
.L443:	.word	caml_curry9_4_app
.L441:	bl	caml_call_gc(PLT)
.L440:	b	.L442
	.cfi_endproc
	.type	caml_curry9_3, %function
	.size	caml_curry9_3, .-caml_curry9_3
	.text
	.align	2
	.globl	caml_curry9_4_app
	.thumb
	.type	caml_curry9_4_app, %function
caml_curry9_4_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L445:
.L445:
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L447
.L448:
	ldr	r1, [r5, #16]
	ldr	r3, [r5, #12]
	ldr	r4, [r1, #16]
	ldr	r5, [sp, #4]
	ldr	r6, [r4, #16]
	ldr	r2, [r1, #12]
	ldr	r7, [r6, #16]
	ldr	r1, [r4, #12]
	ldr	r12, [r7, #8]
	str	r7, [sp, #20]
	str	r12, [sp, #24]
	ldr	r12, [sp, #16]
	ldr	r7, [sp, #12]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #20]
	ldr	r4, [sp, #0]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #24]
	ldr	r0, [r6, #12]
	ldr	r6, [sp, #8]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L447:	bl	caml_call_gc(PLT)
.L446:	b	.L448
	.cfi_endproc
	.type	caml_curry9_4_app, %function
	.size	caml_curry9_4_app, .-caml_curry9_4_app
	.text
	.align	2
	.globl	caml_curry9_4
	.thumb
	.type	caml_curry9_4, %function
caml_curry9_4:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L449:
.L449:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L451
.L452:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L453 @ caml_curry9_5_app
	ldr	r4, .L454 @ caml_curry9_5
	movs	r5, #0x7 @ 0x4000007
	adds	r5, r5, #0x4000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L454:	.word	caml_curry9_5
.L453:	.word	caml_curry9_5_app
.L451:	bl	caml_call_gc(PLT)
.L450:	b	.L452
	.cfi_endproc
	.type	caml_curry9_4, %function
	.size	caml_curry9_4, .-caml_curry9_4
	.text
	.align	2
	.globl	caml_curry9_5_app
	.thumb
	.type	caml_curry9_5_app, %function
caml_curry9_5_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L455:
.L455:
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L457
.L458:
	ldr	r3, [r4, #16]
	ldr	r4, [r4, #12]
	ldr	r7, [r3, #16]
	ldr	r3, [r3, #12]
	ldr	r12, [r7, #16]
	ldr	r2, [r7, #12]
	ldr	r5, [r12, #16]
	ldr	r1, [r12, #12]
	ldr	r6, [r5, #16]
	ldr	r0, [r5, #12]
	ldr	r12, [r6, #8]
	str	r6, [sp, #16]
	str	r12, [sp, #20]
	ldr	r12, [sp, #12]
	ldr	r6, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #16]
	ldr	r5, [sp, #0]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #20]
	ldr	r7, [sp, #8]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L457:	bl	caml_call_gc(PLT)
.L456:	b	.L458
	.cfi_endproc
	.type	caml_curry9_5_app, %function
	.size	caml_curry9_5_app, .-caml_curry9_5_app
	.text
	.align	2
	.globl	caml_curry9_5
	.thumb
	.type	caml_curry9_5, %function
caml_curry9_5:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L459:
.L459:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L461
.L462:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L463 @ caml_curry9_6_app
	ldr	r4, .L464 @ caml_curry9_6
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L464:	.word	caml_curry9_6
.L463:	.word	caml_curry9_6_app
.L461:	bl	caml_call_gc(PLT)
.L460:	b	.L462
	.cfi_endproc
	.type	caml_curry9_5, %function
	.size	caml_curry9_5, .-caml_curry9_5
	.text
	.align	2
	.globl	caml_curry9_6_app
	.thumb
	.type	caml_curry9_6_app, %function
caml_curry9_6_app:
	.cfi_startproc
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L465:
.L465:
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L467
.L468:
	ldr	r0, [r3, #16]
	ldr	r5, [r3, #12]
	ldr	r2, [r0, #16]
	ldr	r4, [r0, #12]
	ldr	r1, [r2, #16]
	ldr	r3, [r2, #12]
	ldr	r6, [r1, #16]
	ldr	r2, [r1, #12]
	ldr	r7, [r6, #16]
	ldr	r1, [r6, #12]
	ldr	r12, [r7, #16]
	ldr	r6, [sp, #0]
	str	r12, [sp, #12]
	ldr	r12, [r12, #8]
	ldr	r0, [r7, #12]
	str	r12, [sp, #16]
	ldr	r12, [sp, #8]
	ldr	r7, [sp, #4]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #16]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	24
.L467:	bl	caml_call_gc(PLT)
.L466:	b	.L468
	.cfi_endproc
	.type	caml_curry9_6_app, %function
	.size	caml_curry9_6_app, .-caml_curry9_6_app
	.text
	.align	2
	.globl	caml_curry9_6
	.thumb
	.type	caml_curry9_6, %function
caml_curry9_6:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L469:
.L469:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L471
.L472:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L473 @ caml_curry9_7_app
	ldr	r4, .L474 @ caml_curry9_7
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L474:	.word	caml_curry9_7
.L473:	.word	caml_curry9_7_app
.L471:	bl	caml_call_gc(PLT)
.L470:	b	.L472
	.cfi_endproc
	.type	caml_curry9_6, %function
	.size	caml_curry9_6, .-caml_curry9_6
	.text
	.align	2
	.globl	caml_curry9_7_app
	.thumb
	.type	caml_curry9_7_app, %function
caml_curry9_7_app:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L475:
.L475:
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L477
.L478:
	ldr	r5, [r2, #16]
	ldr	r6, [r2, #12]
	ldr	r1, [r5, #16]
	ldr	r5, [r5, #12]
	ldr	r3, [r1, #16]
	str	r5, [sp, #16]
	ldr	r7, [r3, #16]
	ldr	r5, [r1, #12]
	ldr	r12, [r7, #16]
	str	r6, [sp, #20]
	ldr	r0, [r12, #16]
	ldr	r1, [r12, #12]
	ldr	r4, [r0, #16]
	ldr	r0, [r0, #12]
	ldr	r12, [r4, #8]
	str	r4, [sp, #8]
	str	r12, [sp, #12]
	ldr	r12, [sp, #4]
	mov	r4, r5
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #8]
	ldr	r5, [sp, #16]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #12]
	ldr	r6, [sp, #20]
	ldr	r3, [r3, #12]
	ldr	r2, [r7, #12]
	ldr	r7, [sp, #0]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L477:	bl	caml_call_gc(PLT)
.L476:	b	.L478
	.cfi_endproc
	.type	caml_curry9_7_app, %function
	.size	caml_curry9_7_app, .-caml_curry9_7_app
	.text
	.align	2
	.globl	caml_curry9_7
	.thumb
	.type	caml_curry9_7, %function
caml_curry9_7:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L479:
.L479:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L481
.L482:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L483 @ caml_curry9_8
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L483:	.word	caml_curry9_8
.L481:	bl	caml_call_gc(PLT)
.L480:	b	.L482
	.cfi_endproc
	.type	caml_curry9_7, %function
	.size	caml_curry9_7, .-caml_curry9_7
	.text
	.align	2
	.globl	caml_curry9_8
	.thumb
	.type	caml_curry9_8, %function
caml_curry9_8:
	.cfi_startproc
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L484:
.L484:
	str	r0, [sp, #4]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L486
.L487:
	ldr	r2, [r1, #12]
	ldr	r1, [r1, #8]
	ldr	r3, [r2, #16]
	ldr	r2, [r2, #12]
	ldr	r4, [r3, #16]
	str	r2, [sp, #20]
	ldr	r7, [r4, #16]
	ldr	r3, [r3, #12]
	ldr	r12, [r7, #16]
	str	r3, [sp, #16]
	ldr	r0, [r12, #16]
	ldr	r2, [r12, #12]
	ldr	r5, [r0, #16]
	str	r1, [sp, #0]
	ldr	r6, [r5, #16]
	ldr	r1, [r0, #12]
	ldr	r12, [r6, #8]
	str	r6, [sp, #8]
	str	r12, [sp, #12]
	ldr	r12, [sp, #4]
	ldr	r6, [sp, #20]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #8]
	ldr	r0, [r5, #12]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #12]
	ldr	r5, [sp, #16]
	ldr	r3, [r7, #12]
	ldr	r7, [sp, #0]
	ldr	r4, [r4, #12]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L486:	bl	caml_call_gc(PLT)
.L485:	b	.L487
	.cfi_endproc
	.type	caml_curry9_8, %function
	.size	caml_curry9_8, .-caml_curry9_8
	.text
	.align	2
	.globl	caml_curry8
	.thumb
	.type	caml_curry8, %function
caml_curry8:
	.cfi_startproc
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L488:
.L488:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L490
.L491:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L492 @ caml_curry8_1_app
	ldr	r4, .L493 @ caml_curry8_1
	movs	r5, #0x7 @ 0x7000007
	adds	r5, r5, #0x7000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L493:	.word	caml_curry8_1
.L492:	.word	caml_curry8_1_app
.L490:	bl	caml_call_gc(PLT)
.L489:	b	.L491
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
.L494:
.L494:
	str	r6, [sp, #24]
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L496
.L497:
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
.L496:	bl	caml_call_gc(PLT)
.L495:	b	.L497
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
.L498:
.L498:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L500
.L501:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L502 @ caml_curry8_2_app
	ldr	r4, .L503 @ caml_curry8_2
	movs	r5, #0x7 @ 0x6000007
	adds	r5, r5, #0x6000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L503:	.word	caml_curry8_2
.L502:	.word	caml_curry8_2_app
.L500:	bl	caml_call_gc(PLT)
.L499:	b	.L501
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
.L504:
.L504:
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L506
.L507:
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
.L506:	bl	caml_call_gc(PLT)
.L505:	b	.L507
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
.L508:
.L508:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L510
.L511:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L512 @ caml_curry8_3_app
	ldr	r4, .L513 @ caml_curry8_3
	movs	r5, #0x7 @ 0x5000007
	adds	r5, r5, #0x5000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L513:	.word	caml_curry8_3
.L512:	.word	caml_curry8_3_app
.L510:	bl	caml_call_gc(PLT)
.L509:	b	.L511
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
.L514:
.L514:
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L516
.L517:
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
.L516:	bl	caml_call_gc(PLT)
.L515:	b	.L517
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
.L518:
.L518:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L520
.L521:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L522 @ caml_curry8_4_app
	ldr	r4, .L523 @ caml_curry8_4
	movs	r5, #0x7 @ 0x4000007
	adds	r5, r5, #0x4000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L523:	.word	caml_curry8_4
.L522:	.word	caml_curry8_4_app
.L520:	bl	caml_call_gc(PLT)
.L519:	b	.L521
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
.L524:
.L524:
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L526
.L527:
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
.L526:	bl	caml_call_gc(PLT)
.L525:	b	.L527
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
.L528:
.L528:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L530
.L531:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L532 @ caml_curry8_5_app
	ldr	r4, .L533 @ caml_curry8_5
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L533:	.word	caml_curry8_5
.L532:	.word	caml_curry8_5_app
.L530:	bl	caml_call_gc(PLT)
.L529:	b	.L531
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
.L534:
.L534:
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L536
.L537:
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
.L536:	bl	caml_call_gc(PLT)
.L535:	b	.L537
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
.L538:
.L538:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L540
.L541:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L542 @ caml_curry8_6_app
	ldr	r4, .L543 @ caml_curry8_6
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L543:	.word	caml_curry8_6
.L542:	.word	caml_curry8_6_app
.L540:	bl	caml_call_gc(PLT)
.L539:	b	.L541
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
.L544:
.L544:
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L546
.L547:
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
.L546:	bl	caml_call_gc(PLT)
.L545:	b	.L547
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
.L548:
.L548:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L550
.L551:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L552 @ caml_curry8_7
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L552:	.word	caml_curry8_7
.L550:	bl	caml_call_gc(PLT)
.L549:	b	.L551
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
.L553:
.L553:
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L555
.L556:
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
.L555:	bl	caml_call_gc(PLT)
.L554:	b	.L556
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
.L557:
.L557:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L559
.L560:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L561 @ caml_curry7_1_app
	ldr	r4, .L562 @ caml_curry7_1
	movs	r5, #0x7 @ 0x6000007
	adds	r5, r5, #0x6000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L562:	.word	caml_curry7_1
.L561:	.word	caml_curry7_1_app
.L559:	bl	caml_call_gc(PLT)
.L558:	b	.L560
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
.L563:
.L563:
	str	r5, [sp, #20]
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L565
.L566:
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
.L565:	bl	caml_call_gc(PLT)
.L564:	b	.L566
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
.L567:
.L567:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L569
.L570:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L571 @ caml_curry7_2_app
	ldr	r4, .L572 @ caml_curry7_2
	movs	r5, #0x7 @ 0x5000007
	adds	r5, r5, #0x5000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L572:	.word	caml_curry7_2
.L571:	.word	caml_curry7_2_app
.L569:	bl	caml_call_gc(PLT)
.L568:	b	.L570
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
.L573:
.L573:
	str	r4, [sp, #12]
	str	r3, [sp, #8]
	str	r2, [sp, #4]
	str	r1, [sp, #0]
	mov	r6, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L575
.L576:
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
.L575:	bl	caml_call_gc(PLT)
.L574:	b	.L576
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
.L577:
.L577:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L579
.L580:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L581 @ caml_curry7_3_app
	ldr	r4, .L582 @ caml_curry7_3
	movs	r5, #0x7 @ 0x4000007
	adds	r5, r5, #0x4000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L582:	.word	caml_curry7_3
.L581:	.word	caml_curry7_3_app
.L579:	bl	caml_call_gc(PLT)
.L578:	b	.L580
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
.L583:
.L583:
	str	r3, [sp, #4]
	str	r2, [sp, #0]
	mov	r6, r1
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L585
.L586:
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
.L585:	bl	caml_call_gc(PLT)
.L584:	b	.L586
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
.L587:
.L587:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L589
.L590:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L591 @ caml_curry7_4_app
	ldr	r4, .L592 @ caml_curry7_4
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L592:	.word	caml_curry7_4
.L591:	.word	caml_curry7_4_app
.L589:	bl	caml_call_gc(PLT)
.L588:	b	.L590
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
.L593:
.L593:
	mov	r6, r2
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L595
.L596:
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
.L595:	bl	caml_call_gc(PLT)
.L594:	b	.L596
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
.L597:
.L597:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L599
.L600:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L601 @ caml_curry7_5_app
	ldr	r4, .L602 @ caml_curry7_5
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L602:	.word	caml_curry7_5
.L601:	.word	caml_curry7_5_app
.L599:	bl	caml_call_gc(PLT)
.L598:	b	.L600
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
.L603:
.L603:
	mov	r6, r1
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L605
.L606:
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
.L605:	bl	caml_call_gc(PLT)
.L604:	b	.L606
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
.L607:
.L607:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L609
.L610:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L611 @ caml_curry7_6
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L611:	.word	caml_curry7_6
.L609:	bl	caml_call_gc(PLT)
.L608:	b	.L610
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
.L612:
.L612:
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L614
.L615:
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
.L614:	bl	caml_call_gc(PLT)
.L613:	b	.L615
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
.L616:
.L616:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L618
.L619:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L620 @ caml_curry6_1_app
	ldr	r4, .L621 @ caml_curry6_1
	movs	r5, #0x7 @ 0x5000007
	adds	r5, r5, #0x5000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L621:	.word	caml_curry6_1
.L620:	.word	caml_curry6_1_app
.L618:	bl	caml_call_gc(PLT)
.L617:	b	.L619
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
.L622:
.L622:
	str	r4, [sp, #16]
	str	r3, [sp, #12]
	str	r2, [sp, #8]
	str	r1, [sp, #4]
	str	r0, [sp, #0]
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L624
.L625:
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
.L624:	bl	caml_call_gc(PLT)
.L623:	b	.L625
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
.L626:
.L626:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L628
.L629:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L630 @ caml_curry6_2_app
	ldr	r4, .L631 @ caml_curry6_2
	movs	r5, #0x7 @ 0x4000007
	adds	r5, r5, #0x4000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L631:	.word	caml_curry6_2
.L630:	.word	caml_curry6_2_app
.L628:	bl	caml_call_gc(PLT)
.L627:	b	.L629
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
.L632:
.L632:
	str	r3, [sp, #8]
	str	r2, [sp, #4]
	str	r1, [sp, #0]
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L634
.L635:
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
.L634:	bl	caml_call_gc(PLT)
.L633:	b	.L635
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
.L636:
.L636:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L638
.L639:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L640 @ caml_curry6_3_app
	ldr	r4, .L641 @ caml_curry6_3
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L641:	.word	caml_curry6_3
.L640:	.word	caml_curry6_3_app
.L638:	bl	caml_call_gc(PLT)
.L637:	b	.L639
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
.L642:
.L642:
	str	r2, [sp, #0]
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L644
.L645:
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
.L644:	bl	caml_call_gc(PLT)
.L643:	b	.L645
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
.L646:
.L646:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L648
.L649:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L650 @ caml_curry6_4_app
	ldr	r4, .L651 @ caml_curry6_4
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L651:	.word	caml_curry6_4
.L650:	.word	caml_curry6_4_app
.L648:	bl	caml_call_gc(PLT)
.L647:	b	.L649
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
.L652:
.L652:
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L654
.L655:
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
.L654:	bl	caml_call_gc(PLT)
.L653:	b	.L655
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
.L656:
.L656:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L658
.L659:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L660 @ caml_curry6_5
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L660:	.word	caml_curry6_5
.L658:	bl	caml_call_gc(PLT)
.L657:	b	.L659
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
.L661:
.L661:
	mov	r5, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L663
.L664:
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
.L663:	bl	caml_call_gc(PLT)
.L662:	b	.L664
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
.L665:
.L665:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L667
.L668:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L669 @ caml_curry5_1_app
	ldr	r4, .L670 @ caml_curry5_1
	movs	r5, #0x7 @ 0x4000007
	adds	r5, r5, #0x4000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L670:	.word	caml_curry5_1
.L669:	.word	caml_curry5_1_app
.L667:	bl	caml_call_gc(PLT)
.L666:	b	.L668
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
.L671:
.L671:
	str	r3, [sp, #8]
	str	r2, [sp, #4]
	str	r1, [sp, #0]
	mov	r7, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L673
.L674:
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
.L673:	bl	caml_call_gc(PLT)
.L672:	b	.L674
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
.L675:
.L675:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L677
.L678:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L679 @ caml_curry5_2_app
	ldr	r4, .L680 @ caml_curry5_2
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L680:	.word	caml_curry5_2
.L679:	.word	caml_curry5_2_app
.L677:	bl	caml_call_gc(PLT)
.L676:	b	.L678
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
.L681:
.L681:
	str	r2, [sp, #0]
	mov	r4, r1
	mov	r7, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L683
.L684:
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
.L683:	bl	caml_call_gc(PLT)
.L682:	b	.L684
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
.L685:
.L685:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L687
.L688:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L689 @ caml_curry5_3_app
	ldr	r4, .L690 @ caml_curry5_3
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L690:	.word	caml_curry5_3
.L689:	.word	caml_curry5_3_app
.L687:	bl	caml_call_gc(PLT)
.L686:	b	.L688
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
.L691:
.L691:
	mov	r4, r1
	mov	r3, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L693
.L694:
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
.L693:	bl	caml_call_gc(PLT)
.L692:	b	.L694
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
.L695:
.L695:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L697
.L698:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L699 @ caml_curry5_4
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L699:	.word	caml_curry5_4
.L697:	bl	caml_call_gc(PLT)
.L696:	b	.L698
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
.L700:
.L700:
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L702
.L703:
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
.L702:	bl	caml_call_gc(PLT)
.L701:	b	.L703
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
.L704:
.L704:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L706
.L707:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L708 @ caml_curry4_1_app
	ldr	r4, .L709 @ caml_curry4_1
	movs	r5, #0x7 @ 0x3000007
	adds	r5, r5, #0x3000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L709:	.word	caml_curry4_1
.L708:	.word	caml_curry4_1_app
.L706:	bl	caml_call_gc(PLT)
.L705:	b	.L707
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
.L710:
.L710:
	str	r2, [sp, #0]
	mov	r7, r1
	mov	r6, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L712
.L713:
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
.L712:	bl	caml_call_gc(PLT)
.L711:	b	.L713
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
.L714:
.L714:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L716
.L717:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L718 @ caml_curry4_2_app
	ldr	r4, .L719 @ caml_curry4_2
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L719:	.word	caml_curry4_2
.L718:	.word	caml_curry4_2_app
.L716:	bl	caml_call_gc(PLT)
.L715:	b	.L717
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
.L720:
.L720:
	mov	r3, r1
	mov	r6, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L722
.L723:
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
.L722:	bl	caml_call_gc(PLT)
.L721:	b	.L723
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
.L724:
.L724:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L726
.L727:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L728 @ caml_curry4_3
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L728:	.word	caml_curry4_3
.L726:	bl	caml_call_gc(PLT)
.L725:	b	.L727
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
.L729:
.L729:
	mov	r3, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L731
.L732:
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
.L731:	bl	caml_call_gc(PLT)
.L730:	b	.L732
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
.L733:
.L733:
   sub     alloc_ptr, alloc_ptr, #0x18
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L735
.L736:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r6, .L737 @ caml_curry3_1_app
	ldr	r4, .L738 @ caml_curry3_1
	movs	r5, #0x7 @ 0x2000007
	adds	r5, r5, #0x2000000
	movs	r3, #0xf7 @ 0x14f7
	adds	r3, r3, #0x1400
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
.L738:	.word	caml_curry3_1
.L737:	.word	caml_curry3_1_app
.L735:	bl	caml_call_gc(PLT)
.L734:	b	.L736
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
.L739:
.L739:
	mov	r5, r1
	mov	r4, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L741
.L742:
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
.L741:	bl	caml_call_gc(PLT)
.L740:	b	.L742
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
.L743:
.L743:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L745
.L746:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L747 @ caml_curry3_2
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L747:	.word	caml_curry3_2
.L745:	bl	caml_call_gc(PLT)
.L744:	b	.L746
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
.L748:
.L748:
	mov	r2, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L750
.L751:
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
.L750:	bl	caml_call_gc(PLT)
.L749:	b	.L751
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
.L752:
.L752:
   sub     alloc_ptr, alloc_ptr, #0x14
	ldr	r2, [domain_state_ptr, #0]
     cmp     alloc_ptr, r2
     bcc     .L754
.L755:     add     r2, alloc_ptr, #4
	ldr	lr, [sp, #4]
	ldr	r4, .L756 @ caml_curry2_1
	movs	r5, #0x5 @ 0x1000005
	adds	r5, r5, #0x1000000
	movs	r3, #0xf7 @ 0x10f7
	adds	r3, r3, #0x1000
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
.L756:	.word	caml_curry2_1
.L754:	bl	caml_call_gc(PLT)
.L753:	b	.L755
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
.L757:
.L757:
	mov	r3, r0
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L759
.L760:
	ldr	r2, [r1, #12]
	ldr	r0, [r1, #8]
	ldr	r4, [r2, #8]
	mov	r1, r3
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r4
	.cfi_adjust_cfa_offset	8
.L759:	bl	caml_call_gc(PLT)
.L758:	b	.L760
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
.L761:
.L761:
	mov	r2, r1
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L763
.L764:
	ldr	r4, [r2, #8]
	ldr	r1, [r0, #4]
	ldr	r0, [r0, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r4
	.cfi_adjust_cfa_offset	8
.L763:	bl	caml_call_gc(PLT)
.L762:	b	.L764
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
.L765:
.L765:
	mov	r3, r1
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L767
.L768:
	ldr	r5, [r3, #8]
	ldr	r1, [r0, #4]
	ldr	r2, [r0, #8]
	ldr	r0, [r0, #0]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	8
.L767:	bl	caml_call_gc(PLT)
.L766:	b	.L768
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
.L769:
.L769:
	mov	r4, r1
	ldr	r12, [domain_state_ptr, #0]
	cmp	alloc_ptr, r12
	bls	.L771
.L772:
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
.L771:	bl	caml_call_gc(PLT)
.L770:	b	.L772
	.cfi_endproc
	.type	caml_tuplify4, %function
	.size	caml_tuplify4, .-caml_tuplify4
	.text
	.align	2
	.globl	caml_apply11
	.thumb
	.type	caml_apply11, %function
.L775:
	movs	r12, #0x27
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply11:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x178
	cmp	sp, r12
	bcc	.L775
	sub	sp, sp, #0x38
	.cfi_adjust_cfa_offset	56
	.cfi_offset 14, -4
	str	lr, [sp, #52]
.L774:
.L774:
	str	r1, [sp, #8]
	ldr	r1, [domain_state_ptr, #532]
	str	r7, [sp, #32]
	ldr	r7, [r1, #4]
	str	r5, [sp, #24]
	ldr	r5, [domain_state_ptr, #528]
	asrs	r12, r7, #24
	str	r4, [sp, #20]
	ldr	r4, [domain_state_ptr, #524]
	str	r3, [sp, #16]
	ldr	r3, [domain_state_ptr, #520]
	str	r3, [sp, #36]
	str	r4, [sp, #40]
	str	r5, [sp, #44]
	str	r6, [sp, #28]
	str	r2, [sp, #12]
	str	r0, [sp, #4]
	cmp	r12, #11
	bne	.L773
	ldr	r12, [r1, #8]
	str	r1, [sp, #0]
	str	r12, [sp, #48]
	ldr	r12, [sp, #36]
	ldr	r1, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #40]
	ldr	r7, [sp, #32]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #44]
	ldr	r6, [sp, #28]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #0]
	ldr	r5, [sp, #24]
	str	r12, [domain_state_ptr, #532]
	ldr	r12, [sp, #48]
	ldr	r4, [sp, #20]
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #12]
	ldr	r0, [sp, #4]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	56
.L773:
	ldr	r0, [r1, #0]
	str	r0, [sp, #0]
	ldr	r4, [sp, #0]
	ldr	r0, [sp, #4]
	mov	lr, pc
	bx	r4
.L776:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #8]
	mov	lr, pc
	bx	r2
.L777:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #12]
	mov	lr, pc
	bx	r4
.L778:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #16]
	mov	lr, pc
	bx	r6
.L779:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #20]
	mov	lr, pc
	bx	r12
.L780:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #24]
	mov	lr, pc
	bx	r2
.L781:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #28]
	mov	lr, pc
	bx	r3
.L782:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #32]
	mov	lr, pc
	bx	r5
.L783:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #36]
	mov	lr, pc
	bx	r7
.L784:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #40]
	mov	lr, pc
	bx	r2
.L785:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #44]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r2
	.cfi_adjust_cfa_offset	56
	.cfi_endproc
	.type	caml_apply11, %function
	.size	caml_apply11, .-caml_apply11
	.text
	.align	2
	.globl	caml_apply10
	.thumb
	.type	caml_apply10, %function
.L788:
	movs	r12, #0x27
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply10:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x178
	cmp	sp, r12
	bcc	.L788
	sub	sp, sp, #0x38
	.cfi_adjust_cfa_offset	56
	.cfi_offset 14, -4
	str	lr, [sp, #52]
.L787:
.L787:
	str	r1, [sp, #8]
	ldr	r1, [domain_state_ptr, #528]
	str	r5, [sp, #24]
	ldr	r5, [r1, #4]
	str	r6, [sp, #28]
	asrs	r6, r5, #24
	str	r3, [sp, #16]
	ldr	r3, [domain_state_ptr, #524]
	str	r2, [sp, #12]
	ldr	r2, [domain_state_ptr, #520]
	str	r2, [sp, #36]
	str	r3, [sp, #40]
	str	r7, [sp, #32]
	str	r4, [sp, #20]
	str	r0, [sp, #4]
	cmp	r6, #10
	bne	.L786
	ldr	r12, [r1, #8]
	str	r1, [sp, #0]
	str	r12, [sp, #44]
	ldr	r12, [sp, #36]
	ldr	r1, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #40]
	ldr	r7, [sp, #32]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #0]
	ldr	r6, [sp, #28]
	str	r12, [domain_state_ptr, #528]
	ldr	r12, [sp, #44]
	ldr	r5, [sp, #24]
	ldr	r4, [sp, #20]
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #12]
	ldr	r0, [sp, #4]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	56
.L786:
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #4]
	str	r7, [sp, #0]
	ldr	r2, [sp, #0]
	mov	lr, pc
	bx	r2
.L789:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #8]
	mov	lr, pc
	bx	r2
.L790:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #12]
	mov	lr, pc
	bx	r2
.L791:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #16]
	mov	lr, pc
	bx	r4
.L792:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #20]
	mov	lr, pc
	bx	r6
.L793:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #24]
	mov	lr, pc
	bx	r12
.L794:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #28]
	mov	lr, pc
	bx	r2
.L795:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #32]
	mov	lr, pc
	bx	r3
.L796:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #36]
	mov	lr, pc
	bx	r5
.L797:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #40]
	add	sp, sp, #0x38
	.cfi_adjust_cfa_offset	-56
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	56
	.cfi_endproc
	.type	caml_apply10, %function
	.size	caml_apply10, .-caml_apply10
	.text
	.align	2
	.globl	caml_apply9
	.thumb
	.type	caml_apply9, %function
.L800:
	movs	r12, #0x26
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply9:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x170
	cmp	sp, r12
	bcc	.L800
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L799:
.L799:
	str	r1, [sp, #8]
	ldr	r1, [domain_state_ptr, #520]
	str	r1, [sp, #36]
	ldr	r1, [domain_state_ptr, #524]
	str	r3, [sp, #16]
	ldr	r3, [r1, #4]
	str	r4, [sp, #20]
	asrs	r4, r3, #24
	str	r7, [sp, #32]
	str	r6, [sp, #28]
	str	r5, [sp, #24]
	str	r2, [sp, #12]
	str	r0, [sp, #4]
	cmp	r4, #9
	bne	.L798
	ldr	r12, [r1, #8]
	str	r1, [sp, #0]
	str	r12, [sp, #40]
	ldr	r12, [sp, #36]
	ldr	r1, [sp, #8]
	str	r12, [domain_state_ptr, #520]
	ldr	r12, [sp, #0]
	ldr	r7, [sp, #32]
	str	r12, [domain_state_ptr, #524]
	ldr	r12, [sp, #40]
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
.L798:
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #4]
	str	r5, [sp, #0]
	ldr	r5, [sp, #0]
	mov	lr, pc
	bx	r5
.L801:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #8]
	mov	lr, pc
	bx	r7
.L802:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #12]
	mov	lr, pc
	bx	r2
.L803:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #16]
	mov	lr, pc
	bx	r2
.L804:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #20]
	mov	lr, pc
	bx	r4
.L805:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #24]
	mov	lr, pc
	bx	r6
.L806:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #28]
	mov	lr, pc
	bx	r12
.L807:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #32]
	mov	lr, pc
	bx	r2
.L808:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #36]
	add	sp, sp, #0x30
	.cfi_adjust_cfa_offset	-48
	ldr	lr, [sp, #-4]
	bx	r3
	.cfi_adjust_cfa_offset	48
	.cfi_endproc
	.type	caml_apply9, %function
	.size	caml_apply9, .-caml_apply9
	.text
	.align	2
	.globl	caml_apply8
	.thumb
	.type	caml_apply8, %function
.L811:
	movs	r12, #0x26
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply8:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x170
	cmp	sp, r12
	bcc	.L811
	sub	sp, sp, #0x30
	.cfi_adjust_cfa_offset	48
	.cfi_offset 14, -4
	str	lr, [sp, #44]
.L810:
.L810:
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
	bne	.L809
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
.L809:
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #4]
	str	r3, [sp, #0]
	ldr	r2, [sp, #0]
	mov	lr, pc
	bx	r2
.L812:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #8]
	mov	lr, pc
	bx	r5
.L813:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #12]
	mov	lr, pc
	bx	r7
.L814:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #16]
	mov	lr, pc
	bx	r2
.L815:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #20]
	mov	lr, pc
	bx	r2
.L816:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #24]
	mov	lr, pc
	bx	r4
.L817:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #28]
	mov	lr, pc
	bx	r6
.L818:
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
.L821:
	movs	r12, #0x24
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply7:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x160
	cmp	sp, r12
	bcc	.L821
	sub	sp, sp, #0x20
	.cfi_adjust_cfa_offset	32
	.cfi_offset 14, -4
	str	lr, [sp, #28]
.L820:
.L820:
	ldr	r12, [r7, #4]
	asrs	r12, r12, #24
	cmp	r12, #7
	bne	.L819
	ldr	r12, [r7, #8]
	add	sp, sp, #0x20
	.cfi_adjust_cfa_offset	-32
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	32
.L819:
	str	r2, [sp, #4]
	ldr	r2, [r7, #0]
	str	r1, [sp, #0]
	mov	r1, r7
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	str	r5, [sp, #16]
	str	r6, [sp, #20]
	mov	lr, pc
	bx	r2
.L822:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #0]
	mov	lr, pc
	bx	r4
.L823:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #4]
	mov	lr, pc
	bx	r6
.L824:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #8]
	mov	lr, pc
	bx	r12
.L825:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #12]
	mov	lr, pc
	bx	r2
.L826:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #16]
	mov	lr, pc
	bx	r3
.L827:
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
.L830:
	movs	r12, #0x23
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply6:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x158
	cmp	sp, r12
	bcc	.L830
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L829:
.L829:
	ldr	r12, [r6, #4]
	asrs	r7, r12, #24
	cmp	r7, #6
	bne	.L828
	ldr	r7, [r6, #8]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r7
	.cfi_adjust_cfa_offset	24
.L828:
	str	r2, [sp, #4]
	ldr	r2, [r6, #0]
	str	r1, [sp, #0]
	mov	r1, r6
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	str	r5, [sp, #16]
	mov	lr, pc
	bx	r2
.L831:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #0]
	mov	lr, pc
	bx	r3
.L832:
	mov	r1, r0
	ldr	r5, [r1, #0]
	ldr	r0, [sp, #4]
	mov	lr, pc
	bx	r5
.L833:
	mov	r1, r0
	ldr	r7, [r1, #0]
	ldr	r0, [sp, #8]
	mov	lr, pc
	bx	r7
.L834:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #12]
	mov	lr, pc
	bx	r2
.L835:
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
.L838:
	movs	r12, #0x23
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply5:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x158
	cmp	sp, r12
	bcc	.L838
	sub	sp, sp, #0x18
	.cfi_adjust_cfa_offset	24
	.cfi_offset 14, -4
	str	lr, [sp, #20]
.L837:
.L837:
	ldr	r7, [r5, #4]
	asrs	r12, r7, #24
	cmp	r12, #5
	bne	.L836
	ldr	r6, [r5, #8]
	add	sp, sp, #0x18
	.cfi_adjust_cfa_offset	-24
	ldr	lr, [sp, #-4]
	bx	r6
	.cfi_adjust_cfa_offset	24
.L836:
	str	r2, [sp, #4]
	ldr	r2, [r5, #0]
	str	r1, [sp, #0]
	mov	r1, r5
	str	r3, [sp, #8]
	str	r4, [sp, #12]
	mov	lr, pc
	bx	r2
.L839:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #0]
	mov	lr, pc
	bx	r2
.L840:
	mov	r1, r0
	ldr	r4, [r1, #0]
	ldr	r0, [sp, #4]
	mov	lr, pc
	bx	r4
.L841:
	mov	r1, r0
	ldr	r6, [r1, #0]
	ldr	r0, [sp, #8]
	mov	lr, pc
	bx	r6
.L842:
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
.L845:
	movs	r12, #0x22
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply4:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x150
	cmp	sp, r12
	bcc	.L845
	sub	sp, sp, #0x10
	.cfi_adjust_cfa_offset	16
	.cfi_offset 14, -4
	str	lr, [sp, #12]
.L844:
.L844:
	ldr	r6, [r4, #4]
	asrs	r7, r6, #24
	cmp	r7, #4
	bne	.L843
	ldr	r5, [r4, #8]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r5
	.cfi_adjust_cfa_offset	16
.L843:
	ldr	r12, [r4, #0]
	str	r1, [sp, #0]
	mov	r1, r4
	str	r2, [sp, #4]
	str	r3, [sp, #8]
	mov	lr, pc
	bx	r12
.L846:
	mov	r1, r0
	ldr	r2, [r1, #0]
	ldr	r0, [sp, #0]
	mov	lr, pc
	bx	r2
.L847:
	mov	r1, r0
	ldr	r3, [r1, #0]
	ldr	r0, [sp, #4]
	mov	lr, pc
	bx	r3
.L848:
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
.L851:
	movs	r12, #0x22
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply3:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x150
	cmp	sp, r12
	bcc	.L851
	sub	sp, sp, #0x10
	.cfi_adjust_cfa_offset	16
	.cfi_offset 14, -4
	str	lr, [sp, #12]
.L850:
.L850:
	ldr	r4, [r3, #4]
	asrs	r5, r4, #24
	cmp	r5, #3
	bne	.L849
	ldr	r4, [r3, #8]
	add	sp, sp, #0x10
	.cfi_adjust_cfa_offset	-16
	ldr	lr, [sp, #-4]
	bx	r4
	.cfi_adjust_cfa_offset	16
.L849:
	ldr	r6, [r3, #0]
	str	r1, [sp, #0]
	mov	r1, r3
	str	r2, [sp, #4]
	mov	lr, pc
	bx	r6
.L852:
	mov	r1, r0
	ldr	r12, [r1, #0]
	ldr	r0, [sp, #0]
	mov	lr, pc
	bx	r12
.L853:
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
.L856:
	movs	r12, #0x21
	push	{r12, lr}
	bl	caml_call_realloc_stack(PLT)
	pop	{r12, lr}
caml_apply2:
	.cfi_startproc
	ldr	r12, [domain_state_ptr, #40]
	add	r12, r12, #0x148
	cmp	sp, r12
	bcc	.L856
	sub	sp, sp, #0x8
	.cfi_adjust_cfa_offset	8
	.cfi_offset 14, -4
	str	lr, [sp, #4]
.L855:
.L855:
	ldr	r3, [r2, #4]
	asrs	r4, r3, #24
	cmp	r4, #2
	bne	.L854
	ldr	r12, [r2, #8]
	add	sp, sp, #0x8
	.cfi_adjust_cfa_offset	-8
	ldr	lr, [sp, #-4]
	bx	r12
	.cfi_adjust_cfa_offset	8
.L854:
	ldr	r5, [r2, #0]
	str	r1, [sp, #0]
	mov	r1, r2
	mov	lr, pc
	bx	r5
.L857:
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
