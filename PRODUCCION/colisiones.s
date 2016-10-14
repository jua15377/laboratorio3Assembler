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
	mov r4, #428

	cmp r2, r4 				@Compara la posicion en Y con la del objeto
	bne end1 			@Si no son iguales, compara otra frontera del objeto
	
	superior1: 

		cmp r1, r3			@compara con la posicion de X superior del objeto
		beq gameOver 		@ si son iguales, game over
		
		add r3, #1
		cmp r3, #251
		bge end1		@si ya se acabo la frontera, pasa a la siguente

		b superior1 		@Si no se ha acabado la frontera superior,



gameOver:  					@Subrutina que lanzara la imagen de gameOver
	
	push {lr} 				
	bl GameOverImg			
	pop {lr}

end1:  						@final del objeto 1

	pop {lr}


