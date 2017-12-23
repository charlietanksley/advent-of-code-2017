%% Puzzle 1: Given a string of numbers (0-9), sum all numbers such
%% that the next number in the string is the same. (Note that the
%% 'next' number for the last number is the first number.
%%
%% Examples:
%% captcha("1122", 3).
%% captcha(1111) = 4
%% captcha(1234) = 0
%% captcha("91212129", 9)

:- use_module(library(apply)).
:- debug.


zip(X, Y, Z) :-
        Z = [X, Y].

matches(Pair) :-
        nth0(0, Pair, Left),
        nth0(1, Pair, Right),
        Left == Right.

shift([H|T], L) :-
        append(T, [H], L).

sum_head(Lst, Out) :-
        maplist(nth0(0), Lst, Heads),
        sum_list(Heads, Out).

atom_number(Atm, Num) :-
        atom_string(Atm, Str),
        number_string(Num, Str).

captcha(Str, Out) :-
        string_chars(Str, LstStr),
        maplist(atom_number, LstStr, Lst),
        shift(Lst, Shifted),
        maplist(zip, Lst, Shifted, Zipped),
        include(matches, Zipped, Matches),
        sum_head(Matches, Out).
