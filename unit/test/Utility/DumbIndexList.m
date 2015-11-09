(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Utility/DumbIndexList.m"]


With[
    {
    	ST = SymbolicTensor`SymbolicTensor,
    	TI = SymbolicTensor`TensorIndex,
    	
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex,
    	
    	DIL = SymbolicTensor`Utility`DumbIndexList
    },
    
    {
    	VerificationTest[
    		DIL[ ST[0, TI[ {c_}, {b_}, {a_} ]], {} ],
    		{a_, b_, c_},
    		TestID -> "simple tensor case 1"
    	],
    
    	VerificationTest[
    		DIL[ SS[A[c_,b_], SI[ {d_}, {b_}, {c_}, {a_} ]], {} ],
    		{c_, b_, a_, d_},
    		TestID -> "simple sum case 1"
    	],
    
    	VerificationTest[
    		DIL[ SS[ SS[ A[i_, j_], SI[{i_}] ][ B[i_] ], SI[{i_}, {j_}] ], {} ],
    		{j_, i_},
    		TestID -> "simple case"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ SS[ A[i_, k_], SI[{i_}] ] SS[ A[k_, j_], SI[{k_}] ], SI[{i_}, {j_,4}, {k_,3}] ], {} ],
    		{k_, j_, i_},
    		TestID -> "shadowing of internal dumb index 1"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ SS[ A[i_, k_], SI[{i_}] ] SS[ A[k_, j_], SI[{k_}] ], SI[{i_,3}, {j_,4}, {k_,3}] ], {} ],
    		{k_, j_, i_},
    		TestID -> "shadowing of internal dumb index 2"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ SS[ A[j_, a_], SI[{a_}] ] SS[ A[i_, b_], SI[{b_}] ], SI[{i_,3}, {j_,3}] ], {} ],
    		{j_, i_},
    		TestID -> "totally determinated by internal dumb index"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ SS[ A[j_, a_], SI[{a_}] ] SS[ A[i_, a_], SI[{a_}] ], SI[{i_,3}, {j_,3}] ], {} ],
    		{i_, j_},
    		TestID -> "fall back to explicit comparing"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ A[j_,k_,i_]+A[l_,j_,k_], SI[{i_,3}, {l_,4}] ], {j_,k_} ],
    		{i_, l_},
    		TestID -> "classical exterior dumb index 1"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ A[j_,k_,l_]+A[i_,j_,i_], SI[{i_,3}, {l_,4}] ], {j_, k_} ],
    		{l_, i_},
    		TestID -> "classical exterior dumb index 2"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ i_ k_ k_ + j_ l_ k_, SI[{i_}, {j_}] ], {k_, l_} ],
    		{j_, i_},
    		TestID -> "exterior dumb index: totally determinated by exterior"
    	],
    	
    	VerificationTest[
    		DIL[ SS[ j_ k_ k_ + i_ l_ l_, SI[{i_}, {j_}] ], {k_, l_} ],
    		{i_, j_},
    		TestID -> "exterior dumb indexes: fall back to explicit comparing"
    	]
    }	
]



