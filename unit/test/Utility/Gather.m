(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Utility/QuotientStructure.m"]


Begin["IndexNotation`test`"];


With[
    {
        QGt = IndexNotation`Utility`QuotientStructure`Gather
    },
    
    Global`RESULTS = {    
        VerificationTest[
            QGt[{a,b,c,d}][{ a+c,b+d,K[b,3],K[a,3],K[a,4] }],
            { {K[b,3],K[a,3]}, {K[a,4]}, {a+c,b+d} },
            TestID -> "QuotientStructure`SameQ -- classical case"
        ]
    }
]


End[];
