(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        DI = IndexNotation`DummyIndex,    
    
        LC = IndexNotation`IndexSimplify`LeafCount,
        HLC = IndexNotation`IndexSimplify`LeafCount`Hold
    },
    
(**     LeafCount
  *
  *   - similar to System`LeafCount except that LeafCount[DummyIndex[__]] === 1
  *)        
    SetAttributes[HLC, HoldAll];
    
    LC[x_] := HLC[Evaluate @ x];
    
    HLC[x_, y__] := HLC[x] + HLC[y];
    
    HLC[_DI] := HLC[DI];
    
    (*HLC[ (h : ScH)[x_, vrs_, opt___] ] := HLC[h, x];*)
    
    HLC[ h_[x___] ] := HLC[h, x];
    
    HLC[x_] /; AtomQ[x] := 1;
    
    HLC[] := 0;
]


End[];
