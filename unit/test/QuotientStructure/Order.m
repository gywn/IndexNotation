(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["QuotientStructure.m"]


With[
    {	
    	QO = SymbolicTensor`QuotientStructure`Order,
    	wp = SymbolicTensor`QuotientStructure`Order`Wrapper
    },
    
    {   
    	VerificationTest[
    		QO[{a,b,c}][a,b], 0,
    		TestID -> "QuotientStructure`Order -- simple pure dumb indexes"
    	],
    	
    	VerificationTest[
    		QO[{Ind[1],Ind[2],Ind[3]}][Ind[3],Ind[2]], 0,
    		TestID -> "QuotientStructure`Order -- complex pure dumb indexes"
    	],
    	
    	VerificationTest[
    		QO[{Ind[1],Ind[2],Ind[3]}][Ind[3],H[F[a]]], 1,
    		TestID -> "QuotientStructure`Order -- dumb indexes + complex structure 1"
    	],
    	
    	VerificationTest[
    		QO[{Ind[1],Ind[2],Ind[3]}][H[F[a]],Ind[3]], -1,
    		TestID -> "QuotientStructure`Order -- dumb indexes + complex structure 2"
    	],
    	
    	VerificationTest[
    		QO[{Ind[1],Ind[2],Ind[3]}][
    			wp[Ind[3],Ind[2],H],
    			wp[Ind[2],Ind[1],H]
    		], 0,
    		TestID -> "QuotientStructure`Order -- wrapper 1"
    	],
    	
    	VerificationTest[
    		QO[{Ind[1],Ind[2],Ind[3]}][
    			wp[Ind[3],H,Ind[2]],
    			wp[Ind[2],Ind[1],H]
    		], -1,
    		TestID -> "QuotientStructure`Order -- wrapper 2"
    	],
    	
    	VerificationTest[
    		QO[{Ind[1],Ind[2],Ind[3]}][
    			Ind[3] + F + G,
    			H + Ind[1] + Ind[2]
    		], -1,
    		TestID -> "QuotientStructure`Order -- orderless terms"
    	],
    	
    	VerificationTest[
    		QO[{Ind[1],Ind[2],Ind[3]}][
    			{Ind[3], F, G},
    			{H, Ind[1], Ind[2]}
    		], 1,
    		TestID -> "QuotientStructure`Order -- orderless terms (non-orderless)"
    	],
    	
    	VerificationTest[
    		QO[{}][ Q,P[] ], 1,
    		TestID -> "QuotientStructure`Order -- complex + pure symbol 1"
    	],
    	
    	VerificationTest[
    		QO[{}][ P[],Q ], -1,
    		TestID -> "QuotientStructure`Order -- complex + pure symbol 2"
    	],
    	
    	VerificationTest[
    		QO[{}][ a,3.0 ], -1,
    		TestID -> "QuotientStructure`Order -- default Order"
    	]
    }
]
