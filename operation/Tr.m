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
    
    ST /: Tr[ s1 : ST[_, vrs1_] ] := TC[ s1, { Length[vrs1] + {-1,0} } ];
]



End[];
