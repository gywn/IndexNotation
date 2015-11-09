(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["QuotientStructure.m"]


With[
    {
        QGt = SymbolicTensor`QuotientStructure`Gather
    },
    
    {    
        VerificationTest[
            QGt[{a,b,c,d}][{ a+c,b+d,K[b,3],K[a,3],K[a,4] }],
            { {K[b,3],K[a,3]}, {K[a,4]}, {a+c,b+d} },
            TestID -> "QuotientStructure`SameQ -- classical case"
        ]
    }
]
