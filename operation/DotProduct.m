(* ::Package:: *)

Begin["SymbolicTensor`temp`"];

With[
    {
        ST = SymbolicTensor`SymbolicTensor,
        TI = SymbolicTensor`TensorIndex,
        
        ScU = SymbolicTensor`Scope`UniqueIndex,
        ScT = SymbolicTensor`Scope`Transform,
        
        indexfunc = SymbolicTensor`DumbIndex,

        TC = TensorContract
    },
    
    ST /: ( s1 : ST[_, vrs1_] ).( s2 : ST[_, _] ) := 
        TC[ s1 \[TensorProduct] s2, { Length[vrs1] + {0,1} } ]
]



End[];
