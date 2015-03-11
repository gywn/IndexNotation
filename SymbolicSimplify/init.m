(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{ 
		TS = SymbolicTensor`SymbolicSimplify,
		LC = SymbolicTensor`SymbolicSimplify`LeafCount,
		ES = SymbolicTensor`SymbolicSimplify`EmptySum,
		
		ScT = SymbolicTensor`Scope`Transform,
		
		indexfunc = SymbolicTensor`DumbIndex
	},
	
	TS[ x_, assum___ ] := Simplify[ ScT[indexfunc][x], assum,
		ComplexityFunction -> LC,
		TransformationFunctions -> {Automatic, ES}
	];
];


End[];
