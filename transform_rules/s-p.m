(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		OFML = SymbolicTensor`Utility`OrderedFreeMemberList,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScY = SymbolicTensor`Scope`Yield,
		ScT = SymbolicTensor`Scope`Transform,
		
		indexfunc = SymbolicTensor`DumbIndex
	},
	
	SS[ Plus[x_, y__], vrs_ ]
		(*/; OFML[ x, Verbatim /@ vrs[[All, 1]] ] =!= {}*)
		:= SS[x, vrs] + SS[Plus[y], vrs];
]


End[];
