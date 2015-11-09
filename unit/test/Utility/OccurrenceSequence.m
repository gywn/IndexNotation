(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Utility/OccurrenceSequence.m"];


With[
    {
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex,
    	ST = SymbolicTensor`SymbolicTensor,
    	TI = SymbolicTensor`TensorIndex,
    	
    	sql = SymbolicTensor`Utility`OccurrenceSequence`Sequential,
    	sml = SymbolicTensor`Utility`OccurrenceSequence`Simultaneous,
    	CoS = SymbolicTensor`Utility`OccurrenceSequence`ComplexSequence,
    	
    	OcS = SymbolicTensor`Utility`OccurrenceSequence
    },
    
    {
    	VerificationTest[
    		CoS[SS[A[i,4]+A[j,3],SI[{i},{j}]], {i,j}],
    		Sequence[],
    		TestID -> "ComplexSequence -- no occurrence"
    	],
    	
    	VerificationTest[
    		CoS[A[i,4]+A[j,3], {i,j}],
    		sql[j,i],
    		TestID -> "ComplexSequence -- orderless yet sequential"
    	],
    	
    	VerificationTest[
    		CoS[A[i,3]+A[j,3], {i,j}],
    		sql[sml[sql[j],sql[i]]],
    		TestID -> "ComplexSequence -- orderless and simultaneous"
    	],
    	
    	VerificationTest[
    		CoS[A[i,3]+A[j,3]+A[i,4], {i,j}],
    		sql[sml[sql[j],sql[i]],i],
    		TestID -> "ComplexSequence -- orderless and mixed"
    	],
    	
    	VerificationTest[
    		OcS[ F[c,G[a,b]+G[c,d],a], {a,b,c,d} ] - {c,d,a,b},
    		OcS[ F[c,G[a,d]+G[c,b],a], {a,b,c,d} ] - {c,b,a,d},
    		TestID -> "OccurrenceSequence -- differentiating Orderless terms"
    	],
    	
    	VerificationTest[
    		OcS[ SS[A[a,b],SI[{a}]], {a, b} ],
    		{b},
    		TestID -> "OccurrenceSequence -- shadowing + only one index"
    	],
    	
    	VerificationTest[
    		OcS[ ST[A[a_,b_,b_],TI[{a_}]], {a_, b_} ],
    		{b_},
    		TestID -> "OrderedFreeMemberList -- shadowing + pattern index + duplicated occurrence"
    	],
    	
    	VerificationTest[
    		OcS[ {a+b,SI[{a,4},{b,3}]}, {a,b} ],
    		{b,a},
    		TestID -> "OccurrenceSequence -- classical case 1"
    	],
    	
    	VerificationTest[
    		OcS[ {a+b,TI[{a,4},{b,3}]}, {a,b} ],
    		{a,b},
    		TestID -> "OccurrenceSequence -- classical case 2"
    	],
    	
    	VerificationTest[
    		OcS[ a, {a,b,c} ],
    		{a},
    		TestID -> "OccurrenceSequence -- single occurrence"
    	],
    	
    	VerificationTest[
    		OcS[ d, {a,b,c} ],
    		{},
    		TestID -> "OccurrenceSequence -- no occurrence"
    	]
    }
]
