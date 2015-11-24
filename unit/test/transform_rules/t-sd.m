(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["transform_rules/t-sd.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,

        DI = IndexNotation`DummyIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            IT[ SeriesData[x, 0, {a, b}, 0, 2, 1], TI[{i_},{j_}] ],
            SeriesData[x, 0, {
                IT[ a, TI[{i_},{j_}] ], IT[ b, TI[{i_},{j_}] ]
            }, 0, 2, 1],
            TestID -> "1"
        ]
    }
]


End[];
