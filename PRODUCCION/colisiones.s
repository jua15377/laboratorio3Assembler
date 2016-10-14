/******************************************************************************
*	L1O1
*	Primer obstaculo del laberinto 1
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*	Parametros: 
*		r1: posicion del pollo en x
*		r2: posicion del pollo en y
*******************************************************************************/
.global L1O1
L1O1: 
	push {lr}

	@parte superior ([0-251], 528)
	@En x se exitende de 0 a 251 pixeles
	@En y esta en 528, pero por el desfase del punto de referencia, 
	@ se tomara 428

	mov r3, #0
	mov r4, #440

	cmp r2, r4 				@Compara la posicion en Y con la del objeto
	bne Isderecha1 			@Si no son iguales, compara otra frontera del objeto
	
	superior1: 

		cmp r1, r3			@compara con la posicion de X superior del objeto
		beq gameOver 		@ si son iguales, game over
		
		add r3, #20
		cmp r3, #240
		bge Isderecha1		@si ya se acabo la frontera, pasa a la siguente

		b superior1 		@Si no se ha acabado la frontera superior,
								@ sigue comparando 

Isderecha1:  				@Comparara para el lado derecho, no sin antes
							@definir los valores iniciales de comparacion

	mov r3, #240 			@En X es 251
	mov r4, #440			@en Y es 428, tomando en cuenta el desfase de 
							@ la gallina

	cmp r1, #240 
	bne Isabajo1 			@si no esta en la posicion de X, se saltara el paso 
	
	derecha1: 
		cmp r2, r4 			@compara para todas las posibles posiciones de Y 
		beq gameOver 		@si en alguna caza, gameOver

		add r4, #20
		mov r5, #600	@si no, se agrega uno al contador
		
		
		cmp r4, r5 			@se compara con el limite
		bge Isabajo1 		@Si ya llego al limite, se pasa a la siguiente frontera

		b derecha1 			@Si no, se quedara comparando

	Isabajo1: 				@Lo mismo pero para la fronterra de abao

	mov r3, #260 			@Valor inicial de X 251,
	mov r4, #600		@Valor incial de comparacion de Y , 520


	cmp r2, r4 				@Compara si se encuentra a la altura
	bne end1 				@ y termina si no lo esta
	abajo1: 
		cmp r1, r3 			@Compara para todos los valores de X de abajo
		beq gameOver 		@y si caza en alguno, gameOver

		sub r3, #20			@Resta de 1 en 1 al contador
		cmp r3, #0 			@y chequea si ya llego al limite
		ble end1 			@Si ya lo alcanzo, termina de comparar

	b abajo1 			@en caso contrario, sigue comparando



gameOver:  					@Subrutina que lanzara la imagen de gameOver
					
	b GameOverLoop	

end1:  						@final del objeto 1

	pop {pc}


/******************************************************************************
*	L1O2
*	Segundo obstaculo del laberinto 1
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*	Parametros: 
*		r1: posicion del pollo en x
*		r2: posicion del pollo en y
*******************************************************************************/
.global L1O2
L1O2: 
	push {lr}

	mov r3, #360
	mov r4, #0

	cmp r1, r3
	bne Isabajo2

	izquierda2: 
		cmp r2, r4
		beq gameOver2

		add r4, #20
		cmp r4, #440
		bge Isabajo2

		b izquierda2

	Isabajo2: 

	mov r3, #360
	mov r4, #420

	cmp r2, r4
	bne Isderecha2

	abajo2: 
		cmp r1, r3
		beq gameOver2

		add r3, #20 
		mov r5, #500

		cmp r3, r5
		bge Isderecha2

		b abajo2
	
	Isderecha2: 

	mov r3, #480
	mov r4, #440

	cmp r1, r3
	bne end2

	derecha2: 
		cmp r2, r4
		beq gameOver2

		sub r4, #20
		cmp r4, #0
		ble end2

		b derecha2

gameOver2:  					@Subrutina que lanzara la imagen de gameOver
					
	b GameOverLoop	

end2:  						@final del objeto 1

	pop {pc}


/******************************************************************************
*	L1O3
*	Tercer obstaculo del laberinto 1
*	Por: Diego Castaneda, Carnet: 15151
*   	 Jonnathan Juares, Carnet: 15377
*   Taller de Assembler, Seccio: 30
*	Parametros: 
*		r1: posicion del pollo en x
*		r2: posicion del pollo en y
*******************************************************************************/
.global L1O3
L1O3: 
	push {lr}

	pop {pc}


