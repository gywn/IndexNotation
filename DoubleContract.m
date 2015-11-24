(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex,
        
        TC = TensorContract,
        DC = IndexNotation`DoubleContract
    },
    
    DC[ s1 : IT[_, vrs1_], s2_IT ] := TC[ s1 \[TensorProduct] s2, Length[vrs1] + {{-1, 1}, {0, 2}} ];
]



End[];
