@/******************************************************************************
@*	MazeMethods.s
@*	Subrutinas del juego MazeCase
@*	Por: Diego Castaneda, Carnet: 15151
@*   	 Jonnathan Juares, Carnet: 15377
@*   Taller de Assembler, Seccio: 30
@*******************************************************************************/
@ ******************************************************************
@	background
@	Subrutina que imprime en pantalla el fondo que se desea colocar
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ ******************************************************************
.global background
background: 
	push {lr}
		x	  .req r1
		y         .req r2
		colour 	  .req r3
		addrPixel .req r5
		countByte .req r6
		ancho	  .req r7
		alto	  .req r8

	mov countByte,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr ancho,=laberintoL1Width
	ldr ancho,[ancho]
	ldr alto,=laberintoL1Height
	ldr alto,[alto]
	mov y,#0

	@Ciclo que dibuja filas
	drawRow:
		mov x,#0
		drawPixel:
			cmp x,ancho				@comparar x con el ancho de la imagen
			bge end
			ldr addrPixel,=laberintoL1 	@Obtenemos la direccion de la matriz con los colores
			ldrb colour,[addrPixel,countByte]	@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add countByte,#1 		@Incrementamos los bytes dibujados
			add x,#1 				@Aumenta el contador del ancho de la imagen
		
			b drawPixel
	end:	
		@ aumentamos y
		add y,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq y,alto
		bne drawRow

	.unreq x		  
	.unreq	y         
	.unreq	colour 	  
	.unreq	addrPixel 
	.unreq	countByte 
	.unreq	ancho	  
	.unreq	alto
pop {pc}

@ ****************************************************************************
@	character
@	Subrutina que imprime una imagen segun coordenadas, ancho y largo de la misma
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ *****************************************************************************
@ 	Asignaciones: 
@	r1 - comparador de x
@	r2 - comparador de y
@	r3 - matriz de colores
@   r4 - addrPixel 
@	r5 - direccion de la matriz
@	r6 - contador de bytes
@	r7 - ancho
@ 	r8 - alto
@*******************************************************************************
.global character
character: 
	push {lr} 
	
<<<<<<< HEAD
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=gallinaSprite1Width 			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=gallinaSprite1Height
	ldr r8,[r8]
	mov r2,#0
=======
	mov r6,#0 						@Contador que cuenta la cantidad de bytes dibujados

	ldr r7,=ancho					@Asignar valor al comparador de X	
	ldr r7,[r7]
	ldr r9, =origenX 				@Con la diferencia de tener un origen inicial donde colocarlo
	ldr r9, [r9]
	add r7, r9

	ldr r8,=altura 					@Asignar valor al comparador de Y
	ldr r8,[r8]	
	ldr r10, =origenY 				@Con diferencia de tener un origen inicial donde colocarlo
	ldr r10, [r10]
	add r8, r10

	ldr r2,=origenY
	ldr r2, [r2]

>>>>>>> 24c9466b3646a53bdd56955bbace90a80c23ec26
	filas:
		mov r1,#0
		dibujaPixel:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm
			ldr r5,=gallinaSprite1
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			cmp r3,#39
			blne pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
<<<<<<< HEAD
			add r6,#1 		@Incrementamos los bytes dibujados
=======
		resolucion: 	
			add r6,#1 				@Incrementamos los bytes dibujados
>>>>>>> 24c9466b3646a53bdd56955bbace90a80c23ec26
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel
	finIm:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas

	pop {pc}

@ ****************************************************************************
@	character
@	Subrutina que imprime una imagen segun coordenadas, ancho y largo de la misma
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ *****************************************************************************
@ 	Asignaciones: 
@	r1 - comparador de x
@	r2 - comparador de y
@	r3 - matriz de colores
@   r4 - addrPixel 
@	r5 - direccion de la matriz
@	r6 - contador de bytes
@	r7 - ancho
@ 	r8 - alto
@*******************************************************************************
.global character2
character2: 
	push {lr} 
	
	mov r6,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr r7,=gallinaSprite2Width 			@Asignar valor al comparador de Y
	ldr r7,[r7]
	ldr r8,=gallinaSprite2Height
	ldr r8,[r8]
	mov r2,#0
	filas2:
		mov r1,#0
		dibujaPixel2:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm2
			ldr r5,=gallinaSprite2
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			cmp r3,#39
			blne pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add r6,#1 		@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel2
	finIm2:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas2

	pop {pc}









