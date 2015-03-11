(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


Print["Test for SymbolicTensor`SymbolicSimplify`LeafCount"];

With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		DI = SymbolicTensor`DumbIndex,
		
		LC = SymbolicTensor`SymbolicSimplify`LeafCount
	},
	
	Block[
		{ expr = HEAD[A1,A2,A3][B1[C1,C2],B2] },
		
		Compare[ LC[ expr ], LeafCount[ expr ] ];
	];
	
	Compare[
		LC @ ST[ SS[ A[DI[1],DI[2]], SI[{DI[1]}] ], TI[{DI[2]}] ],
		11
	];
]
