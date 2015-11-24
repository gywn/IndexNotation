(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Utility/QuotientStructure.m"]


Begin["IndexNotation`test`"];


With[
    {    
        QSQ = IndexNotation`Utility`QuotientStructure`SameQ
    },
    
    Global`RESULTS = {
        VerificationTest[
            QSQ[{a,b,c,d}][a+b,c+d], True,
            TestID -> "QuotientStructure`SameQ -- simple case 1"
        ],
        
        VerificationTest[
            QSQ[{a,b,c}][a+b,c+d], False,
            TestID -> "QuotientStructure`SameQ -- simple case 2"
        ]
    }
]


End[];
