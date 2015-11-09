(* ::Package:: *)

With[
    {
        packageDir = "SymbolicTensorDev",
        packageContext = "SymbolicTensor"
    },

    Quiet[
        (con \[Function] Remove @ Evaluate @ StringJoin[con, "*"]) /@ Contexts[packageContext <> "*"],
        {Remove::rmnsm, Remove::rmptc}
        (* Message: no symbol matched & protected symbol *)
    ];
]


<< "SymbolicTensorDev/DumbIndex.m"
<< "SymbolicTensorDev/QuotientStructure.m"
<< "SymbolicTensorDev/Utility/UnionPartition.m"
<< "SymbolicTensorDev/SymbolicSimplify/LeafCount.m"
<< "SymbolicTensorDev/Scope/Transform.m"
<< "SymbolicTensorDev/Scope/UniqueIndex.m"
<< "SymbolicTensorDev/SymbolicSum.m"
<< "SymbolicTensorDev/SymbolicTensor.m"
<< "SymbolicTensorDev/Utility/DumbIndexList.m"
<< "SymbolicTensorDev/Utility/OccurrenceSequence.m"
<< "SymbolicTensorDev/operation/DotProduct.m"
<< "SymbolicTensorDev/operation/Part.m"
<< "SymbolicTensorDev/operation/TensorContract.m"
<< "SymbolicTensorDev/operation/TensorProduct.m"
<< "SymbolicTensorDev/operation/TensorTranspose.m"
<< "SymbolicTensorDev/operation/Tr.m"
<< "SymbolicTensorDev/transform_rules/m-t.m"
<< "SymbolicTensorDev/transform_rules/p-t.m"
<< "SymbolicTensorDev/transform_rules/s-d.m"
<< "SymbolicTensorDev/transform_rules/s-m-p.m"
<< "SymbolicTensorDev/transform_rules/s-m-s.m"
<< "SymbolicTensorDev/transform_rules/s-p.m"
<< "SymbolicTensorDev/transform_rules/s-s.m"
<< "SymbolicTensorDev/transform_rules/s-t.m"
<< "SymbolicTensorDev/transform_rules/t-t.m"
<< "SymbolicTensorDev/TensorFlatten.m"
<< "SymbolicTensorDev/Utility/FreeMemberQ.m"
<< "SymbolicTensorDev/transform_rules/s-m.m"
<< "SymbolicTensorDev/SymbolicSimplify/ReduceEmptySum.m"
<< "SymbolicTensorDev/SymbolicSimplify/Simplify.m"

(**   - inject SymbolicTensor` into $ContextPath
 *    - define some shortcuts
 *)
BeginPackage["SymbolicTensor`"];
    
    STensor = SymbolicTensor`SymbolicTensor;
    SSum = SymbolicTensor`SymbolicSum;
    SSimplify = SymbolicTensor`SymbolicSimplify`Simplify;
    ReformatList = SymbolicTensor`ReformatList;
    
EndPackage[];






