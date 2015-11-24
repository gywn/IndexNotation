(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        IS = IndexNotation`IndexSum
    },
    
    IS[ HoldPattern @ SeriesData[v_, v0_, c_List, n1_, n2_, den_], vrs_ ]
        := SeriesData[v, v0, IS[#, vrs]& /@ c, n1, n2, den];
]


End[];
