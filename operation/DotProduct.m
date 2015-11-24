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
    
    IT /: ( s1 : IT[_, vrs1_] ).( s2 : IT[_, _] ) := 
        TC[ s1 \[TensorProduct] s2, { Length[vrs1] + {0,1} } ]
]



End[];
