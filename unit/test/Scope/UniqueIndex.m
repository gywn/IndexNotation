(* ::Package:: *)

<< "SymbolicTensorDev/unit/lib/init_test.m"

RecursiveGet["Scope/UniqueIndex.m"]


With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        SS = SymbolicTensor`SymbolicSum,
        SI = SymbolicTensor`SumIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex
    },
    
    {
        VerificationTest[
            MatchQ[
                ScU[ ST[ a_[SS[ a_, SI[{a_}] ]], TI[{a_}, {b_}]] ],
                ST[ a_[SS[ c_, SI[{c_}] ]], TI[{a_}, {b_}]] /; 
                    Length @ Union[{a,b,c}] == 3
            ],
            True, 
            TestID -> "unshadow using unique variable"
        ]
    }    
]



