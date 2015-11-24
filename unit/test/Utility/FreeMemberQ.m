(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Utility/FreeMemberQ.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        FrM = IndexNotation`Utility`FreeMember,
        flt = IndexNotation`Utility`FreeMember`Flat,
        FMQ = IndexNotation`Utility`FreeMemberQ
    },
    
    Global`RESULTS = {
        VerificationTest[
            FrM[ IS[ i_, SI[{i_}] ], i_ ],
            flt[]
        ],
        
        VerificationTest[
            FrM[ IS[ A[i_, j_], SI[{i_}] ], j_ ],
            flt[j_]
        ],
        
        VerificationTest[
            FMQ[ IS[ i_, SI[{i_}] ], i_ ],
            False
        ],
        
        VerificationTest[
            FMQ[ IS[ j_, SI[{k_}, {j_, 3}, {k_}] ], j_ ],
            False
        ],
    
        VerificationTest[
            FMQ[ i_ + IS[ i_, SI[{i_}] ], i_ ],
            True
        ]
    }
]


End[];
