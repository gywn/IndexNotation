(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["SymbolicTensor.m"]


With[
    {
    	TI = SymbolicTensor`TensorIndex,
    	ST = SymbolicTensor`SymbolicTensor
    },
    
    {
    	VerificationTest[
    		ST[A, TI[]], A,
    		TestID -> "SymbolicTensor -- identity_1"
    	],
    	
    	VerificationTest[
    		ST[A], A,
    		TestID -> "SymbolicTensor -- identity_2"
    	],
    
    	VerificationTest[
    		ST[A,{a_},{b_},{c_}],
    		ST[ST[ST[A, TI[{c_}]], TI[{b_}]], TI[{a_}]],
    		TestID -> "SymbolicTensor -- gammar sugar"
    	],

    	VerificationTest[
            Block[
                {a = A[j_, i_], b = 0},

                ST[a, b] = ST[ A[i_, j_], TI[ {i_}, {j_} ] ];
                {a, b}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ] },
    		TestID -> "SymbolicTensor -- direct unpacking assignement"
    	],

    	VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                ST[a, b, c] = ST[ A[i_, j_], TI[ {i_}, {j_} ] ];
                {a, b, c}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ] },
    		TestID -> "SymbolicTensor -- direct unpacking assignement, empty option"
    	],

    	VerificationTest[
            Block[
                {a = A[j_, i_], b = 0, c = k_},

                ST[a, b, c] = ST[ A[i_, j_], TI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 ];
                {a, b, c}
            ],
            { A[i_, j_], TI[ {i_}, {j_} ], O1 -> V1, O2 -> V2 },
    		TestID -> "SymbolicTensor -- direct unpacking assignement, several options"
    	]
    }
]



