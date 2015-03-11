(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScY = SymbolicTensor`Scope`Yield,
		ScT = SymbolicTensor`Scope`Transform,
		
		indexfunc = SymbolicTensor`DumbIndex
	},
	
	SS[ s_SS, vrs2_ ] :=  Replace[
		ScY[ s, vrs2[[All, 1]] ],
		SS[ x_, vrs1_ ] :> ScT[indexfunc] @ SS[ x, Join[vrs1, vrs2] ]
	];
]


End[];
