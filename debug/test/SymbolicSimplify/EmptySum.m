(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


Print["Test for SymbolicTensor`SymbolicSimplify`EmptySum"];

With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		DI = SymbolicTensor`DumbIndex,
		
		TS = SymbolicTensor`SymbolicSimplify
	},
		
	Compare[
		TS @ SS[ A, SI[{i,2},{j,2},{k,2}] ],
		8 A
	];
]
