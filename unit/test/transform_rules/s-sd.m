(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/s-sd.m"]


Begin["IndexNotation`test`"];


With[
    {
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,

        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IS[ SeriesData[x, 0, {a, b}, 0, 2, 1], SI[{i_},{j_}] ],
            SeriesData[x, 0, {
                IS[ a, SI[{i_},{j_}] ], IS[ b, SI[{i_},{j_}] ]
            }, 0, 2, 1],
            TestID -> "1"
        ]
    }
]


End[];
