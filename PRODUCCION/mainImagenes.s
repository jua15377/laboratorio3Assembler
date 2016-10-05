/******************************************************************************
*	mainImagenes.s
*	Imprime una imagen utilizando impIm
*	Por: Diego Castaneda y Jonnathan Juarez
*   Creado: 04/10/2016
*******************************************************************************/
 .text
 .align 2
 .global main
main:
	#-------------------------
	#get screen address
	#-------------------------
	bl getScreenAddr
	ldr r1,=pixelAddr
	str r0,[r1]

	@posiciones iniciales del desierto 0, 0
	mov r0, #0  @el primero ingresado sera el X
	mov r1, #0 	@el segundo ingresado sera el y

	str r0, [sp, #-4]!
	str r1, [sp, #-4]!



	ldr r0, =desierto
	ldr r1, =desiertoWidth
	ldr r2, =desiertoHeight
	bl impIm 



.data
.global pixelAddr
pixelAddr: .word 0
x: 		   .word 0

