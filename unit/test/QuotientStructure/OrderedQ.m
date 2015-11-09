(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["QuotientStructure.m"]


Begin["SymbolicTensor`test`"];


With[
    {    
        QOQ = SymbolicTensor`QuotientStructure`OrderedQ
    },
    
    Global`RESULTS = {
        VerificationTest[
            QOQ[{Ind[1],Ind[2],Ind[3]}][ Ind[3], Ind[2] ], True,
            TestID -> "QuotientStructure`OrderedQ -- orderless terms"
        ],
        
        VerificationTest[
            QOQ[{}][a, a], True,
            TestID -> "QuotientStructure`OrderedQ -- orderless terms"
        ],
        
        VerificationTest[
            QOQ[{Ind[1],Ind[2],Ind[3]}][ a, Ind[1] ], True,
            TestID -> "QuotientStructure`OrderedQ -- orderless terms"
        ]
    }
]


End[];
