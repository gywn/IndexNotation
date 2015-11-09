(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
    {
    	ES = SymbolicTensor`Utility`UnionPartition`EmptySum,
    	UP = SymbolicTensor`Utility`UnionPartition
    },
    
(**     UnionPartition
  *
  *   - UnionPartition[sets, universe] gives a replacement list 'rpl' which satisfies
  *       + if 'index' is used in 'sets', 'index //. rpl' gives ID of the partition 
  *         cluster that 'index' is in;
  *       + if 'index' is unused, 'index //. rpl' gives 'ES'.
  *
  *   - 'Complement[ Values[rpl], Keys[rpl] ]' gives a list of partition clusters' IDs
  *     mixed with 'ES' if there is one.
  *   
  *   - 'Keys @ Select[ rpl, # === ES & ]' gives the list of unused indexes.
  *)
    UP[ sets : {__List}, univ_List ] := Block[
    	{ rpl = <||>, unused },
    
    	(set \[Function] With[
    		{ setID = Unique[] },
    		
    		(vertex \[Function]
    			If[ \[Not] KeyExistsQ[rpl, vertex],
    				AssociateTo[ rpl, vertex -> setID ],
    				If[ (vertex //. rpl) =!= setID,
    					AssociateTo[ rpl, (vertex //. rpl) -> setID ]
    				]
    			]) /@ set

    	]) /@ sets;
    	
    	unused = Complement[ univ, Complement[ Keys[rpl], Values[rpl] ] ];
    	(vertex \[Function] AssociateTo[ rpl, vertex -> ES ]) /@ unused;
    	
    	# //. rpl & /@ rpl   (* accelerate clustering by shortening reference path *)
    ];
]


End[];
