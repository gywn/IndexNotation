(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["operation/TensorContract.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        DI = SymbolicTensor`DumbIndex
    },
    
    {
        VerificationTest[
            TensorContract[ ST[ A[i_, j_] B[k_, l_] C[m_], TI[ {m_, 4}, {l_, 2}, {k_, 3}, {j_, 3}, {i_, 2} ] ], {{2,3},{1,4}} ],
            ST[ SS[ SS[ A[DI[2], DI[1]] B[DI[1], DI[2]] C[DI[3]], SI[ {DI[1], 3} ] ], SI[ {DI[2], 2} ] ], TI[ {DI[3], 4} ] ],
            TestID -> "multiple contraction"
        ],
        
        VerificationTest[
            TensorContract[ ST[ A[i_, j_] B[k_, l_], TI[ {l_, 4}, {k_, 3}, {j_, 3}, {i_, 2} ] ], {{2,3}} ],
            ST[ SS[ A[DI[2], DI[1]] B[DI[1], DI[3]], SI[ {DI[1], 3} ] ], TI[ {DI[3], 4}, {DI[2], 2} ] ],
            TestID -> "simple 1"
        ],
        
        VerificationTest[
            Evaluate @ TensorContract[ ST[ A[i_, j_] B[k_, l_], TI[ {l_, 4}, {k_, 4}, {j_, 3}, {i_, 2} ] ], {{2,3}} ],
            Hold @ TensorContract[ ST[ A[i_, j_] B[k_, l_], TI[ {l_, 4}, {k_, 4}, {j_, 3}, {i_, 2} ] ], {{2,3}} ],
            TestID -> "order mismatched"
        ],
        
        VerificationTest[
            Evaluate @ TensorContract[ ST[ A[i_, j_] B[k_, l_], TI[ {l_, 4}, {k_}, {j_}, {i_, 2} ] ], {{2,3}} ],
            Hold @ TensorContract[ ST[ A[i_, j_] B[k_, l_], TI[ {l_, 4}, {k_}, {j_}, {i_, 2} ] ], {{2,3}} ],
            TestID -> "no order"
        ],
        
        VerificationTest[
            TensorContract[ ST[ A[i_, j_], TI[ {j_, 2}, {i_, 2} ] ], {{1,2}} ],
            SS[ A[DI[1], DI[1]], SI[ {DI[1], 2} ] ],
            TestID -> "to scalar"
        ],
        
        VerificationTest[
            TensorContract[ ST[ A[i_, j_, k_], TI[ {k_, 2}, {j_, 2}, {i_, 3} ] ], {{2,3}} ],
            ST[ SS[ A[DI[2], DI[1], DI[1]], SI[ {DI[1], 2} ] ], TI[ {DI[2], 3} ] ],
            TestID -> "asymmetric"
        ]
    }
]
