(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


With[
	{
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		DI = SymbolicTensor`DumbIndex,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScT = SymbolicTensor`Scope`Transform
	},
	
	Print["Test for S-M-S --> S-M transformation"];
	
	Compare[
		SS[ a[i_,j_] SS[ b[i_,j_,k_], SI[{k_}] ], SI[{i_},{j_}] ],
		SS[ a[DI[1],DI[2]] b[DI[1],DI[2],DI[3]], SI[{DI[1]},{DI[2]},{DI[3]}] ]
	];
]
