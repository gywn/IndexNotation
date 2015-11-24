(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        IS = IndexNotation`IndexSum,
        SI = IndexNotation`SumIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        
        IdF = IndexNotation`IndexFlatten
    },
    
    IdF[x_] := ScU[x] //. {
        HoldPattern @ IT[ x1_, TI[vrs__] ] :> Table[ x1, Evaluate[ Sequence @@ Reverse @ {vrs} ] ],
        HoldPattern @ IS[ x1_, SI[vrs__] ] :> Sum[ x1, Evaluate[ Sequence @@ {vrs} ] ]
    };
]



End[];
