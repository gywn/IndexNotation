(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
		
		PPQ = SymbolicTensor`Utility`PatternPresentQ,
		OFML = SymbolicTensor`Utility`OrderedFreeMemberList
	},
	
(**     OrderedFreeMemberList
  *
  *   - return a subset of 'is' ordered by its apperances in 'x' as free index
  *   - 'is' should be wrapped by Verbatim properly.
  *   - result is NOT wrapped by Verbatim.
  *
  *     Known Bug: if 'x' has Orderless attribute, resulted list follows order in 'is',
  *                instead of 'x'.
  *)
	OFML[x_, is_] := Block[
		{ ois = {} },
		
		If[ PPQ[ is ], Message[OFML::pat, HoldForm[is]] ];
		
		x /. {
			s : ScH[x1_, vrs_, ___]
				:> (ois = Join[ ois, OFML[ x1, Select[ is, \[Not] MemberQ[vrs, {#, ___}]& ] ] ]; s),
			i : (Alternatives @@ is) :> (ois = Append[ ois, i ]; i)
			(* Verbatim is stripped here for 'i' *)
		};
		ois
	];
	
	OFML[x_, {}] := {};
	
	OFML::pat = "pattern-like rule test list `1`"
]


End[];
