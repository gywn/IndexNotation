(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    { 
        ScH = IndexNotation`IndexTensor | IndexNotation`IndexSum,
        
        FrM = IndexNotation`Utility`FreeMember,
        flt = IndexNotation`Utility`FreeMember`Flat,
        FMQ = IndexNotation`Utility`FreeMemberQ
    },

(**     FreeMemberQ[s, i]
  *
  *   - Return True if 'i' occurs in 'x' but not as a dummy index
  *   - Utility`FreeMember is similar to Utility`SortedIndex, but a little bit faster.
  *)
    SetAttributes[flt, Flat];

    FrM[i_, i_] := i;

    FrM[s : ScH[_, vh_[___, {i_, ___}, ___], ___], i_] := flt[];

    FrM[s : ScH[_, vrs_, ___], i_] := FrM[List @@ s, i];

    FrM[ h_[x1___], i_ ] := flt @@ (y \[Function] FrM[y, i]) /@ {h, x1};

    FrM[x_, i_] := flt[];

    FMQ[x_, i_] := FrM[x, i] =!= flt[];
]


End[];
