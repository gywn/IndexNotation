(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


With[
	{
		ST = SymbolicTensor`SymbolicTensor,
		TI = SymbolicTensor`TensorIndex,
		
		SS = SymbolicTensor`SymbolicSum,
		SI = SymbolicTensor`SumIndex,
		
		DIL = SymbolicTensor`Utility`DumbIndexList
	},
	
	Print["Test for SymbolicTensor`Utility`DumbIndexList"];
	
	Compare[
		DIL[ SymbolicTensor[0, TensorIndex[ {c_}, {b_}, {a_} ]] ],
		{a_, b_, c_}
	];
	
	Compare[
		DIL[ SymbolicSum[A[c_,b_], SumIndex[ {d_}, {b_}, {c_}, {a_} ]] ],
		{c_, b_, a_, d_}
	];
	
	Compare[
		DIL[ SS[ SS[ A[i_, j_], SI[{i_}] ][ B[i_] ], SI[{i_}, {j_}] ] ],
		{j_, i_}
	];
		
]


Print["Test for SymbolicTensor`Utility`FreeMemberQ"];

With[
	{FMQ = SymbolicTensor`Utility`FreeMemberQ},
	
	Compare[
		FMQ[ SymbolicSum[ i_, SumIndex[{i_}] ], Verbatim[i_] ],
		False
	];
	
	Compare[
		FMQ[ i_ + SymbolicSum[ i_, SumIndex[{i_}] ], Verbatim[i_] ],
		True
	];
]


Print["Test for SymbolicTensor`Utility`UnionPartition"];

With[
	{
		UP = SymbolicTensor`Utility`UnionPartition,
		ES = SymbolicTensor`Utility`UnionPartition`EmptySum
	},
	
	Block[
		{ rpl = UP[ {{i_,j_},{j_,k_},{l_,m_},{m_,n_}}, {} ] },
		
		Compare[
			GatherBy[ {i_,j_,k_,l_,m_,n_}, (# //. rpl)& ],
			{{i_,j_,k_},{l_,m_,n_}}
		];
	];
	
	Block[
		{ rpl = UP[ {{i_,j_},{j_,k_},{}}, {} ] },
		
		Compare[
			MemberQ[ rpl, ES -> _ ],
			True
		];
	];
	
	Block[
		{ rpl = UP[ {{i_,j_},{j_,k_},{l_}}, {i_,j_,k_,l_,m_} ] },
		
		Compare[
			MemberQ[ rpl, ES -> _ ],
			True
		];
	];
	
	Block[
		{ rpl = UP[ {{i_,j_},{j_,k_},{l_}}, {i_,j_,k_,l_,m_} ] },
		
		Compare[
			Length @ Complement[ rpl[[All,2]], rpl[[All,1]] ],
			3
		];
	];
]


Print["Test for SymbolicTensor`Utility`PatternPresentQ"];

With[
	{ PPQ = SymbolicTensor`Utility`PatternPresentQ },
	
	Compare[
		PPQ @ Verbatim[m_],
		False
	];
	
	Compare[
		PPQ[ _ ] \[And] PPQ[ m_ ] \[And] PPQ[ m_ /; m > 2 ] \[And] PPQ[ m_ ? OddQ ] \[And] PPQ[ m_ | n_ ],
		True
	];
]
