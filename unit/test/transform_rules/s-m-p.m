(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-m-p.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,

        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IS[ (a[i_,j_] + b[j_,i_]) c[i_], SI[{i_},{j_}] ],
            IS[ a[i_,j_] c[i_] + b[j_, i_] c[i_], SI[{i_},{j_}] ],
            TestID -> "1"
        ],

        VerificationTest[
            IS[ (a[i_,j_] + b[j_,i_] + d) c[i_], SI[{i_},{j_}] ],
            IS[ (a[i_,j_] + b[j_, i_]) c[i_] + d c[i_], SI[{i_},{j_}] ],
            TestID -> "without s-p.m"
        ]
    }
]


End[];
