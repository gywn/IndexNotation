(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["QuotientStructure.m"]


With[
    {    
        QSr = SymbolicTensor`QuotientStructure`Sort
    },
    
    {    
        VerificationTest[
            QSr[{a,b,c,d}][{b c,a+b,a+c,a b,3+a,3 b}],
            {a+b,a+c,3+a,b c,a b,3 b},
            TestID -> "QuotientStructure`Sort -- simple case"
        ],
        
        VerificationTest[
            QSr[{a,b,c,d}][{{a,4},{b,3}}],
            {{b,3},{a,4}},
            TestID -> "QuotientStructure`Sort -- classical case 1"
        ],
        
        VerificationTest[
            QSr[{a,b,c,d}][{S[U,{a,4}],S[U,{b,3}]}],
            {S[U,{b,3}],S[U,{a,4}]},
            TestID -> "QuotientStructure`Sort -- classical case 2"
        ]
    }
]
