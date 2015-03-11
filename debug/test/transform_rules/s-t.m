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
	
	Print["Test for S-T --> T-S transformation"];
	
	Compare[
		SS[ ST[ a[DI[2],DI[1]], TI[{DI[2]}] ], SI[{DI[1]}] ],
		ST[ SS[ a[DI[1],DI[2]], SI[{DI[2]}] ], TI[{DI[1]}] ]
	];
	
	Compare[
		SS[ ST[ a[DI[4],DI[3],DI[2],DI[1]], TI[{DI[4]},{DI[3]}] ], SI[{DI[1]},{DI[2]}] ],
		ST[ SS[ a[DI[2],DI[1],DI[3],DI[4]], SI[{DI[3]},{DI[4]}] ], TI[{DI[2]},{DI[1]}] ]
	];
	
	(* vrs from SS correctly intrude ST *)
	
	Compare[
		SS[ ST[ a[DI[1]], TI[{DI[1]}] ], SI[{DI[1]}] ],
		ST[ SS[ a[DI[1]], SI[{DI[2]}] ], TI[{DI[1]}] ]
	];
]
