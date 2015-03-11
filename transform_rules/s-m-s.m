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
	
	SS[ Times[ s_SS, y__ ], vrs2_ ] := Replace[
		ScY[ s, {y, vrs2[[All,1]]} ],
		SS[ x_, vrs1_ ] :> ScT[indexfunc] @ SS[ Times[x,y], Join[vrs1, vrs2] ]
	];
]


End[];
