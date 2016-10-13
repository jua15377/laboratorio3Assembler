/******************************************************************************
*	MazeCase.s
*	Programa principal del juego MazeCase
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/
@@compliar con: gcc -o main MazeCase.s MazeMethods.s intro.s GameOver.s testlaberintoL2.s testlaberintoL3.s gallinaSprite1.s gallinaSprite2.s laberintoL1.s pixelV2.c phys_to_virt.c gpio0_2.s
 
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
	ldr r0, =xRes
	ldr r1, =yRes
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

	@Posicionando inicialmente al personaje
	ldr r0, =20
	ldr r1, =origenX
	ldr r0, [r1]

	ldr r0, =20
	ldr r1, =origenY
	str r0, [r1]

levelOneLoop:
	bl background1


	bl character

	@revisar boton arriba
	mov r0,#26
	bl GetGpio
	
	cmp r0,#1
	ldreq r0, =origenY
	ldreq r0, [r0]

	
	cmp r0, #0
	ldrne r1, =origenY
	subne r0, #1
	strne r0, [r1]

	
	@revisar boton derecha
	mov r0,#19
	bl GetGpio
	cmp r0,#1
	ldreq r0, =origenX
	ldreq r0, [r0]
	
	cmp r0, #0
	ldrne r1, =origenX
	addne r0, #1
	strne r0, [r1]
	
	@revisar boton izquierda
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	ldreq r0, =origenX
	ldreq r0, [r0]
	
	cmp r0, #0
	ldrne r1, =origenX
	subne r0, #1
	strne r0, [r1]
	
	@revisar boton abajo
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	ldreq r0, =origenY
	ldreq r0, [r0]
	
	cmp r0, #0
	ldrne r1, =origenY
	addne r0, #1
	strne r0, [r1]

	push {r0}
	bl wait
	pop {r0}
	bl background1
	bl character2
	push {r0}
	bl wait
	pop {r0}
b levelOneLoop

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
	subs r0,#1
	bne sleepLoop @ loop delay
	mov pc,lr 

.data
.global pixelAddr,origenX,origenY, xRes, yRes
	pixelAddr: .word 0
	bign: .word 0xfffffff
	origenY: .word 20
	origenX: .word 20
	xRes: .word 0 
	yRes: .word 0
.global myloc
	myloc: .word 0
