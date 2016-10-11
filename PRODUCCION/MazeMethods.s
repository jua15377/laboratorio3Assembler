/******************************************************************************
*	MazeMethods.s
*	Subrutinas del juego MazeCase
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/

@ ******************************************************************
@	backround
@	Subrutina que imprime en pantalla el fondo que se desea colocar
@	Parametros (en memoria):
@  	xRes: resolucion en X de la pantalla
@  	YRes: resolucion en Y de la pantalla
@  	fondo: matriz de colores del fondo a pintar
@ ******************************************************************


.global background
background: 
	push {lr}

		x	      .req r1        	@nombrar registros para mayor facilidad
		y         .req r2
		colour 	  .req r3
		addrPixel .req r5
		countByte .req r6
		ancho	  .req r7
		alto	  .req r8

	mov countByte,#0 				@Contador que cuenta la cantidad de bytes dibujados
	ldr ancho,=xRes
	ldr ancho,[ancho] 				@Establecemos el ancho de la pantalla
	ldr alto,=yRes
	ldr alto,[alto] 				@Establecemos el alto de la pantalla
	mov y,#0 

	/*-----------------------------Ciclo que dibuja filas-----------------------------------*/
	drawRow$:
		mov x,#0
		drawPixel$:
			cmp x,ancho				@comparar x con el ancho de la imagen
			bge end
			ldr addrPixel,=fondo 	@Obtenemos la direccion de la matriz con los colores
			ldrb colour,[addrPixel,countByte]	@Leer el dato de la matriz.
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
			add countByte,#1 		@Incrementamos los bytes dibujados
			add x,#1 				@Aumenta el contador del ancho de la imagen
		
			b drawPixel$
	end:	
		@ aumentamos y
		add y,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq y,alto
		bne drawRow$

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

	mov r5, r0
	
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

	filas:
		ldr r1, =origenX
		ldr r1, [r1]

		dibujaPixel:
			cmp r1,r7				@comparar x con el ancho de la imagen
			bge finIm
			
			ldrb r3,[r5,r6]			@Leer el dato de la matriz.

			cmp r3, #39
			beq resolucion
			
			ldr r0,=pixelAddr
			ldr r0,[r0] 
			push {r0-r12}
			bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
			pop {r0-r12}
		resolucion: 	
			add r6,#1 				@Incrementamos los bytes dibujados
			add r1,#1 				@Aumenta el contador del ancho de la imagen
		
			b dibujaPixel
	finIm:	
		@ aumentamos y
		add r2,#1
					
		@Revisamos si ya dibujamos toda la imagen.
		teq r2,r8
		bne filas

	pop {pc}











