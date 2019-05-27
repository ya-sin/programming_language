%Run: swipl -q -s lowest_common_ancestor.pl

% define ancestor
ancestor(A, B) :- parent(A, B).        
ancestor(A, B) :- parent(X, B), ancestor(A, X).

% print a  list
print_ans([]).
print_ans([H| LIST]) :-
    write(H),                           % print the head of the list
    nl,                                 % print a newline
	print_ans(LIST).                    % call print_ans(LIST) to print tail's head

% append a element to a list
append([], X, [X]).
append([H| L1], X, [H| L2]) :- append(L1, X, L2).

% find lowest common ancestor, if found append it to L1
lca(A, B, L1, L2) :- 
    A==B -> append(L1, A, L2);
    ancestor(A, B) -> append(L1, A, L2);
    parent(X, A),lca(X, B, L1, L2).

% construct tree refer to each command
declare_fact(NODENO) :-
	NODENO > 0,								% check NODENO if bigger than 0
	readln(X),								% read line (parent child)
	nth0(0, X, P),							% binds index 0 in X to P
	nth0(1, X, C),       					% binds index 1 in X to C
	assert(parent(P, C)),               	% assert the fact
	TMP1 is NODENO - 1,                     % TMP1 = NODENO - 1
	declare_fact(TMP1);                   	% if(NODENO!=0) declare_fact(NODENO-1);
	NODENO = 0.								% if(NODENO==0) return;

% find lowest common ancestor for each query
call_lca(QUERYNO, L1, L2) :-
	QUERYNO > 0,							% check QUERYNO if bigger than 0
	readln(X),								% read line (node node)
	nth0(0, X, NODE1),						% binds index 0 in X to NODE1
	nth0(1, X, NODE2),  					% binds index 1 in X to NODE2
	lca(NODE1, NODE2, L1, L2),              % call lca to find lowest common ancestor
	TMP2 is QUERYNO - 1,                    % TMP2 = QUERYNO - 1
	call_lca(TMP2, L2, _L3);          		%if(QUERYNO!=0) call_lca(TMP2, L2, _L3)
	QUERYNO = 0,
	print_ans(L1).                     		%if(QUERYNO==0) print_ans(L1)

% main
:-
    readln(NODENO),							% read line # of nodes							
	declare_fact(NODENO-1),					% construct a tree(clarify the fact)
	readln(QUERYNO),                        % read line # of queries
	call_lca(QUERYNO, _L1, _L2).			% call lca refer to each query
