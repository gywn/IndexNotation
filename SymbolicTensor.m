(* ::Package:: *)

(* ::Text:: *)
(*SymbolicTensor[x, TensorIndex[..., {j, 3}, {i, 3}]]*)
(*SymbolicTensor[SymbolicTensor[x, TensorIndex[..., {j, 3}]], TensorIndex[{i, 3}]]*)
(*  - It's not recommanded to write SymbolicTensor[x, TensorIndex[__List]] directly.*)
(*	Write SymbolicTensor[x, __List] instead to enable scope checking.*)
(*	*)


(* ::Text:: *)
(*Allow using ST[x, {i,3}, {j,3}] to build symbolic tensor*)
(*  - Reverse the order of vrs to makes {j,3} inner-most item / first item to contract, *)
(*	compatible with mathematica's "Table" function.*)
(*  - Derivation on x adds item on the side of {j,3}, compatible with tensorial calculus.*)
(**)
(*Syntax highlight in Mathematica front-end is supported.*)


Begin["SymbolicTensor`temp`"];


With[
	{
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		DIL = SymbolicTensor`Utility`DumbIndexList,
		DI = SymbolicTensor`Utility`DuplicatedIndexQ
	},
	
	SetAttributes[TI, {}];

	(*ST[ ST[ x_, vrs1_TI ], vrs2_TI ] 
		/; Length @ Intersection[ vrs1[[All,1]], vrs2[[All,1]] ]
		:= ST[ x, TI[vrs1, vrs2] ];*)
	ST[ x_, TI[] ] := x;
	ST[ x_ ] := x;
	
	(* grammar sugar *)
	
	ST[x_, vrl__List]
		/; DuplicateFreeQ[ {vrl}[[All, 1]] ]
		:= Fold[ ST[#1,TI[#2]]&, x, Reverse[{vrl}] ];
	
(*	st : ST[x_, vrl__List] := Block[
		{ new = ST[ x, Reverse @ TI[vrl] ] },
		
		If[ DI[new], Message[ST::rpgi, HoldForm[st]] ];
		new
	];*)
	
	ST::rpgi = "`1` has ghost index conflict";
	
	Options[ST] = {Type -> "Normal"}; (* Options[] must be placed before SyntaxInformation[] *)
	SyntaxInformation[ST] = {
		"LocalVariables" -> {"Table",{0,Infinity}},
		"ArgumentsPattern" -> {__, OptionsPattern[]}
	};
]


End[];
