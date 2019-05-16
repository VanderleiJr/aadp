% Inversão da solução da busca em largura
inversao([], []).

inversao([Cabeca | Cauda], Y) :- 
	inversao(Cauda, Invertida), concat(Invertida, [Cabeca], Y).

% Solução por busca em largura
solucao_bl(Inicial, SolucaoInvertida) :- 
	bl([[Inicial]], Solucao), inversao(Solucao, SolucaoInvertida).

% Se o primeiro estado de F for meta, então o retorna com o caminho
bl([[Estado | Caminho] | _], [Estado | Caminho]) :- 
	meta(Estado).

% Falha ao encontrar a meta, então estende o primeiro estado até seus sucessores e os coloca no final da lista de fronteira
bl([Primeiro | Outros], Solucao) :-
	estende(Primeiro, Sucessores), 
	concat(Outros, Sucessores, NovaFronteira),
	bl(NovaFronteira, Solucao).

% Extensão do caminho até os nós filhos do estado
estende([Estado | Caminho], ListaSucessores):-
	bagof([Sucessor, Estado | Caminho], (s(Estado, Sucessor), not(pertence(Sucessor, [Estado | Caminho]))), ListaSucessores),!.

% Se o estado não tiver sucessor, falha e não procura mais
estende(_, []).