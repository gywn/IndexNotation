(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


With[
	{
		TI = SymbolicTensor`TensorIndex,
		ST = SymbolicTensor`SymbolicTensor},
	
	(*Print["Test for SymbolicTensor`TensorIndex"]
	
	Compare[ TI[{a_}, TI[{b_}, {c_}]], TI[{a_}, {b_}, {c_}] ];
*)	
	Print["Test for SymbolicTensor`SymbolicTensor"];
	
	Compare[ ST[A, TI[]], A ];
	
	Compare[ ST[A], A ];
	
	Compare[ ST[A, {a_}, {b_}, {c_}], ST[ST[ST[A, TI[{c_}]], TI[{b_}]], TI[{a_}]] ];

]



