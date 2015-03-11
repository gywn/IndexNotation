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
	
	ST /: Times[ s_ST, y__ ]
		/; \[Not] MemberQ[ {y}, _ST ]
		:= Replace[
			ScY[ s, Times[y] ],
			ST[x_, vrs1_] :> ScT[indexfunc] @ ST[ Times[x,y], vrs1 ]
		];
]


End[];
