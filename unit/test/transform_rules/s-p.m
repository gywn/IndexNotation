(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-p.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,

        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IS[ a[i_,j_] + b[j_,i_], SI[{i_},{j_}] ],
            IS[ a[i_,j_], SI[{i_},{j_}] ] + IS[ b[j_,i_], SI[{i_},{j_}] ],
            TestID -> "1"
        ],

        VerificationTest[
            IS[ a[i_,j_] + b[j_,i_] + c, SI[{i_},{j_}] ],
            IS[ a[i_,j_], SI[{i_},{j_}] ] + IS[ b[j_,i_], SI[{i_},{j_}] ] + IS[ c, SI[{i_},{j_}] ],
            TestID -> "more than 2 terms"
        ]
    }
]


End[];
