(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
    	PPQ = SymbolicTensor`Utility`PatternPresentQ,
    	IPPQ = Internal`PatternPresentQ
    },
    
    (*PPQ[ x_ ] := IPPQ[ Hold[x] /. _Verbatim :> Null ];*)
    
(**     PatternPresentQ
  *
  *   - similar to Internal`PatternPresentQ, except that Verbatim and what is wrapped
  *     by it are not considered as pattern.
  *)
    PPQ[ x_ ] := Block[
    	{ presence = False },
    	
    	x /. {
    		v_Verbatim :> v,
    		a : Alternatives[
    			_Blank, _BlankSequence, _BlankNullSequence,
    			_Alternatives, _Repeated, _RepeatedNull, _Pattern,
    			_Except, _Longest, _Shortest,
    			_Condition, _PatternTest
    		] :> (presence = True; a)
    	};
    	
    	presence
    ];
];


End[];
