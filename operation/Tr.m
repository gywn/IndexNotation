(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IT = IndexNotation`IndexTensor,
        TI = IndexNotation`TensorIndex,
        
        ScU = IndexNotation`Scope`UniqueIndex,
        ScT = IndexNotation`Scope`Transform,
        
        indexfunc = IndexNotation`DummyIndex,

        TC = TensorContract
    },
    
    IT /: Tr[ s1 : IT[_, vrs1_] ] := TC[ s1, { Length[vrs1] + {-1,0} } ];
]



End[];
