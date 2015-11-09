(* ::Package:: *)

<< "SymbolicTensorDev/debug/lib/Compare.m"


With[
    {
    	ST = SymbolicTensor`SymbolicTensor,
    	TI = SymbolicTensor`TensorIndex,
    	
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex,
    	
    	ScR = SymbolicTensor`Scope`Replace,
    	ScY = SymbolicTensor`Scope`Yield,
    	ScT = SymbolicTensor`Scope`Transform
    },
    
Block[
    { indexfunc },
    	
    indexfunc[i_] := A[i];
    
    	
    Print["Test for SymbolicTensor`Scope`Replace"];
    	
    Compare[
    	ScR[
    		SS[ a[i_], SI[{i_}] ] b[i_], 
    		Verbatim[i_] :> j_
    	],
    	SS[a[i_], SI[{i_}]] b[j_]
    ];
    	
    Compare[
    	ScR[
    		SS[ a[i_], SI[{i_}] ] b[i_], 
    		Verbatim[i_] :> i
    	],
    	SS[a[i_], SI[{i_}]] b[i]
    ];
    	
    Compare[
    	ScT[indexfunc] @ ScR[
    		SS[ a[i_] ~OP~ c[j_], SI[{i_}] ] b[i_] d[j_], 
    		{
    			Verbatim[i_] :> j_,
    			Verbatim[j_] :> i_
    		}
    	],
    	SS[a[A[1]] ~OP~ c[i_], SI[{A[1]}]] b[j_] d[i_]
    ];
    	
    Compare[
    	ScT[indexfunc] @ ScR[
    		SS[ a[i_, j_] ~OP~ b[k_,l_,m_], SI[{i_}, {j_}, {m_}]],
    		{
    			Verbatim[k_] :> i_,
    			Verbatim[l_] :> j_,
    			Verbatim[m_] :> k_
    		}
    	],
    	SS[ a[A[1], A[2]] ~OP~ b[i_, j_, A[3]], SI[{A[1]}, {A[2]}, {A[3]}]]
    ];
    	
    Print["Test for SymbolicTensor`Scope`Yield"];
    
    Compare[
    	ScT[indexfunc] @ ScY[ SS[ B[i,j], SI[{i},{j}] ], Sin[i] ],
    	SS[ B[A[1],A[2]], SI[{A[1]}, {A[2]}] ]
    ];
    
]
]


With[
    {
    	ST = SymbolicTensor`SymbolicTensor,
    	TI = SymbolicTensor`TensorIndex,
    	
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex,
    	
    	ScT = SymbolicTensor`Scope`Transform
    },
    
    Print["Test for SymbolicTensor`Scope`Transform"];
    
    
Block[
    { indexfunc },
    
    indexfunc[i_] := A[i];
    
(*  some shadowing    *)

    Compare[
    	ScT[indexfunc][
    		A[0] ~OP~ SS[
    			A[0] ~OP~ SS[
    				a[a_,b_],
    				SI[ {a_} ]
    			] [ A[1] b[a_] ],
    			SI[ {a_}, {b_} ]
    		]
    	],
    	ScT[indexfunc][
    		A[0] ~OP~ SS[
    			A[0] ~OP~ SS[
    				a[A[1],A[3]],
    				SI[ {A[1]} ]
    			] [ A[1] b[A[2]] ],
    			SI[ {A[2]}, {A[3]} ]
    		]
    	]
    ];
    
(* A[1] is forced to change into a random index, and then into A[2] *)

    Compare[
    	ScT[indexfunc] @
    		SS[
    			A[0] ~OP~ SS[
    				a[A[1], i], SI[{A[1]}]
    			],
    			SI[{i}]
    		],
    	SS[
    		A[0] ~OP~ SS[
    			a[A[2], A[1]], SI[{A[2]}]
    		],
    		SI[{A[1]}]
    	]
    ];

(*  new dumb index already occurs in vrs  *)

    Compare[
    	ScT[indexfunc][
    		ST[ a[a_, A[1]], TI[ {A[1]}, {a_} ]]
    	],
    	ST[ a[A[1], A[2]], TI[ {A[2]}, {A[1]} ] ]
    ];
    
(* consistency of repeating transformations *)
    With[
    	{ e1 = ST[ a[A[1], A[2]], TI[ {A[1]}, {A[2]} ]] },
    	
    	Compare[ ScT[indexfunc] @ ScT[indexfunc][e1], ScT[indexfunc][e1] ];
    ];
    
    indexfunc[i_] := Pattern[ Evaluate @ Symbol[ "dumb$" <> ToString[ i ] ], _ ];
    
(*  use pattern to transform pattern   *)
    
    Compare[
    	ScT[indexfunc][
    		ST[ SS[ a[pat2_, pat1_], SI[ {pat1_} ] ], TI[ {pat2_}, {pat4_} ] ]
    	],
    	ST[SS[a[dumb$2_,dumb$1_],SI[{dumb$1_}]],TI[{dumb$2_},{dumb$1_}]]
    ];

(* automatic equivalence *)
    		
    Compare[
    	ScT[indexfunc][
    		SS[ A[a_, b_], SI[ {a_, 2}, {b_, 3} ] ] -
    		SS[ A[c_, b_], SI[ {c_, 2}, {b_, 3} ] ]
    	],
    	0
    ];
]]



