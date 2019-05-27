%Run: swipl -q -s goldbach.pl
%Input: integer
%Input: 0 to stop the program

%function prime
%先過濾掉<=1，2 的倍數，和 3 的倍數,並設<=3 的為 prime
%用 loop 檢查是否為(5 or 7)的倍數, (11 or 13)的倍數, (17 or 19)的倍數, (i or i+2)的倍數...,直到 i*i>要測試的數字,過程如果是的話為 false,否則 true

%define prime
prime(2).
prime(3).

prime(N):-
    integer(N),
    N>3,
    N mod 2 =\= 0,
    N mod 3 =\= 0,
    iteration_prime(N,5).

iteration_prime(N,I):- 
    I =< sqrt(N),
    N mod I =\= 0,
    N mod (I+2) =\= 0,
    I2 is I +6,
    iteration_prime(N,I2).

iteration_prime(N,I):-
    I > sqrt(N).

%function goldbach
two_prime(X1,X2):- prime(X1),prime(X2).

%% check for the combination from (3,EVEN-3)->(5,EVEN-5)->(7,EVEN-7).....

% if 2 number are prime, then print it out and check for next conbination  (EVEN,INTEGER+2)
% else keeping check for the combination ......->(5,EVEN-5)->(7,EVEN-7).....
goldbach(EVEN,INTEGER):- 
    INTEGER =< (EVEN/2),
    INTEGER2 is (EVEN-INTEGER),
    prime(INTEGER),prime(INTEGER2),
    write(INTEGER),
    write(" "),
    write(INTEGER2),
    nl,
    TMP1 is (INTEGER+2),
    goldbach(EVEN,TMP1).
% else
goldbach(EVEN,INTEGER):- 
    INTEGER =< (EVEN/2),
    INTEGER2 is (EVEN-INTEGER),
    \+(two_prime(INTEGER,INTEGER2)),
    TMP2 is (INTEGER+2),
    TMP2 =< (EVEN/2),
    goldbach(EVEN,TMP2).
% EVEN is no need to check ( range: integer which is < 6 )
goldbach(EVEN,INTEGER):-
    INTEGER > (EVEN/2).

% main
main :-
    repeat,
    write('input: '),
    readln(X),
    (
        (((X mod 2) =:= 0), (X > 2), write('output: '),nl, goldbach(X,3));%如果是二的倍數且大於二，就進入尋找兩個質數相加的function
        (X =:= 4, writeln('2 2'));%如果input is 4,直接output 2 2
        ((((X mod 2) =\= 0); X =:= 2), writeln('Please Input One even integer greater than 2'));% 輸入非偶數，顯示錯誤訊息
        (X =:= 0, halt)% 輸入0，則跳出程式
    ),
    X = 0.
    :-initialization(main).
