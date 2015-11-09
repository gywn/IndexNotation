(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["SymbolicSum.m"]


With[
    {
    	SI = SymbolicTensor`SumIndex,
    	SS = SymbolicTensor`SymbolicSum
    },
    
    {
    	VerificationTest[
    		SS[A, SI[]], A,
    		TestID -> "SymbolicSum -- identity_1"
    	],
    	
    	VerificationTest[
    		SS[A], A,
    		TestID -> "SymbolicSum -- identity_2"
    	],
    
    	VerificationTest[
    		SS[A,{a_},{b_},{c_}],
    		SS[SS[SS[A, SI[{a_}]], SI[{b_}]], SI[{c_}]],
    		TestID -> "SymbolicSum -- gammar sugar"
    	],

    	VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                SS[a, b] = SS[ A[i_, j_], SI[ {i_}, {j_} ] ];
                {a, b}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ] },
    		TestID -> "SymbolicTensor -- direct unpacking assignement"
    	],

    	VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                SS[a, b, c] = SS[ A[i_, j_], SI[ {i_}, {j_} ] ];
                {a, b, c}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ] },
    		TestID -> "SymbolicTensor -- direct unpacking assignement, empty option"
    	],

    	VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                SS[a, b, c] = SS[ A[i_, j_], SI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 ];
                {a, b, c}
            ],
            { A[i_, j_], SI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 },
    		TestID -> "SymbolicTensor -- direct unpacking assignement, several options"
    	]
    }
]



