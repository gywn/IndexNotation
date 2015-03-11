(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


With[
	{
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		DI = SymbolicTensor`DumbIndex		
	},
	
	Print["Test for M-T --> T-M transformation"];
	
	Compare[
		ST[ a[i_, DI[2]], TI[{DI[2]},{i_}] ] DI[2] Sin[DI[1]],
		ST[ a[DI[3],DI[4]] DI[2] Sin[DI[1]], TI[{DI[4]},{DI[3]}] ]
	];
]
