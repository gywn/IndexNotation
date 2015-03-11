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
	
	Print["Test for S-M --> M-S transformation"];
	
	Compare[
		SS[ a[i_] b[j_] c[j_,k_], SI[{i_},{j_},{k_}] ],
		SS[ a[i_], SI[{i_}] ] SS[ b[j_] c[j_,k_], SI[{j_},{k_}] ]
	]; 
	
	Compare[
		SS[ a b[i_], SI[{i_,i},{j_,j}] ],
		SS[ a, SI[{j_,j}] ] SS[ b[i_], SI[{i_,i}] ]
	];
]



