(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScY = SymbolicTensor`Scope`Yield,
		ScT = SymbolicTensor`Scope`Transform,
		
		indexfunc = SymbolicTensor`DumbIndex
	},
	
	SS[ s_ST, vrs2_ ] := Replace[
		ScY[ s, vrs2[[All, 1]] ],
		ST[x_, vrs1_] :> ScT[indexfunc] @ ST[ SS[x, vrs2], vrs1 ]
	];
]


End[];
