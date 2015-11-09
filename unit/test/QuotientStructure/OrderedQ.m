(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["QuotientStructure.m"]


With[
    {	
    	QOQ = SymbolicTensor`QuotientStructure`OrderedQ
    },
    
    {
    	VerificationTest[
    		QOQ[{Ind[1],Ind[2],Ind[3]}][ Ind[3], Ind[2] ], True,
    		TestID -> "QuotientStructure`OrderedQ -- orderless terms"
    	],
    	
    	VerificationTest[
    		QOQ[{}][ a, a ], True,
    		TestID -> "QuotientStructure`OrderedQ -- orderless terms"
    	],
    	
    	VerificationTest[
    		QOQ[{Ind[1],Ind[2],Ind[3]}][ a, Ind[1] ], False,
    		TestID -> "QuotientStructure`OrderedQ -- orderless terms"
    	]
    }
]
