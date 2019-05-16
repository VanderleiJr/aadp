/*
Trabalho de Inteligência Artificial
	--Agente Aspirador de Pó--

Feito por: 	Ariane Gomes
			Vanderlei Junior

Comandos:
	['aadp'].
	inicio(X), solucao_bl(X, Y).

*/

% Consulta dos métodos da busca e da lista
:- ['lista'].
:- ['buscaLargura'].


% Estado inicial e mapeamento dos problemas
/* Ambiente 1 */
inicio([[9, 0], 0, []]).

docker([8, 2]).
parede([[4, 0], [7, 1], [4, 2], [5, 4]]).
elevador([1, 8]).
lixos([[6, 1], [2, 3], [6, 4]]).
lixeira([[4, 4]]).


/* Ambiente 2 
inicio([[3, 0], 0, []]).

docker([9, 1]).
parede([[4, 0], [2, 2], [5, 4]]).
elevador([1]).
lixos([[0, 0], [6, 1], [2, 3]]).
lixeira([[4, 4]]).
*/

/* Ambiente 3
inicio([[3, 0], 0, []]).

docker([5, 0]).
parede([[4, 0], [4, 1], [4, 2], [4, 3], [4, 4]]).
elevador([0, 9]).
lixos([[6, 1], [3, 2], [2, 3]]).
lixeira([[5, 3]]).
*/

% Meta
meta([Posicao, QtdLixosCarregados, LixosRecolhidos]) :- 
	docker(Docker), lixos(Lixos), cont(Lixos, QtdTotal), cont(LixosRecolhidos, QtdRecolhidos),
	QtdLixosCarregados == 0, Docker == Posicao, QtdTotal == QtdRecolhidos.


% O lixo passa a ser inserido na lista lixosRecolhidos e a variável lixosCarregados incrementa em 1
pegaLixo(Coord, [QtdLixosCarregados, ListaLixosCarregados], [QtdLixosCarregados1, ListaLixosCarregados1]) :- 
	QtdLixosCarregados < 2, QtdLixosCarregados1 is QtdLixosCarregados + 1, if(Coord, ListaLixosCarregados, ListaLixosCarregados1).

% Ao se deparar com uma lixeira, a variável lixosCarregados volta a ser 0
jogaFora([QtdLixosCarregados | Z], [0 | Z]) :- 
	QtdLixosCarregados > 0.

% Se houver um lixo na coordenada e o mesmo não pertencer a lista lixosRecolhidos, executa pegaLixo
s([Coord | Z], [Coord | Z2]) :- 
	lixos(Lixos), ultimo(Z, Ultimo), pertence(Coord, Lixos), not(pertence(Coord, Ultimo)), pegaLixo(Coord, Z, Z2), !.

% Se houver uma lixeira na coordenada, joga fora o lixo
s([Coord | Z], [Coord | Z2]) :- 
	lixeira(Lixeira), pertence(Coord, Lixeira), jogaFora(Z, Z2), !.

% Anda verticalmente apenas se estiver no mapa e estiver no X que tenha elevador
s([[PosX, PosY] | Z], [[PosX, PosY1] | Z]) :- 
	elevador(Elevador), pertence(PosX, Elevador), ((PosY < 4, PosY1 is PosY + 1) ; (PosY > 0, PosY1 is PosY - 1)).

% Anda horizontalmente apenas se estiver no mapa e não tiver parede na próxima coordenada
s([[PosX, PosY] | Z], [[PosX1, PosY] | Z]) :- 
	parede(Parede), (PosX1 is PosX+1, PosX < 9, not(pertence([PosX1, PosY], Parede))) ; 
	parede(Parede), (PosX1 is PosX-1, PosX > 0, not(pertence([PosX1, PosY], Parede))), !.