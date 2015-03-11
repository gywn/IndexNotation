(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		ScH = SymbolicTensor`SymbolicTensor | SymbolicTensor`SymbolicSum,
		
		DIL = SymbolicTensor`Utility`DumbIndexList,
		FMQ = SymbolicTensor`Utility`FreeMemberQ,
		ScR = SymbolicTensor`Scope`Replace,
	
		ScT = SymbolicTensor`Scope`Transform
	},	
	
(**     Transform
 *
 *    - Transform[indexfunc][x] rename all dumb indexes in x with indexfunc. 
 *    - Transform's goal is to use a minimal number of distincted indexes.
 *
 *      indexfunc
 *	
 *    - indexfunc[n] should return the n-th dumb index notation
 *    - ScT calls indexfunc sequencially, so indexfunc[n_] can be implemented as
 *
 *          indexfunc[1] := IndexFuncStart
 *          indexfunc[_] := IndexFuncNext
 *
 *      which is literally an iterator
 *)		
			
	ScT[indexfunc_][ x_ ] := 
		x /. s : ScH[__] :> Block[
			{ rpl },
			
			rpl = Block[
				{ n = 0, new },
		
				(
					While[ FMQ[ s, Verbatim[ new = indexfunc[ ++n ] ] ] ];
					Verbatim[#] -> new
				)& /@ DIL[ s ]
			];
			
			(ScT[indexfunc] @ ScR[#, rpl])& /@ s
		];
];	


End[];
