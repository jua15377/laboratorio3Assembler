/*------------------------------------------------------*/
/*Universidad del Valle de Guatemala 				   	*/
/*Taller de Assembeler, Seccion: 31   				   	*/
/*Jonnathan Juarez, Carnet: 15377    				   	*/
/*Diego Castaneda,  Carnet: 15151 						*/
/*Laboratorio 2:Control de posiciones de un Servomotor  */ 
/*main: asignacion GPIO e implementacion de rutinas     */
/*------------------------------------------------------*/

/*compilar con: gcc -o main phys_to_virt.c gpio0_2.s main.s*/
@@PUERTOS DE GPIO
@@-----ENTRADA-----
@ GPIO 6 = BTN abajo 
@ GPIO 19 = BTN derecha 
@ GPIO 13 = BTN izquierda 
@ GPIO 26 = BTN arriba 


.text
.align 2
.global main
@incica codido
main:
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


mainLoop:
	@revisar boton arriba
	mov r0,#26
	bl GetGpio
	cmp r0,#1
	bleq btnArriba
	@revisar boton derecha
	mov r0,#19
	bl GetGpio
	cmp r0,#1
	bleq btnDerecha
	@revisar boton izquierda
	mov r0,#13
	bl GetGpio
	cmp r0,#1
	bleq btnIzquierda
	@revisar boton abajo
	mov r0,#6
	bl GetGpio
	cmp r0,#1
	bleq btnAbajo

b mainLoop


btnArriba:
	push {lr}
		ldr r0,=testTag1
		bl puts
	pop {pc}
btnDerecha:
	push {lr}
		ldr r0,=testTag2
		bl puts
	pop {pc}
btnIzquierda:
	push {lr}
		ldr r0,=testTag3
		bl puts
	pop {pc}
btnAbajo:
	push {lr}
		ldr r0,=testTag4
		bl puts
	pop {pc}


salida:
	@salida al SO
	MOV R7, #1				
	SWI 0
@datos
.data
.align 2
	.global myloc
	myloc: .word 0

formato:
	.asciz "%s"
testTag1:
	.asciz "arriba\n"
testTag2:
	.asciz "derecha\n"
testTag3:
	.asciz "izquierda\n"
testTag4:
	.asciz "abajo\n"
@@-------
