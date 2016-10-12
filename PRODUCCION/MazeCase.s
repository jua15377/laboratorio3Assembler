/******************************************************************************
*	MazeCase.s
*	Programa principal del juego MazeCase
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/
@@compliar con: gcc -o main MazeCase.s MazeCaseMetods.s gallinaSprite1.s gallinaSprite2.s laberintoL1.s pixelV2.c
 .text
 .align 2
 .global main
main:

@@--------------------INICIANDO DIRECCIONES Y POSICIONES----------------------*/
	bl getScreenAddr 			@Se obtiene la direccion de la pantalla 
	ldr r1,=pixelAddr
	str r0,[r1]
mainloop:
	bl background
	bl character 
	push {r0}
	bl wait
	pop {r0}
	bl background
	bl character2
	push {r0}
	bl wait
	pop {r0}
b mainloop
wait:
	ldr r0, =bign	 @ big number
	ldr r0, [r0]
	sleepLoop:
	subs r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr 

.data
.global pixelAddr,origenX,origenY
pixelAddr:
	.word 0
bign: .word 0xfffffff