(* ::Package:: *)

(* ::Text:: *)
(*SymbolicSum[x, SumIndex[{i, 3}, {j, 3}, ...]]*)
(*SymbolicSum[SymbolicSum[x, SumIndex[{i, 3}]], SumIndex[{j, 3}, ...]]*)
(*  - It's not recommanded to write SymbolicSum[x, SumIndex[__List]] directly.*)
(*	Write SymbolicSum[x, __List] instead to enable scope checking.*)
(**)
(*Allow using SymbolicSum[x, {i,3}, {j,3}] to build symbolic sum*)
(**)
(*Syntax highlight in Mathematica front-end is supported.*)


Begin["SymbolicTensor`temp`"];


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		DIL = SymbolicTensor`Utility`DumbIndexList,
		DI = SymbolicTensor`Utility`DuplicatedIndexQ
	},
	
	SetAttributes[SI, {Orderless}];

	(*SS[ SS[ x_, vrs1_SI ], vrs2_SI ]
		/; Length @ Intersection[ vrs1[[All,1]], vrs2[[All,1]] ] == 0
		:= SS[ x, SI[vrs1, vrs2] ];*)
	SS[ x_, SI[] ] := x;
	SS[ x_ ] := x;
	
	(* grammar sugar *)
	
	SS[x_, vrl__List]
		/; DuplicateFreeQ[ {vrl}[[All, 1]] ]
		:= Fold[ SS[#1,SI[#2]]&, x, {vrl} ];

(*	ss : SS[x_, vrl__List] := Block[
		{ new = SS[ x, Reverse @ SI[vrl] ] },
	
		If[ DI[new], Message[SS::rpgi, HoldForm[ss]] ];
		new
	];*)
	
	SS::rpgi = "`1` has ghost index conflict";
	
	Options[SS] = {Type -> "Normal"}; (* Options[] must be placed before SyntaxInformation[] *)
	SyntaxInformation[SS] = {
		"LocalVariables" -> {"Table",{0,Infinity}},
		"ArgumentsPattern" -> {__, OptionsPattern[]}
	};
]


End[];
