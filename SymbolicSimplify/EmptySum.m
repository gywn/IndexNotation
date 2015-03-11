(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		FMQ = SymbolicTensor`Utility`FreeMemberQ,
		
		ScT = SymbolicTensor`Scope`Transform,
		indexfunc = SymbolicTensor`DumbIndex,
		
		ES = SymbolicTensor`SymbolicSimplify`EmptySum
	},
	
	ES @ s : SS[ x_, SI[ {i_, n_, ___}, vs___ ] ]
		/; \[Not] FMQ[ x, Verbatim @ i ]
		:= ScT[indexfunc][ n SS[x, SI[vs]] ];
]


End[];
