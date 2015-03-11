(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


With[
	{
		SI = SymbolicTensor`SumIndex,
		SS = SymbolicTensor`SymbolicSum},
	
	(*Print["Test for SymbolicTensor`SumIndex"]
	
	Compare[ SI[{a_}, SI[{b_}, {c_}]], SI[{b_}, {c_}, {a_}] ];*)
	
	Print["Test for SymbolicTensor`SymbolicSum"];
	
	Compare[ SS[A, SI[]], A ];
	
	Compare[ SS[A], A ];
	
	Compare[ SS[A, {a_}, {b_}, {c_}], SS[SS[SS[A, SI[{a_}]], SI[{b_}]], SI[{c_}]] ];

]






