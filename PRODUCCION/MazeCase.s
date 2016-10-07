/******************************************************************************
*	MazeCase.s
*	Programa principal del juego MazeCase
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*******************************************************************************/

 .text
 .align 2
 .global main
main:

/*--------------------INICIANDO DIRECCIONES Y POSICIONES----------------------*/
	
	ldr r0, =xRes				@Se da la direccion donde ira la resolucion de X
	ldr r1, =yRes 				@Se da la direccion donde ira la resolucion de Y
	bl getScreenAddr 			@Se obtiene la direccion de la pantalla 
	ldr r1,=pixelAddr
	str r0,[r1]

	push {r0-r12}
	bl background				@subrutina que colorea el fondo debidamente
	pop {r0-r12}
/*----------------------IMPRESION DEL PERSONAJE---------------------------------*/
	ldr r0, =ancho				@guarda en memoria el ancho de la imagen
	ldr r1, =gallinaSprite1Width
	ldr r1, [r1]
	str r1, [r0]

	ldr r0, =altura				@guarda en memoria la altura de la imagen
	ldr r1, =gallinaSprite1Height
	ldr r1, [r1]
	str r1, [r0]

	ldr r0, =0 					@guardar la posicion inicial de pintado de X en memoria
	ldr r1, =origenX
	str r0, [r1]

	ldr r0, =0					@guardar la posicion inicial de pintado de Y en memoria
	ldr r1, =origenX
	str r0, [r1]

	ldr r0, =gallinaSprite1 	@Carga la matriz de colores en r0

	push {r0-r12}
	bl character				@imprime el personaje sobre el fondo
	pop {r0-r12}


	mov r7, #1
	swi 0 

.data
.align 2

.global pixelAddr, origenX, origenY

xRes: 							@Resolucion en X
	.word 0
yRes: 							@Resolucion en Y
	.word 0 
pixelAddr: 						@Direccion de la pantalla
	.word 0 

origenX: 						@Sera el punto de origen, en X, para pintar la imagen
	.word 0
origenY: 						@Sera el punto de origen, en Y, para pintar la imagen
	.word 0 
