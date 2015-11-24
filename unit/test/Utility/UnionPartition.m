(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Utility/UnionPartition.m"];


Begin["IndexNotation`test`"];


With[
    {
        SI = IndexNotation`SumIndex,
        
        UP = IndexNotation`Utility`UnionPartition,
        rES = IndexNotation`Utility`UnionPartition`ReducibleEmptySum,
        iES = IndexNotation`Utility`UnionPartition`IrreducibleEmptySum
    },
    
    Global`RESULTS = {
        VerificationTest[
            Block[
                { rpl = UP[
                    { {i_, j_}, {j_, k_}, {l_, m_}, {m_, n_}, {} },
                    SI[ {i_}, {j_}, {k_}, {l_}, {m_}, {n_}, {o_}, {p_, 2}, {q_, 3} ]
                ]},
                
                GatherBy[ {i_, j_, k_, l_, m_, n_, o_, p_, q_}, # //. rpl & ]
            ],
            { {i_, j_, k_}, {l_, m_, n_}, {o_}, {p_, q_} },
            TestID -> "complex"
        ],

        VerificationTest[
            Cases[
                UP[ { {i_, j_}, {j_, k_} }, SI[ {i_}, {j_}, {k_}, {l_, 4}, {m_, 3} ] ],
                iES
            ],
            {},
            TestID -> "no irreducible index"
        ],

        VerificationTest[
            Cases[
                UP[ { {i_, j_}, {j_, k_} }, SI[ {i_}, {j_}, {k_}, {l_}, {m_} ] ],
                rES
            ],
            {},
            TestID -> "no reducible index"
        ]
    }
]


End[];
