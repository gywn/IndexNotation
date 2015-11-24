(* ::Package:: *)

<< "IndexNotation/unit/lib/init_test.m"

RecursiveGet["Scope/UniqueIndex.m"]


Begin["IndexNotation`test`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex
    },
    
    Global`RESULTS = {
        VerificationTest[
            MatchQ[
                ScU[ IT[ a_[IS[ a_, SI[{a_}] ]], TI[{a_}, {b_}]] ],
                IT[ a_[IS[ c_, SI[{c_}] ]], TI[{a_}, {b_}]] /; 
                    Length @ Union[{a,b,c}] == 3
            ],
            True, 
            TestID -> "unshadow using unique variable"
        ]
    }    
]


End[];
