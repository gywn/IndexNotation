(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{ 
		ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
		
		PPQ = SymbolicTensor`Utility`PatternPresentQ,
		FMQ = SymbolicTensor`Utility`FreeMemberQ
	},

(**     FreeMemberQ[s, i]
  *
  *   - return true if 'i' occurs in 'x' but not as a dumb index
  *   - 'i' should be wrapped by Verbatim properly.
  *)
	FMQ[ x_, i_ ] := Block[
		{ presence = False },
		
		If[ PPQ[ i ], Message[FMQ::pat, HoldForm[i]] ];
		
		x /. {
			s : ScH[x1_, vrs_, ___] /; MemberQ[vrs, {i, ___}] :> s,
			i :> (presence = True; i)
		};
		
		presence
	];
	
	FMQ::pat = "pattern-like rule test element `1`"
]


End[];
