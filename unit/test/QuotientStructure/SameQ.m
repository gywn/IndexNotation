(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["QuotientStructure.m"]


Begin["SymbolicTensor`test`"];


With[
    {    
        QSQ = SymbolicTensor`QuotientStructure`SameQ
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
