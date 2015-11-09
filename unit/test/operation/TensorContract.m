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
        ]
    }
]
