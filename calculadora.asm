
.data
	switch: .word 0, 1, 2, 3, 4, 5
	opcao: .word
	a: .word
	b: .word
	
	menu: .asciiz "----MENU----\n0: Soma \n1: Subtracao \n2 Conjuncao \n3 Disjuncao \n4 Fatorial \n5 Sair\n\nDigite sua opção: "
	operando1: .asciiz "Primeiro Operando: "
	operando2: .asciiz "Segundo Operando: "
	resultado: .asciiz "\nResultado: "
	quebraLinha: .asciiz "\n \n"
	
.text 
	.globl start
	.ent start
	
start:
	#Imprimindo o texto 
	li $v0, 4 	#Adicionando codigo de imprimir uma String para o syscall
	la $a0, menu 	#Guarda o endereco da String menu no $a0
	syscall 	#Imprime a String que esta no endereco no registrador $a0
	
	#Lendo a opcao da operacao pelo teclado
	li $v0, 5 	#Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	#Recebe um valor inteiro como entrada do teclado
	
	or $s0, $zero, $v0 	#Guarda a opcao escolhida no registrador $s0
	
	#Desviar para fim se a opção for de sair
	#bne $s0, 5, fim
	
	# $s0 = Opcao da Operacao
	# $s1 = Valor do Operador 1
	# $s2 = Valor do Operador 2
	
	jal calculadora		#Iniciando o procedimento da calculadora
	
	or $s0, $zero, $v0 	#Guarda o resultado da calculadora no registrador $s0
	
	#Imprimindo a String resutado
	li $v0, 4 		#Adicionando codigo de imprimir uma String para o syscall
	la $a0, resultado 	#Guarda o endereco da String resultado no $a0
	syscall 		#Imprime a String que esta no endereco no registrador $a0
	
	#Iprimindo o valor da resultado
	li $v0, 1 		#Adicionando codigo de imprimir um inteiro para o syscall
	or $a0, $zero, $s0 	#Guarda o valor do resultado em $a0
	syscall 		#Imprime o inteiro que esta no endereco no registrador $a0
	
	#Quebra de linha para o voltar ao menu
	
	#Imprimindo a String resutado
	li $v0, 4 		#Adicionando codigo de imprimir uma String para o syscall
	la $a0, quebraLinha 	#Guarda o endereco da String resultado no $a0
	syscall 		#Imprime a String que esta no endereco no registrador $a0
	
	jal start 		#Pula para o inicio da execucao
	
calculadora:
	#Calculando o deslocamento para a funcao escolhida pelo usuario
	la $t0, switch 	  #Carrega o endereco base do switch no registrador $t0
	#Atribuindo endereco de "soma" ao switch[0]
	la $t1, soma   	  #Carrega o endereco de "soma" no registrador $t1
	sw $t1, 0($t0)	  #Armazena o endereco contido em $t1 em 0($t0)
	#Atribuindo endereco de "subtracao" ao switch[1]
	la $t1, subtracao #Carrega o endereco de "subtracao" no registrador $t1
	sw $t1, 4($t0)	  #Armazena o endereco contido em $t1 em 4($t0)
	#Atribuindo endereco de "conjuncao" ao switch[2]
	la $t1, conjuncao #Carrega o endereco de "conjuncao" no registrador $t1
	sw $t1, 8($t0)    #Armazena o endereco contido em $t1 em 8($t0)
	#Atribuindo endereco de "disjuncao" ao switch[3]
	la $t1, disjuncao #Carrega o endereco de "disjuncao" no registrador $t1
	sw $t1, 12($t0)   #Armazena o endereco contido em $t1 em 12($t0)
	#Atribuindo endereco de "fatorial" ao switch[4]
	la $t1, fatorial  #Carrega o endereco de "fatorial" no registrador $t1
	sw $t1, 16($t0)   #Armazena o endereco contido em $t1 em 16($t0)
	#Atribuindo endereco de "Sair" ao switch[5]
	la $t1, fim  #Carrega o endereco de "fatorial" no registrador $t1
	sw $t1, 20($t0)   #Armazena o endereco contido em $t1 em 16($t0)
	
	sll $t1, $s0, 2   #Multiplica $s0 por 4 e armazena em $t1
	
	add $t0, $t0, $t1 #Soma o endereco base do switch com o valor da opcao escolhida
	lw $t0, 0($t0)    #Armazena o endereco da opcao escolhida
	
	jr $t0	#Pula para o endereco da intrucao escolhida

soma:
	#Imprimindo opcao do operador 1
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando1 #Guarda o endereco da String operando1 no $a0
	syscall		  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador1 pelo teclado
	li $v0, 5 	#Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	#Recebe um valor inteiro como entrada do teclado
	or $s1, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1
	
	#Imprimindo opcao do operador 2
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando2 #Guarda o endereco da String operando1 no $a0
	syscall 	  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador2 pelo teclado
	li $v0, 5 #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall #Recebe um valor inteiro como entrada do teclado
	or $s2, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1
	
	add $v0, $s1, $s2 #Soma os valores de $s1 e $s2 e armazena em $v0
	jr $ra	#Retorna para quem chamou
subtracao:

	#Imprimindo opcao do operador 1
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando1 #Guarda o endereco da String operando1 no $a0
	syscall		  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador1 pelo teclado
	li $v0, 5 	   #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall	           #Recebe um valor inteiro como entrada do teclado
	or $s1, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1
	
	#Imprimindo opcao do operador 2
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando2 #Guarda o endereco da String operando1 no $a0
	syscall 	  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador2 pelo teclado
	li $v0, 5	   #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	   #Recebe um valor inteiro como entrada do teclado
	or $s2, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1

	sub $v0, $s1, $s2 #Subtrai os valores de $s1 e $s2 e armazena em $v0
	jr $ra		  #Retorna para quem chamou
conjuncao:
	#Imprimindo opcao do operador 1
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando1 #Guarda o endereco da String operando1 no $a0
	syscall 	  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador1 pelo teclado
	li $v0, 5 	   #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	   #Recebe um valor inteiro como entrada do teclado
	or $s1, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1
	
	#Imprimindo opcao do operador 2
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando2 #Guarda o endereco da String operando1 no $a0
	syscall		  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador2 pelo teclado
	li $v0, 5 	   #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	   #Recebe um valor inteiro como entrada do teclado
	or $s2, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1

	and $v0, $s1, $s2
	jr $ra	#Retorna para quem chamou
disjuncao:
	#Imprimindo opcao do operador 1
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando1 #Guarda o endereco da String operando1 no $a0
	syscall 	  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador1 pelo teclado
	li $v0, 5 	   #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	   #Recebe um valor inteiro como entrada do teclado
	or $s1, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1
	
	#Imprimindo opcao do operador 2
	li $v0, 4 	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando2 #Guarda o endereco da String operando1 no $a0
	syscall	          #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador2 pelo teclado
	li $v0, 5	   #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	   #Recebe um valor inteiro como entrada do teclado
	or $s2, $zero, $v0 #Guarda o valor do operador 1 no registrador $s1

	or $v0, $s1, $s2
	jr $ra	#Retorna para quem chamou
fatorial:
	#Imprimindo opcao do operador 1
	li $v0, 4	  #Adicionando codigo de imprimir uma String para o syscall
	la $a0, operando1 #Guarda o endereco da String operando1 no $a0
	syscall 	  #Imprime a String que esta no endereco no registrador $a0
	
	#Lendo o valor do operador1 pelo teclado
	li $v0, 5	   #Adicionando codigo pra receber valor inteiro como entrada do teclado
	syscall 	   #Recebe um valor inteiro como entrada do teclado
	or $s1, $zero, $v0 #Guarda o valor do operador 1 no registrador $s10
	
	sub $sp, $sp, 4 #Liberando 8 bytes para armazenar na Stack
	sw $ra, 0($sp)  #Armazena o endereco de retorno para a chamada antiga

	jal fatorial_procedimento
	
	lw $ra, 0($sp) #Recuperando o endereco de retorno do fatorial 
	jr $ra         #Retorna para quem chamou
	
fim:
	#Finalizando a execucao da calculadora
	li $v0, 10 #Adicionando codigo de finalizar a execucao
	syscall    #Finalizando a execucao

fatorial_procedimento:
	sub $sp, $sp, 8 #Liberando 8 bytes para armazenar na Stack
	sw $ra, 4($sp)  #Armazena o endereco de retorno para a chamada antiga
	sw $s1, 0($sp)	#Armazena o valor do argumento do fatorial
	
	bne $s1, $zero, fatorial_procedimento2 #Desvia caso nao tenha chegado no Caso Base "$s0 == 0"
	
	li $v0, 1       #Armazena o valor do fatorial de 0
	add $sp, $sp, 8 #Libera o espaco na Stack antes de voltar
	jr $ra	        #Voltando para o endereco de retorno
	
fatorial_procedimento2:
	sub $s1, $s1, 1		  #Subtraindo um no valor do argumento do fatorial
	jal fatorial_procedimento #Chamando novamente a funcao fatorial
	
	#Endereco de retorno da funcao fatorial
	lw $s1,0($sp)  #Recuperando o valor do argumento do fatorial
	lw $ra, 4($sp) #Recuperando o endereco de retorno do fatorial
		
	add $sp, $sp, 8 #Libera o espaco na Stack antes de voltar
	
	mul $v0, $s1, $v0 #Caclula o valor do fatorial N*(N-1)
	jr $ra 		  #Voltando para o endereco de retorno

