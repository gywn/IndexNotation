(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet[
    "transform_rules/s-m-p.m",
    "transform_rules/s-p.m",
    "transform_rules/m-t.m",
    "transform_rules/p-t.m",
    "transform_rules/s-m-s.m",
    "transform_rules/s-t.m",
    "transform_rules/s-s.m",
    "transform_rules/t-t.m",
    "transform_rules/s-m.m"
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
            IS[ b[i] IS[ b[j] IT[ a[i, j], TI[ {i, 2}, {j, 3} ] ] + c[j], SI[ {j, 4} ] ], SI[ {i, 4} ] ],
            IT[ a[DI[3], DI[2]] IS[ b[DI[1]], SI[ {DI[1], 4} ] ]^2, TI[ {DI[3], 2}, {DI[2], 3} ] ]
                + IS[ c[DI[1]], SI[ {DI[1], 4} ] ] IS[ b[DI[1]], SI[ {DI[1], 4} ] ],
            TestID -> "1"
        ]
    }
]


End[];
