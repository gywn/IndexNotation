(* ::Package:: *)

Begin["SymbolicTensor`temp`"];


With[
	{
		UP = SymbolicTensor`Utility`UnionPartition,
		ES = SymbolicTensor`Utility`UnionPartition`EmptySum
	},
	
(**     UnionPartition
  *
  *   - UnionPartition[sets, universe] gives a replacement list 'rpl' which satisfies
  *       + 'index //. rpl' gives ID of the partition cluster that 'index' is in.
  *       + 'rpl' contains 'ES -> ES_ID' if
  *           * 'sets' doesn't cover 'universe', which means there are unused indexes; 
  *           * or there is empty set in 'sets', which means some terms don't use any index.
  *
  *   - Complement[ rpl[[All, 1]], rpl[[All, 2]] ] gives a list of all used indexes in 'sets'
  *     wrapped by Verbatim, along with ES if needed.
  *
  *   - Complement[ rpl[[All, 2]], rpl[[All, 1]] ] gives a list of partition clusters' IDs.
  *)
	UP[ sets : {__List}, univ_List ] := Block[
		{ rpl = {}, unused },
	
		(set \[Function] With[
			{ setID = Unique[] },
			
			If[ set === {},
				If[ (ES //. rpl) === ES, AppendTo[ rpl, ES -> setID ]],
				(vertex \[Function]
					If[ (vertex //. rpl) === vertex,
						AppendTo[ rpl, Verbatim[vertex] -> setID ],
						If[ (vertex //. rpl) =!= setID,
							AppendTo[ rpl, (vertex //. rpl) -> setID ]
						]
					]) /@ set
			]
		]) /@ sets;
		
		unused = Complement[ Verbatim /@ univ, Complement[ rpl[[All, 1]], rpl[[All, 2]] ] ];
		
		If[ (ES //. rpl) === ES \[And] unused === {},
			rpl,
			Append[ rpl, ES -> Unique[] ]
		]
	];
]


End[];
