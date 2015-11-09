(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["TensorFlatten.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        TF = SymbolicTensor`TensorFlatten
    },
    
    {
        VerificationTest[
            TF @ ST[ a[i_, j_], TI[ {j_, 2}, {i_, 2} ] ],
            { {a[1, 1], a[1, 2]}, {a[2, 1], a[2, 2]} },
            TestID -> "pure SymbolicTensor" 
        ],
        
        VerificationTest[
            TF @ SS[ a[i_, j_], SI[ {j_, 2}, {i_, 2} ] ],
            a[1, 1] + a[1, 2] + a[2, 1] + a[2, 2],
            TestID -> "pure SymbolicSum" 
        ],
        
        VerificationTest[
            TF @ ST[ a[i_] + SS[ b[i_, j_], SI[ {i_, 2} ] ], TI[ {j_, 2}, {i_, 2} ] ],
            { 
                {a[1] + b[1, 1] + b[2, 1], a[1] + b[1, 2] + b[2, 2]},
                {a[2] + b[1, 1] + b[2, 1], a[2] + b[1, 2] + b[2, 2]}
            },
            TestID -> "mixed" 
        ]
    }
]
