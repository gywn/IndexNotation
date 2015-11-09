(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Utility/FreeMemberQ.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        FrM = SymbolicTensor`Utility`FreeMember,
        flt = SymbolicTensor`Utility`FreeMember`Flat,
        FMQ = SymbolicTensor`Utility`FreeMemberQ
    },
    
    Global`RESULTS = {
        VerificationTest[
            FrM[ SS[ i_, SI[{i_}] ], i_ ],
            flt[]
        ],
        
        VerificationTest[
            FrM[ SS[ A[i_, j_], SI[{i_}] ], j_ ],
            flt[j_]
        ],
        
        VerificationTest[
            FMQ[ SS[ i_, SI[{i_}] ], i_ ],
            False
        ],
        
        VerificationTest[
            FMQ[ SS[ j_, SI[{k_}, {j_, 3}, {k_}] ], j_ ],
            False
        ],
    
        VerificationTest[
            FMQ[ i_ + SS[ i_, SI[{i_}] ], i_ ],
            True
        ]
    }
]


End[];
