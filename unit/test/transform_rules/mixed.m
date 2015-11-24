(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet[
    "transform_rules/s-m-p.m",
    "transform_rules/s-p.m",
    "transform_rules/m-t.m",
    "transform_rules/p-t.m",
    "transform_rules/s-m-s.m",
    "transform_rules/s-t.m"
]


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
            IS[ (a + 2( b[j_] + c[i_]) + a[i_]) a[i_] b[j_], SI[ {i_}, {j_} ] ],
            IS[a a[i_] b[j_], SI[{i_}, {j_}]] + IS[a[i_]^2 b[j_], SI[{i_}, {j_}]]
                + IS[2 a[i_] b[j_]^2, SI[{i_}, {j_}]] + IS[2 a[i_] b[j_] c[i_], SI[{i_}, {j_}]],
            TestID -> "1"
        ],
        
        VerificationTest[
            IS[ b[i_] IS[ b[j_] IT[ a[i_, j_], TI[ {i_, 2}, {j_, 3} ] ] + c[j_], SI[ {j_, 4} ] ], SI[ {i_, 5} ] ],
            IT[ IS[ a[DI[4], DI[3]] b[DI[1]] b[DI[2]], SI[ {DI[1], 4}, {DI[2], 5} ] ], TI[ {DI[4], 2}, {DI[3], 3} ] ]
                + IS[ c[DI[2]] b[DI[1]], SI[ {DI[1], 5}, {DI[2], 4} ] ],
            TestID -> "2"
        ]
    }  
]


End[];
