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
	
	Print["Test for P-T --> T-P transformation"];
	
	Compare[
		ST[ a[i_,j_], TI[{j_},{i_}] ] + ST[ b[k_,l_], TI[{l_},{k_}] ] + A,
		ST[ a[DI[1],DI[2]] + b[DI[1],DI[2]], TI[{DI[2]}, {DI[1]}] ] + A
	];
	
	Compare[
		ST[ a[i_,j_], TI[{i_}] ] + ST[ b[i_, j_], TI[{j_}] ] + A,
		ST[ a[DI[1],j_] + b[i_,DI[1]], TI[{DI[1]}] ] + A
	];
]
