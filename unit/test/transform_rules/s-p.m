(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-p.m"]


Begin["SymbolicTensor`test`"];


With[
    {
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,

        DI = SymbolicTensor`DumbIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            SS[ a[i_,j_] + b[j_,i_], SI[{i_},{j_}] ],
            SS[ a[i_,j_], SI[{i_},{j_}] ] + SS[ b[j_,i_], SI[{i_},{j_}] ],
            TestID -> "1"
        ],

        VerificationTest[
            SS[ a[i_,j_] + b[j_,i_] + c, SI[{i_},{j_}] ],
            SS[ a[i_,j_], SI[{i_},{j_}] ] + SS[ b[j_,i_], SI[{i_},{j_}] ] + SS[ c, SI[{i_},{j_}] ],
            TestID -> "more than 2 terms"
        ]
    }
]


End[];
