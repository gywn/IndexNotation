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
	
	Print["Test for S-P --> P-S transformation"];
	
	Compare[
		SS[ a[i_,j_] + b[j_,i_], SI[{i_},{j_}] ],
		SS[ a[i_,j_], SI[{i_},{j_}] ] + SS[ b[j_,i_], SI[{i_},{j_}] ]
	]; 
]



