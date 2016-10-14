/******************************************************************************
*	MazeCase.str
*	Programa principal del juego MazeCase
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/
@@compliar con: gcc -o main MazeCase.s MazeMethods.s intro.s GameOver.s maiz.s testlaberintoL2.s testlaberintoL3.s gallinaSprite1.s gallinaSprite2.s laberintoL1.s pixelV2.c phys_to_virt.c gpio0_2.s colisiones.s
 
@PUERTOS DE GPIO
@@-----ENTRADA-----
@ GPIO 6 = BTN abajo 
@ GPIO 19 = BTN derecha 
@ GPIO 13 = BTN izquierda 
@ GPIO 26 = BTN arriba 

 .text
 .align 2
 .global main
main:

@@--------------------INICIANDO DIRECCIONES Y POSICIONES----------------------*/
	ldr r0,=xRes
	ldr r1,=yRes
	bl getScreenAddr 			@Se obtiene la direccion de la pantalla 
	ldr r1,=pixelAddr
	str r0,[r1]


@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress @solo se llama una vez
	
	@GPIO para lectura puerto 6 
	mov r0,#6
	mov r1,#0
	bl SetGpioFunction	

	@GPIO para lectura puerto 13 
	mov r0,#13
	mov r1,#0
	bl SetGpioFunction	

	@GPIO para lectura puerto 19 
	mov r0,#19
	mov r1,#0
	bl SetGpioFunction

	@GPIO para lectura puerto 26 
	mov r0,#26
	mov r1,#0
	bl SetGpioFunction
	
welcomeLoop:
	bl welcomeImg
	bl wait
	bl welcomeImg2

	bl SuperWait
	@revisar boton arriba
	mov r0,#26
	bl GetGpio
	cmp r0,#1
	beq levelOneLoop
	
	@revisar boton derecha
	mov r0,#19
	bl GetGpio
	cmp r0,#1
	beq levelTwoLoop
	
	@revisar boton izquierda
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	beq levelThreeLoop
	
	@revisar boton abajo
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	beq GameOverLoop
b welcomeLoop

levelOneLoop:

	ldr r1,=origenX
	ldr	r1,[r1]
	ldr r2,=origenY
	ldr r2,[r2]
	@colisiones
	bl L1O1
	bl L1O2
	bl L1O3

	bl background1
	bl character
	bl maizImg
	push {r0}
	bl wait
	bl wait
	pop {r0}
	bl background1
	bl character2
	bl maizImg
	push {r0}
	bl wait
	bl wait
	pop {r0}

	@revisar boton arriba
	mov r0,#26
	bl GetGpio
	cmp r0,#1
	bleq decrementoEnY
	
	@revisar boton derecha
	mov r0,#19
	bl GetGpio
	cmp r0,#1
	bleq aumentoEnX
	
	@revisar boton izquierda
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	bleq decrementoEnX
	
	@revisar boton abajo
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	bleq aumentoEnY
b levelOneLoop

aumentoEnX:
	push {lr}
	ldr r0,=origenX
	ldr r1,[r0]
	ldr r2,=topeEnX
	ldr r2,[r2]
	cmp r1,r2
	beq EndaumentoEnX
	add r1,#20
	str r1,[r0]
EndaumentoEnX:
pop {pc}

aumentoEnY:
	push {lr}
	ldr r0,=origenY
	ldr r1,[r0]
	ldr r2,=topeEnY
	ldr r2,[r2]
	cmp r1,r2
	beq EndaumentoEnY
	add r1,#20
	str r1,[r0]
EndaumentoEnY:
pop {pc}

decrementoEnX:
	push {lr}
	ldr r0,=origenX
	ldr r1,[r0]
	cmp r1,#0
	beq EnddecrementoEnX
	sub r1,#20
	str r1,[r0]
EnddecrementoEnX:
pop {pc}

decrementoEnY:
	push {lr}
	ldr r0,=origenY
	ldr r1,[r0]
	cmp r1,#0
	subge r1,#20
	strge r1,[r0]
EnddecrementoEnY:
pop {pc}



levelTwoLoop:
	bl background2
	bl character 
	push {r0}
	bl wait
	pop {r0}
	bl background2
	bl character2
	push {r0}
	bl wait
	pop {r0}
b levelTwoLoop

levelThreeLoop:
	bl background3
	bl character 
	push {r0}
	bl wait
	pop {r0}
	bl background3
	bl character2
	push {r0}
	bl wait
	pop {r0}
b levelThreeLoop

.global GameOverLoop
GameOverLoop:
	ldr r0,=origenX
	ldr r1,[r0]
	mov r1,#0
	str r1,[r0]

	ldr r0,=origenY
	ldr r1,[r0]
	mov r1,#0
	str r1,[r0]

	bl GameOverImg
	bl SuperWait
	
	@revisar boton abajo
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	beq welcomeLoop

b GameOverLoop


@.global winnersLoop
@winnersLoop:
@	ldr r0,=origenX
@	ldr r1,[r0]
@	mov r1,#0
@	str r1,[r0]
@
@	ldr r0,=origenY
@	ldr r1,[r0]
@	mov r1,#0
@	str r1,[r0]
@
@	bl WinGameImg
@	bl SuperWait
@	
@	@revisar boton abajo
@	mov r0,#6
@	bl GetGpio
@	cmp r0,#1
@	beq welcomeLoop
@
@b GameOverLoop


wait:
	ldr r0, =bign	 @ big number
	ldr r0, [r0]
	sleepLoop:
	sub r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr 

SuperWait:
	push {lr}
	bl wait
	bl wait
	bl wait
	bl wait
	bl wait
	bl wait
	bl wait
	bl wait
pop {pc}

.data
.global pixelAddr,origenX,origenY,milCien
	pixelAddr: .word 0
	bign: .word 0xfffffff
	origenY: .word 0
	origenX: .word 0
	topeEnX: .word 1000
	topeEnY: .word 670
	milCien: .word 1100
.global myloc
	myloc: .word 0

