% Verifica se um elemento pertence a lista
pertence(Elem, [Elem | _]).
pertence(Elem, [_ | Cauda]) :- 
	pertence(Elem, Cauda).

% Insere um elemento na última posição da lista
if(X, [], [X]).
if(X, [Cabeca | Cauda], [Cabeca | Resto]) :- 
	if(X, Cauda, Resto).

% Concatena duas listas
concat([], L, L).
concat([Cabeca | Cauda], L2, [Cabeca | Resultado]) :- 
	concat(Cauda, L2, Resultado).

% Contabiliza a quantidade de elementos de uma lista
cont([], 0).
cont([_ | Cauda], S) :- 
	cont(Cauda, S1), S is S1 + 1.

% Retorna o último elemento da lista
ultimo([Y], Y).
ultimo([_ | Cauda], X) :- 
	ultimo(Cauda, X).