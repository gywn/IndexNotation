(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Utility/QuotientStructure.m"]


Begin["IndexNotation`test`"];


With[
    {    
        QO = IndexNotation`Utility`QuotientStructure`Order,
        wp = IndexNotation`Utility`QuotientStructure`Order`Wrapper
    },
    
    Global`RESULTS = {   
        VerificationTest[
            QO[ {a, b, c} ][a, b], 0,
            TestID -> "QuotientStructure`Order -- simple pure dummy indices"
        ],
        
        VerificationTest[
            QO[ {Ind[1], Ind[2], Ind[3]} ][Ind[3], Ind[2]], 0,
            TestID -> "QuotientStructure`Order -- complex pure dummy indices"
        ],
        
        VerificationTest[
            QO[ {Ind[1], Ind[2], Ind[3]} ][ Ind[3], H[ F[a] ] ], -1,
            TestID -> "QuotientStructure`Order -- dummy indices + complex structure 1"
        ],
        
        VerificationTest[
            QO[ {Ind[1], Ind[2], Ind[3]} ][ H[ F[a] ], Ind[3] ], +1,
            TestID -> "QuotientStructure`Order -- dummy indices + complex structure 2"
        ],
        
        VerificationTest[
            QO[ {Ind[1], Ind[2], Ind[3]} ][
                wp[Ind[3], Ind[2], H],
                wp[Ind[2], Ind[1], H]
            ], 0,
            TestID -> "QuotientStructure`Order -- wrapper 1"
        ],
        
        VerificationTest[
            QO[ {Ind[1], Ind[2], Ind[3]} ][
                wp[Ind[3], H, Ind[2]],
                wp[Ind[2], Ind[1], H]
            ], +1,
            TestID -> "QuotientStructure`Order -- wrapper 2"
        ],
        
        VerificationTest[
            QO[ {Ind[1], Ind[2], Ind[3]} ][
                Ind[3] + F + G,
                H + Ind[1] + Ind[2]
            ], +1,
            TestID -> "QuotientStructure`Order -- orderless terms"
        ],
        
        VerificationTest[
            QO[ {Ind[1], Ind[2], Ind[3]} ][
                {Ind[3], F, G},
                {H, Ind[1], Ind[2]}
            ], -1,
            TestID -> "QuotientStructure`Order -- orderless terms (non-orderless)"
        ],
        
        VerificationTest[
            QO[ {} ][ Q, P[] ], 1,
            TestID -> "QuotientStructure`Order -- complex + pure symbol 1"
        ],
        
        VerificationTest[
            QO[ {} ][ P[], Q ], -1,
            TestID -> "QuotientStructure`Order -- complex + pure symbol 2"
        ],
        
        VerificationTest[
            QO[ {} ][a, 3.0], -1,
            TestID -> "QuotientStructure`Order -- default Order"
        ]
    }
]


End[];
