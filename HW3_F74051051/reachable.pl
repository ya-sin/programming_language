%Run: swipl -q -s reachable.pl

% print a  list
print_ans([]).
print_ans([H| LIST]) :-
    write(H),                           		% print the head of the list
    nl,                                 		% print a newline
	print_ans(LIST).                    		% call print_ans(LIST) to print tail's head

% append a element to a list
append([], X, [X]).
append([H| L1], X, [H| L2]) :- append(L1, X, L2).    

% A & B have path?
path(A,B,ANS) :-   
	walk(A,B,[]) -> ANS = 'Yes'.				% if there is a walk from A to B, reachable = YES
            
path(_A,_B,ANS) :-
	ANS = 'No'.									% otherwise, reachable = NO

% check if there is a walk from A to B?
walk(A,B,V) :-
  	edge(A,X) ,									% A and X have edge
  	not(member(X,V)) ,							% we haven't visit X
  	(
		B = X;									% X is B(means ther is a walk from A to B!)
    	walk(X,B,[A|V])							% or we can check if there is a walk from X to B
  	).

% build the graph refer to each command
declare_fact(EDGENO) :-
	EDGENO > 0,									% check EDGENO if bigger than 0
	readln(X),									% read line (node1 node2)
	nth0(0, X, NODE1), 							% binds index 0 in X to NODE1
	nth0(1, X, NODE2),							% binds index 1 in X to NODE2
	assert(edge(NODE1, NODE2)),					% assert the fact
	assert(edge(NODE2, NODE1)),					% assert the fact ( undirectly )
	TMP1 is EDGENO - 1,							% TMP1 = EDGENO - 1
	declare_fact(TMP1);							% if(EDGENO!=0) declare_fact(EDGENO-1);
	EDGENO = 0.									% if(EDGENO==0) return;

% find path for each query
call_path(QUERYNO, L1, L2) :-
	QUERYNO > 0,								% check QUERYNO if bigger than 0
	readln(X),									% read line (nodea nodeb)
	nth0(0, X, NODEA),							% binds index 0 in X to NODEA
	nth0(1, X, NODEB),							% binds index 0 in X to NODEB
	path(NODEA, NODEB, ANS),					% call path to find path from NODEA to NODEB
	append(L1, ANS, L2),						% append the answer to list
	TMP2 is QUERYNO - 1,						% TMP2 = QUERYNO - 1
	call_path(TMP2, L2, _L3);					%if(QUERYNO!=0) path(TMP2, L2, _L3)
	QUERYNO = 0,
	print_ans(L1).								%if(QUERYNO==0) print_ans(L1)

% main
:-
	readln(X),									% read line (# of node, # of edge)
	nth0(0, X, _NODENO),						% binds index 0 in X to NODENO
	nth0(1, X, EDGENO),							% binds index 1 in X to EDGENO
	declare_fact(EDGENO),						% build the graph(clarify the fact)
	readln(QUERYNO),                        	% read line # of queries
	call_path(QUERYNO, _L1, _L2).				% call path refer to each query
