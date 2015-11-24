(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["IndexFlatten.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        IdF = IndexNotation`IndexFlatten
    },
    
    Global`RESULTS = {
        VerificationTest[
            IdF @ IT[ a[i_, j_], TI[ {j_, 2}, {i_, 2} ] ],
            { {a[1, 1], a[1, 2]}, {a[2, 1], a[2, 2]} },
            TestID -> "pure IndexTensor" 
        ],
        
        VerificationTest[
            IdF @ IS[ a[i_, j_], SI[ {j_, 2}, {i_, 2} ] ],
            a[1, 1] + a[1, 2] + a[2, 1] + a[2, 2],
            TestID -> "pure IndexSum" 
        ],
        
        VerificationTest[
            IdF @ IT[ a[i_] + IS[ b[i_, j_], SI[ {i_, 2} ] ], TI[ {j_, 2}, {i_, 2} ] ],
            { 
                {a[1] + b[1, 1] + b[2, 1], a[1] + b[1, 2] + b[2, 2]},
                {a[2] + b[1, 1] + b[2, 1], a[2] + b[1, 2] + b[2, 2]}
            },
            TestID -> "mixed" 
        ]
    }
]


End[];
