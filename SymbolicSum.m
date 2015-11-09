(* ::Package:: *)

(* ::Text:: *)
(*SymbolicSum[x, SumIndex[{i, 3}, {j, 3}, ...]]*)
(*SymbolicSum[SymbolicSum[x, SumIndex[{i, 3}]], SumIndex[{j, 3}, ...]]*)
(*  - It's not recommanded to write SymbolicSum[x, SumIndex[__List]] directly.*)
(*    Write SymbolicSum[x, __List] instead to enable scope checking.*)
(**)
(*Allow using SymbolicSum[x, {i,3}, {j,3}] to build symbolic sum*)
(**)
(*Syntax highlight in Mathematica front-end is supported.*)


Begin["SymbolicTensor`temp`"];


With[
    {
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex
    },
    
    SetAttributes[SI, {Orderless}];

    SS[ x_, SI[] ] := x;
    SS[ x_ ] := x;

    (* Enable direct unpacking assignment *)

    SS /: ( SS[x1_, vrs1_] = SS[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
    );

    SS /: ( SS[x1_, vrs1_, opt1_] = SS[x2_, vrs2_, opt2___] ) := (
        x1 = x2;
        vrs1 = vrs2;
        opt1 = opt2;
    );

    (* grammar sugar *)
    
    SS[x_, vrl__List]
    	/; DuplicateFreeQ[ {vrl}[[All, 1]] ]
    	:= Fold[ SS[#1,SI[#2]]&, x, {vrl} ];
    
    Options[SS] = {Type -> "Normal"}; (* Options[] must be placed before SyntaxInformation[] *)
    SyntaxInformation[SS] = {
    	"LocalVariables" -> {"Table",{0,Infinity}},
    	"ArgumentsPattern" -> {__, OptionsPattern[]}
    };
]


End[];
