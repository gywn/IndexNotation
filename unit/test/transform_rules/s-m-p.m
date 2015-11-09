(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-m-p.m"]


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,

        DI = SymbolicTensor`DumbIndex
    },
    
    {
        VerificationTest[
            SS[ (a[i_,j_] + b[j_,i_]) c[i_], SI[{i_},{j_}] ],
            SS[ a[i_,j_] c[i_] + b[j_, i_] c[i_], SI[{i_},{j_}] ],
            TestID -> "1"
        ],

        VerificationTest[
            SS[ (a[i_,j_] + b[j_,i_] + d) c[i_], SI[{i_},{j_}] ],
            SS[ (a[i_,j_] + b[j_, i_]) c[i_] + d c[i_], SI[{i_},{j_}] ],
            TestID -> "without s-p.m"
        ]
    }
]



