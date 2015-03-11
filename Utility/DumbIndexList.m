(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
		
		OFML = SymbolicTensor`Utility`OrderedFreeMemberList,
		DIL = SymbolicTensor`Utility`DumbIndexList
	},
	
(**     DumbIndexList
 *
 *    - return dumb index List for a closed-scope expression (e.g. SymbolicTensor)
 *    - if 'vrs' has Orderless head, order in the result is determinated by their
 *      appearance order in x, and then order in vrs.
 *)
	
	(* OPTIMIZATION: opt___ can be ___ ? *)
	
	DIL[ s : ScH[ x_, vrs : vh_[___], opt___] ] 
		/; MemberQ[ Attributes[ vh ], Orderless ]
		:=  DeleteDuplicates @ Join[
			OFML[ x, Verbatim /@ vrs[[All, 1]] ],
			Cases[ vrs, {i_, ___} :> i ]
		];

	DIL[ s : ScH[ x_, vrs : vh_[___], opt___] ]
		:= Cases[ Reverse @ vrs, {i_, ___} :> i ];
]


End[];
