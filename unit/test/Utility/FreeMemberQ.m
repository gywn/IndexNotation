(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Utility/FreeMemberQ.m"]


With[
    {
    	ST = SymbolicTensor`SymbolicTensor,
    	TI = SymbolicTensor`TensorIndex,
    	
    	SS = SymbolicTensor`SymbolicSum,
    	SI = SymbolicTensor`SumIndex,
    	
    	FMQ = SymbolicTensor`Utility`FreeMemberQ
    },
    
    {
    	VerificationTest[
    		FMQ[ SS[ i_, SI[{i_}] ], Verbatim[i_] ],
    		False
    	],
    
    	VerificationTest[
    		FMQ[ i_ + SS[ i_, SI[{i_}] ], Verbatim[i_] ],
    		True
    	]
    }
]
