/******************************************************************************
*	impIm.s
*	Imprime una imagen segun posicion, altura, ancho y matriz de colores indicado
*	Por: Diego Castaneda y Jonnathan Juarez
*   Creado: 04/10/2016
*******************************************************************************/

.global impIm

impIm: 
	push {lr}
	impresion: 

		colour 	  .req r3
		addrPixel .req r5
		countByte .req r6
		ancho	  .req r7
		alto	  .req r8
		posY 	  .req r9
		posX      .req r10

		ldr posY,[sp], #4
		ldr posX, [sp], #4

		ldr ancho, [r1]
		add ancho, ancho, posX
		ldr alto, [r2]
		add alto, alto, posY

		x	  	  .req r1
		y         .req r2

	render$:

		
		mov countByte,#0 				@Contador que cuenta la cantidad de bytes dibujados
		mov y,#0
		add y, y, posY
		
		@Ciclo que dibuja filas
		drawRow$:
			mov x,#0
			add x, x, posX
			drawPixel$:
				cmp x,ancho				@comparar x con el ancho de la imagen
				bge end
				mov addrPixel, r0 	@Obtenemos la direccion de la matriz con los colores
				ldrb colour,[addrPixel,countByte]	@Leer el dato de la matriz.
				

				push {r0-r12, lr}

				ldr r0,=pixelAddr
				ldr r0,[r0] 
				bl pixel				@Dibujamos el pixel. r1=x,r2=y,r3=colour
				pop {r0-r12, lr}
				add countByte,#1 		@Incrementamos los bytes dibujados
				add x,#1 				@Aumenta el contador del ancho de la imagen
			
				b drawPixel$
		end:	
			@ aumentamos y
			add y,#1
						
			@Revisamos si ya dibujamos toda la imagen.
			teq y,alto
			bne drawRow$

	b render$

	.unreq x		  
	.unreq	y         
	.unreq	colour 	  
	.unreq	addrPixel 
	.unreq	countByte 
	.unreq	ancho	  
	.unreq	alto	
