(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["operation/Part.m"]


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
            ST[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[1, 2, 3]],
            a[1, 2] b[3],
            TestID -> "number index" 
        ],

        VerificationTest[
            ST[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_]],
            a[l_, m_] b[n_],
            TestID -> "abritary index" 
        ],

        VerificationTest[
            ST[ a[i_, j_] SS[ b[i_, k_], SI[{i_}] ], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_]],
            a[l_, m_] SS[ b[DI[1], n_], SI[{DI[1]}] ],
            TestID -> "abritary index + internal dumb index" 
        ],

        VerificationTest[
            ST[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_, o_]],
            Hold @ ST[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_, o_]],
            TestID -> "mismatched index number" 
        ],

        VerificationTest[
            ST[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[4, m_, n_]],
            Hold @ ST[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[4, m_, n_]],
            TestID -> "out of range" 
        ],
        
        VerificationTest[
            ST[ a[i_, j_] SS[ b[k_, i_], SI[{i_}] ], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_]],
            a[l_, m_] SS[ b[n_, DI[1]], SI[{DI[1]}] ],
            TestID -> "transformed" 
        ]
    }
]
