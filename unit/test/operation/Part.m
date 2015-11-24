(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["operation/Part.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IT[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[1, 2, 3]],
            a[1, 2] b[3],
            TestID -> "number index" 
        ],

        VerificationTest[
            IT[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_]],
            a[l_, m_] b[n_],
            TestID -> "abritary index" 
        ],

        VerificationTest[
            IT[ a[i_, j_] IS[ b[i_, k_], SI[{i_}] ], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_]],
            a[l_, m_] IS[ b[DI[1], n_], SI[{DI[1]}] ],
            TestID -> "abritary index + internal dummy index" 
        ],

        VerificationTest[
            IT[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_, o_]],
            Hold @ IT[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_, o_]],
            TestID -> "mismatched index number" 
        ],

        VerificationTest[
            IT[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[4, m_, n_]],
            Hold @ IT[ a[i_, j_] b[k_], TI[ {k_}, {j_, n}, {i_, 3} ] ][[4, m_, n_]],
            TestID -> "out of range" 
        ],
        
        VerificationTest[
            IT[ a[i_, j_] IS[ b[k_, i_], SI[{i_}] ], TI[ {k_}, {j_, n}, {i_, 3} ] ][[l_, m_, n_]],
            a[l_, m_] IS[ b[n_, DI[1]], SI[{DI[1]}] ],
            TestID -> "transformed" 
        ]
    }
]


End[];
