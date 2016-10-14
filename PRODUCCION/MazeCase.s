/******************************************************************************
*	MazeCase.s
*	Programa principal del juego MazeCase
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/
@@compliar con: gcc -o main MazeCase.s MazeMethods.s intro.s GameOver.s testlaberintoL2.s testlaberintoL3.s gallinaSprite1.s gallinaSprite2.s laberintoL1.s pixelV2.c phys_to_virt.c gpio0_2.s colisiones.s
 
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
	@revisar boton arriba
	mov r0,#26
	bl GetGpio
	cmp r0,#1
	bleq levelOneLoop
	
	@revisar boton derecha
	mov r0,#19
	bl GetGpio
	cmp r0,#1
	bleq levelTwoLoop
	
	@revisar boton izquierda
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	bleq levelThreeLoop
	
	@revisar boton abajo
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	bleq GameOverLoop
b welcomeLoop

levelOneLoop:
	bl background1
	bl character
	push {r0}
	bl wait
	bl wait
	pop {r0}
	bl background1
	bl character2
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
	ldr r1,=origenX
	ldr	r1,[r1]
	ldr r2,=origenY
	ldr r2,[r2]
	bl L1O1
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
	ldr r1,=origenX
	ldr	r1,[r1]
	ldr r2,=origenY
	ldr r2,[r2]
	bl L1O1

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

GameOverLoop:
	bl GameOverImg
	push {r0}
	bl wait
	pop {r0}
b GameOverLoop


wait:
	ldr r0, =bign	 @ big number
	ldr r0, [r0]
	sleepLoop:
	sub r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr 

.data
.global pixelAddr,origenX,origenY
	pixelAddr: .word 0
	bign: .word 0xfffffff
	origenY: .word 1
	origenX: .word 1
	topeEnX: .word 1000
	topeEnY: .word 670
.global myloc
	myloc: .word 0
