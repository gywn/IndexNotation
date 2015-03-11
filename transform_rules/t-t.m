(* ::Package:: *)

Begin["SymbolicTensor`temp`"];

With[
	{
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScY = SymbolicTensor`Scope`Yield,
		ScT = SymbolicTensor`Scope`Transform,
		
		indexfunc = SymbolicTensor`DumbIndex
	},
	
	
	ST[ s_ST, vrs2_ ] :=  Replace[
		ScY[ s, vrs2[[All, 1]] ],
		ST[ x_, vrs1_ ] :> ScT[indexfunc] @ ST[ x, Join[vrs1, vrs2] ]
	];
]



End[];
