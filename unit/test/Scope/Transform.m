(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Scope/Transform.m"]


With[
    {
    	ST = SymbolicTensor`SymbolicTensor,
    	TI = SymbolicTensor`TensorIndex,
    	
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex,
    	
    	ScT = SymbolicTensor`Scope`Transform
    },
    
Block[
    {indexfunc},
    
    indexfunc[i_] := Idx[i];
    {
        VerificationTest[
    		ScT[indexfunc] @ ST[ SS[ a_ + b_, SI[{a_,4}] ], TI[{b_,3}] ],
    		ST[ SS[ Idx[1] + Idx[2], SI[{Idx[1],4}] ], TI[{Idx[2],3}] ],
    		TestID -> "multiple layers"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ SS[ a_ + b_, SI[{a_,4}, {b_,3}]] ],
    		ScT[indexfunc][ SS[ b_ + a_, SI[{b_,4}, {a_,3}]] ],
    		TestID -> "determinated by SumIndex order"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ SS[ A[a_] + B[b_], SI[{a_}, {b_}]] ],
    		ScT[indexfunc][ SS[ A[b_] + B[a_], SI[{b_}, {a_}]] ],
    		TestID -> "determinated by Sum content"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ SS[ A[a_, c_], SI[{c_}] ] + SS[ A[a_, d_], SI[{d_}] ] ],
    		ScT[indexfunc][ 2 SS[ A[a_, c_], SI[{c_}] ] ],
    		TestID -> "complex identification 1"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ SS[ SS[ A[a_, c_], SI[{c_}] ] + SS[ A[b_, d_], SI[{d_}] ], SI[{a_}, {b_}]] ],
    		ScT[indexfunc][ SS[ SS[ A[b_, e_], SI[{e_}] ] + SS[ A[a_, f_], SI[{f_}] ], SI[{b_}, {a_}]] ],
    		TestID -> "complex identification 2"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ SS[ Idx[1] A[c_], SI[{c_}] ] ],
    		ScT[indexfunc][ SS[ Idx[1] A[ Idx[2] ], SI[{ Idx[2] }] ] ],
    		TestID -> "Simple shadowing"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ SS[ c_ + Idx[1], SI[{c_, 3}, {Idx[1], 4}] ] ],
    		ScT[indexfunc][ SS[ Idx[1] + Idx[2], SI[{Idx[1], 3}, {Idx[2], 4}] ] ],
    		TestID -> "Renaming occupied index"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ SS[ A[a_, a_, b_], SI[{a_}, {b_}]] ],
    		ScT[indexfunc][ SS[ A[d_, d_, c_], SI[{c_}, {d_}]] ],
    		TestID -> "Structual equivalence: Sum"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc][ ST[ A[a_, a_, b_], TI[{a_}, {b_}]] ],
    		ScT[indexfunc][ ST[ A[c_, c_, d_], TI[{c_}, {d_}]] ],
    		TestID -> "Structual equivalence: Tensor"
    	],
    	
    	VerificationTest[
    		ScT[indexfunc] @ ScT[indexfunc][ SS[ A[a_, a_, b_], SI[{a_}, {b_}]] ],
    		ScT[indexfunc][ SS[ A[d_, d_, c_], SI[{c_}, {d_}]] ],
    		TestID -> "Consistency of repeated transformation"
    	]
    }
]    
]



