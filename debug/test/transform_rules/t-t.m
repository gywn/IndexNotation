(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


With[
	{
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		DI = SymbolicTensor`DumbIndex,
		
		ScR = SymbolicTensor`Scope`Replace,
		ScT = SymbolicTensor`Scope`Transform
	},
	
	Print["Test for T-T --> T transformation"];
	
	Compare[
		ST[ ST[ a[i,j], TI[{j}] ], TI[{i}] ],
		ST[a[DI[1],DI[2]],TI[{DI[2]},{DI[1]}]] 
	];
	
	Compare[
		ST[ ST[ ST[ a[DI[1]], TI[{DI[1],a}] ], TI[{DI[1],b}] ], TI[{DI[1],c}] ],
		ST[ a[DI[3]], TI[ {DI[3],a}, {DI[2],b}, {DI[1],c} ] ]
	];
	
	Compare[
		ST[ ST[ a[i,j], TI[{i,1},{k,3}] ], TI[{j,2},{l,4}] ],
		ST[
			a[DI[4],DI[2]], 
			TI[
				{DI[4],1}, {DI[3],3},
				{DI[2],2}, {DI[1],4}
			]
		] 
	];
	
	Compare[
		ST[ ST[ a[DI[1], DI[3]], TI[{DI[1],1}, {DI[3],2}] ], {i,3} ],
		ST[a[DI[3],DI[2]],TI[{DI[3],1},{DI[2],2},{DI[1],3}]]
	];
]
