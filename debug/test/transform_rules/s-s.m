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
	
	Print["Test for S-S --> S transformation"];
	
	Compare[
		SS[ SS[ a[i,j], SI[{i}] ], SI[{j}] ],
		SS[a[DI[1],DI[2]],SI[{DI[1]},{DI[2]}]] 
	];
	
	Compare[
		SS[ SS[ SS[ a[DI[1]], SI[{DI[1],a}] ], SI[{DI[1],b}] ], SI[{DI[1],c}] ],
		SS[ a[DI[1]], SI[ {DI[1],a}, {DI[2],c}, {DI[3],b} ] ]
	];
	
	Compare[
		SS[ SS[ a[i,j], SI[{i,1},{k,3}] ], SI[{j,2},{l,4}] ],
		SS[
			a[DI[1],DI[2]], 
			SI[
				{DI[1],1}, {DI[2],2},
				{DI[3],3}, {DI[4],4}
			]
		] 
	];
	
	Compare[
		SS[ SS[ a[DI[1], DI[3]], SI[{DI[1],1}, {DI[3],2}] ], {i,3} ],
		SS[a[DI[1],DI[2]],SI[{DI[1],1},{DI[2],2},{DI[3],3}]]
	];
]
