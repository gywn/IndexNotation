(* ::Package:: *)

Begin["IndexNotation`Private`"];


With[
    {
        packageDir = "IndexNotation",
        packageContext = "IndexNotation"
    },

    Quiet[
        (con \[Function] ClearAll @ Evaluate @ StringJoin[con, "*"]) /@ Contexts[packageContext <> "*"],
        {ClearAll::wrsym}
        (* Message: protected symbol *)
    ];
]


<< "IndexNotation/DummyIndex.m"
<< "IndexNotation/Utility/QuotientStructure.m"
<< "IndexNotation/Utility/UnionPartition.m"
<< "IndexNotation/IndexSimplify/LeafCount.m"
<< "IndexNotation/IndexSum.m"
<< "IndexNotation/IndexTensor.m"
<< "IndexNotation/Scope/DummyIndexList.m"
<< "IndexNotation/Scope/Transform.m"
<< "IndexNotation/Scope/UniqueIndex.m"
<< "IndexNotation/Utility/SortedIndex.m"
<< "IndexNotation/operation/DotProduct.m"
<< "IndexNotation/operation/MakeBoxes.m"
<< "IndexNotation/operation/Part.m"
<< "IndexNotation/operation/TensorContract.m"
<< "IndexNotation/operation/TensorProduct.m"
<< "IndexNotation/operation/TensorTranspose.m"
<< "IndexNotation/operation/Tr.m"
<< "IndexNotation/transform_rules/m-t.m"
<< "IndexNotation/transform_rules/p-t.m"
<< "IndexNotation/transform_rules/s-d.m"
<< "IndexNotation/transform_rules/s-m-p.m"
<< "IndexNotation/transform_rules/s-m-s.m"
<< "IndexNotation/transform_rules/s-p.m"
<< "IndexNotation/transform_rules/s-s.m"
<< "IndexNotation/transform_rules/s-sd.m"
<< "IndexNotation/transform_rules/s-t.m"
<< "IndexNotation/transform_rules/t-sd.m"
<< "IndexNotation/transform_rules/t-t.m"
<< "IndexNotation/DoubleContract.m"
<< "IndexNotation/IndexFlatten.m"
<< "IndexNotation/TensorDerivative.m"
<< "IndexNotation/Utility/FreeMemberQ.m"
<< "IndexNotation/transform_rules/s-m.m"

(**   - inject IndexNotation` into $ContextPath
 *    - define some shortcuts
 *)
    IndexNotation`TrF = IndexNotation`Scope`Transform[IndexNotation`DummyIndex];
    
    $ContextPath = Union[ $ContextPath, {"IndexNotation`"} ];


End[];
