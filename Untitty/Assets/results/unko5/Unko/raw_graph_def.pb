
C
global_step/initial_valueConst*
dtype0*
value	B : 
W
global_step
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
global_step/AssignAssignglobal_stepglobal_step/initial_value*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
R
global_step/readIdentityglobal_step*
T0*
_class
loc:@global_step
;
steps_to_incrementPlaceholder*
dtype0*
shape: 
9
AddAddglobal_step/readsteps_to_increment*
T0
t
AssignAssignglobal_stepAdd*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
L
vector_observationPlaceholder*
dtype0*
shape:���������
w
%normalization_steps/Initializer/zerosConst*&
_class
loc:@normalization_steps*
dtype0*
value	B : 
�
normalization_steps
VariableV2*&
_class
loc:@normalization_steps*
	container *
dtype0*
shape: *
shared_name 
�
normalization_steps/AssignAssignnormalization_steps%normalization_steps/Initializer/zeros*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
j
normalization_steps/readIdentitynormalization_steps*
T0*&
_class
loc:@normalization_steps
p
running_mean/Initializer/zerosConst*
_class
loc:@running_mean*
dtype0*
valueB*    
}
running_mean
VariableV2*
_class
loc:@running_mean*
	container *
dtype0*
shape:*
shared_name 
�
running_mean/AssignAssignrunning_meanrunning_mean/Initializer/zeros*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
U
running_mean/readIdentityrunning_mean*
T0*
_class
loc:@running_mean
w
!running_variance/Initializer/onesConst*#
_class
loc:@running_variance*
dtype0*
valueB*  �?
�
running_variance
VariableV2*#
_class
loc:@running_variance*
	container *
dtype0*
shape:*
shared_name 
�
running_variance/AssignAssignrunning_variance!running_variance/Initializer/ones*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
a
running_variance/readIdentityrunning_variance*
T0*#
_class
loc:@running_variance
;
ShapeShapevector_observation*
T0*
out_type0
A
strided_slice/stackConst*
dtype0*
valueB: 
C
strided_slice/stack_1Const*
dtype0*
valueB:
C
strided_slice/stack_2Const*
dtype0*
valueB:
�
strided_sliceStridedSliceShapestrided_slice/stackstrided_slice/stack_1strided_slice/stack_2*
Index0*
T0*

begin_mask *
ellipsis_mask *
end_mask *
new_axis_mask *
shrink_axis_mask
>
Add_1Addnormalization_steps/readstrided_slice*
T0
:
SubSubvector_observationrunning_mean/read*
T0
;
CastCastAdd_1*

DstT0*

SrcT0*
Truncate( 
&
truedivRealDivSubCast*
T0
?
Sum/reduction_indicesConst*
dtype0*
value	B : 
P
SumSumtruedivSum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
/
add_2AddV2running_mean/readSum*
T0
0
Sub_1Subvector_observationadd_2*
T0

mulMulSub_1Sub*
T0
A
Sum_1/reduction_indicesConst*
dtype0*
value	B : 
P
Sum_1SummulSum_1/reduction_indices*
T0*

Tidx0*
	keep_dims( 
5
add_3AddV2running_variance/readSum_1*
T0
z
Assign_1Assignrunning_meanadd_2*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
Assign_2Assignrunning_varianceadd_3*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
Assign_3Assignnormalization_stepsAdd_1*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
L
moments/mean/reduction_indicesConst*
dtype0*
valueB: 
n
moments/meanMeanvector_observationmoments/mean/reduction_indices*
T0*

Tidx0*
	keep_dims(
;
moments/StopGradientStopGradientmoments/mean*
T0
a
moments/SquaredDifferenceSquaredDifferencevector_observationmoments/StopGradient*
T0
P
"moments/variance/reduction_indicesConst*
dtype0*
valueB: 
}
moments/varianceMeanmoments/SquaredDifference"moments/variance/reduction_indices*
T0*

Tidx0*
	keep_dims(
H
moments/SqueezeSqueezemoments/mean*
T0*
squeeze_dims
 
N
moments/Squeeze_1Squeezemoments/variance*
T0*
squeeze_dims
 
�
Assign_4Assignrunning_meanmoments/Squeeze*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
4
add_4/yConst*
dtype0*
valueB
 *���3
3
add_4AddV2moments/Squeeze_1add_4/y*
T0
=
Cast_1CastAdd_1*

DstT0*

SrcT0*
Truncate( 
$
mul_1Muladd_4Cast_1*
T0
�
Assign_5Assignrunning_variancemul_1*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
3

group_depsNoOp	^Assign_3	^Assign_4	^Assign_5
5
group_deps_1NoOp	^Assign_1	^Assign_2	^Assign_3
<
sub_2Subvector_observationrunning_mean/read*
T0
P
Cast_2Castnormalization_steps/read*

DstT0*

SrcT0*
Truncate( 
4
add_5/yConst*
dtype0*
valueB
 *  �?
(
add_5AddV2Cast_2add_5/y*
T0
;
	truediv_1RealDivrunning_variance/readadd_5*
T0
 
SqrtSqrt	truediv_1*
T0
*
	truediv_2RealDivsub_2Sqrt*
T0
G
normalized_state/Minimum/yConst*
dtype0*
valueB
 *  �@
S
normalized_state/MinimumMinimum	truediv_2normalized_state/Minimum/y*
T0
?
normalized_state/yConst*
dtype0*
valueB
 *  ��
R
normalized_stateMaximumnormalized_state/Minimumnormalized_state/y*
T0
5

batch_sizePlaceholder*
dtype0*
shape:
:
sequence_lengthPlaceholder*
dtype0*
shape:
;
masksPlaceholder*
dtype0*
shape:���������
A
epsilonPlaceholder*
dtype0*
shape:���������
=
Cast_3Castmasks*

DstT0*

SrcT0*
Truncate( 
M
#is_continuous_control/initial_valueConst*
dtype0*
value	B :
a
is_continuous_control
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
is_continuous_control/AssignAssignis_continuous_control#is_continuous_control/initial_value*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
p
is_continuous_control/readIdentityis_continuous_control*
T0*(
_class
loc:@is_continuous_control
M
#trainer_major_version/initial_valueConst*
dtype0*
value	B : 
a
trainer_major_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_major_version/AssignAssigntrainer_major_version#trainer_major_version/initial_value*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
p
trainer_major_version/readIdentitytrainer_major_version*
T0*(
_class
loc:@trainer_major_version
M
#trainer_minor_version/initial_valueConst*
dtype0*
value	B :
a
trainer_minor_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_minor_version/AssignAssigntrainer_minor_version#trainer_minor_version/initial_value*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
p
trainer_minor_version/readIdentitytrainer_minor_version*
T0*(
_class
loc:@trainer_minor_version
M
#trainer_patch_version/initial_valueConst*
dtype0*
value	B : 
a
trainer_patch_version
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
trainer_patch_version/AssignAssigntrainer_patch_version#trainer_patch_version/initial_value*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
p
trainer_patch_version/readIdentitytrainer_patch_version*
T0*(
_class
loc:@trainer_patch_version
F
version_number/initial_valueConst*
dtype0*
value	B :
Z
version_number
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
version_number/AssignAssignversion_numberversion_number/initial_value*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
[
version_number/readIdentityversion_number*
T0*!
_class
loc:@version_number
C
memory_size/initial_valueConst*
dtype0*
value	B : 
W
memory_size
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
memory_size/AssignAssignmemory_sizememory_size/initial_value*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
R
memory_size/readIdentitymemory_size*
T0*
_class
loc:@memory_size
K
!action_output_shape/initial_valueConst*
dtype0*
value	B :
_
action_output_shape
VariableV2*
	container *
dtype0*
shape: *
shared_name 
�
action_output_shape/AssignAssignaction_output_shape!action_output_shape/initial_value*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
j
action_output_shape/readIdentityaction_output_shape*
T0*&
_class
loc:@action_output_shape
�
Fpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shapeConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Epolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/meanConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Gpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddevConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *���>
�
Ppolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalFpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
seed�'*
seed2 
�
Dpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulMulPpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalGpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
@policy/main_graph_0/hidden_0/kernel/Initializer/truncated_normalAddDpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulEpolicy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
#policy/main_graph_0/hidden_0/kernel
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
*policy/main_graph_0/hidden_0/kernel/AssignAssign#policy/main_graph_0/hidden_0/kernel@policy/main_graph_0/hidden_0/kernel/Initializer/truncated_normal*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
(policy/main_graph_0/hidden_0/kernel/readIdentity#policy/main_graph_0/hidden_0/kernel*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
3policy/main_graph_0/hidden_0/bias/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
!policy/main_graph_0/hidden_0/bias
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
(policy/main_graph_0/hidden_0/bias/AssignAssign!policy/main_graph_0/hidden_0/bias3policy/main_graph_0/hidden_0/bias/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
&policy/main_graph_0/hidden_0/bias/readIdentity!policy/main_graph_0/hidden_0/bias*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
#policy/main_graph_0/hidden_0/MatMulMatMulnormalized_state(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
$policy/main_graph_0/hidden_0/BiasAddBiasAdd#policy/main_graph_0/hidden_0/MatMul&policy/main_graph_0/hidden_0/bias/read*
T0*
data_formatNHWC
^
$policy/main_graph_0/hidden_0/SigmoidSigmoid$policy/main_graph_0/hidden_0/BiasAdd*
T0
|
 policy/main_graph_0/hidden_0/MulMul$policy/main_graph_0/hidden_0/BiasAdd$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
Fpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shapeConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Epolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/meanConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Gpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddevConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *��M=
�
Ppolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalFpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
seed�'*
seed2
�
Dpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulMulPpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalGpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
@policy/main_graph_0/hidden_1/kernel/Initializer/truncated_normalAddDpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulEpolicy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
#policy/main_graph_0/hidden_1/kernel
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
*policy/main_graph_0/hidden_1/kernel/AssignAssign#policy/main_graph_0/hidden_1/kernel@policy/main_graph_0/hidden_1/kernel/Initializer/truncated_normal*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
(policy/main_graph_0/hidden_1/kernel/readIdentity#policy/main_graph_0/hidden_1/kernel*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
3policy/main_graph_0/hidden_1/bias/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
!policy/main_graph_0/hidden_1/bias
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
(policy/main_graph_0/hidden_1/bias/AssignAssign!policy/main_graph_0/hidden_1/bias3policy/main_graph_0/hidden_1/bias/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
&policy/main_graph_0/hidden_1/bias/readIdentity!policy/main_graph_0/hidden_1/bias*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
#policy/main_graph_0/hidden_1/MatMulMatMul policy/main_graph_0/hidden_0/Mul(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
$policy/main_graph_0/hidden_1/BiasAddBiasAdd#policy/main_graph_0/hidden_1/MatMul&policy/main_graph_0/hidden_1/bias/read*
T0*
data_formatNHWC
^
$policy/main_graph_0/hidden_1/SigmoidSigmoid$policy/main_graph_0/hidden_1/BiasAdd*
T0
|
 policy/main_graph_0/hidden_1/MulMul$policy/main_graph_0/hidden_1/BiasAdd$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
3policy/mu/kernel/Initializer/truncated_normal/shapeConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB"      
�
2policy/mu/kernel/Initializer/truncated_normal/meanConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *    
�
4policy/mu/kernel/Initializer/truncated_normal/stddevConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *��;
�
=policy/mu/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal3policy/mu/kernel/Initializer/truncated_normal/shape*
T0*#
_class
loc:@policy/mu/kernel*
dtype0*
seed�'*
seed2
�
1policy/mu/kernel/Initializer/truncated_normal/mulMul=policy/mu/kernel/Initializer/truncated_normal/TruncatedNormal4policy/mu/kernel/Initializer/truncated_normal/stddev*
T0*#
_class
loc:@policy/mu/kernel
�
-policy/mu/kernel/Initializer/truncated_normalAdd1policy/mu/kernel/Initializer/truncated_normal/mul2policy/mu/kernel/Initializer/truncated_normal/mean*
T0*#
_class
loc:@policy/mu/kernel
�
policy/mu/kernel
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
policy/mu/kernel/AssignAssignpolicy/mu/kernel-policy/mu/kernel/Initializer/truncated_normal*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
a
policy/mu/kernel/readIdentitypolicy/mu/kernel*
T0*#
_class
loc:@policy/mu/kernel
t
 policy/mu/bias/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
policy/mu/bias
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
policy/mu/bias/AssignAssignpolicy/mu/bias policy/mu/bias/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
[
policy/mu/bias/readIdentitypolicy/mu/bias*
T0*!
_class
loc:@policy/mu/bias
�
policy_1/mu/MatMulMatMul policy/main_graph_0/hidden_1/Mulpolicy/mu/kernel/read*
T0*
transpose_a( *
transpose_b( 
g
policy_1/mu/BiasAddBiasAddpolicy_1/mu/MatMulpolicy/mu/bias/read*
T0*
data_formatNHWC
t
 policy/log_std/Initializer/zerosConst*!
_class
loc:@policy/log_std*
dtype0*
valueB*    
�
policy/log_std
VariableV2*!
_class
loc:@policy/log_std*
	container *
dtype0*
shape:*
shared_name 
�
policy/log_std/AssignAssignpolicy/log_std policy/log_std/Initializer/zeros*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
[
policy/log_std/readIdentitypolicy/log_std*
T0*!
_class
loc:@policy/log_std
M
 policy_1/clip_by_value/Minimum/yConst*
dtype0*
valueB
 *   @
i
policy_1/clip_by_value/MinimumMinimumpolicy/log_std/read policy_1/clip_by_value/Minimum/y*
T0
E
policy_1/clip_by_value/yConst*
dtype0*
valueB
 *  ��
d
policy_1/clip_by_valueMaximumpolicy_1/clip_by_value/Minimumpolicy_1/clip_by_value/y*
T0
4
policy_1/ExpExppolicy_1/clip_by_value*
T0
E
policy_1/ShapeShapepolicy_1/mu/BiasAdd*
T0*
out_type0
H
policy_1/random_normal/meanConst*
dtype0*
valueB
 *    
J
policy_1/random_normal/stddevConst*
dtype0*
valueB
 *  �?
�
+policy_1/random_normal/RandomStandardNormalRandomStandardNormalpolicy_1/Shape*
T0*
dtype0*
seed�'*
seed2
v
policy_1/random_normal/mulMul+policy_1/random_normal/RandomStandardNormalpolicy_1/random_normal/stddev*
T0
_
policy_1/random_normalAddpolicy_1/random_normal/mulpolicy_1/random_normal/mean*
T0
B
policy_1/mulMulpolicy_1/Exppolicy_1/random_normal*
T0
A
policy_1/addAddV2policy_1/mu/BiasAddpolicy_1/mul*
T0
<
policy_1/StopGradientStopGradientpolicy_1/add*
T0
H
policy_1/subSubpolicy_1/StopGradientpolicy_1/mu/BiasAdd*
T0
=
policy_1/add_1/yConst*
dtype0*
valueB
 *�7�5
@
policy_1/add_1AddV2policy_1/Exppolicy_1/add_1/y*
T0
B
policy_1/truedivRealDivpolicy_1/subpolicy_1/add_1*
T0
;
policy_1/pow/yConst*
dtype0*
valueB
 *   @
>
policy_1/powPowpolicy_1/truedivpolicy_1/pow/y*
T0
=
policy_1/mul_1/xConst*
dtype0*
valueB
 *   @
H
policy_1/mul_1Mulpolicy_1/mul_1/xpolicy_1/clip_by_value*
T0
>
policy_1/add_2AddV2policy_1/powpolicy_1/mul_1*
T0
=
policy_1/add_3/yConst*
dtype0*
valueB
 *�?�?
B
policy_1/add_3AddV2policy_1/add_2policy_1/add_3/y*
T0
=
policy_1/mul_2/xConst*
dtype0*
valueB
 *   �
@
policy_1/mul_2Mulpolicy_1/mul_2/xpolicy_1/add_3*
T0
H
policy_1/Sum/reduction_indicesConst*
dtype0*
value	B :
i
policy_1/SumSumpolicy_1/mul_2policy_1/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims(
;
policy_1/Log/xConst*
dtype0*
valueB
 *���A
,
policy_1/LogLogpolicy_1/Log/x*
T0
=
policy_1/mul_3/xConst*
dtype0*
valueB
 *   @
H
policy_1/mul_3Mulpolicy_1/mul_3/xpolicy_1/clip_by_value*
T0
>
policy_1/add_4AddV2policy_1/Logpolicy_1/mul_3*
T0
<
policy_1/ConstConst*
dtype0*
valueB: 
[
policy_1/MeanMeanpolicy_1/add_4policy_1/Const*
T0*

Tidx0*
	keep_dims( 
=
policy_1/mul_4/xConst*
dtype0*
valueB
 *   ?
?
policy_1/mul_4Mulpolicy_1/mul_4/xpolicy_1/Mean*
T0
Q
policy_1/strided_slice/stackConst*
dtype0*
valueB"        
S
policy_1/strided_slice/stack_1Const*
dtype0*
valueB"       
S
policy_1/strided_slice/stack_2Const*
dtype0*
valueB"      
�
policy_1/strided_sliceStridedSlicepolicy_1/mu/BiasAddpolicy_1/strided_slice/stackpolicy_1/strided_slice/stack_1policy_1/strided_slice/stack_2*
Index0*
T0*

begin_mask*
ellipsis_mask *
end_mask*
new_axis_mask *
shrink_axis_mask
M
policy_1/Reshape/shapeConst*
dtype0*
valueB:
���������
b
policy_1/ReshapeReshapepolicy_1/strided_slicepolicy_1/Reshape/shape*
T0*
Tshape0
L
policy_1/ones_like/ShapeShapepolicy_1/Reshape*
T0*
out_type0
E
policy_1/ones_like/ConstConst*
dtype0*
valueB
 *  �?
i
policy_1/ones_likeFillpolicy_1/ones_like/Shapepolicy_1/ones_like/Const*
T0*

index_type0
B
policy_1/mul_5Mulpolicy_1/ones_likepolicy_1/mul_4*
T0
D
clip_by_value/Minimum/yConst*
dtype0*
valueB
 *  @@
P
clip_by_value/MinimumMinimumpolicy_1/addclip_by_value/Minimum/y*
T0
<
clip_by_value/yConst*
dtype0*
valueB
 *  @�
I
clip_by_valueMaximumclip_by_value/Minimumclip_by_value/y*
T0
8
truediv_3/yConst*
dtype0*
valueB
 *  @@
9
	truediv_3RealDivclip_by_valuetruediv_3/y*
T0
&
actionIdentity	truediv_3*
T0
-
StopGradientStopGradientaction*
T0
1
action_probsIdentitypolicy_1/mul_2*
T0
A
save/filename/inputConst*
dtype0*
valueB Bmodel
V
save/filenamePlaceholderWithDefaultsave/filename/input*
dtype0*
shape: 
M

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
shape: 
�
save/SaveV2/tensor_namesConst*
dtype0*�
value�B�Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsBpolicy/log_stdB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBpolicy/mu/biasBpolicy/mu/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
k
save/SaveV2/shape_and_slicesConst*
dtype0*7
value.B,B B B B B B B B B B B B B B B B B B 
�
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesaction_output_shapeglobal_stepis_continuous_controlmemory_sizenormalization_stepspolicy/log_std!policy/main_graph_0/hidden_0/bias#policy/main_graph_0/hidden_0/kernel!policy/main_graph_0/hidden_1/bias#policy/main_graph_0/hidden_1/kernelpolicy/mu/biaspolicy/mu/kernelrunning_meanrunning_variancetrainer_major_versiontrainer_minor_versiontrainer_patch_versionversion_number* 
dtypes
2
e
save/control_dependencyIdentity
save/Const^save/SaveV2*
T0*
_class
loc:@save/Const
�
save/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*�
value�B�Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsBpolicy/log_stdB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBpolicy/mu/biasBpolicy/mu/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
}
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*7
value.B,B B B B B B B B B B B B B B B B B B 
�
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0* 
dtypes
2
�
save/AssignAssignaction_output_shapesave/RestoreV2*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
�
save/Assign_1Assignglobal_stepsave/RestoreV2:1*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
�
save/Assign_2Assignis_continuous_controlsave/RestoreV2:2*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
�
save/Assign_3Assignmemory_sizesave/RestoreV2:3*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
�
save/Assign_4Assignnormalization_stepssave/RestoreV2:4*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
�
save/Assign_5Assignpolicy/log_stdsave/RestoreV2:5*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save/Assign_6Assign!policy/main_graph_0/hidden_0/biassave/RestoreV2:6*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save/Assign_7Assign#policy/main_graph_0/hidden_0/kernelsave/RestoreV2:7*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save/Assign_8Assign!policy/main_graph_0/hidden_1/biassave/RestoreV2:8*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save/Assign_9Assign#policy/main_graph_0/hidden_1/kernelsave/RestoreV2:9*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save/Assign_10Assignpolicy/mu/biassave/RestoreV2:10*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save/Assign_11Assignpolicy/mu/kernelsave/RestoreV2:11*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save/Assign_12Assignrunning_meansave/RestoreV2:12*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
save/Assign_13Assignrunning_variancesave/RestoreV2:13*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
save/Assign_14Assigntrainer_major_versionsave/RestoreV2:14*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
�
save/Assign_15Assigntrainer_minor_versionsave/RestoreV2:15*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
�
save/Assign_16Assigntrainer_patch_versionsave/RestoreV2:16*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
�
save/Assign_17Assignversion_numbersave/RestoreV2:17*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
�
save/restore_allNoOp^save/Assign^save/Assign_1^save/Assign_10^save/Assign_11^save/Assign_12^save/Assign_13^save/Assign_14^save/Assign_15^save/Assign_16^save/Assign_17^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8^save/Assign_9
�
initNoOp^action_output_shape/Assign^global_step/Assign^is_continuous_control/Assign^memory_size/Assign^normalization_steps/Assign^policy/log_std/Assign)^policy/main_graph_0/hidden_0/bias/Assign+^policy/main_graph_0/hidden_0/kernel/Assign)^policy/main_graph_0/hidden_1/bias/Assign+^policy/main_graph_0/hidden_1/kernel/Assign^policy/mu/bias/Assign^policy/mu/kernel/Assign^running_mean/Assign^running_variance/Assign^trainer_major_version/Assign^trainer_minor_version/Assign^trainer_patch_version/Assign^version_number/Assign
e
+optimizer/curiosity_next_vector_observationPlaceholder*
dtype0*
shape:���������
�
Zoptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/shapeConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
valueB"      
�
Yoptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/meanConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
valueB
 *    
�
[optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/stddevConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
valueB
 *���>
�
doptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalZoptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
seed�'*
seed2
�
Xoptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/mulMuldoptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormal[optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel
�
Toptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normalAddXoptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/mulYoptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel
�
7optimizer//curiosity_vector_obs_encoder/hidden_0/kernel
VariableV2*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
>optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/AssignAssign7optimizer//curiosity_vector_obs_encoder/hidden_0/kernelToptimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Initializer/truncated_normal*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
<optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/readIdentity7optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel
�
Goptimizer//curiosity_vector_obs_encoder/hidden_0/bias/Initializer/zerosConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
dtype0*
valueB�*    
�
5optimizer//curiosity_vector_obs_encoder/hidden_0/bias
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
<optimizer//curiosity_vector_obs_encoder/hidden_0/bias/AssignAssign5optimizer//curiosity_vector_obs_encoder/hidden_0/biasGoptimizer//curiosity_vector_obs_encoder/hidden_0/bias/Initializer/zeros*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
:optimizer//curiosity_vector_obs_encoder/hidden_0/bias/readIdentity5optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias
�
6optimizer/curiosity_vector_obs_encoder/hidden_0/MatMulMatMulvector_observation<optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
7optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAddBiasAdd6optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul:optimizer//curiosity_vector_obs_encoder/hidden_0/bias/read*
T0*
data_formatNHWC
�
7optimizer/curiosity_vector_obs_encoder/hidden_0/SigmoidSigmoid7optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd*
T0
�
3optimizer/curiosity_vector_obs_encoder/hidden_0/MulMul7optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd7optimizer/curiosity_vector_obs_encoder/hidden_0/Sigmoid*
T0
�
Zoptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/shapeConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
valueB"      
�
Yoptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/meanConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
[optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/stddevConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
valueB
 *6��=
�
doptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalZoptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
seed�'*
seed2
�
Xoptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/mulMuldoptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormal[optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel
�
Toptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normalAddXoptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/mulYoptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel
�
7optimizer//curiosity_vector_obs_encoder/hidden_1/kernel
VariableV2*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
>optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/AssignAssign7optimizer//curiosity_vector_obs_encoder/hidden_1/kernelToptimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Initializer/truncated_normal*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
<optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/readIdentity7optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel
�
Goptimizer//curiosity_vector_obs_encoder/hidden_1/bias/Initializer/zerosConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
dtype0*
valueB�*    
�
5optimizer//curiosity_vector_obs_encoder/hidden_1/bias
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
<optimizer//curiosity_vector_obs_encoder/hidden_1/bias/AssignAssign5optimizer//curiosity_vector_obs_encoder/hidden_1/biasGoptimizer//curiosity_vector_obs_encoder/hidden_1/bias/Initializer/zeros*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
:optimizer//curiosity_vector_obs_encoder/hidden_1/bias/readIdentity5optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias
�
6optimizer/curiosity_vector_obs_encoder/hidden_1/MatMulMatMul3optimizer/curiosity_vector_obs_encoder/hidden_0/Mul<optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
7optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAddBiasAdd6optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul:optimizer//curiosity_vector_obs_encoder/hidden_1/bias/read*
T0*
data_formatNHWC
�
7optimizer/curiosity_vector_obs_encoder/hidden_1/SigmoidSigmoid7optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd*
T0
�
3optimizer/curiosity_vector_obs_encoder/hidden_1/MulMul7optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd7optimizer/curiosity_vector_obs_encoder/hidden_1/Sigmoid*
T0
�
8optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMulMatMul+optimizer/curiosity_next_vector_observation<optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
9optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAddBiasAdd8optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul:optimizer//curiosity_vector_obs_encoder/hidden_0/bias/read*
T0*
data_formatNHWC
�
9optimizer/curiosity_vector_obs_encoder_1/hidden_0/SigmoidSigmoid9optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd*
T0
�
5optimizer/curiosity_vector_obs_encoder_1/hidden_0/MulMul9optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd9optimizer/curiosity_vector_obs_encoder_1/hidden_0/Sigmoid*
T0
�
8optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMulMatMul5optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul<optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
9optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAddBiasAdd8optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul:optimizer//curiosity_vector_obs_encoder/hidden_1/bias/read*
T0*
data_formatNHWC
�
9optimizer/curiosity_vector_obs_encoder_1/hidden_1/SigmoidSigmoid9optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd*
T0
�
5optimizer/curiosity_vector_obs_encoder_1/hidden_1/MulMul9optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd9optimizer/curiosity_vector_obs_encoder_1/hidden_1/Sigmoid*
T0
E
optimizer/concat/concat_dimConst*
dtype0*
value	B :
a
optimizer/concat/concatIdentity3optimizer/curiosity_vector_obs_encoder/hidden_1/Mul*
T0
G
optimizer/concat_1/concat_dimConst*
dtype0*
value	B :
e
optimizer/concat_1/concatIdentity5optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul*
T0
A
optimizer/concat_2/axisConst*
dtype0*
value	B :
�
optimizer/concat_2ConcatV2optimizer/concat/concatoptimizer/concat_1/concatoptimizer/concat_2/axis*
N*
T0*

Tidx0
�
8optimizer//dense/kernel/Initializer/random_uniform/shapeConst**
_class 
loc:@optimizer//dense/kernel*
dtype0*
valueB"      
�
6optimizer//dense/kernel/Initializer/random_uniform/minConst**
_class 
loc:@optimizer//dense/kernel*
dtype0*
valueB
 *���
�
6optimizer//dense/kernel/Initializer/random_uniform/maxConst**
_class 
loc:@optimizer//dense/kernel*
dtype0*
valueB
 *��=
�
@optimizer//dense/kernel/Initializer/random_uniform/RandomUniformRandomUniform8optimizer//dense/kernel/Initializer/random_uniform/shape*
T0**
_class 
loc:@optimizer//dense/kernel*
dtype0*
seed�'*
seed2
�
6optimizer//dense/kernel/Initializer/random_uniform/subSub6optimizer//dense/kernel/Initializer/random_uniform/max6optimizer//dense/kernel/Initializer/random_uniform/min*
T0**
_class 
loc:@optimizer//dense/kernel
�
6optimizer//dense/kernel/Initializer/random_uniform/mulMul@optimizer//dense/kernel/Initializer/random_uniform/RandomUniform6optimizer//dense/kernel/Initializer/random_uniform/sub*
T0**
_class 
loc:@optimizer//dense/kernel
�
2optimizer//dense/kernel/Initializer/random_uniformAdd6optimizer//dense/kernel/Initializer/random_uniform/mul6optimizer//dense/kernel/Initializer/random_uniform/min*
T0**
_class 
loc:@optimizer//dense/kernel
�
optimizer//dense/kernel
VariableV2**
_class 
loc:@optimizer//dense/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
optimizer//dense/kernel/AssignAssignoptimizer//dense/kernel2optimizer//dense/kernel/Initializer/random_uniform*
T0**
_class 
loc:@optimizer//dense/kernel*
use_locking(*
validate_shape(
v
optimizer//dense/kernel/readIdentityoptimizer//dense/kernel*
T0**
_class 
loc:@optimizer//dense/kernel
�
'optimizer//dense/bias/Initializer/zerosConst*(
_class
loc:@optimizer//dense/bias*
dtype0*
valueB�*    
�
optimizer//dense/bias
VariableV2*(
_class
loc:@optimizer//dense/bias*
	container *
dtype0*
shape:�*
shared_name 
�
optimizer//dense/bias/AssignAssignoptimizer//dense/bias'optimizer//dense/bias/Initializer/zeros*
T0*(
_class
loc:@optimizer//dense/bias*
use_locking(*
validate_shape(
p
optimizer//dense/bias/readIdentityoptimizer//dense/bias*
T0*(
_class
loc:@optimizer//dense/bias
�
optimizer/dense/MatMulMatMuloptimizer/concat_2optimizer//dense/kernel/read*
T0*
transpose_a( *
transpose_b( 
v
optimizer/dense/BiasAddBiasAddoptimizer/dense/MatMuloptimizer//dense/bias/read*
T0*
data_formatNHWC
D
optimizer/dense/SigmoidSigmoidoptimizer/dense/BiasAdd*
T0
U
optimizer/dense/MulMuloptimizer/dense/BiasAddoptimizer/dense/Sigmoid*
T0
�
:optimizer//dense_1/kernel/Initializer/random_uniform/shapeConst*,
_class"
 loc:@optimizer//dense_1/kernel*
dtype0*
valueB"      
�
8optimizer//dense_1/kernel/Initializer/random_uniform/minConst*,
_class"
 loc:@optimizer//dense_1/kernel*
dtype0*
valueB
 *V��
�
8optimizer//dense_1/kernel/Initializer/random_uniform/maxConst*,
_class"
 loc:@optimizer//dense_1/kernel*
dtype0*
valueB
 *V�>
�
Boptimizer//dense_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform:optimizer//dense_1/kernel/Initializer/random_uniform/shape*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
dtype0*
seed�'*
seed2
�
8optimizer//dense_1/kernel/Initializer/random_uniform/subSub8optimizer//dense_1/kernel/Initializer/random_uniform/max8optimizer//dense_1/kernel/Initializer/random_uniform/min*
T0*,
_class"
 loc:@optimizer//dense_1/kernel
�
8optimizer//dense_1/kernel/Initializer/random_uniform/mulMulBoptimizer//dense_1/kernel/Initializer/random_uniform/RandomUniform8optimizer//dense_1/kernel/Initializer/random_uniform/sub*
T0*,
_class"
 loc:@optimizer//dense_1/kernel
�
4optimizer//dense_1/kernel/Initializer/random_uniformAdd8optimizer//dense_1/kernel/Initializer/random_uniform/mul8optimizer//dense_1/kernel/Initializer/random_uniform/min*
T0*,
_class"
 loc:@optimizer//dense_1/kernel
�
optimizer//dense_1/kernel
VariableV2*,
_class"
 loc:@optimizer//dense_1/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
 optimizer//dense_1/kernel/AssignAssignoptimizer//dense_1/kernel4optimizer//dense_1/kernel/Initializer/random_uniform*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
use_locking(*
validate_shape(
|
optimizer//dense_1/kernel/readIdentityoptimizer//dense_1/kernel*
T0*,
_class"
 loc:@optimizer//dense_1/kernel
�
)optimizer//dense_1/bias/Initializer/zerosConst**
_class 
loc:@optimizer//dense_1/bias*
dtype0*
valueB*    
�
optimizer//dense_1/bias
VariableV2**
_class 
loc:@optimizer//dense_1/bias*
	container *
dtype0*
shape:*
shared_name 
�
optimizer//dense_1/bias/AssignAssignoptimizer//dense_1/bias)optimizer//dense_1/bias/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_1/bias*
use_locking(*
validate_shape(
v
optimizer//dense_1/bias/readIdentityoptimizer//dense_1/bias*
T0**
_class 
loc:@optimizer//dense_1/bias
�
optimizer/dense_1/MatMulMatMuloptimizer/dense/Muloptimizer//dense_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
|
optimizer/dense_1/BiasAddBiasAddoptimizer/dense_1/MatMuloptimizer//dense_1/bias/read*
T0*
data_formatNHWC
b
optimizer/SquaredDifferenceSquaredDifferenceoptimizer/dense_1/BiasAddStopGradient*
T0
I
optimizer/Sum/reduction_indicesConst*
dtype0*
value	B :
x
optimizer/SumSumoptimizer/SquaredDifferenceoptimizer/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
d
optimizer/DynamicPartitionDynamicPartitionoptimizer/SumCast_3*
T0*
num_partitions
=
optimizer/ConstConst*
dtype0*
valueB: 
k
optimizer/MeanMeanoptimizer/DynamicPartition:1optimizer/Const*
T0*

Tidx0*
	keep_dims( 
A
optimizer/concat_3/axisConst*
dtype0*
value	B :
|
optimizer/concat_3ConcatV2optimizer/concat/concatStopGradientoptimizer/concat_3/axis*
N*
T0*

Tidx0
�
:optimizer//dense_2/kernel/Initializer/random_uniform/shapeConst*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
valueB"     
�
8optimizer//dense_2/kernel/Initializer/random_uniform/minConst*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
valueB
 *Kݽ
�
8optimizer//dense_2/kernel/Initializer/random_uniform/maxConst*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
valueB
 *K�=
�
Boptimizer//dense_2/kernel/Initializer/random_uniform/RandomUniformRandomUniform:optimizer//dense_2/kernel/Initializer/random_uniform/shape*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
seed�'*
seed2
�
8optimizer//dense_2/kernel/Initializer/random_uniform/subSub8optimizer//dense_2/kernel/Initializer/random_uniform/max8optimizer//dense_2/kernel/Initializer/random_uniform/min*
T0*,
_class"
 loc:@optimizer//dense_2/kernel
�
8optimizer//dense_2/kernel/Initializer/random_uniform/mulMulBoptimizer//dense_2/kernel/Initializer/random_uniform/RandomUniform8optimizer//dense_2/kernel/Initializer/random_uniform/sub*
T0*,
_class"
 loc:@optimizer//dense_2/kernel
�
4optimizer//dense_2/kernel/Initializer/random_uniformAdd8optimizer//dense_2/kernel/Initializer/random_uniform/mul8optimizer//dense_2/kernel/Initializer/random_uniform/min*
T0*,
_class"
 loc:@optimizer//dense_2/kernel
�
optimizer//dense_2/kernel
VariableV2*,
_class"
 loc:@optimizer//dense_2/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
 optimizer//dense_2/kernel/AssignAssignoptimizer//dense_2/kernel4optimizer//dense_2/kernel/Initializer/random_uniform*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
use_locking(*
validate_shape(
|
optimizer//dense_2/kernel/readIdentityoptimizer//dense_2/kernel*
T0*,
_class"
 loc:@optimizer//dense_2/kernel
�
)optimizer//dense_2/bias/Initializer/zerosConst**
_class 
loc:@optimizer//dense_2/bias*
dtype0*
valueB�*    
�
optimizer//dense_2/bias
VariableV2**
_class 
loc:@optimizer//dense_2/bias*
	container *
dtype0*
shape:�*
shared_name 
�
optimizer//dense_2/bias/AssignAssignoptimizer//dense_2/bias)optimizer//dense_2/bias/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_2/bias*
use_locking(*
validate_shape(
v
optimizer//dense_2/bias/readIdentityoptimizer//dense_2/bias*
T0**
_class 
loc:@optimizer//dense_2/bias
�
optimizer/dense_2/MatMulMatMuloptimizer/concat_3optimizer//dense_2/kernel/read*
T0*
transpose_a( *
transpose_b( 
|
optimizer/dense_2/BiasAddBiasAddoptimizer/dense_2/MatMuloptimizer//dense_2/bias/read*
T0*
data_formatNHWC
H
optimizer/dense_2/SigmoidSigmoidoptimizer/dense_2/BiasAdd*
T0
[
optimizer/dense_2/MulMuloptimizer/dense_2/BiasAddoptimizer/dense_2/Sigmoid*
T0
�
:optimizer//dense_3/kernel/Initializer/random_uniform/shapeConst*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
valueB"      
�
8optimizer//dense_3/kernel/Initializer/random_uniform/minConst*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
valueB
 *׳ݽ
�
8optimizer//dense_3/kernel/Initializer/random_uniform/maxConst*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
valueB
 *׳�=
�
Boptimizer//dense_3/kernel/Initializer/random_uniform/RandomUniformRandomUniform:optimizer//dense_3/kernel/Initializer/random_uniform/shape*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
seed�'*
seed2	
�
8optimizer//dense_3/kernel/Initializer/random_uniform/subSub8optimizer//dense_3/kernel/Initializer/random_uniform/max8optimizer//dense_3/kernel/Initializer/random_uniform/min*
T0*,
_class"
 loc:@optimizer//dense_3/kernel
�
8optimizer//dense_3/kernel/Initializer/random_uniform/mulMulBoptimizer//dense_3/kernel/Initializer/random_uniform/RandomUniform8optimizer//dense_3/kernel/Initializer/random_uniform/sub*
T0*,
_class"
 loc:@optimizer//dense_3/kernel
�
4optimizer//dense_3/kernel/Initializer/random_uniformAdd8optimizer//dense_3/kernel/Initializer/random_uniform/mul8optimizer//dense_3/kernel/Initializer/random_uniform/min*
T0*,
_class"
 loc:@optimizer//dense_3/kernel
�
optimizer//dense_3/kernel
VariableV2*,
_class"
 loc:@optimizer//dense_3/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
 optimizer//dense_3/kernel/AssignAssignoptimizer//dense_3/kernel4optimizer//dense_3/kernel/Initializer/random_uniform*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
use_locking(*
validate_shape(
|
optimizer//dense_3/kernel/readIdentityoptimizer//dense_3/kernel*
T0*,
_class"
 loc:@optimizer//dense_3/kernel
�
)optimizer//dense_3/bias/Initializer/zerosConst**
_class 
loc:@optimizer//dense_3/bias*
dtype0*
valueB�*    
�
optimizer//dense_3/bias
VariableV2**
_class 
loc:@optimizer//dense_3/bias*
	container *
dtype0*
shape:�*
shared_name 
�
optimizer//dense_3/bias/AssignAssignoptimizer//dense_3/bias)optimizer//dense_3/bias/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_3/bias*
use_locking(*
validate_shape(
v
optimizer//dense_3/bias/readIdentityoptimizer//dense_3/bias*
T0**
_class 
loc:@optimizer//dense_3/bias
�
optimizer/dense_3/MatMulMatMuloptimizer/dense_2/Muloptimizer//dense_3/kernel/read*
T0*
transpose_a( *
transpose_b( 
|
optimizer/dense_3/BiasAddBiasAddoptimizer/dense_3/MatMuloptimizer//dense_3/bias/read*
T0*
data_formatNHWC
q
optimizer/SquaredDifference_1SquaredDifferenceoptimizer/dense_3/BiasAddoptimizer/concat_1/concat*
T0
K
!optimizer/Sum_1/reduction_indicesConst*
dtype0*
value	B :
~
optimizer/Sum_1Sumoptimizer/SquaredDifference_1!optimizer/Sum_1/reduction_indices*
T0*

Tidx0*
	keep_dims( 
<
optimizer/mul/xConst*
dtype0*
valueB
 *   ?
?
optimizer/mulMuloptimizer/mul/xoptimizer/Sum_1*
T0
f
optimizer/DynamicPartition_1DynamicPartitionoptimizer/mulCast_3*
T0*
num_partitions
?
optimizer/Const_1Const*
dtype0*
valueB: 
q
optimizer/Mean_1Meanoptimizer/DynamicPartition_1:1optimizer/Const_1*
T0*

Tidx0*
	keep_dims( 
>
optimizer/mul_1/xConst*
dtype0*
valueB
 *��L>
D
optimizer/mul_1Muloptimizer/mul_1/xoptimizer/Mean_1*
T0
>
optimizer/mul_2/xConst*
dtype0*
valueB
 *��L?
B
optimizer/mul_2Muloptimizer/mul_2/xoptimizer/Mean*
T0
A
optimizer/addAddV2optimizer/mul_1optimizer/mul_2*
T0
>
optimizer/mul_3/xConst*
dtype0*
valueB
 *   A
A
optimizer/mul_3Muloptimizer/mul_3/xoptimizer/add*
T0
B
optimizer/gradients/ShapeConst*
dtype0*
valueB 
J
optimizer/gradients/grad_ys_0Const*
dtype0*
valueB
 *  �?
u
optimizer/gradients/FillFilloptimizer/gradients/Shapeoptimizer/gradients/grad_ys_0*
T0*

index_type0
e
,optimizer/gradients/optimizer/mul_3_grad/MulMuloptimizer/gradients/Filloptimizer/add*
T0
k
.optimizer/gradients/optimizer/mul_3_grad/Mul_1Muloptimizer/gradients/Filloptimizer/mul_3/x*
T0
�
9optimizer/gradients/optimizer/mul_3_grad/tuple/group_depsNoOp-^optimizer/gradients/optimizer/mul_3_grad/Mul/^optimizer/gradients/optimizer/mul_3_grad/Mul_1
�
Aoptimizer/gradients/optimizer/mul_3_grad/tuple/control_dependencyIdentity,optimizer/gradients/optimizer/mul_3_grad/Mul:^optimizer/gradients/optimizer/mul_3_grad/tuple/group_deps*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/mul_3_grad/Mul
�
Coptimizer/gradients/optimizer/mul_3_grad/tuple/control_dependency_1Identity.optimizer/gradients/optimizer/mul_3_grad/Mul_1:^optimizer/gradients/optimizer/mul_3_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_3_grad/Mul_1
�
7optimizer/gradients/optimizer/add_grad/tuple/group_depsNoOpD^optimizer/gradients/optimizer/mul_3_grad/tuple/control_dependency_1
�
?optimizer/gradients/optimizer/add_grad/tuple/control_dependencyIdentityCoptimizer/gradients/optimizer/mul_3_grad/tuple/control_dependency_18^optimizer/gradients/optimizer/add_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_3_grad/Mul_1
�
Aoptimizer/gradients/optimizer/add_grad/tuple/control_dependency_1IdentityCoptimizer/gradients/optimizer/mul_3_grad/tuple/control_dependency_18^optimizer/gradients/optimizer/add_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_3_grad/Mul_1
�
,optimizer/gradients/optimizer/mul_1_grad/MulMul?optimizer/gradients/optimizer/add_grad/tuple/control_dependencyoptimizer/Mean_1*
T0
�
.optimizer/gradients/optimizer/mul_1_grad/Mul_1Mul?optimizer/gradients/optimizer/add_grad/tuple/control_dependencyoptimizer/mul_1/x*
T0
�
9optimizer/gradients/optimizer/mul_1_grad/tuple/group_depsNoOp-^optimizer/gradients/optimizer/mul_1_grad/Mul/^optimizer/gradients/optimizer/mul_1_grad/Mul_1
�
Aoptimizer/gradients/optimizer/mul_1_grad/tuple/control_dependencyIdentity,optimizer/gradients/optimizer/mul_1_grad/Mul:^optimizer/gradients/optimizer/mul_1_grad/tuple/group_deps*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/mul_1_grad/Mul
�
Coptimizer/gradients/optimizer/mul_1_grad/tuple/control_dependency_1Identity.optimizer/gradients/optimizer/mul_1_grad/Mul_1:^optimizer/gradients/optimizer/mul_1_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_1_grad/Mul_1
�
,optimizer/gradients/optimizer/mul_2_grad/MulMulAoptimizer/gradients/optimizer/add_grad/tuple/control_dependency_1optimizer/Mean*
T0
�
.optimizer/gradients/optimizer/mul_2_grad/Mul_1MulAoptimizer/gradients/optimizer/add_grad/tuple/control_dependency_1optimizer/mul_2/x*
T0
�
9optimizer/gradients/optimizer/mul_2_grad/tuple/group_depsNoOp-^optimizer/gradients/optimizer/mul_2_grad/Mul/^optimizer/gradients/optimizer/mul_2_grad/Mul_1
�
Aoptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependencyIdentity,optimizer/gradients/optimizer/mul_2_grad/Mul:^optimizer/gradients/optimizer/mul_2_grad/tuple/group_deps*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/mul_2_grad/Mul
�
Coptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependency_1Identity.optimizer/gradients/optimizer/mul_2_grad/Mul_1:^optimizer/gradients/optimizer/mul_2_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_2_grad/Mul_1
e
7optimizer/gradients/optimizer/Mean_1_grad/Reshape/shapeConst*
dtype0*
valueB:
�
1optimizer/gradients/optimizer/Mean_1_grad/ReshapeReshapeCoptimizer/gradients/optimizer/mul_1_grad/tuple/control_dependency_17optimizer/gradients/optimizer/Mean_1_grad/Reshape/shape*
T0*
Tshape0
q
/optimizer/gradients/optimizer/Mean_1_grad/ShapeShapeoptimizer/DynamicPartition_1:1*
T0*
out_type0
�
.optimizer/gradients/optimizer/Mean_1_grad/TileTile1optimizer/gradients/optimizer/Mean_1_grad/Reshape/optimizer/gradients/optimizer/Mean_1_grad/Shape*
T0*

Tmultiples0
s
1optimizer/gradients/optimizer/Mean_1_grad/Shape_1Shapeoptimizer/DynamicPartition_1:1*
T0*
out_type0
Z
1optimizer/gradients/optimizer/Mean_1_grad/Shape_2Const*
dtype0*
valueB 
]
/optimizer/gradients/optimizer/Mean_1_grad/ConstConst*
dtype0*
valueB: 
�
.optimizer/gradients/optimizer/Mean_1_grad/ProdProd1optimizer/gradients/optimizer/Mean_1_grad/Shape_1/optimizer/gradients/optimizer/Mean_1_grad/Const*
T0*

Tidx0*
	keep_dims( 
_
1optimizer/gradients/optimizer/Mean_1_grad/Const_1Const*
dtype0*
valueB: 
�
0optimizer/gradients/optimizer/Mean_1_grad/Prod_1Prod1optimizer/gradients/optimizer/Mean_1_grad/Shape_21optimizer/gradients/optimizer/Mean_1_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
]
3optimizer/gradients/optimizer/Mean_1_grad/Maximum/yConst*
dtype0*
value	B :
�
1optimizer/gradients/optimizer/Mean_1_grad/MaximumMaximum0optimizer/gradients/optimizer/Mean_1_grad/Prod_13optimizer/gradients/optimizer/Mean_1_grad/Maximum/y*
T0
�
2optimizer/gradients/optimizer/Mean_1_grad/floordivFloorDiv.optimizer/gradients/optimizer/Mean_1_grad/Prod1optimizer/gradients/optimizer/Mean_1_grad/Maximum*
T0
�
.optimizer/gradients/optimizer/Mean_1_grad/CastCast2optimizer/gradients/optimizer/Mean_1_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
1optimizer/gradients/optimizer/Mean_1_grad/truedivRealDiv.optimizer/gradients/optimizer/Mean_1_grad/Tile.optimizer/gradients/optimizer/Mean_1_grad/Cast*
T0
c
5optimizer/gradients/optimizer/Mean_grad/Reshape/shapeConst*
dtype0*
valueB:
�
/optimizer/gradients/optimizer/Mean_grad/ReshapeReshapeCoptimizer/gradients/optimizer/mul_2_grad/tuple/control_dependency_15optimizer/gradients/optimizer/Mean_grad/Reshape/shape*
T0*
Tshape0
m
-optimizer/gradients/optimizer/Mean_grad/ShapeShapeoptimizer/DynamicPartition:1*
T0*
out_type0
�
,optimizer/gradients/optimizer/Mean_grad/TileTile/optimizer/gradients/optimizer/Mean_grad/Reshape-optimizer/gradients/optimizer/Mean_grad/Shape*
T0*

Tmultiples0
o
/optimizer/gradients/optimizer/Mean_grad/Shape_1Shapeoptimizer/DynamicPartition:1*
T0*
out_type0
X
/optimizer/gradients/optimizer/Mean_grad/Shape_2Const*
dtype0*
valueB 
[
-optimizer/gradients/optimizer/Mean_grad/ConstConst*
dtype0*
valueB: 
�
,optimizer/gradients/optimizer/Mean_grad/ProdProd/optimizer/gradients/optimizer/Mean_grad/Shape_1-optimizer/gradients/optimizer/Mean_grad/Const*
T0*

Tidx0*
	keep_dims( 
]
/optimizer/gradients/optimizer/Mean_grad/Const_1Const*
dtype0*
valueB: 
�
.optimizer/gradients/optimizer/Mean_grad/Prod_1Prod/optimizer/gradients/optimizer/Mean_grad/Shape_2/optimizer/gradients/optimizer/Mean_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
[
1optimizer/gradients/optimizer/Mean_grad/Maximum/yConst*
dtype0*
value	B :
�
/optimizer/gradients/optimizer/Mean_grad/MaximumMaximum.optimizer/gradients/optimizer/Mean_grad/Prod_11optimizer/gradients/optimizer/Mean_grad/Maximum/y*
T0
�
0optimizer/gradients/optimizer/Mean_grad/floordivFloorDiv,optimizer/gradients/optimizer/Mean_grad/Prod/optimizer/gradients/optimizer/Mean_grad/Maximum*
T0
�
,optimizer/gradients/optimizer/Mean_grad/CastCast0optimizer/gradients/optimizer/Mean_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
/optimizer/gradients/optimizer/Mean_grad/truedivRealDiv,optimizer/gradients/optimizer/Mean_grad/Tile,optimizer/gradients/optimizer/Mean_grad/Cast*
T0
R
optimizer/gradients/zeros_like	ZerosLikeoptimizer/DynamicPartition_1*
T0
e
;optimizer/gradients/optimizer/DynamicPartition_1_grad/ShapeShapeCast_3*
T0*
out_type0
i
;optimizer/gradients/optimizer/DynamicPartition_1_grad/ConstConst*
dtype0*
valueB: 
�
:optimizer/gradients/optimizer/DynamicPartition_1_grad/ProdProd;optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape;optimizer/gradients/optimizer/DynamicPartition_1_grad/Const*
T0*

Tidx0*
	keep_dims( 
k
Aoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/startConst*
dtype0*
value	B : 
k
Aoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/deltaConst*
dtype0*
value	B :
�
;optimizer/gradients/optimizer/DynamicPartition_1_grad/rangeRangeAoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/start:optimizer/gradients/optimizer/DynamicPartition_1_grad/ProdAoptimizer/gradients/optimizer/DynamicPartition_1_grad/range/delta*

Tidx0
�
=optimizer/gradients/optimizer/DynamicPartition_1_grad/ReshapeReshape;optimizer/gradients/optimizer/DynamicPartition_1_grad/range;optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape*
T0*
Tshape0
�
Foptimizer/gradients/optimizer/DynamicPartition_1_grad/DynamicPartitionDynamicPartition=optimizer/gradients/optimizer/DynamicPartition_1_grad/ReshapeCast_3*
T0*
num_partitions
�
Koptimizer/gradients/optimizer/DynamicPartition_1_grad/ParallelDynamicStitchParallelDynamicStitchFoptimizer/gradients/optimizer/DynamicPartition_1_grad/DynamicPartitionHoptimizer/gradients/optimizer/DynamicPartition_1_grad/DynamicPartition:1optimizer/gradients/zeros_like1optimizer/gradients/optimizer/Mean_1_grad/truediv*
N*
T0
n
=optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape_1Shapeoptimizer/mul*
T0*
out_type0
�
?optimizer/gradients/optimizer/DynamicPartition_1_grad/Reshape_1ReshapeKoptimizer/gradients/optimizer/DynamicPartition_1_grad/ParallelDynamicStitch=optimizer/gradients/optimizer/DynamicPartition_1_grad/Shape_1*
T0*
Tshape0
R
 optimizer/gradients/zeros_like_1	ZerosLikeoptimizer/DynamicPartition*
T0
c
9optimizer/gradients/optimizer/DynamicPartition_grad/ShapeShapeCast_3*
T0*
out_type0
g
9optimizer/gradients/optimizer/DynamicPartition_grad/ConstConst*
dtype0*
valueB: 
�
8optimizer/gradients/optimizer/DynamicPartition_grad/ProdProd9optimizer/gradients/optimizer/DynamicPartition_grad/Shape9optimizer/gradients/optimizer/DynamicPartition_grad/Const*
T0*

Tidx0*
	keep_dims( 
i
?optimizer/gradients/optimizer/DynamicPartition_grad/range/startConst*
dtype0*
value	B : 
i
?optimizer/gradients/optimizer/DynamicPartition_grad/range/deltaConst*
dtype0*
value	B :
�
9optimizer/gradients/optimizer/DynamicPartition_grad/rangeRange?optimizer/gradients/optimizer/DynamicPartition_grad/range/start8optimizer/gradients/optimizer/DynamicPartition_grad/Prod?optimizer/gradients/optimizer/DynamicPartition_grad/range/delta*

Tidx0
�
;optimizer/gradients/optimizer/DynamicPartition_grad/ReshapeReshape9optimizer/gradients/optimizer/DynamicPartition_grad/range9optimizer/gradients/optimizer/DynamicPartition_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients/optimizer/DynamicPartition_grad/DynamicPartitionDynamicPartition;optimizer/gradients/optimizer/DynamicPartition_grad/ReshapeCast_3*
T0*
num_partitions
�
Ioptimizer/gradients/optimizer/DynamicPartition_grad/ParallelDynamicStitchParallelDynamicStitchDoptimizer/gradients/optimizer/DynamicPartition_grad/DynamicPartitionFoptimizer/gradients/optimizer/DynamicPartition_grad/DynamicPartition:1 optimizer/gradients/zeros_like_1/optimizer/gradients/optimizer/Mean_grad/truediv*
N*
T0
l
;optimizer/gradients/optimizer/DynamicPartition_grad/Shape_1Shapeoptimizer/Sum*
T0*
out_type0
�
=optimizer/gradients/optimizer/DynamicPartition_grad/Reshape_1ReshapeIoptimizer/gradients/optimizer/DynamicPartition_grad/ParallelDynamicStitch;optimizer/gradients/optimizer/DynamicPartition_grad/Shape_1*
T0*
Tshape0
_
,optimizer/gradients/optimizer/mul_grad/ShapeShapeoptimizer/mul/x*
T0*
out_type0
a
.optimizer/gradients/optimizer/mul_grad/Shape_1Shapeoptimizer/Sum_1*
T0*
out_type0
�
<optimizer/gradients/optimizer/mul_grad/BroadcastGradientArgsBroadcastGradientArgs,optimizer/gradients/optimizer/mul_grad/Shape.optimizer/gradients/optimizer/mul_grad/Shape_1*
T0
�
*optimizer/gradients/optimizer/mul_grad/MulMul?optimizer/gradients/optimizer/DynamicPartition_1_grad/Reshape_1optimizer/Sum_1*
T0
�
*optimizer/gradients/optimizer/mul_grad/SumSum*optimizer/gradients/optimizer/mul_grad/Mul<optimizer/gradients/optimizer/mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
.optimizer/gradients/optimizer/mul_grad/ReshapeReshape*optimizer/gradients/optimizer/mul_grad/Sum,optimizer/gradients/optimizer/mul_grad/Shape*
T0*
Tshape0
�
,optimizer/gradients/optimizer/mul_grad/Mul_1Muloptimizer/mul/x?optimizer/gradients/optimizer/DynamicPartition_1_grad/Reshape_1*
T0
�
,optimizer/gradients/optimizer/mul_grad/Sum_1Sum,optimizer/gradients/optimizer/mul_grad/Mul_1>optimizer/gradients/optimizer/mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients/optimizer/mul_grad/Reshape_1Reshape,optimizer/gradients/optimizer/mul_grad/Sum_1.optimizer/gradients/optimizer/mul_grad/Shape_1*
T0*
Tshape0
�
7optimizer/gradients/optimizer/mul_grad/tuple/group_depsNoOp/^optimizer/gradients/optimizer/mul_grad/Reshape1^optimizer/gradients/optimizer/mul_grad/Reshape_1
�
?optimizer/gradients/optimizer/mul_grad/tuple/control_dependencyIdentity.optimizer/gradients/optimizer/mul_grad/Reshape8^optimizer/gradients/optimizer/mul_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/mul_grad/Reshape
�
Aoptimizer/gradients/optimizer/mul_grad/tuple/control_dependency_1Identity0optimizer/gradients/optimizer/mul_grad/Reshape_18^optimizer/gradients/optimizer/mul_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients/optimizer/mul_grad/Reshape_1
k
,optimizer/gradients/optimizer/Sum_grad/ShapeShapeoptimizer/SquaredDifference*
T0*
out_type0
�
+optimizer/gradients/optimizer/Sum_grad/SizeConst*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape*
dtype0*
value	B :
�
*optimizer/gradients/optimizer/Sum_grad/addAddV2optimizer/Sum/reduction_indices+optimizer/gradients/optimizer/Sum_grad/Size*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape
�
*optimizer/gradients/optimizer/Sum_grad/modFloorMod*optimizer/gradients/optimizer/Sum_grad/add+optimizer/gradients/optimizer/Sum_grad/Size*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape
�
.optimizer/gradients/optimizer/Sum_grad/Shape_1Const*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape*
dtype0*
valueB 
�
2optimizer/gradients/optimizer/Sum_grad/range/startConst*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape*
dtype0*
value	B : 
�
2optimizer/gradients/optimizer/Sum_grad/range/deltaConst*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape*
dtype0*
value	B :
�
,optimizer/gradients/optimizer/Sum_grad/rangeRange2optimizer/gradients/optimizer/Sum_grad/range/start+optimizer/gradients/optimizer/Sum_grad/Size2optimizer/gradients/optimizer/Sum_grad/range/delta*

Tidx0*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape
�
1optimizer/gradients/optimizer/Sum_grad/Fill/valueConst*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape*
dtype0*
value	B :
�
+optimizer/gradients/optimizer/Sum_grad/FillFill.optimizer/gradients/optimizer/Sum_grad/Shape_11optimizer/gradients/optimizer/Sum_grad/Fill/value*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape*

index_type0
�
4optimizer/gradients/optimizer/Sum_grad/DynamicStitchDynamicStitch,optimizer/gradients/optimizer/Sum_grad/range*optimizer/gradients/optimizer/Sum_grad/mod,optimizer/gradients/optimizer/Sum_grad/Shape+optimizer/gradients/optimizer/Sum_grad/Fill*
N*
T0*?
_class5
31loc:@optimizer/gradients/optimizer/Sum_grad/Shape
�
.optimizer/gradients/optimizer/Sum_grad/ReshapeReshape=optimizer/gradients/optimizer/DynamicPartition_grad/Reshape_14optimizer/gradients/optimizer/Sum_grad/DynamicStitch*
T0*
Tshape0
�
2optimizer/gradients/optimizer/Sum_grad/BroadcastToBroadcastTo.optimizer/gradients/optimizer/Sum_grad/Reshape,optimizer/gradients/optimizer/Sum_grad/Shape*
T0*

Tidx0
o
.optimizer/gradients/optimizer/Sum_1_grad/ShapeShapeoptimizer/SquaredDifference_1*
T0*
out_type0
�
-optimizer/gradients/optimizer/Sum_1_grad/SizeConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape*
dtype0*
value	B :
�
,optimizer/gradients/optimizer/Sum_1_grad/addAddV2!optimizer/Sum_1/reduction_indices-optimizer/gradients/optimizer/Sum_1_grad/Size*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape
�
,optimizer/gradients/optimizer/Sum_1_grad/modFloorMod,optimizer/gradients/optimizer/Sum_1_grad/add-optimizer/gradients/optimizer/Sum_1_grad/Size*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape
�
0optimizer/gradients/optimizer/Sum_1_grad/Shape_1Const*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape*
dtype0*
valueB 
�
4optimizer/gradients/optimizer/Sum_1_grad/range/startConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape*
dtype0*
value	B : 
�
4optimizer/gradients/optimizer/Sum_1_grad/range/deltaConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients/optimizer/Sum_1_grad/rangeRange4optimizer/gradients/optimizer/Sum_1_grad/range/start-optimizer/gradients/optimizer/Sum_1_grad/Size4optimizer/gradients/optimizer/Sum_1_grad/range/delta*

Tidx0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape
�
3optimizer/gradients/optimizer/Sum_1_grad/Fill/valueConst*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape*
dtype0*
value	B :
�
-optimizer/gradients/optimizer/Sum_1_grad/FillFill0optimizer/gradients/optimizer/Sum_1_grad/Shape_13optimizer/gradients/optimizer/Sum_1_grad/Fill/value*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape*

index_type0
�
6optimizer/gradients/optimizer/Sum_1_grad/DynamicStitchDynamicStitch.optimizer/gradients/optimizer/Sum_1_grad/range,optimizer/gradients/optimizer/Sum_1_grad/mod.optimizer/gradients/optimizer/Sum_1_grad/Shape-optimizer/gradients/optimizer/Sum_1_grad/Fill*
N*
T0*A
_class7
53loc:@optimizer/gradients/optimizer/Sum_1_grad/Shape
�
0optimizer/gradients/optimizer/Sum_1_grad/ReshapeReshapeAoptimizer/gradients/optimizer/mul_grad/tuple/control_dependency_16optimizer/gradients/optimizer/Sum_1_grad/DynamicStitch*
T0*
Tshape0
�
4optimizer/gradients/optimizer/Sum_1_grad/BroadcastToBroadcastTo0optimizer/gradients/optimizer/Sum_1_grad/Reshape.optimizer/gradients/optimizer/Sum_1_grad/Shape*
T0*

Tidx0
�
;optimizer/gradients/optimizer/SquaredDifference_grad/scalarConst3^optimizer/gradients/optimizer/Sum_grad/BroadcastTo*
dtype0*
valueB
 *   @
�
8optimizer/gradients/optimizer/SquaredDifference_grad/MulMul;optimizer/gradients/optimizer/SquaredDifference_grad/scalar2optimizer/gradients/optimizer/Sum_grad/BroadcastTo*
T0
�
8optimizer/gradients/optimizer/SquaredDifference_grad/subSuboptimizer/dense_1/BiasAddStopGradient3^optimizer/gradients/optimizer/Sum_grad/BroadcastTo*
T0
�
:optimizer/gradients/optimizer/SquaredDifference_grad/mul_1Mul8optimizer/gradients/optimizer/SquaredDifference_grad/Mul8optimizer/gradients/optimizer/SquaredDifference_grad/sub*
T0
w
:optimizer/gradients/optimizer/SquaredDifference_grad/ShapeShapeoptimizer/dense_1/BiasAdd*
T0*
out_type0
l
<optimizer/gradients/optimizer/SquaredDifference_grad/Shape_1ShapeStopGradient*
T0*
out_type0
�
Joptimizer/gradients/optimizer/SquaredDifference_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients/optimizer/SquaredDifference_grad/Shape<optimizer/gradients/optimizer/SquaredDifference_grad/Shape_1*
T0
�
8optimizer/gradients/optimizer/SquaredDifference_grad/SumSum:optimizer/gradients/optimizer/SquaredDifference_grad/mul_1Joptimizer/gradients/optimizer/SquaredDifference_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients/optimizer/SquaredDifference_grad/ReshapeReshape8optimizer/gradients/optimizer/SquaredDifference_grad/Sum:optimizer/gradients/optimizer/SquaredDifference_grad/Shape*
T0*
Tshape0
�
:optimizer/gradients/optimizer/SquaredDifference_grad/Sum_1Sum:optimizer/gradients/optimizer/SquaredDifference_grad/mul_1Loptimizer/gradients/optimizer/SquaredDifference_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients/optimizer/SquaredDifference_grad/Reshape_1Reshape:optimizer/gradients/optimizer/SquaredDifference_grad/Sum_1<optimizer/gradients/optimizer/SquaredDifference_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients/optimizer/SquaredDifference_grad/NegNeg>optimizer/gradients/optimizer/SquaredDifference_grad/Reshape_1*
T0
�
Eoptimizer/gradients/optimizer/SquaredDifference_grad/tuple/group_depsNoOp9^optimizer/gradients/optimizer/SquaredDifference_grad/Neg=^optimizer/gradients/optimizer/SquaredDifference_grad/Reshape
�
Moptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependencyIdentity<optimizer/gradients/optimizer/SquaredDifference_grad/ReshapeF^optimizer/gradients/optimizer/SquaredDifference_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients/optimizer/SquaredDifference_grad/Reshape
�
Ooptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependency_1Identity8optimizer/gradients/optimizer/SquaredDifference_grad/NegF^optimizer/gradients/optimizer/SquaredDifference_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/SquaredDifference_grad/Neg
�
=optimizer/gradients/optimizer/SquaredDifference_1_grad/scalarConst5^optimizer/gradients/optimizer/Sum_1_grad/BroadcastTo*
dtype0*
valueB
 *   @
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/MulMul=optimizer/gradients/optimizer/SquaredDifference_1_grad/scalar4optimizer/gradients/optimizer/Sum_1_grad/BroadcastTo*
T0
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/subSuboptimizer/dense_3/BiasAddoptimizer/concat_1/concat5^optimizer/gradients/optimizer/Sum_1_grad/BroadcastTo*
T0
�
<optimizer/gradients/optimizer/SquaredDifference_1_grad/mul_1Mul:optimizer/gradients/optimizer/SquaredDifference_1_grad/Mul:optimizer/gradients/optimizer/SquaredDifference_1_grad/sub*
T0
y
<optimizer/gradients/optimizer/SquaredDifference_1_grad/ShapeShapeoptimizer/dense_3/BiasAdd*
T0*
out_type0
{
>optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape_1Shapeoptimizer/concat_1/concat*
T0*
out_type0
�
Loptimizer/gradients/optimizer/SquaredDifference_1_grad/BroadcastGradientArgsBroadcastGradientArgs<optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape>optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape_1*
T0
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/SumSum<optimizer/gradients/optimizer/SquaredDifference_1_grad/mul_1Loptimizer/gradients/optimizer/SquaredDifference_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients/optimizer/SquaredDifference_1_grad/ReshapeReshape:optimizer/gradients/optimizer/SquaredDifference_1_grad/Sum<optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape*
T0*
Tshape0
�
<optimizer/gradients/optimizer/SquaredDifference_1_grad/Sum_1Sum<optimizer/gradients/optimizer/SquaredDifference_1_grad/mul_1Noptimizer/gradients/optimizer/SquaredDifference_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape_1Reshape<optimizer/gradients/optimizer/SquaredDifference_1_grad/Sum_1>optimizer/gradients/optimizer/SquaredDifference_1_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients/optimizer/SquaredDifference_1_grad/NegNeg@optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape_1*
T0
�
Goptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/group_depsNoOp;^optimizer/gradients/optimizer/SquaredDifference_1_grad/Neg?^optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape
�
Ooptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependencyIdentity>optimizer/gradients/optimizer/SquaredDifference_1_grad/ReshapeH^optimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape
�
Qoptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1Identity:optimizer/gradients/optimizer/SquaredDifference_1_grad/NegH^optimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/SquaredDifference_1_grad/Neg
�
>optimizer/gradients/optimizer/dense_1/BiasAdd_grad/BiasAddGradBiasAddGradMoptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependency*
T0*
data_formatNHWC
�
Coptimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/group_depsNoOpN^optimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependency?^optimizer/gradients/optimizer/dense_1/BiasAdd_grad/BiasAddGrad
�
Koptimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/control_dependencyIdentityMoptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependencyD^optimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients/optimizer/SquaredDifference_grad/Reshape
�
Moptimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/control_dependency_1Identity>optimizer/gradients/optimizer/dense_1/BiasAdd_grad/BiasAddGradD^optimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients/optimizer/dense_1/BiasAdd_grad/BiasAddGrad
�
>optimizer/gradients/optimizer/dense_3/BiasAdd_grad/BiasAddGradBiasAddGradOoptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependency*
T0*
data_formatNHWC
�
Coptimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/group_depsNoOpP^optimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependency?^optimizer/gradients/optimizer/dense_3/BiasAdd_grad/BiasAddGrad
�
Koptimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/control_dependencyIdentityOoptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependencyD^optimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients/optimizer/SquaredDifference_1_grad/Reshape
�
Moptimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/control_dependency_1Identity>optimizer/gradients/optimizer/dense_3/BiasAdd_grad/BiasAddGradD^optimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients/optimizer/dense_3/BiasAdd_grad/BiasAddGrad
�
8optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMulMatMulKoptimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/control_dependencyoptimizer//dense_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
:optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMul_1MatMuloptimizer/dense/MulKoptimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Boptimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/group_depsNoOp9^optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMul;^optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMul_1
�
Joptimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/control_dependencyIdentity8optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMulC^optimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMul
�
Loptimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/control_dependency_1Identity:optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMul_1C^optimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/dense_1/MatMul_grad/MatMul_1
�
8optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMulMatMulKoptimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/control_dependencyoptimizer//dense_3/kernel/read*
T0*
transpose_a( *
transpose_b(
�
:optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMul_1MatMuloptimizer/dense_2/MulKoptimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Boptimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/group_depsNoOp9^optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMul;^optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMul_1
�
Joptimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/control_dependencyIdentity8optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMulC^optimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMul
�
Loptimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/control_dependency_1Identity:optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMul_1C^optimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/dense_3/MatMul_grad/MatMul_1
m
2optimizer/gradients/optimizer/dense/Mul_grad/ShapeShapeoptimizer/dense/BiasAdd*
T0*
out_type0
o
4optimizer/gradients/optimizer/dense/Mul_grad/Shape_1Shapeoptimizer/dense/Sigmoid*
T0*
out_type0
�
Boptimizer/gradients/optimizer/dense/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs2optimizer/gradients/optimizer/dense/Mul_grad/Shape4optimizer/gradients/optimizer/dense/Mul_grad/Shape_1*
T0
�
0optimizer/gradients/optimizer/dense/Mul_grad/MulMulJoptimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/control_dependencyoptimizer/dense/Sigmoid*
T0
�
0optimizer/gradients/optimizer/dense/Mul_grad/SumSum0optimizer/gradients/optimizer/dense/Mul_grad/MulBoptimizer/gradients/optimizer/dense/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients/optimizer/dense/Mul_grad/ReshapeReshape0optimizer/gradients/optimizer/dense/Mul_grad/Sum2optimizer/gradients/optimizer/dense/Mul_grad/Shape*
T0*
Tshape0
�
2optimizer/gradients/optimizer/dense/Mul_grad/Mul_1Muloptimizer/dense/BiasAddJoptimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/control_dependency*
T0
�
2optimizer/gradients/optimizer/dense/Mul_grad/Sum_1Sum2optimizer/gradients/optimizer/dense/Mul_grad/Mul_1Doptimizer/gradients/optimizer/dense/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients/optimizer/dense/Mul_grad/Reshape_1Reshape2optimizer/gradients/optimizer/dense/Mul_grad/Sum_14optimizer/gradients/optimizer/dense/Mul_grad/Shape_1*
T0*
Tshape0
�
=optimizer/gradients/optimizer/dense/Mul_grad/tuple/group_depsNoOp5^optimizer/gradients/optimizer/dense/Mul_grad/Reshape7^optimizer/gradients/optimizer/dense/Mul_grad/Reshape_1
�
Eoptimizer/gradients/optimizer/dense/Mul_grad/tuple/control_dependencyIdentity4optimizer/gradients/optimizer/dense/Mul_grad/Reshape>^optimizer/gradients/optimizer/dense/Mul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients/optimizer/dense/Mul_grad/Reshape
�
Goptimizer/gradients/optimizer/dense/Mul_grad/tuple/control_dependency_1Identity6optimizer/gradients/optimizer/dense/Mul_grad/Reshape_1>^optimizer/gradients/optimizer/dense/Mul_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients/optimizer/dense/Mul_grad/Reshape_1
q
4optimizer/gradients/optimizer/dense_2/Mul_grad/ShapeShapeoptimizer/dense_2/BiasAdd*
T0*
out_type0
s
6optimizer/gradients/optimizer/dense_2/Mul_grad/Shape_1Shapeoptimizer/dense_2/Sigmoid*
T0*
out_type0
�
Doptimizer/gradients/optimizer/dense_2/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs4optimizer/gradients/optimizer/dense_2/Mul_grad/Shape6optimizer/gradients/optimizer/dense_2/Mul_grad/Shape_1*
T0
�
2optimizer/gradients/optimizer/dense_2/Mul_grad/MulMulJoptimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/control_dependencyoptimizer/dense_2/Sigmoid*
T0
�
2optimizer/gradients/optimizer/dense_2/Mul_grad/SumSum2optimizer/gradients/optimizer/dense_2/Mul_grad/MulDoptimizer/gradients/optimizer/dense_2/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients/optimizer/dense_2/Mul_grad/ReshapeReshape2optimizer/gradients/optimizer/dense_2/Mul_grad/Sum4optimizer/gradients/optimizer/dense_2/Mul_grad/Shape*
T0*
Tshape0
�
4optimizer/gradients/optimizer/dense_2/Mul_grad/Mul_1Muloptimizer/dense_2/BiasAddJoptimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/control_dependency*
T0
�
4optimizer/gradients/optimizer/dense_2/Mul_grad/Sum_1Sum4optimizer/gradients/optimizer/dense_2/Mul_grad/Mul_1Foptimizer/gradients/optimizer/dense_2/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
8optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape_1Reshape4optimizer/gradients/optimizer/dense_2/Mul_grad/Sum_16optimizer/gradients/optimizer/dense_2/Mul_grad/Shape_1*
T0*
Tshape0
�
?optimizer/gradients/optimizer/dense_2/Mul_grad/tuple/group_depsNoOp7^optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape9^optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape_1
�
Goptimizer/gradients/optimizer/dense_2/Mul_grad/tuple/control_dependencyIdentity6optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape@^optimizer/gradients/optimizer/dense_2/Mul_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape
�
Ioptimizer/gradients/optimizer/dense_2/Mul_grad/tuple/control_dependency_1Identity8optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape_1@^optimizer/gradients/optimizer/dense_2/Mul_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape_1
�
<optimizer/gradients/optimizer/dense/Sigmoid_grad/SigmoidGradSigmoidGradoptimizer/dense/SigmoidGoptimizer/gradients/optimizer/dense/Mul_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients/optimizer/dense_2/Sigmoid_grad/SigmoidGradSigmoidGradoptimizer/dense_2/SigmoidIoptimizer/gradients/optimizer/dense_2/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients/AddNAddNEoptimizer/gradients/optimizer/dense/Mul_grad/tuple/control_dependency<optimizer/gradients/optimizer/dense/Sigmoid_grad/SigmoidGrad*
N*
T0*G
_class=
;9loc:@optimizer/gradients/optimizer/dense/Mul_grad/Reshape
�
<optimizer/gradients/optimizer/dense/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN*
T0*
data_formatNHWC
�
Aoptimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN=^optimizer/gradients/optimizer/dense/BiasAdd_grad/BiasAddGrad
�
Ioptimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddNB^optimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients/optimizer/dense/Mul_grad/Reshape
�
Koptimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/control_dependency_1Identity<optimizer/gradients/optimizer/dense/BiasAdd_grad/BiasAddGradB^optimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients/optimizer/dense/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients/AddN_1AddNGoptimizer/gradients/optimizer/dense_2/Mul_grad/tuple/control_dependency>optimizer/gradients/optimizer/dense_2/Sigmoid_grad/SigmoidGrad*
N*
T0*I
_class?
=;loc:@optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape
�
>optimizer/gradients/optimizer/dense_2/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_1*
T0*
data_formatNHWC
�
Coptimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_1?^optimizer/gradients/optimizer/dense_2/BiasAdd_grad/BiasAddGrad
�
Koptimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_1D^optimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients/optimizer/dense_2/Mul_grad/Reshape
�
Moptimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/control_dependency_1Identity>optimizer/gradients/optimizer/dense_2/BiasAdd_grad/BiasAddGradD^optimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients/optimizer/dense_2/BiasAdd_grad/BiasAddGrad
�
6optimizer/gradients/optimizer/dense/MatMul_grad/MatMulMatMulIoptimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/control_dependencyoptimizer//dense/kernel/read*
T0*
transpose_a( *
transpose_b(
�
8optimizer/gradients/optimizer/dense/MatMul_grad/MatMul_1MatMuloptimizer/concat_2Ioptimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
@optimizer/gradients/optimizer/dense/MatMul_grad/tuple/group_depsNoOp7^optimizer/gradients/optimizer/dense/MatMul_grad/MatMul9^optimizer/gradients/optimizer/dense/MatMul_grad/MatMul_1
�
Hoptimizer/gradients/optimizer/dense/MatMul_grad/tuple/control_dependencyIdentity6optimizer/gradients/optimizer/dense/MatMul_grad/MatMulA^optimizer/gradients/optimizer/dense/MatMul_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients/optimizer/dense/MatMul_grad/MatMul
�
Joptimizer/gradients/optimizer/dense/MatMul_grad/tuple/control_dependency_1Identity8optimizer/gradients/optimizer/dense/MatMul_grad/MatMul_1A^optimizer/gradients/optimizer/dense/MatMul_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/dense/MatMul_grad/MatMul_1
�
8optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMulMatMulKoptimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/control_dependencyoptimizer//dense_2/kernel/read*
T0*
transpose_a( *
transpose_b(
�
:optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMul_1MatMuloptimizer/concat_3Koptimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Boptimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/group_depsNoOp9^optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMul;^optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMul_1
�
Joptimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/control_dependencyIdentity8optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMulC^optimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMul
�
Loptimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/control_dependency_1Identity:optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMul_1C^optimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/dense_2/MatMul_grad/MatMul_1
Z
0optimizer/gradients/optimizer/concat_2_grad/RankConst*
dtype0*
value	B :
�
/optimizer/gradients/optimizer/concat_2_grad/modFloorModoptimizer/concat_2/axis0optimizer/gradients/optimizer/concat_2_grad/Rank*
T0
l
1optimizer/gradients/optimizer/concat_2_grad/ShapeShapeoptimizer/concat/concat*
T0*
out_type0
�
2optimizer/gradients/optimizer/concat_2_grad/ShapeNShapeNoptimizer/concat/concatoptimizer/concat_1/concat*
N*
T0*
out_type0
�
8optimizer/gradients/optimizer/concat_2_grad/ConcatOffsetConcatOffset/optimizer/gradients/optimizer/concat_2_grad/mod2optimizer/gradients/optimizer/concat_2_grad/ShapeN4optimizer/gradients/optimizer/concat_2_grad/ShapeN:1*
N
�
1optimizer/gradients/optimizer/concat_2_grad/SliceSliceHoptimizer/gradients/optimizer/dense/MatMul_grad/tuple/control_dependency8optimizer/gradients/optimizer/concat_2_grad/ConcatOffset2optimizer/gradients/optimizer/concat_2_grad/ShapeN*
Index0*
T0
�
3optimizer/gradients/optimizer/concat_2_grad/Slice_1SliceHoptimizer/gradients/optimizer/dense/MatMul_grad/tuple/control_dependency:optimizer/gradients/optimizer/concat_2_grad/ConcatOffset:14optimizer/gradients/optimizer/concat_2_grad/ShapeN:1*
Index0*
T0
�
<optimizer/gradients/optimizer/concat_2_grad/tuple/group_depsNoOp2^optimizer/gradients/optimizer/concat_2_grad/Slice4^optimizer/gradients/optimizer/concat_2_grad/Slice_1
�
Doptimizer/gradients/optimizer/concat_2_grad/tuple/control_dependencyIdentity1optimizer/gradients/optimizer/concat_2_grad/Slice=^optimizer/gradients/optimizer/concat_2_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients/optimizer/concat_2_grad/Slice
�
Foptimizer/gradients/optimizer/concat_2_grad/tuple/control_dependency_1Identity3optimizer/gradients/optimizer/concat_2_grad/Slice_1=^optimizer/gradients/optimizer/concat_2_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients/optimizer/concat_2_grad/Slice_1
Z
0optimizer/gradients/optimizer/concat_3_grad/RankConst*
dtype0*
value	B :
�
/optimizer/gradients/optimizer/concat_3_grad/modFloorModoptimizer/concat_3/axis0optimizer/gradients/optimizer/concat_3_grad/Rank*
T0
l
1optimizer/gradients/optimizer/concat_3_grad/ShapeShapeoptimizer/concat/concat*
T0*
out_type0
�
2optimizer/gradients/optimizer/concat_3_grad/ShapeNShapeNoptimizer/concat/concatStopGradient*
N*
T0*
out_type0
�
8optimizer/gradients/optimizer/concat_3_grad/ConcatOffsetConcatOffset/optimizer/gradients/optimizer/concat_3_grad/mod2optimizer/gradients/optimizer/concat_3_grad/ShapeN4optimizer/gradients/optimizer/concat_3_grad/ShapeN:1*
N
�
1optimizer/gradients/optimizer/concat_3_grad/SliceSliceJoptimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/control_dependency8optimizer/gradients/optimizer/concat_3_grad/ConcatOffset2optimizer/gradients/optimizer/concat_3_grad/ShapeN*
Index0*
T0
�
3optimizer/gradients/optimizer/concat_3_grad/Slice_1SliceJoptimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/control_dependency:optimizer/gradients/optimizer/concat_3_grad/ConcatOffset:14optimizer/gradients/optimizer/concat_3_grad/ShapeN:1*
Index0*
T0
�
<optimizer/gradients/optimizer/concat_3_grad/tuple/group_depsNoOp2^optimizer/gradients/optimizer/concat_3_grad/Slice4^optimizer/gradients/optimizer/concat_3_grad/Slice_1
�
Doptimizer/gradients/optimizer/concat_3_grad/tuple/control_dependencyIdentity1optimizer/gradients/optimizer/concat_3_grad/Slice=^optimizer/gradients/optimizer/concat_3_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients/optimizer/concat_3_grad/Slice
�
Foptimizer/gradients/optimizer/concat_3_grad/tuple/control_dependency_1Identity3optimizer/gradients/optimizer/concat_3_grad/Slice_1=^optimizer/gradients/optimizer/concat_3_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients/optimizer/concat_3_grad/Slice_1
�
optimizer/gradients/AddN_2AddNQoptimizer/gradients/optimizer/SquaredDifference_1_grad/tuple/control_dependency_1Foptimizer/gradients/optimizer/concat_2_grad/tuple/control_dependency_1*
N*
T0*M
_classC
A?loc:@optimizer/gradients/optimizer/SquaredDifference_1_grad/Neg
�
optimizer/gradients/AddN_3AddNDoptimizer/gradients/optimizer/concat_2_grad/tuple/control_dependencyDoptimizer/gradients/optimizer/concat_3_grad/tuple/control_dependency*
N*
T0*D
_class:
86loc:@optimizer/gradients/optimizer/concat_2_grad/Slice
�
optimizer/gradients/AddN_4AddNOoptimizer/gradients/optimizer/SquaredDifference_grad/tuple/control_dependency_1Foptimizer/gradients/optimizer/concat_3_grad/tuple/control_dependency_1*
N*
T0*K
_classA
?=loc:@optimizer/gradients/optimizer/SquaredDifference_grad/Neg
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/ShapeShape9optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd*
T0*
out_type0
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Shape_1Shape9optimizer/curiosity_vector_obs_encoder_1/hidden_1/Sigmoid*
T0*
out_type0
�
doptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/ShapeVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Shape_1*
T0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/MulMuloptimizer/gradients/AddN_29optimizer/curiosity_vector_obs_encoder_1/hidden_1/Sigmoid*
T0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/SumSumRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Muldoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/ReshapeReshapeRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/SumToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Mul_1Mul9optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAddoptimizer/gradients/AddN_2*
T0
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Sum_1SumToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Mul_1foptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Xoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape_1ReshapeToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Sum_1Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
_optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/tuple/group_depsNoOpW^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/ReshapeY^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape_1
�
goptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/tuple/control_dependencyIdentityVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape`^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape
�
ioptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/tuple/control_dependency_1IdentityXoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape_1`^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/tuple/group_deps*
T0*k
_classa
_]loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape_1
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/ShapeShape7optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd*
T0*
out_type0
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Shape_1Shape7optimizer/curiosity_vector_obs_encoder/hidden_1/Sigmoid*
T0*
out_type0
�
boptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/ShapeToptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Shape_1*
T0
�
Poptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/MulMuloptimizer/gradients/AddN_37optimizer/curiosity_vector_obs_encoder/hidden_1/Sigmoid*
T0
�
Poptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/SumSumPoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Mulboptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/ReshapeReshapePoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/SumRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Mul_1Mul7optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAddoptimizer/gradients/AddN_3*
T0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Sum_1SumRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Mul_1doptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape_1ReshapeRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Sum_1Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
]optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/tuple/group_depsNoOpU^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/ReshapeW^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape_1
�
eoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/tuple/control_dependencyIdentityToptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape^^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*g
_class]
[Yloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape
�
goptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/tuple/control_dependency_1IdentityVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape_1^^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape_1
�
^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad9optimizer/curiosity_vector_obs_encoder_1/hidden_1/Sigmoidioptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad7optimizer/curiosity_vector_obs_encoder/hidden_1/Sigmoidgoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients/AddN_5AddNgoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/tuple/control_dependency^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape
�
^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_5*
T0*
data_formatNHWC
�
coptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_5_^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/BiasAddGrad
�
koptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_5d^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/Mul_grad/Reshape
�
moptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/control_dependency_1Identity^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/BiasAddGradd^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*q
_classg
ecloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients/AddN_6AddNeoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/tuple/control_dependency\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*g
_class]
[Yloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape
�
\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_6*
T0*
data_formatNHWC
�
aoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_6]^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/BiasAddGrad
�
ioptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_6b^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*g
_class]
[Yloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/Mul_grad/Reshape
�
koptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1Identity\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/BiasAddGradb^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*o
_classe
caloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMulMatMulkoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/control_dependency<optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Zoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMul_1MatMul5optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mulkoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
boptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/group_depsNoOpY^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMul[^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMul_1
�
joptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/control_dependencyIdentityXoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMulc^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/group_deps*
T0*k
_classa
_]loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMul
�
loptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityZoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMul_1c^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/group_deps*
T0*m
_classc
a_loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMul_1
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMulMatMulioptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency<optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Xoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMul_1MatMul3optimizer/curiosity_vector_obs_encoder/hidden_0/Mulioptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
`optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/group_depsNoOpW^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMulY^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMul_1
�
hoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/control_dependencyIdentityVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMula^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMul
�
joptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityXoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMul_1a^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/group_deps*
T0*k
_classa
_]loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/MatMul_1
�
optimizer/gradients/AddN_7AddNmoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/tuple/control_dependency_1koptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
N*
T0*q
_classg
ecloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/BiasAdd_grad/BiasAddGrad
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/ShapeShape9optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd*
T0*
out_type0
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Shape_1Shape9optimizer/curiosity_vector_obs_encoder_1/hidden_0/Sigmoid*
T0*
out_type0
�
doptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/ShapeVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Shape_1*
T0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/MulMuljoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/control_dependency9optimizer/curiosity_vector_obs_encoder_1/hidden_0/Sigmoid*
T0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/SumSumRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Muldoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/ReshapeReshapeRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/SumToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Mul_1Mul9optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAddjoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Sum_1SumToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Mul_1foptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Xoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape_1ReshapeToptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Sum_1Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
_optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/tuple/group_depsNoOpW^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/ReshapeY^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape_1
�
goptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/tuple/control_dependencyIdentityVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape`^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape
�
ioptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/tuple/control_dependency_1IdentityXoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape_1`^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/tuple/group_deps*
T0*k
_classa
_]loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape_1
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/ShapeShape7optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd*
T0*
out_type0
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Shape_1Shape7optimizer/curiosity_vector_obs_encoder/hidden_0/Sigmoid*
T0*
out_type0
�
boptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/ShapeToptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Shape_1*
T0
�
Poptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/MulMulhoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/control_dependency7optimizer/curiosity_vector_obs_encoder/hidden_0/Sigmoid*
T0
�
Poptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/SumSumPoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Mulboptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/ReshapeReshapePoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/SumRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Mul_1Mul7optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAddhoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Roptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Sum_1SumRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Mul_1doptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape_1ReshapeRoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Sum_1Toptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
]optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/tuple/group_depsNoOpU^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/ReshapeW^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape_1
�
eoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/tuple/control_dependencyIdentityToptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape^^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*g
_class]
[Yloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape
�
goptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/tuple/control_dependency_1IdentityVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape_1^^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape_1
�
optimizer/gradients/AddN_8AddNloptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/tuple/control_dependency_1joptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_1/MatMul_grad/tuple/control_dependency_1*
N*
T0*m
_classc
a_loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_1/MatMul_grad/MatMul_1
�
^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad9optimizer/curiosity_vector_obs_encoder_1/hidden_0/Sigmoidioptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad7optimizer/curiosity_vector_obs_encoder/hidden_0/Sigmoidgoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients/AddN_9AddNgoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/tuple/control_dependency^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape
�
^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_9*
T0*
data_formatNHWC
�
coptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_9_^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/BiasAddGrad
�
koptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_9d^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/Mul_grad/Reshape
�
moptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/control_dependency_1Identity^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/BiasAddGradd^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*q
_classg
ecloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients/AddN_10AddNeoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/tuple/control_dependency\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*g
_class]
[Yloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape
�
\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients/AddN_10*
T0*
data_formatNHWC
�
aoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients/AddN_10]^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/BiasAddGrad
�
ioptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients/AddN_10b^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*g
_class]
[Yloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/Mul_grad/Reshape
�
koptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1Identity\optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/BiasAddGradb^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*o
_classe
caloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMulMatMulkoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/control_dependency<optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Zoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMul_1MatMul+optimizer/curiosity_next_vector_observationkoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
boptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/tuple/group_depsNoOpY^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMul[^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMul_1
�
joptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/tuple/control_dependencyIdentityXoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMulc^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/tuple/group_deps*
T0*k
_classa
_]loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMul
�
loptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityZoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMul_1c^optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/tuple/group_deps*
T0*m
_classc
a_loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMul_1
�
Voptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMulMatMulioptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency<optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Xoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMul_1MatMulvector_observationioptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
`optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/tuple/group_depsNoOpW^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMulY^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMul_1
�
hoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/tuple/control_dependencyIdentityVoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMula^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*i
_class_
][loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMul
�
joptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityXoptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMul_1a^optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/tuple/group_deps*
T0*k
_classa
_]loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/MatMul_1
�
optimizer/gradients/AddN_11AddNmoptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/tuple/control_dependency_1koptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
N*
T0*q
_classg
ecloc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients/AddN_12AddNloptimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/tuple/control_dependency_1joptimizer/gradients/optimizer/curiosity_vector_obs_encoder/hidden_0/MatMul_grad/tuple/control_dependency_1*
N*
T0*m
_classc
a_loc:@optimizer/gradients/optimizer/curiosity_vector_obs_encoder_1/hidden_0/MatMul_grad/MatMul_1
�
#optimizer/beta1_power/initial_valueConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
dtype0*
valueB
 *fff?
�
optimizer/beta1_power
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta1_power/AssignAssignoptimizer/beta1_power#optimizer/beta1_power/initial_value*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
optimizer/beta1_power/readIdentityoptimizer/beta1_power*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias
�
#optimizer/beta2_power/initial_valueConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
dtype0*
valueB
 *w�?
�
optimizer/beta2_power
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta2_power/AssignAssignoptimizer/beta2_power#optimizer/beta2_power/initial_value*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
optimizer/beta2_power/readIdentityoptimizer/beta2_power*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias
�
ioptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
valueB"      
�
_optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/Initializer/zeros/ConstConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
valueB
 *    
�
Yoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/Initializer/zerosFillioptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensor_optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/Initializer/zeros/Const*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*

index_type0
�
Goptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam
VariableV2*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
Noptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/AssignAssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/AdamYoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/Initializer/zeros*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
Loptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/readIdentityGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel
�
koptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
valueB"      
�
aoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/Initializer/zeros/ConstConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
dtype0*
valueB
 *    
�
[optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/Initializer/zerosFillkoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensoraoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/Initializer/zeros/Const*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*

index_type0
�
Ioptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1
VariableV2*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
Poptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/AssignAssignIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1[optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/Initializer/zeros*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
Noptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/readIdentityIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel
�
Woptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam/Initializer/zerosConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
dtype0*
valueB�*    
�
Eoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Loptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam/AssignAssignEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/AdamWoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam/Initializer/zeros*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
Joptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam/readIdentityEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias
�
Yoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1/Initializer/zerosConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
dtype0*
valueB�*    
�
Goptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Noptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1/AssignAssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1Yoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1/Initializer/zeros*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
Loptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1/readIdentityGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias
�
ioptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
valueB"      
�
_optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/Initializer/zeros/ConstConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
Yoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/Initializer/zerosFillioptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensor_optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*

index_type0
�
Goptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam
VariableV2*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
Noptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/AssignAssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/AdamYoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/Initializer/zeros*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
Loptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/readIdentityGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel
�
koptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
valueB"      
�
aoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
dtype0*
valueB
 *    
�
[optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/Initializer/zerosFillkoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensoraoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*

index_type0
�
Ioptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1
VariableV2*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
Poptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/AssignAssignIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1[optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/Initializer/zeros*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
Noptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/readIdentityIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel
�
Woptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam/Initializer/zerosConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
dtype0*
valueB�*    
�
Eoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Loptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam/AssignAssignEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/AdamWoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam/Initializer/zeros*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
Joptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam/readIdentityEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias
�
Yoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1/Initializer/zerosConst*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
dtype0*
valueB�*    
�
Goptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1
VariableV2*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Noptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1/AssignAssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1Yoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1/Initializer/zeros*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
Loptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1/readIdentityGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias
�
Ioptimizer//optimizer//dense/kernel/Adam/Initializer/zeros/shape_as_tensorConst**
_class 
loc:@optimizer//dense/kernel*
dtype0*
valueB"      
�
?optimizer//optimizer//dense/kernel/Adam/Initializer/zeros/ConstConst**
_class 
loc:@optimizer//dense/kernel*
dtype0*
valueB
 *    
�
9optimizer//optimizer//dense/kernel/Adam/Initializer/zerosFillIoptimizer//optimizer//dense/kernel/Adam/Initializer/zeros/shape_as_tensor?optimizer//optimizer//dense/kernel/Adam/Initializer/zeros/Const*
T0**
_class 
loc:@optimizer//dense/kernel*

index_type0
�
'optimizer//optimizer//dense/kernel/Adam
VariableV2**
_class 
loc:@optimizer//dense/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
.optimizer//optimizer//dense/kernel/Adam/AssignAssign'optimizer//optimizer//dense/kernel/Adam9optimizer//optimizer//dense/kernel/Adam/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense/kernel*
use_locking(*
validate_shape(
�
,optimizer//optimizer//dense/kernel/Adam/readIdentity'optimizer//optimizer//dense/kernel/Adam*
T0**
_class 
loc:@optimizer//dense/kernel
�
Koptimizer//optimizer//dense/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst**
_class 
loc:@optimizer//dense/kernel*
dtype0*
valueB"      
�
Aoptimizer//optimizer//dense/kernel/Adam_1/Initializer/zeros/ConstConst**
_class 
loc:@optimizer//dense/kernel*
dtype0*
valueB
 *    
�
;optimizer//optimizer//dense/kernel/Adam_1/Initializer/zerosFillKoptimizer//optimizer//dense/kernel/Adam_1/Initializer/zeros/shape_as_tensorAoptimizer//optimizer//dense/kernel/Adam_1/Initializer/zeros/Const*
T0**
_class 
loc:@optimizer//dense/kernel*

index_type0
�
)optimizer//optimizer//dense/kernel/Adam_1
VariableV2**
_class 
loc:@optimizer//dense/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
0optimizer//optimizer//dense/kernel/Adam_1/AssignAssign)optimizer//optimizer//dense/kernel/Adam_1;optimizer//optimizer//dense/kernel/Adam_1/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense/kernel*
use_locking(*
validate_shape(
�
.optimizer//optimizer//dense/kernel/Adam_1/readIdentity)optimizer//optimizer//dense/kernel/Adam_1*
T0**
_class 
loc:@optimizer//dense/kernel
�
7optimizer//optimizer//dense/bias/Adam/Initializer/zerosConst*(
_class
loc:@optimizer//dense/bias*
dtype0*
valueB�*    
�
%optimizer//optimizer//dense/bias/Adam
VariableV2*(
_class
loc:@optimizer//dense/bias*
	container *
dtype0*
shape:�*
shared_name 
�
,optimizer//optimizer//dense/bias/Adam/AssignAssign%optimizer//optimizer//dense/bias/Adam7optimizer//optimizer//dense/bias/Adam/Initializer/zeros*
T0*(
_class
loc:@optimizer//dense/bias*
use_locking(*
validate_shape(
�
*optimizer//optimizer//dense/bias/Adam/readIdentity%optimizer//optimizer//dense/bias/Adam*
T0*(
_class
loc:@optimizer//dense/bias
�
9optimizer//optimizer//dense/bias/Adam_1/Initializer/zerosConst*(
_class
loc:@optimizer//dense/bias*
dtype0*
valueB�*    
�
'optimizer//optimizer//dense/bias/Adam_1
VariableV2*(
_class
loc:@optimizer//dense/bias*
	container *
dtype0*
shape:�*
shared_name 
�
.optimizer//optimizer//dense/bias/Adam_1/AssignAssign'optimizer//optimizer//dense/bias/Adam_19optimizer//optimizer//dense/bias/Adam_1/Initializer/zeros*
T0*(
_class
loc:@optimizer//dense/bias*
use_locking(*
validate_shape(
�
,optimizer//optimizer//dense/bias/Adam_1/readIdentity'optimizer//optimizer//dense/bias/Adam_1*
T0*(
_class
loc:@optimizer//dense/bias
�
;optimizer//optimizer//dense_1/kernel/Adam/Initializer/zerosConst*,
_class"
 loc:@optimizer//dense_1/kernel*
dtype0*
valueB	�*    
�
)optimizer//optimizer//dense_1/kernel/Adam
VariableV2*,
_class"
 loc:@optimizer//dense_1/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
0optimizer//optimizer//dense_1/kernel/Adam/AssignAssign)optimizer//optimizer//dense_1/kernel/Adam;optimizer//optimizer//dense_1/kernel/Adam/Initializer/zeros*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
use_locking(*
validate_shape(
�
.optimizer//optimizer//dense_1/kernel/Adam/readIdentity)optimizer//optimizer//dense_1/kernel/Adam*
T0*,
_class"
 loc:@optimizer//dense_1/kernel
�
=optimizer//optimizer//dense_1/kernel/Adam_1/Initializer/zerosConst*,
_class"
 loc:@optimizer//dense_1/kernel*
dtype0*
valueB	�*    
�
+optimizer//optimizer//dense_1/kernel/Adam_1
VariableV2*,
_class"
 loc:@optimizer//dense_1/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
2optimizer//optimizer//dense_1/kernel/Adam_1/AssignAssign+optimizer//optimizer//dense_1/kernel/Adam_1=optimizer//optimizer//dense_1/kernel/Adam_1/Initializer/zeros*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
use_locking(*
validate_shape(
�
0optimizer//optimizer//dense_1/kernel/Adam_1/readIdentity+optimizer//optimizer//dense_1/kernel/Adam_1*
T0*,
_class"
 loc:@optimizer//dense_1/kernel
�
9optimizer//optimizer//dense_1/bias/Adam/Initializer/zerosConst**
_class 
loc:@optimizer//dense_1/bias*
dtype0*
valueB*    
�
'optimizer//optimizer//dense_1/bias/Adam
VariableV2**
_class 
loc:@optimizer//dense_1/bias*
	container *
dtype0*
shape:*
shared_name 
�
.optimizer//optimizer//dense_1/bias/Adam/AssignAssign'optimizer//optimizer//dense_1/bias/Adam9optimizer//optimizer//dense_1/bias/Adam/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_1/bias*
use_locking(*
validate_shape(
�
,optimizer//optimizer//dense_1/bias/Adam/readIdentity'optimizer//optimizer//dense_1/bias/Adam*
T0**
_class 
loc:@optimizer//dense_1/bias
�
;optimizer//optimizer//dense_1/bias/Adam_1/Initializer/zerosConst**
_class 
loc:@optimizer//dense_1/bias*
dtype0*
valueB*    
�
)optimizer//optimizer//dense_1/bias/Adam_1
VariableV2**
_class 
loc:@optimizer//dense_1/bias*
	container *
dtype0*
shape:*
shared_name 
�
0optimizer//optimizer//dense_1/bias/Adam_1/AssignAssign)optimizer//optimizer//dense_1/bias/Adam_1;optimizer//optimizer//dense_1/bias/Adam_1/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_1/bias*
use_locking(*
validate_shape(
�
.optimizer//optimizer//dense_1/bias/Adam_1/readIdentity)optimizer//optimizer//dense_1/bias/Adam_1*
T0**
_class 
loc:@optimizer//dense_1/bias
�
Koptimizer//optimizer//dense_2/kernel/Adam/Initializer/zeros/shape_as_tensorConst*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
valueB"     
�
Aoptimizer//optimizer//dense_2/kernel/Adam/Initializer/zeros/ConstConst*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
valueB
 *    
�
;optimizer//optimizer//dense_2/kernel/Adam/Initializer/zerosFillKoptimizer//optimizer//dense_2/kernel/Adam/Initializer/zeros/shape_as_tensorAoptimizer//optimizer//dense_2/kernel/Adam/Initializer/zeros/Const*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*

index_type0
�
)optimizer//optimizer//dense_2/kernel/Adam
VariableV2*,
_class"
 loc:@optimizer//dense_2/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
0optimizer//optimizer//dense_2/kernel/Adam/AssignAssign)optimizer//optimizer//dense_2/kernel/Adam;optimizer//optimizer//dense_2/kernel/Adam/Initializer/zeros*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
use_locking(*
validate_shape(
�
.optimizer//optimizer//dense_2/kernel/Adam/readIdentity)optimizer//optimizer//dense_2/kernel/Adam*
T0*,
_class"
 loc:@optimizer//dense_2/kernel
�
Moptimizer//optimizer//dense_2/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
valueB"     
�
Coptimizer//optimizer//dense_2/kernel/Adam_1/Initializer/zeros/ConstConst*,
_class"
 loc:@optimizer//dense_2/kernel*
dtype0*
valueB
 *    
�
=optimizer//optimizer//dense_2/kernel/Adam_1/Initializer/zerosFillMoptimizer//optimizer//dense_2/kernel/Adam_1/Initializer/zeros/shape_as_tensorCoptimizer//optimizer//dense_2/kernel/Adam_1/Initializer/zeros/Const*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*

index_type0
�
+optimizer//optimizer//dense_2/kernel/Adam_1
VariableV2*,
_class"
 loc:@optimizer//dense_2/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
2optimizer//optimizer//dense_2/kernel/Adam_1/AssignAssign+optimizer//optimizer//dense_2/kernel/Adam_1=optimizer//optimizer//dense_2/kernel/Adam_1/Initializer/zeros*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
use_locking(*
validate_shape(
�
0optimizer//optimizer//dense_2/kernel/Adam_1/readIdentity+optimizer//optimizer//dense_2/kernel/Adam_1*
T0*,
_class"
 loc:@optimizer//dense_2/kernel
�
9optimizer//optimizer//dense_2/bias/Adam/Initializer/zerosConst**
_class 
loc:@optimizer//dense_2/bias*
dtype0*
valueB�*    
�
'optimizer//optimizer//dense_2/bias/Adam
VariableV2**
_class 
loc:@optimizer//dense_2/bias*
	container *
dtype0*
shape:�*
shared_name 
�
.optimizer//optimizer//dense_2/bias/Adam/AssignAssign'optimizer//optimizer//dense_2/bias/Adam9optimizer//optimizer//dense_2/bias/Adam/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_2/bias*
use_locking(*
validate_shape(
�
,optimizer//optimizer//dense_2/bias/Adam/readIdentity'optimizer//optimizer//dense_2/bias/Adam*
T0**
_class 
loc:@optimizer//dense_2/bias
�
;optimizer//optimizer//dense_2/bias/Adam_1/Initializer/zerosConst**
_class 
loc:@optimizer//dense_2/bias*
dtype0*
valueB�*    
�
)optimizer//optimizer//dense_2/bias/Adam_1
VariableV2**
_class 
loc:@optimizer//dense_2/bias*
	container *
dtype0*
shape:�*
shared_name 
�
0optimizer//optimizer//dense_2/bias/Adam_1/AssignAssign)optimizer//optimizer//dense_2/bias/Adam_1;optimizer//optimizer//dense_2/bias/Adam_1/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_2/bias*
use_locking(*
validate_shape(
�
.optimizer//optimizer//dense_2/bias/Adam_1/readIdentity)optimizer//optimizer//dense_2/bias/Adam_1*
T0**
_class 
loc:@optimizer//dense_2/bias
�
Koptimizer//optimizer//dense_3/kernel/Adam/Initializer/zeros/shape_as_tensorConst*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
valueB"      
�
Aoptimizer//optimizer//dense_3/kernel/Adam/Initializer/zeros/ConstConst*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
valueB
 *    
�
;optimizer//optimizer//dense_3/kernel/Adam/Initializer/zerosFillKoptimizer//optimizer//dense_3/kernel/Adam/Initializer/zeros/shape_as_tensorAoptimizer//optimizer//dense_3/kernel/Adam/Initializer/zeros/Const*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*

index_type0
�
)optimizer//optimizer//dense_3/kernel/Adam
VariableV2*,
_class"
 loc:@optimizer//dense_3/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
0optimizer//optimizer//dense_3/kernel/Adam/AssignAssign)optimizer//optimizer//dense_3/kernel/Adam;optimizer//optimizer//dense_3/kernel/Adam/Initializer/zeros*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
use_locking(*
validate_shape(
�
.optimizer//optimizer//dense_3/kernel/Adam/readIdentity)optimizer//optimizer//dense_3/kernel/Adam*
T0*,
_class"
 loc:@optimizer//dense_3/kernel
�
Moptimizer//optimizer//dense_3/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
valueB"      
�
Coptimizer//optimizer//dense_3/kernel/Adam_1/Initializer/zeros/ConstConst*,
_class"
 loc:@optimizer//dense_3/kernel*
dtype0*
valueB
 *    
�
=optimizer//optimizer//dense_3/kernel/Adam_1/Initializer/zerosFillMoptimizer//optimizer//dense_3/kernel/Adam_1/Initializer/zeros/shape_as_tensorCoptimizer//optimizer//dense_3/kernel/Adam_1/Initializer/zeros/Const*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*

index_type0
�
+optimizer//optimizer//dense_3/kernel/Adam_1
VariableV2*,
_class"
 loc:@optimizer//dense_3/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
2optimizer//optimizer//dense_3/kernel/Adam_1/AssignAssign+optimizer//optimizer//dense_3/kernel/Adam_1=optimizer//optimizer//dense_3/kernel/Adam_1/Initializer/zeros*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
use_locking(*
validate_shape(
�
0optimizer//optimizer//dense_3/kernel/Adam_1/readIdentity+optimizer//optimizer//dense_3/kernel/Adam_1*
T0*,
_class"
 loc:@optimizer//dense_3/kernel
�
9optimizer//optimizer//dense_3/bias/Adam/Initializer/zerosConst**
_class 
loc:@optimizer//dense_3/bias*
dtype0*
valueB�*    
�
'optimizer//optimizer//dense_3/bias/Adam
VariableV2**
_class 
loc:@optimizer//dense_3/bias*
	container *
dtype0*
shape:�*
shared_name 
�
.optimizer//optimizer//dense_3/bias/Adam/AssignAssign'optimizer//optimizer//dense_3/bias/Adam9optimizer//optimizer//dense_3/bias/Adam/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_3/bias*
use_locking(*
validate_shape(
�
,optimizer//optimizer//dense_3/bias/Adam/readIdentity'optimizer//optimizer//dense_3/bias/Adam*
T0**
_class 
loc:@optimizer//dense_3/bias
�
;optimizer//optimizer//dense_3/bias/Adam_1/Initializer/zerosConst**
_class 
loc:@optimizer//dense_3/bias*
dtype0*
valueB�*    
�
)optimizer//optimizer//dense_3/bias/Adam_1
VariableV2**
_class 
loc:@optimizer//dense_3/bias*
	container *
dtype0*
shape:�*
shared_name 
�
0optimizer//optimizer//dense_3/bias/Adam_1/AssignAssign)optimizer//optimizer//dense_3/bias/Adam_1;optimizer//optimizer//dense_3/bias/Adam_1/Initializer/zeros*
T0**
_class 
loc:@optimizer//dense_3/bias*
use_locking(*
validate_shape(
�
.optimizer//optimizer//dense_3/bias/Adam_1/readIdentity)optimizer//optimizer//dense_3/bias/Adam_1*
T0**
_class 
loc:@optimizer//dense_3/bias
I
optimizer/Adam/learning_rateConst*
dtype0*
valueB
 *RI�9
A
optimizer/Adam/beta1Const*
dtype0*
valueB
 *fff?
A
optimizer/Adam/beta2Const*
dtype0*
valueB
 *w�?
C
optimizer/Adam/epsilonConst*
dtype0*
valueB
 *w�+2
�
Woptimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/ApplyAdam	ApplyAdam7optimizer//curiosity_vector_obs_encoder/hidden_0/kernelGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/AdamIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonoptimizer/gradients/AddN_12*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Uoptimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/bias/ApplyAdam	ApplyAdam5optimizer//curiosity_vector_obs_encoder/hidden_0/biasEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/AdamGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonoptimizer/gradients/AddN_11*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Woptimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/ApplyAdam	ApplyAdam7optimizer//curiosity_vector_obs_encoder/hidden_1/kernelGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/AdamIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonoptimizer/gradients/AddN_8*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Uoptimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/bias/ApplyAdam	ApplyAdam5optimizer//curiosity_vector_obs_encoder/hidden_1/biasEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/AdamGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonoptimizer/gradients/AddN_7*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
use_locking( *
use_nesterov( 
�
7optimizer/Adam/update_optimizer//dense/kernel/ApplyAdam	ApplyAdamoptimizer//dense/kernel'optimizer//optimizer//dense/kernel/Adam)optimizer//optimizer//dense/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonJoptimizer/gradients/optimizer/dense/MatMul_grad/tuple/control_dependency_1*
T0**
_class 
loc:@optimizer//dense/kernel*
use_locking( *
use_nesterov( 
�
5optimizer/Adam/update_optimizer//dense/bias/ApplyAdam	ApplyAdamoptimizer//dense/bias%optimizer//optimizer//dense/bias/Adam'optimizer//optimizer//dense/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonKoptimizer/gradients/optimizer/dense/BiasAdd_grad/tuple/control_dependency_1*
T0*(
_class
loc:@optimizer//dense/bias*
use_locking( *
use_nesterov( 
�
9optimizer/Adam/update_optimizer//dense_1/kernel/ApplyAdam	ApplyAdamoptimizer//dense_1/kernel)optimizer//optimizer//dense_1/kernel/Adam+optimizer//optimizer//dense_1/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonLoptimizer/gradients/optimizer/dense_1/MatMul_grad/tuple/control_dependency_1*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
use_locking( *
use_nesterov( 
�
7optimizer/Adam/update_optimizer//dense_1/bias/ApplyAdam	ApplyAdamoptimizer//dense_1/bias'optimizer//optimizer//dense_1/bias/Adam)optimizer//optimizer//dense_1/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonMoptimizer/gradients/optimizer/dense_1/BiasAdd_grad/tuple/control_dependency_1*
T0**
_class 
loc:@optimizer//dense_1/bias*
use_locking( *
use_nesterov( 
�
9optimizer/Adam/update_optimizer//dense_2/kernel/ApplyAdam	ApplyAdamoptimizer//dense_2/kernel)optimizer//optimizer//dense_2/kernel/Adam+optimizer//optimizer//dense_2/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonLoptimizer/gradients/optimizer/dense_2/MatMul_grad/tuple/control_dependency_1*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
use_locking( *
use_nesterov( 
�
7optimizer/Adam/update_optimizer//dense_2/bias/ApplyAdam	ApplyAdamoptimizer//dense_2/bias'optimizer//optimizer//dense_2/bias/Adam)optimizer//optimizer//dense_2/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonMoptimizer/gradients/optimizer/dense_2/BiasAdd_grad/tuple/control_dependency_1*
T0**
_class 
loc:@optimizer//dense_2/bias*
use_locking( *
use_nesterov( 
�
9optimizer/Adam/update_optimizer//dense_3/kernel/ApplyAdam	ApplyAdamoptimizer//dense_3/kernel)optimizer//optimizer//dense_3/kernel/Adam+optimizer//optimizer//dense_3/kernel/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonLoptimizer/gradients/optimizer/dense_3/MatMul_grad/tuple/control_dependency_1*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
use_locking( *
use_nesterov( 
�
7optimizer/Adam/update_optimizer//dense_3/bias/ApplyAdam	ApplyAdamoptimizer//dense_3/bias'optimizer//optimizer//dense_3/bias/Adam)optimizer//optimizer//dense_3/bias/Adam_1optimizer/beta1_power/readoptimizer/beta2_power/readoptimizer/Adam/learning_rateoptimizer/Adam/beta1optimizer/Adam/beta2optimizer/Adam/epsilonMoptimizer/gradients/optimizer/dense_3/BiasAdd_grad/tuple/control_dependency_1*
T0**
_class 
loc:@optimizer//dense_3/bias*
use_locking( *
use_nesterov( 
�
optimizer/Adam/mulMuloptimizer/beta1_power/readoptimizer/Adam/beta1V^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/bias/ApplyAdamX^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/ApplyAdamV^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/bias/ApplyAdamX^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/ApplyAdam6^optimizer/Adam/update_optimizer//dense/bias/ApplyAdam8^optimizer/Adam/update_optimizer//dense/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_1/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_1/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_2/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_2/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_3/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_3/kernel/ApplyAdam*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias
�
optimizer/Adam/AssignAssignoptimizer/beta1_poweroptimizer/Adam/mul*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking( *
validate_shape(
�
optimizer/Adam/mul_1Muloptimizer/beta2_power/readoptimizer/Adam/beta2V^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/bias/ApplyAdamX^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/ApplyAdamV^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/bias/ApplyAdamX^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/ApplyAdam6^optimizer/Adam/update_optimizer//dense/bias/ApplyAdam8^optimizer/Adam/update_optimizer//dense/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_1/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_1/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_2/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_2/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_3/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_3/kernel/ApplyAdam*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias
�
optimizer/Adam/Assign_1Assignoptimizer/beta2_poweroptimizer/Adam/mul_1*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking( *
validate_shape(
�
optimizer/AdamNoOp^optimizer/Adam/Assign^optimizer/Adam/Assign_1V^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/bias/ApplyAdamX^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/ApplyAdamV^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/bias/ApplyAdamX^optimizer/Adam/update_optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/ApplyAdam6^optimizer/Adam/update_optimizer//dense/bias/ApplyAdam8^optimizer/Adam/update_optimizer//dense/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_1/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_1/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_2/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_2/kernel/ApplyAdam8^optimizer/Adam/update_optimizer//dense_3/bias/ApplyAdam:^optimizer/Adam/update_optimizer//dense_3/kernel/ApplyAdam
K
optimizer/PlaceholderPlaceholder*
dtype0*
shape:���������
M
optimizer/Placeholder_1Placeholder*
dtype0*
shape:���������
K
optimizer/ExpandDims/dimConst*
dtype0*
valueB :
���������
h
optimizer/ExpandDims
ExpandDimsoptimizer/Placeholderoptimizer/ExpandDims/dim*
T0*

Tdim0
M
optimizer/ExpandDims_1/dimConst*
dtype0*
valueB :
���������
n
optimizer/ExpandDims_1
ExpandDimsoptimizer/Placeholder_1optimizer/ExpandDims_1/dim*
T0*

Tdim0
Q
optimizer/Placeholder_2Placeholder*
dtype0*
shape:���������
@
optimizer/IdentityIdentityoptimizer/Placeholder_2*
T0
[
!optimizer/gail_vector_observationPlaceholder*
dtype0*
shape:���������
S
optimizer/subSub!optimizer/gail_vector_observationrunning_mean/read*
T0
X
optimizer/CastCastnormalization_steps/read*

DstT0*

SrcT0*
Truncate( 
>
optimizer/add_1/yConst*
dtype0*
valueB
 *  �?
D
optimizer/add_1AddV2optimizer/Castoptimizer/add_1/y*
T0
M
optimizer/truedivRealDivrunning_variance/readoptimizer/add_1*
T0
2
optimizer/SqrtSqrtoptimizer/truediv*
T0
F
optimizer/truediv_1RealDivoptimizer/suboptimizer/Sqrt*
T0
Q
$optimizer/normalized_state/Minimum/yConst*
dtype0*
valueB
 *  �@
q
"optimizer/normalized_state/MinimumMinimumoptimizer/truediv_1$optimizer/normalized_state/Minimum/y*
T0
I
optimizer/normalized_state/yConst*
dtype0*
valueB
 *  ��
p
optimizer/normalized_stateMaximum"optimizer/normalized_state/Minimumoptimizer/normalized_state/y*
T0
G
optimizer/concat_4/concat_dimConst*
dtype0*
value	B :
J
optimizer/concat_4/concatIdentityoptimizer/normalized_state*
T0
G
optimizer/concat_5/concat_dimConst*
dtype0*
value	B :
@
optimizer/concat_5/concatIdentitynormalized_state*
T0
�
Moptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/shapeConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
valueB"   �   
�
Koptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/minConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
valueB
 *AW�
�
Koptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/maxConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
valueB
 *AW>
�
Uoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/RandomUniformRandomUniformMoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/shape*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
seed�'*
seed2

�
Koptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/subSubKoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/maxKoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/min*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel
�
Koptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/mulMulUoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/RandomUniformKoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/sub*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel
�
Goptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniformAddKoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/mulKoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform/min*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel
�
,optimizer//GAIL_model/gail_d_hidden_1/kernel
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
3optimizer//GAIL_model/gail_d_hidden_1/kernel/AssignAssign,optimizer//GAIL_model/gail_d_hidden_1/kernelGoptimizer//GAIL_model/gail_d_hidden_1/kernel/Initializer/random_uniform*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
use_locking(*
validate_shape(
�
1optimizer//GAIL_model/gail_d_hidden_1/kernel/readIdentity,optimizer//GAIL_model/gail_d_hidden_1/kernel*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel
�
<optimizer//GAIL_model/gail_d_hidden_1/bias/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
dtype0*
valueB�*    
�
*optimizer//GAIL_model/gail_d_hidden_1/bias
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
1optimizer//GAIL_model/gail_d_hidden_1/bias/AssignAssign*optimizer//GAIL_model/gail_d_hidden_1/bias<optimizer//GAIL_model/gail_d_hidden_1/bias/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
use_locking(*
validate_shape(
�
/optimizer//GAIL_model/gail_d_hidden_1/bias/readIdentity*optimizer//GAIL_model/gail_d_hidden_1/bias*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias
�
+optimizer/GAIL_model/gail_d_hidden_1/MatMulMatMuloptimizer/concat_4/concat1optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
,optimizer/GAIL_model/gail_d_hidden_1/BiasAddBiasAdd+optimizer/GAIL_model/gail_d_hidden_1/MatMul/optimizer//GAIL_model/gail_d_hidden_1/bias/read*
T0*
data_formatNHWC
n
,optimizer/GAIL_model/gail_d_hidden_1/SigmoidSigmoid,optimizer/GAIL_model/gail_d_hidden_1/BiasAdd*
T0
�
(optimizer/GAIL_model/gail_d_hidden_1/MulMul,optimizer/GAIL_model/gail_d_hidden_1/BiasAdd,optimizer/GAIL_model/gail_d_hidden_1/Sigmoid*
T0
�
Moptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/shapeConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
valueB"�   �   
�
Koptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/minConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
valueB
 *q��
�
Koptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/maxConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
valueB
 *q�>
�
Uoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/RandomUniformRandomUniformMoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/shape*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
seed�'*
seed2
�
Koptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/subSubKoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/maxKoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/min*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel
�
Koptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/mulMulUoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/RandomUniformKoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/sub*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel
�
Goptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniformAddKoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/mulKoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform/min*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel
�
,optimizer//GAIL_model/gail_d_hidden_2/kernel
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
3optimizer//GAIL_model/gail_d_hidden_2/kernel/AssignAssign,optimizer//GAIL_model/gail_d_hidden_2/kernelGoptimizer//GAIL_model/gail_d_hidden_2/kernel/Initializer/random_uniform*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
use_locking(*
validate_shape(
�
1optimizer//GAIL_model/gail_d_hidden_2/kernel/readIdentity,optimizer//GAIL_model/gail_d_hidden_2/kernel*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel
�
<optimizer//GAIL_model/gail_d_hidden_2/bias/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
dtype0*
valueB�*    
�
*optimizer//GAIL_model/gail_d_hidden_2/bias
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
	container *
dtype0*
shape:�*
shared_name 
�
1optimizer//GAIL_model/gail_d_hidden_2/bias/AssignAssign*optimizer//GAIL_model/gail_d_hidden_2/bias<optimizer//GAIL_model/gail_d_hidden_2/bias/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
use_locking(*
validate_shape(
�
/optimizer//GAIL_model/gail_d_hidden_2/bias/readIdentity*optimizer//GAIL_model/gail_d_hidden_2/bias*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias
�
+optimizer/GAIL_model/gail_d_hidden_2/MatMulMatMul(optimizer/GAIL_model/gail_d_hidden_1/Mul1optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
,optimizer/GAIL_model/gail_d_hidden_2/BiasAddBiasAdd+optimizer/GAIL_model/gail_d_hidden_2/MatMul/optimizer//GAIL_model/gail_d_hidden_2/bias/read*
T0*
data_formatNHWC
n
,optimizer/GAIL_model/gail_d_hidden_2/SigmoidSigmoid,optimizer/GAIL_model/gail_d_hidden_2/BiasAdd*
T0
�
(optimizer/GAIL_model/gail_d_hidden_2/MulMul,optimizer/GAIL_model/gail_d_hidden_2/BiasAdd,optimizer/GAIL_model/gail_d_hidden_2/Sigmoid*
T0
�
Moptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/shapeConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
dtype0*
valueB"�      
�
Koptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/minConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
dtype0*
valueB
 *n�\�
�
Koptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/maxConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
dtype0*
valueB
 *n�\>
�
Uoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/RandomUniformRandomUniformMoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/shape*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
dtype0*
seed�'*
seed2
�
Koptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/subSubKoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/maxKoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/min*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel
�
Koptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/mulMulUoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/RandomUniformKoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/sub*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel
�
Goptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniformAddKoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/mulKoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform/min*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel
�
,optimizer//GAIL_model/gail_d_estimate/kernel
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
3optimizer//GAIL_model/gail_d_estimate/kernel/AssignAssign,optimizer//GAIL_model/gail_d_estimate/kernelGoptimizer//GAIL_model/gail_d_estimate/kernel/Initializer/random_uniform*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
use_locking(*
validate_shape(
�
1optimizer//GAIL_model/gail_d_estimate/kernel/readIdentity,optimizer//GAIL_model/gail_d_estimate/kernel*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel
�
<optimizer//GAIL_model/gail_d_estimate/bias/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
dtype0*
valueB*    
�
*optimizer//GAIL_model/gail_d_estimate/bias
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
	container *
dtype0*
shape:*
shared_name 
�
1optimizer//GAIL_model/gail_d_estimate/bias/AssignAssign*optimizer//GAIL_model/gail_d_estimate/bias<optimizer//GAIL_model/gail_d_estimate/bias/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
/optimizer//GAIL_model/gail_d_estimate/bias/readIdentity*optimizer//GAIL_model/gail_d_estimate/bias*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias
�
+optimizer/GAIL_model/gail_d_estimate/MatMulMatMul(optimizer/GAIL_model/gail_d_hidden_2/Mul1optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
,optimizer/GAIL_model/gail_d_estimate/BiasAddBiasAdd+optimizer/GAIL_model/gail_d_estimate/MatMul/optimizer//GAIL_model/gail_d_estimate/bias/read*
T0*
data_formatNHWC
n
,optimizer/GAIL_model/gail_d_estimate/SigmoidSigmoid,optimizer/GAIL_model/gail_d_estimate/BiasAdd*
T0
�
-optimizer/GAIL_model_1/gail_d_hidden_1/MatMulMatMuloptimizer/concat_5/concat1optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
.optimizer/GAIL_model_1/gail_d_hidden_1/BiasAddBiasAdd-optimizer/GAIL_model_1/gail_d_hidden_1/MatMul/optimizer//GAIL_model/gail_d_hidden_1/bias/read*
T0*
data_formatNHWC
r
.optimizer/GAIL_model_1/gail_d_hidden_1/SigmoidSigmoid.optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd*
T0
�
*optimizer/GAIL_model_1/gail_d_hidden_1/MulMul.optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd.optimizer/GAIL_model_1/gail_d_hidden_1/Sigmoid*
T0
�
-optimizer/GAIL_model_1/gail_d_hidden_2/MatMulMatMul*optimizer/GAIL_model_1/gail_d_hidden_1/Mul1optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
.optimizer/GAIL_model_1/gail_d_hidden_2/BiasAddBiasAdd-optimizer/GAIL_model_1/gail_d_hidden_2/MatMul/optimizer//GAIL_model/gail_d_hidden_2/bias/read*
T0*
data_formatNHWC
r
.optimizer/GAIL_model_1/gail_d_hidden_2/SigmoidSigmoid.optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd*
T0
�
*optimizer/GAIL_model_1/gail_d_hidden_2/MulMul.optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd.optimizer/GAIL_model_1/gail_d_hidden_2/Sigmoid*
T0
�
-optimizer/GAIL_model_1/gail_d_estimate/MatMulMatMul*optimizer/GAIL_model_1/gail_d_hidden_2/Mul1optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
.optimizer/GAIL_model_1/gail_d_estimate/BiasAddBiasAdd-optimizer/GAIL_model_1/gail_d_estimate/MatMul/optimizer//GAIL_model/gail_d_estimate/bias/read*
T0*
data_formatNHWC
r
.optimizer/GAIL_model_1/gail_d_estimate/SigmoidSigmoid.optimizer/GAIL_model_1/gail_d_estimate/BiasAdd*
T0
F
optimizer/Const_2Const*
dtype0*
valueB"       
�
optimizer/Mean_2Mean.optimizer/GAIL_model_1/gail_d_estimate/Sigmoidoptimizer/Const_2*
T0*

Tidx0*
	keep_dims( 
F
optimizer/Const_3Const*
dtype0*
valueB"       

optimizer/Mean_3Mean,optimizer/GAIL_model/gail_d_estimate/Sigmoidoptimizer/Const_3*
T0*

Tidx0*
	keep_dims( 
R
optimizer/gail_reward/shapeConst*
dtype0*
valueB:
���������
�
optimizer/gail_rewardReshape.optimizer/GAIL_model_1/gail_d_estimate/Sigmoidoptimizer/gail_reward/shape*
T0*
Tshape0
>
optimizer/sub_1/xConst*
dtype0*
valueB
 *  �?
I
optimizer/sub_1Suboptimizer/sub_1/xoptimizer/gail_reward*
T0
>
optimizer/add_2/yConst*
dtype0*
valueB
 *���3
E
optimizer/add_2AddV2optimizer/sub_1optimizer/add_2/y*
T0
.
optimizer/LogLogoptimizer/add_2*
T0
,
optimizer/NegNegoptimizer/Log*
T0
F
optimizer/Const_4Const*
dtype0*
valueB"       

optimizer/Mean_4Mean,optimizer/GAIL_model/gail_d_estimate/Sigmoidoptimizer/Const_4*
T0*

Tidx0*
	keep_dims( 
F
optimizer/Const_5Const*
dtype0*
valueB"       
�
optimizer/Mean_5Mean.optimizer/GAIL_model_1/gail_d_estimate/Sigmoidoptimizer/Const_5*
T0*

Tidx0*
	keep_dims( 
>
optimizer/add_3/yConst*
dtype0*
valueB
 *���3
b
optimizer/add_3AddV2,optimizer/GAIL_model/gail_d_estimate/Sigmoidoptimizer/add_3/y*
T0
0
optimizer/Log_1Logoptimizer/add_3*
T0
>
optimizer/sub_2/xConst*
dtype0*
valueB
 *  �?
b
optimizer/sub_2Suboptimizer/sub_2/x.optimizer/GAIL_model_1/gail_d_estimate/Sigmoid*
T0
>
optimizer/add_4/yConst*
dtype0*
valueB
 *���3
E
optimizer/add_4AddV2optimizer/sub_2optimizer/add_4/y*
T0
0
optimizer/Log_2Logoptimizer/add_4*
T0
C
optimizer/add_5AddV2optimizer/Log_1optimizer/Log_2*
T0
F
optimizer/Const_6Const*
dtype0*
valueB"       
b
optimizer/Mean_6Meanoptimizer/add_5optimizer/Const_6*
T0*

Tidx0*
	keep_dims( 
1
optimizer/Neg_1Negoptimizer/Mean_6*
T0
L
optimizer/ShapeShapeoptimizer/concat_4/concat*
T0*
out_type0
x
&optimizer/random_uniform/RandomUniformRandomUniformoptimizer/Shape*
T0*
dtype0*
seed�'*
seed2
b
optimizer/mul_4Mul&optimizer/random_uniform/RandomUniformoptimizer/concat_4/concat*
T0
>
optimizer/sub_3/xConst*
dtype0*
valueB
 *  �?
Z
optimizer/sub_3Suboptimizer/sub_3/x&optimizer/random_uniform/RandomUniform*
T0
K
optimizer/mul_5Muloptimizer/sub_3optimizer/concat_5/concat*
T0
C
optimizer/add_6AddV2optimizer/mul_4optimizer/mul_5*
T0
G
optimizer/Shape_1Shapeoptimizer/Identity*
T0*
out_type0
|
(optimizer/random_uniform_1/RandomUniformRandomUniformoptimizer/Shape_1*
T0*
dtype0*
seed�'*
seed2
]
optimizer/mul_6Mul(optimizer/random_uniform_1/RandomUniformoptimizer/Identity*
T0
>
optimizer/sub_4/xConst*
dtype0*
valueB
 *  �?
\
optimizer/sub_4Suboptimizer/sub_4/x(optimizer/random_uniform_1/RandomUniform*
T0
>
optimizer/mul_7Muloptimizer/sub_4StopGradient*
T0
C
optimizer/add_7AddV2optimizer/mul_6optimizer/mul_7*
T0
I
optimizer/Shape_2Shapeoptimizer/ExpandDims*
T0*
out_type0
|
(optimizer/random_uniform_2/RandomUniformRandomUniformoptimizer/Shape_2*
T0*
dtype0*
seed�'*
seed2
_
optimizer/mul_8Mul(optimizer/random_uniform_2/RandomUniformoptimizer/ExpandDims*
T0
>
optimizer/sub_5/xConst*
dtype0*
valueB
 *  �?
\
optimizer/sub_5Suboptimizer/sub_5/x(optimizer/random_uniform_2/RandomUniform*
T0
H
optimizer/mul_9Muloptimizer/sub_5optimizer/ExpandDims_1*
T0
C
optimizer/add_8AddV2optimizer/mul_8optimizer/mul_9*
T0
�
-optimizer/GAIL_model_2/gail_d_hidden_1/MatMulMatMuloptimizer/add_61optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAddBiasAdd-optimizer/GAIL_model_2/gail_d_hidden_1/MatMul/optimizer//GAIL_model/gail_d_hidden_1/bias/read*
T0*
data_formatNHWC
r
.optimizer/GAIL_model_2/gail_d_hidden_1/SigmoidSigmoid.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd*
T0
�
*optimizer/GAIL_model_2/gail_d_hidden_1/MulMul.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0
�
-optimizer/GAIL_model_2/gail_d_hidden_2/MatMulMatMul*optimizer/GAIL_model_2/gail_d_hidden_1/Mul1optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAddBiasAdd-optimizer/GAIL_model_2/gail_d_hidden_2/MatMul/optimizer//GAIL_model/gail_d_hidden_2/bias/read*
T0*
data_formatNHWC
r
.optimizer/GAIL_model_2/gail_d_hidden_2/SigmoidSigmoid.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd*
T0
�
*optimizer/GAIL_model_2/gail_d_hidden_2/MulMul.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0
�
-optimizer/GAIL_model_2/gail_d_estimate/MatMulMatMul*optimizer/GAIL_model_2/gail_d_hidden_2/Mul1optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
.optimizer/GAIL_model_2/gail_d_estimate/BiasAddBiasAdd-optimizer/GAIL_model_2/gail_d_estimate/MatMul/optimizer//GAIL_model/gail_d_estimate/bias/read*
T0*
data_formatNHWC
r
.optimizer/GAIL_model_2/gail_d_estimate/SigmoidSigmoid.optimizer/GAIL_model_2/gail_d_estimate/BiasAdd*
T0
m
optimizer/gradients_1/ShapeShape.optimizer/GAIL_model_2/gail_d_estimate/Sigmoid*
T0*
out_type0
L
optimizer/gradients_1/grad_ys_0Const*
dtype0*
valueB
 *  �?
{
optimizer/gradients_1/FillFilloptimizer/gradients_1/Shapeoptimizer/gradients_1/grad_ys_0*
T0*

index_type0
�
Uoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_estimate/Sigmoidoptimizer/gradients_1/Fill*
T0
�
Uoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/BiasAddGradBiasAddGradUoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad*
T0*
data_formatNHWC
�
Ooptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMulMatMulUoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad1optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_1MatMul*optimizer/GAIL_model_2/gail_d_hidden_2/MulUoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad*
T0*
transpose_a(*
transpose_b( 
�
Koptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ShapeShape.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd*
T0*
out_type0
�
Moptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape_1Shape.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0*
out_type0
�
[optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ShapeMoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape_1*
T0
�
Ioptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/MulMulOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0
�
Ioptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/SumSumIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul[optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ReshapeReshapeIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/SumKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape*
T0*
Tshape0
�
Koptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1Mul.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAddOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul*
T0
�
Koptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1SumKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1]optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ooptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1ReshapeKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1Moptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape_1*
T0*
Tshape0
�
Uoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_hidden_2/SigmoidOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1*
T0
�
optimizer/gradients_1/AddNAddNMoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ReshapeUoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad*
N*
T0*`
_classV
TRloc:@optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape
�
Uoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_1/AddN*
T0*
data_formatNHWC
�
Ooptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMulMatMuloptimizer/gradients_1/AddN1optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_1MatMul*optimizer/GAIL_model_2/gail_d_hidden_1/Muloptimizer/gradients_1/AddN*
T0*
transpose_a(*
transpose_b( 
�
Koptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ShapeShape.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd*
T0*
out_type0
�
Moptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape_1Shape.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0*
out_type0
�
[optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ShapeMoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape_1*
T0
�
Ioptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/MulMulOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0
�
Ioptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/SumSumIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul[optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ReshapeReshapeIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/SumKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Koptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1Mul.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAddOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul*
T0
�
Koptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1SumKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1]optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ooptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1ReshapeKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1Moptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Uoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_hidden_1/SigmoidOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1*
T0
�
optimizer/gradients_1/AddN_1AddNMoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ReshapeUoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*`
_classV
TRloc:@optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape
�
Uoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_1/AddN_1*
T0*
data_formatNHWC
�
Ooptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMulMatMuloptimizer/gradients_1/AddN_11optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_1MatMuloptimizer/add_6optimizer/gradients_1/AddN_1*
T0*
transpose_a(*
transpose_b( 
<
optimizer/pow/yConst*
dtype0*
valueB
 *   @

optimizer/powPowOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMuloptimizer/pow/y*
T0
T
!optimizer/Sum_2/reduction_indicesConst*
dtype0*
valueB :
���������
n
optimizer/Sum_2Sumoptimizer/pow!optimizer/Sum_2/reduction_indices*
T0*

Tidx0*
	keep_dims( 
>
optimizer/add_9/yConst*
dtype0*
valueB
 *���3
E
optimizer/add_9AddV2optimizer/Sum_2optimizer/add_9/y*
T0
2
optimizer/Sqrt_1Sqrtoptimizer/add_9*
T0
>
optimizer/sub_6/yConst*
dtype0*
valueB
 *  �?
D
optimizer/sub_6Suboptimizer/Sqrt_1optimizer/sub_6/y*
T0
>
optimizer/Pow_1/yConst*
dtype0*
valueB
 *   @
C
optimizer/Pow_1Powoptimizer/sub_6optimizer/Pow_1/y*
T0
?
optimizer/Const_7Const*
dtype0*
valueB: 
b
optimizer/Mean_7Meanoptimizer/Pow_1optimizer/Const_7*
T0*

Tidx0*
	keep_dims( 
?
optimizer/mul_10/xConst*
dtype0*
valueB
 *   A
F
optimizer/mul_10Muloptimizer/mul_10/xoptimizer/Mean_7*
T0
E
optimizer/add_10AddV2optimizer/Neg_1optimizer/mul_10*
T0
D
optimizer/gradients_2/ShapeConst*
dtype0*
valueB 
L
optimizer/gradients_2/grad_ys_0Const*
dtype0*
valueB
 *  �?
{
optimizer/gradients_2/FillFilloptimizer/gradients_2/Shapeoptimizer/gradients_2/grad_ys_0*
T0*

index_type0
a
<optimizer/gradients_2/optimizer/add_10_grad/tuple/group_depsNoOp^optimizer/gradients_2/Fill
�
Doptimizer/gradients_2/optimizer/add_10_grad/tuple/control_dependencyIdentityoptimizer/gradients_2/Fill=^optimizer/gradients_2/optimizer/add_10_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_2/Fill
�
Foptimizer/gradients_2/optimizer/add_10_grad/tuple/control_dependency_1Identityoptimizer/gradients_2/Fill=^optimizer/gradients_2/optimizer/add_10_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_2/Fill
�
.optimizer/gradients_2/optimizer/Neg_1_grad/NegNegDoptimizer/gradients_2/optimizer/add_10_grad/tuple/control_dependency*
T0
�
/optimizer/gradients_2/optimizer/mul_10_grad/MulMulFoptimizer/gradients_2/optimizer/add_10_grad/tuple/control_dependency_1optimizer/Mean_7*
T0
�
1optimizer/gradients_2/optimizer/mul_10_grad/Mul_1MulFoptimizer/gradients_2/optimizer/add_10_grad/tuple/control_dependency_1optimizer/mul_10/x*
T0
�
<optimizer/gradients_2/optimizer/mul_10_grad/tuple/group_depsNoOp0^optimizer/gradients_2/optimizer/mul_10_grad/Mul2^optimizer/gradients_2/optimizer/mul_10_grad/Mul_1
�
Doptimizer/gradients_2/optimizer/mul_10_grad/tuple/control_dependencyIdentity/optimizer/gradients_2/optimizer/mul_10_grad/Mul=^optimizer/gradients_2/optimizer/mul_10_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_2/optimizer/mul_10_grad/Mul
�
Foptimizer/gradients_2/optimizer/mul_10_grad/tuple/control_dependency_1Identity1optimizer/gradients_2/optimizer/mul_10_grad/Mul_1=^optimizer/gradients_2/optimizer/mul_10_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_2/optimizer/mul_10_grad/Mul_1
n
9optimizer/gradients_2/optimizer/Mean_6_grad/Reshape/shapeConst*
dtype0*
valueB"      
�
3optimizer/gradients_2/optimizer/Mean_6_grad/ReshapeReshape.optimizer/gradients_2/optimizer/Neg_1_grad/Neg9optimizer/gradients_2/optimizer/Mean_6_grad/Reshape/shape*
T0*
Tshape0
d
1optimizer/gradients_2/optimizer/Mean_6_grad/ShapeShapeoptimizer/add_5*
T0*
out_type0
�
0optimizer/gradients_2/optimizer/Mean_6_grad/TileTile3optimizer/gradients_2/optimizer/Mean_6_grad/Reshape1optimizer/gradients_2/optimizer/Mean_6_grad/Shape*
T0*

Tmultiples0
f
3optimizer/gradients_2/optimizer/Mean_6_grad/Shape_1Shapeoptimizer/add_5*
T0*
out_type0
\
3optimizer/gradients_2/optimizer/Mean_6_grad/Shape_2Const*
dtype0*
valueB 
_
1optimizer/gradients_2/optimizer/Mean_6_grad/ConstConst*
dtype0*
valueB: 
�
0optimizer/gradients_2/optimizer/Mean_6_grad/ProdProd3optimizer/gradients_2/optimizer/Mean_6_grad/Shape_11optimizer/gradients_2/optimizer/Mean_6_grad/Const*
T0*

Tidx0*
	keep_dims( 
a
3optimizer/gradients_2/optimizer/Mean_6_grad/Const_1Const*
dtype0*
valueB: 
�
2optimizer/gradients_2/optimizer/Mean_6_grad/Prod_1Prod3optimizer/gradients_2/optimizer/Mean_6_grad/Shape_23optimizer/gradients_2/optimizer/Mean_6_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
_
5optimizer/gradients_2/optimizer/Mean_6_grad/Maximum/yConst*
dtype0*
value	B :
�
3optimizer/gradients_2/optimizer/Mean_6_grad/MaximumMaximum2optimizer/gradients_2/optimizer/Mean_6_grad/Prod_15optimizer/gradients_2/optimizer/Mean_6_grad/Maximum/y*
T0
�
4optimizer/gradients_2/optimizer/Mean_6_grad/floordivFloorDiv0optimizer/gradients_2/optimizer/Mean_6_grad/Prod3optimizer/gradients_2/optimizer/Mean_6_grad/Maximum*
T0
�
0optimizer/gradients_2/optimizer/Mean_6_grad/CastCast4optimizer/gradients_2/optimizer/Mean_6_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
3optimizer/gradients_2/optimizer/Mean_6_grad/truedivRealDiv0optimizer/gradients_2/optimizer/Mean_6_grad/Tile0optimizer/gradients_2/optimizer/Mean_6_grad/Cast*
T0
g
9optimizer/gradients_2/optimizer/Mean_7_grad/Reshape/shapeConst*
dtype0*
valueB:
�
3optimizer/gradients_2/optimizer/Mean_7_grad/ReshapeReshapeFoptimizer/gradients_2/optimizer/mul_10_grad/tuple/control_dependency_19optimizer/gradients_2/optimizer/Mean_7_grad/Reshape/shape*
T0*
Tshape0
d
1optimizer/gradients_2/optimizer/Mean_7_grad/ShapeShapeoptimizer/Pow_1*
T0*
out_type0
�
0optimizer/gradients_2/optimizer/Mean_7_grad/TileTile3optimizer/gradients_2/optimizer/Mean_7_grad/Reshape1optimizer/gradients_2/optimizer/Mean_7_grad/Shape*
T0*

Tmultiples0
f
3optimizer/gradients_2/optimizer/Mean_7_grad/Shape_1Shapeoptimizer/Pow_1*
T0*
out_type0
\
3optimizer/gradients_2/optimizer/Mean_7_grad/Shape_2Const*
dtype0*
valueB 
_
1optimizer/gradients_2/optimizer/Mean_7_grad/ConstConst*
dtype0*
valueB: 
�
0optimizer/gradients_2/optimizer/Mean_7_grad/ProdProd3optimizer/gradients_2/optimizer/Mean_7_grad/Shape_11optimizer/gradients_2/optimizer/Mean_7_grad/Const*
T0*

Tidx0*
	keep_dims( 
a
3optimizer/gradients_2/optimizer/Mean_7_grad/Const_1Const*
dtype0*
valueB: 
�
2optimizer/gradients_2/optimizer/Mean_7_grad/Prod_1Prod3optimizer/gradients_2/optimizer/Mean_7_grad/Shape_23optimizer/gradients_2/optimizer/Mean_7_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
_
5optimizer/gradients_2/optimizer/Mean_7_grad/Maximum/yConst*
dtype0*
value	B :
�
3optimizer/gradients_2/optimizer/Mean_7_grad/MaximumMaximum2optimizer/gradients_2/optimizer/Mean_7_grad/Prod_15optimizer/gradients_2/optimizer/Mean_7_grad/Maximum/y*
T0
�
4optimizer/gradients_2/optimizer/Mean_7_grad/floordivFloorDiv0optimizer/gradients_2/optimizer/Mean_7_grad/Prod3optimizer/gradients_2/optimizer/Mean_7_grad/Maximum*
T0
�
0optimizer/gradients_2/optimizer/Mean_7_grad/CastCast4optimizer/gradients_2/optimizer/Mean_7_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
3optimizer/gradients_2/optimizer/Mean_7_grad/truedivRealDiv0optimizer/gradients_2/optimizer/Mean_7_grad/Tile0optimizer/gradients_2/optimizer/Mean_7_grad/Cast*
T0
c
0optimizer/gradients_2/optimizer/add_5_grad/ShapeShapeoptimizer/Log_1*
T0*
out_type0
e
2optimizer/gradients_2/optimizer/add_5_grad/Shape_1Shapeoptimizer/Log_2*
T0*
out_type0
�
@optimizer/gradients_2/optimizer/add_5_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_2/optimizer/add_5_grad/Shape2optimizer/gradients_2/optimizer/add_5_grad/Shape_1*
T0
�
.optimizer/gradients_2/optimizer/add_5_grad/SumSum3optimizer/gradients_2/optimizer/Mean_6_grad/truediv@optimizer/gradients_2/optimizer/add_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/add_5_grad/ReshapeReshape.optimizer/gradients_2/optimizer/add_5_grad/Sum0optimizer/gradients_2/optimizer/add_5_grad/Shape*
T0*
Tshape0
�
0optimizer/gradients_2/optimizer/add_5_grad/Sum_1Sum3optimizer/gradients_2/optimizer/Mean_6_grad/truedivBoptimizer/gradients_2/optimizer/add_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_2/optimizer/add_5_grad/Reshape_1Reshape0optimizer/gradients_2/optimizer/add_5_grad/Sum_12optimizer/gradients_2/optimizer/add_5_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_2/optimizer/add_5_grad/tuple/group_depsNoOp3^optimizer/gradients_2/optimizer/add_5_grad/Reshape5^optimizer/gradients_2/optimizer/add_5_grad/Reshape_1
�
Coptimizer/gradients_2/optimizer/add_5_grad/tuple/control_dependencyIdentity2optimizer/gradients_2/optimizer/add_5_grad/Reshape<^optimizer/gradients_2/optimizer/add_5_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/add_5_grad/Reshape
�
Eoptimizer/gradients_2/optimizer/add_5_grad/tuple/control_dependency_1Identity4optimizer/gradients_2/optimizer/add_5_grad/Reshape_1<^optimizer/gradients_2/optimizer/add_5_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_2/optimizer/add_5_grad/Reshape_1
c
0optimizer/gradients_2/optimizer/Pow_1_grad/ShapeShapeoptimizer/sub_6*
T0*
out_type0
g
2optimizer/gradients_2/optimizer/Pow_1_grad/Shape_1Shapeoptimizer/Pow_1/y*
T0*
out_type0
�
@optimizer/gradients_2/optimizer/Pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_2/optimizer/Pow_1_grad/Shape2optimizer/gradients_2/optimizer/Pow_1_grad/Shape_1*
T0
�
.optimizer/gradients_2/optimizer/Pow_1_grad/mulMul3optimizer/gradients_2/optimizer/Mean_7_grad/truedivoptimizer/Pow_1/y*
T0
]
0optimizer/gradients_2/optimizer/Pow_1_grad/sub/yConst*
dtype0*
valueB
 *  �?
�
.optimizer/gradients_2/optimizer/Pow_1_grad/subSuboptimizer/Pow_1/y0optimizer/gradients_2/optimizer/Pow_1_grad/sub/y*
T0

.optimizer/gradients_2/optimizer/Pow_1_grad/PowPowoptimizer/sub_6.optimizer/gradients_2/optimizer/Pow_1_grad/sub*
T0
�
0optimizer/gradients_2/optimizer/Pow_1_grad/mul_1Mul.optimizer/gradients_2/optimizer/Pow_1_grad/mul.optimizer/gradients_2/optimizer/Pow_1_grad/Pow*
T0
�
.optimizer/gradients_2/optimizer/Pow_1_grad/SumSum0optimizer/gradients_2/optimizer/Pow_1_grad/mul_1@optimizer/gradients_2/optimizer/Pow_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/Pow_1_grad/ReshapeReshape.optimizer/gradients_2/optimizer/Pow_1_grad/Sum0optimizer/gradients_2/optimizer/Pow_1_grad/Shape*
T0*
Tshape0
a
4optimizer/gradients_2/optimizer/Pow_1_grad/Greater/yConst*
dtype0*
valueB
 *    
�
2optimizer/gradients_2/optimizer/Pow_1_grad/GreaterGreateroptimizer/sub_64optimizer/gradients_2/optimizer/Pow_1_grad/Greater/y*
T0
m
:optimizer/gradients_2/optimizer/Pow_1_grad/ones_like/ShapeShapeoptimizer/sub_6*
T0*
out_type0
g
:optimizer/gradients_2/optimizer/Pow_1_grad/ones_like/ConstConst*
dtype0*
valueB
 *  �?
�
4optimizer/gradients_2/optimizer/Pow_1_grad/ones_likeFill:optimizer/gradients_2/optimizer/Pow_1_grad/ones_like/Shape:optimizer/gradients_2/optimizer/Pow_1_grad/ones_like/Const*
T0*

index_type0
�
1optimizer/gradients_2/optimizer/Pow_1_grad/SelectSelect2optimizer/gradients_2/optimizer/Pow_1_grad/Greateroptimizer/sub_64optimizer/gradients_2/optimizer/Pow_1_grad/ones_like*
T0
q
.optimizer/gradients_2/optimizer/Pow_1_grad/LogLog1optimizer/gradients_2/optimizer/Pow_1_grad/Select*
T0
\
5optimizer/gradients_2/optimizer/Pow_1_grad/zeros_like	ZerosLikeoptimizer/sub_6*
T0
�
3optimizer/gradients_2/optimizer/Pow_1_grad/Select_1Select2optimizer/gradients_2/optimizer/Pow_1_grad/Greater.optimizer/gradients_2/optimizer/Pow_1_grad/Log5optimizer/gradients_2/optimizer/Pow_1_grad/zeros_like*
T0
�
0optimizer/gradients_2/optimizer/Pow_1_grad/mul_2Mul3optimizer/gradients_2/optimizer/Mean_7_grad/truedivoptimizer/Pow_1*
T0
�
0optimizer/gradients_2/optimizer/Pow_1_grad/mul_3Mul0optimizer/gradients_2/optimizer/Pow_1_grad/mul_23optimizer/gradients_2/optimizer/Pow_1_grad/Select_1*
T0
�
0optimizer/gradients_2/optimizer/Pow_1_grad/Sum_1Sum0optimizer/gradients_2/optimizer/Pow_1_grad/mul_3Boptimizer/gradients_2/optimizer/Pow_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_2/optimizer/Pow_1_grad/Reshape_1Reshape0optimizer/gradients_2/optimizer/Pow_1_grad/Sum_12optimizer/gradients_2/optimizer/Pow_1_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_2/optimizer/Pow_1_grad/tuple/group_depsNoOp3^optimizer/gradients_2/optimizer/Pow_1_grad/Reshape5^optimizer/gradients_2/optimizer/Pow_1_grad/Reshape_1
�
Coptimizer/gradients_2/optimizer/Pow_1_grad/tuple/control_dependencyIdentity2optimizer/gradients_2/optimizer/Pow_1_grad/Reshape<^optimizer/gradients_2/optimizer/Pow_1_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/Pow_1_grad/Reshape
�
Eoptimizer/gradients_2/optimizer/Pow_1_grad/tuple/control_dependency_1Identity4optimizer/gradients_2/optimizer/Pow_1_grad/Reshape_1<^optimizer/gradients_2/optimizer/Pow_1_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_2/optimizer/Pow_1_grad/Reshape_1
�
5optimizer/gradients_2/optimizer/Log_1_grad/Reciprocal
Reciprocaloptimizer/add_3D^optimizer/gradients_2/optimizer/add_5_grad/tuple/control_dependency*
T0
�
.optimizer/gradients_2/optimizer/Log_1_grad/mulMulCoptimizer/gradients_2/optimizer/add_5_grad/tuple/control_dependency5optimizer/gradients_2/optimizer/Log_1_grad/Reciprocal*
T0
�
5optimizer/gradients_2/optimizer/Log_2_grad/Reciprocal
Reciprocaloptimizer/add_4F^optimizer/gradients_2/optimizer/add_5_grad/tuple/control_dependency_1*
T0
�
.optimizer/gradients_2/optimizer/Log_2_grad/mulMulEoptimizer/gradients_2/optimizer/add_5_grad/tuple/control_dependency_15optimizer/gradients_2/optimizer/Log_2_grad/Reciprocal*
T0
d
0optimizer/gradients_2/optimizer/sub_6_grad/ShapeShapeoptimizer/Sqrt_1*
T0*
out_type0
g
2optimizer/gradients_2/optimizer/sub_6_grad/Shape_1Shapeoptimizer/sub_6/y*
T0*
out_type0
�
@optimizer/gradients_2/optimizer/sub_6_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_2/optimizer/sub_6_grad/Shape2optimizer/gradients_2/optimizer/sub_6_grad/Shape_1*
T0
�
.optimizer/gradients_2/optimizer/sub_6_grad/SumSumCoptimizer/gradients_2/optimizer/Pow_1_grad/tuple/control_dependency@optimizer/gradients_2/optimizer/sub_6_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/sub_6_grad/ReshapeReshape.optimizer/gradients_2/optimizer/sub_6_grad/Sum0optimizer/gradients_2/optimizer/sub_6_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_2/optimizer/sub_6_grad/NegNegCoptimizer/gradients_2/optimizer/Pow_1_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_2/optimizer/sub_6_grad/Sum_1Sum.optimizer/gradients_2/optimizer/sub_6_grad/NegBoptimizer/gradients_2/optimizer/sub_6_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_2/optimizer/sub_6_grad/Reshape_1Reshape0optimizer/gradients_2/optimizer/sub_6_grad/Sum_12optimizer/gradients_2/optimizer/sub_6_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_2/optimizer/sub_6_grad/tuple/group_depsNoOp3^optimizer/gradients_2/optimizer/sub_6_grad/Reshape5^optimizer/gradients_2/optimizer/sub_6_grad/Reshape_1
�
Coptimizer/gradients_2/optimizer/sub_6_grad/tuple/control_dependencyIdentity2optimizer/gradients_2/optimizer/sub_6_grad/Reshape<^optimizer/gradients_2/optimizer/sub_6_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/sub_6_grad/Reshape
�
Eoptimizer/gradients_2/optimizer/sub_6_grad/tuple/control_dependency_1Identity4optimizer/gradients_2/optimizer/sub_6_grad/Reshape_1<^optimizer/gradients_2/optimizer/sub_6_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_2/optimizer/sub_6_grad/Reshape_1
�
0optimizer/gradients_2/optimizer/add_3_grad/ShapeShape,optimizer/GAIL_model/gail_d_estimate/Sigmoid*
T0*
out_type0
g
2optimizer/gradients_2/optimizer/add_3_grad/Shape_1Shapeoptimizer/add_3/y*
T0*
out_type0
�
@optimizer/gradients_2/optimizer/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_2/optimizer/add_3_grad/Shape2optimizer/gradients_2/optimizer/add_3_grad/Shape_1*
T0
�
.optimizer/gradients_2/optimizer/add_3_grad/SumSum.optimizer/gradients_2/optimizer/Log_1_grad/mul@optimizer/gradients_2/optimizer/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/add_3_grad/ReshapeReshape.optimizer/gradients_2/optimizer/add_3_grad/Sum0optimizer/gradients_2/optimizer/add_3_grad/Shape*
T0*
Tshape0
�
0optimizer/gradients_2/optimizer/add_3_grad/Sum_1Sum.optimizer/gradients_2/optimizer/Log_1_grad/mulBoptimizer/gradients_2/optimizer/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_2/optimizer/add_3_grad/Reshape_1Reshape0optimizer/gradients_2/optimizer/add_3_grad/Sum_12optimizer/gradients_2/optimizer/add_3_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_2/optimizer/add_3_grad/tuple/group_depsNoOp3^optimizer/gradients_2/optimizer/add_3_grad/Reshape5^optimizer/gradients_2/optimizer/add_3_grad/Reshape_1
�
Coptimizer/gradients_2/optimizer/add_3_grad/tuple/control_dependencyIdentity2optimizer/gradients_2/optimizer/add_3_grad/Reshape<^optimizer/gradients_2/optimizer/add_3_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/add_3_grad/Reshape
�
Eoptimizer/gradients_2/optimizer/add_3_grad/tuple/control_dependency_1Identity4optimizer/gradients_2/optimizer/add_3_grad/Reshape_1<^optimizer/gradients_2/optimizer/add_3_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_2/optimizer/add_3_grad/Reshape_1
c
0optimizer/gradients_2/optimizer/add_4_grad/ShapeShapeoptimizer/sub_2*
T0*
out_type0
g
2optimizer/gradients_2/optimizer/add_4_grad/Shape_1Shapeoptimizer/add_4/y*
T0*
out_type0
�
@optimizer/gradients_2/optimizer/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_2/optimizer/add_4_grad/Shape2optimizer/gradients_2/optimizer/add_4_grad/Shape_1*
T0
�
.optimizer/gradients_2/optimizer/add_4_grad/SumSum.optimizer/gradients_2/optimizer/Log_2_grad/mul@optimizer/gradients_2/optimizer/add_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/add_4_grad/ReshapeReshape.optimizer/gradients_2/optimizer/add_4_grad/Sum0optimizer/gradients_2/optimizer/add_4_grad/Shape*
T0*
Tshape0
�
0optimizer/gradients_2/optimizer/add_4_grad/Sum_1Sum.optimizer/gradients_2/optimizer/Log_2_grad/mulBoptimizer/gradients_2/optimizer/add_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_2/optimizer/add_4_grad/Reshape_1Reshape0optimizer/gradients_2/optimizer/add_4_grad/Sum_12optimizer/gradients_2/optimizer/add_4_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_2/optimizer/add_4_grad/tuple/group_depsNoOp3^optimizer/gradients_2/optimizer/add_4_grad/Reshape5^optimizer/gradients_2/optimizer/add_4_grad/Reshape_1
�
Coptimizer/gradients_2/optimizer/add_4_grad/tuple/control_dependencyIdentity2optimizer/gradients_2/optimizer/add_4_grad/Reshape<^optimizer/gradients_2/optimizer/add_4_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/add_4_grad/Reshape
�
Eoptimizer/gradients_2/optimizer/add_4_grad/tuple/control_dependency_1Identity4optimizer/gradients_2/optimizer/add_4_grad/Reshape_1<^optimizer/gradients_2/optimizer/add_4_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_2/optimizer/add_4_grad/Reshape_1
�
4optimizer/gradients_2/optimizer/Sqrt_1_grad/SqrtGradSqrtGradoptimizer/Sqrt_1Coptimizer/gradients_2/optimizer/sub_6_grad/tuple/control_dependency*
T0
�
Soptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/Sigmoid_grad/SigmoidGradSigmoidGrad,optimizer/GAIL_model/gail_d_estimate/SigmoidCoptimizer/gradients_2/optimizer/add_3_grad/tuple/control_dependency*
T0
e
0optimizer/gradients_2/optimizer/sub_2_grad/ShapeShapeoptimizer/sub_2/x*
T0*
out_type0
�
2optimizer/gradients_2/optimizer/sub_2_grad/Shape_1Shape.optimizer/GAIL_model_1/gail_d_estimate/Sigmoid*
T0*
out_type0
�
@optimizer/gradients_2/optimizer/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_2/optimizer/sub_2_grad/Shape2optimizer/gradients_2/optimizer/sub_2_grad/Shape_1*
T0
�
.optimizer/gradients_2/optimizer/sub_2_grad/SumSumCoptimizer/gradients_2/optimizer/add_4_grad/tuple/control_dependency@optimizer/gradients_2/optimizer/sub_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/sub_2_grad/ReshapeReshape.optimizer/gradients_2/optimizer/sub_2_grad/Sum0optimizer/gradients_2/optimizer/sub_2_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_2/optimizer/sub_2_grad/NegNegCoptimizer/gradients_2/optimizer/add_4_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_2/optimizer/sub_2_grad/Sum_1Sum.optimizer/gradients_2/optimizer/sub_2_grad/NegBoptimizer/gradients_2/optimizer/sub_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_2/optimizer/sub_2_grad/Reshape_1Reshape0optimizer/gradients_2/optimizer/sub_2_grad/Sum_12optimizer/gradients_2/optimizer/sub_2_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_2/optimizer/sub_2_grad/tuple/group_depsNoOp3^optimizer/gradients_2/optimizer/sub_2_grad/Reshape5^optimizer/gradients_2/optimizer/sub_2_grad/Reshape_1
�
Coptimizer/gradients_2/optimizer/sub_2_grad/tuple/control_dependencyIdentity2optimizer/gradients_2/optimizer/sub_2_grad/Reshape<^optimizer/gradients_2/optimizer/sub_2_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/sub_2_grad/Reshape
�
Eoptimizer/gradients_2/optimizer/sub_2_grad/tuple/control_dependency_1Identity4optimizer/gradients_2/optimizer/sub_2_grad/Reshape_1<^optimizer/gradients_2/optimizer/sub_2_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_2/optimizer/sub_2_grad/Reshape_1
c
0optimizer/gradients_2/optimizer/add_9_grad/ShapeShapeoptimizer/Sum_2*
T0*
out_type0
g
2optimizer/gradients_2/optimizer/add_9_grad/Shape_1Shapeoptimizer/add_9/y*
T0*
out_type0
�
@optimizer/gradients_2/optimizer/add_9_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_2/optimizer/add_9_grad/Shape2optimizer/gradients_2/optimizer/add_9_grad/Shape_1*
T0
�
.optimizer/gradients_2/optimizer/add_9_grad/SumSum4optimizer/gradients_2/optimizer/Sqrt_1_grad/SqrtGrad@optimizer/gradients_2/optimizer/add_9_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/add_9_grad/ReshapeReshape.optimizer/gradients_2/optimizer/add_9_grad/Sum0optimizer/gradients_2/optimizer/add_9_grad/Shape*
T0*
Tshape0
�
0optimizer/gradients_2/optimizer/add_9_grad/Sum_1Sum4optimizer/gradients_2/optimizer/Sqrt_1_grad/SqrtGradBoptimizer/gradients_2/optimizer/add_9_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_2/optimizer/add_9_grad/Reshape_1Reshape0optimizer/gradients_2/optimizer/add_9_grad/Sum_12optimizer/gradients_2/optimizer/add_9_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_2/optimizer/add_9_grad/tuple/group_depsNoOp3^optimizer/gradients_2/optimizer/add_9_grad/Reshape5^optimizer/gradients_2/optimizer/add_9_grad/Reshape_1
�
Coptimizer/gradients_2/optimizer/add_9_grad/tuple/control_dependencyIdentity2optimizer/gradients_2/optimizer/add_9_grad/Reshape<^optimizer/gradients_2/optimizer/add_9_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/add_9_grad/Reshape
�
Eoptimizer/gradients_2/optimizer/add_9_grad/tuple/control_dependency_1Identity4optimizer/gradients_2/optimizer/add_9_grad/Reshape_1<^optimizer/gradients_2/optimizer/add_9_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_2/optimizer/add_9_grad/Reshape_1
�
Soptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/BiasAddGradBiasAddGradSoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/Sigmoid_grad/SigmoidGrad*
T0*
data_formatNHWC
�
Xoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/group_depsNoOpT^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/BiasAddGradT^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/Sigmoid_grad/SigmoidGrad
�
`optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/control_dependencyIdentitySoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/Sigmoid_grad/SigmoidGradY^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/group_deps*
T0*f
_class\
ZXloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/Sigmoid_grad/SigmoidGrad
�
boptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/control_dependency_1IdentitySoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/BiasAddGradY^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/group_deps*
T0*f
_class\
ZXloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_1/gail_d_estimate/SigmoidEoptimizer/gradients_2/optimizer/sub_2_grad/tuple/control_dependency_1*
T0
a
0optimizer/gradients_2/optimizer/Sum_2_grad/ShapeShapeoptimizer/pow*
T0*
out_type0
�
/optimizer/gradients_2/optimizer/Sum_2_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_2/optimizer/Sum_2_grad/addAddV2!optimizer/Sum_2/reduction_indices/optimizer/gradients_2/optimizer/Sum_2_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape
�
.optimizer/gradients_2/optimizer/Sum_2_grad/modFloorMod.optimizer/gradients_2/optimizer/Sum_2_grad/add/optimizer/gradients_2/optimizer/Sum_2_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape
�
2optimizer/gradients_2/optimizer/Sum_2_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_2/optimizer/Sum_2_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_2/optimizer/Sum_2_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_2/optimizer/Sum_2_grad/rangeRange6optimizer/gradients_2/optimizer/Sum_2_grad/range/start/optimizer/gradients_2/optimizer/Sum_2_grad/Size6optimizer/gradients_2/optimizer/Sum_2_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape
�
5optimizer/gradients_2/optimizer/Sum_2_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_2/optimizer/Sum_2_grad/FillFill2optimizer/gradients_2/optimizer/Sum_2_grad/Shape_15optimizer/gradients_2/optimizer/Sum_2_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape*

index_type0
�
8optimizer/gradients_2/optimizer/Sum_2_grad/DynamicStitchDynamicStitch0optimizer/gradients_2/optimizer/Sum_2_grad/range.optimizer/gradients_2/optimizer/Sum_2_grad/mod0optimizer/gradients_2/optimizer/Sum_2_grad/Shape/optimizer/gradients_2/optimizer/Sum_2_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_2/optimizer/Sum_2_grad/Shape
�
2optimizer/gradients_2/optimizer/Sum_2_grad/ReshapeReshapeCoptimizer/gradients_2/optimizer/add_9_grad/tuple/control_dependency8optimizer/gradients_2/optimizer/Sum_2_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_2/optimizer/Sum_2_grad/BroadcastToBroadcastTo2optimizer/gradients_2/optimizer/Sum_2_grad/Reshape0optimizer/gradients_2/optimizer/Sum_2_grad/Shape*
T0*

Tidx0
�
Moptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMulMatMul`optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Ooptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMul_1MatMul(optimizer/GAIL_model/gail_d_hidden_2/Mul`optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Woptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/group_depsNoOpN^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMulP^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMul_1
�
_optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/control_dependencyIdentityMoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMulX^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMul
�
aoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/control_dependency_1IdentityOoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMul_1X^optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMul_1
�
Uoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/BiasAddGradBiasAddGradUoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/Sigmoid_grad/SigmoidGrad*
T0*
data_formatNHWC
�
Zoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/group_depsNoOpV^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/BiasAddGradV^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/Sigmoid_grad/SigmoidGrad
�
boptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/control_dependencyIdentityUoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/Sigmoid_grad/SigmoidGrad[^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/Sigmoid_grad/SigmoidGrad
�
doptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/control_dependency_1IdentityUoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/BiasAddGrad[^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/BiasAddGrad
�
.optimizer/gradients_2/optimizer/pow_grad/ShapeShapeOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul*
T0*
out_type0
c
0optimizer/gradients_2/optimizer/pow_grad/Shape_1Shapeoptimizer/pow/y*
T0*
out_type0
�
>optimizer/gradients_2/optimizer/pow_grad/BroadcastGradientArgsBroadcastGradientArgs.optimizer/gradients_2/optimizer/pow_grad/Shape0optimizer/gradients_2/optimizer/pow_grad/Shape_1*
T0
�
,optimizer/gradients_2/optimizer/pow_grad/mulMul6optimizer/gradients_2/optimizer/Sum_2_grad/BroadcastTooptimizer/pow/y*
T0
[
.optimizer/gradients_2/optimizer/pow_grad/sub/yConst*
dtype0*
valueB
 *  �?
}
,optimizer/gradients_2/optimizer/pow_grad/subSuboptimizer/pow/y.optimizer/gradients_2/optimizer/pow_grad/sub/y*
T0
�
,optimizer/gradients_2/optimizer/pow_grad/PowPowOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul,optimizer/gradients_2/optimizer/pow_grad/sub*
T0
�
.optimizer/gradients_2/optimizer/pow_grad/mul_1Mul,optimizer/gradients_2/optimizer/pow_grad/mul,optimizer/gradients_2/optimizer/pow_grad/Pow*
T0
�
,optimizer/gradients_2/optimizer/pow_grad/SumSum.optimizer/gradients_2/optimizer/pow_grad/mul_1>optimizer/gradients_2/optimizer/pow_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients_2/optimizer/pow_grad/ReshapeReshape,optimizer/gradients_2/optimizer/pow_grad/Sum.optimizer/gradients_2/optimizer/pow_grad/Shape*
T0*
Tshape0
_
2optimizer/gradients_2/optimizer/pow_grad/Greater/yConst*
dtype0*
valueB
 *    
�
0optimizer/gradients_2/optimizer/pow_grad/GreaterGreaterOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul2optimizer/gradients_2/optimizer/pow_grad/Greater/y*
T0
�
8optimizer/gradients_2/optimizer/pow_grad/ones_like/ShapeShapeOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul*
T0*
out_type0
e
8optimizer/gradients_2/optimizer/pow_grad/ones_like/ConstConst*
dtype0*
valueB
 *  �?
�
2optimizer/gradients_2/optimizer/pow_grad/ones_likeFill8optimizer/gradients_2/optimizer/pow_grad/ones_like/Shape8optimizer/gradients_2/optimizer/pow_grad/ones_like/Const*
T0*

index_type0
�
/optimizer/gradients_2/optimizer/pow_grad/SelectSelect0optimizer/gradients_2/optimizer/pow_grad/GreaterOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul2optimizer/gradients_2/optimizer/pow_grad/ones_like*
T0
m
,optimizer/gradients_2/optimizer/pow_grad/LogLog/optimizer/gradients_2/optimizer/pow_grad/Select*
T0
�
3optimizer/gradients_2/optimizer/pow_grad/zeros_like	ZerosLikeOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul*
T0
�
1optimizer/gradients_2/optimizer/pow_grad/Select_1Select0optimizer/gradients_2/optimizer/pow_grad/Greater,optimizer/gradients_2/optimizer/pow_grad/Log3optimizer/gradients_2/optimizer/pow_grad/zeros_like*
T0
�
.optimizer/gradients_2/optimizer/pow_grad/mul_2Mul6optimizer/gradients_2/optimizer/Sum_2_grad/BroadcastTooptimizer/pow*
T0
�
.optimizer/gradients_2/optimizer/pow_grad/mul_3Mul.optimizer/gradients_2/optimizer/pow_grad/mul_21optimizer/gradients_2/optimizer/pow_grad/Select_1*
T0
�
.optimizer/gradients_2/optimizer/pow_grad/Sum_1Sum.optimizer/gradients_2/optimizer/pow_grad/mul_3@optimizer/gradients_2/optimizer/pow_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_2/optimizer/pow_grad/Reshape_1Reshape.optimizer/gradients_2/optimizer/pow_grad/Sum_10optimizer/gradients_2/optimizer/pow_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients_2/optimizer/pow_grad/tuple/group_depsNoOp1^optimizer/gradients_2/optimizer/pow_grad/Reshape3^optimizer/gradients_2/optimizer/pow_grad/Reshape_1
�
Aoptimizer/gradients_2/optimizer/pow_grad/tuple/control_dependencyIdentity0optimizer/gradients_2/optimizer/pow_grad/Reshape:^optimizer/gradients_2/optimizer/pow_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients_2/optimizer/pow_grad/Reshape
�
Coptimizer/gradients_2/optimizer/pow_grad/tuple/control_dependency_1Identity2optimizer/gradients_2/optimizer/pow_grad/Reshape_1:^optimizer/gradients_2/optimizer/pow_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_2/optimizer/pow_grad/Reshape_1
�
Ioptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/ShapeShape,optimizer/GAIL_model/gail_d_hidden_2/BiasAdd*
T0*
out_type0
�
Koptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Shape_1Shape,optimizer/GAIL_model/gail_d_hidden_2/Sigmoid*
T0*
out_type0
�
Yoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/ShapeKoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Shape_1*
T0
�
Goptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/MulMul_optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/control_dependency,optimizer/GAIL_model/gail_d_hidden_2/Sigmoid*
T0
�
Goptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/SumSumGoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/MulYoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Koptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/ReshapeReshapeGoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/SumIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Shape*
T0*
Tshape0
�
Ioptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Mul_1Mul,optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/control_dependency*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Sum_1SumIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Mul_1[optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Reshape_1ReshapeIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Sum_1Koptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Shape_1*
T0*
Tshape0
�
Toptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/tuple/group_depsNoOpL^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/ReshapeN^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Reshape_1
�
\optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/tuple/control_dependencyIdentityKoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/ReshapeU^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Reshape
�
^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/tuple/control_dependency_1IdentityMoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Reshape_1U^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Reshape_1
�
Ooptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMulMatMulboptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMul_1MatMul*optimizer/GAIL_model_1/gail_d_hidden_2/Mulboptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Yoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/group_depsNoOpP^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMulR^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMul_1
�
aoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/control_dependencyIdentityOoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMulZ^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMul
�
coptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/control_dependency_1IdentityQoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMul_1Z^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/group_deps*
T0*d
_classZ
XVloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/MatMul_1
�
qoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMulMatMulAoptimizer/gradients_2/optimizer/pow_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
soptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul_1MatMulAoptimizer/gradients_2/optimizer/pow_grad/tuple/control_dependencyoptimizer/gradients_1/AddN_1*
T0*
transpose_a(*
transpose_b( 
�
{optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/group_depsNoOpr^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMult^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul_1
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/control_dependencyIdentityqoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul|^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/group_deps*
T0*�
_classz
xvloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/control_dependency_1Identitysoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul_1|^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/group_deps*
T0*�
_class|
zxloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul_1
�
Soptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Sigmoid_grad/SigmoidGradSigmoidGrad,optimizer/GAIL_model/gail_d_hidden_2/Sigmoid^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/tuple/control_dependency_1*
T0
�
Koptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/ShapeShape.optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd*
T0*
out_type0
�
Moptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Shape_1Shape.optimizer/GAIL_model_1/gail_d_hidden_2/Sigmoid*
T0*
out_type0
�
[optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/ShapeMoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Shape_1*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/MulMulaoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/control_dependency.optimizer/GAIL_model_1/gail_d_hidden_2/Sigmoid*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/SumSumIoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Mul[optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/ReshapeReshapeIoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/SumKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Shape*
T0*
Tshape0
�
Koptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Mul_1Mul.optimizer/GAIL_model_1/gail_d_hidden_2/BiasAddaoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/control_dependency*
T0
�
Koptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Sum_1SumKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Mul_1]optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ooptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Reshape_1ReshapeKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Sum_1Moptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Shape_1*
T0*
Tshape0
�
Voptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/tuple/group_depsNoOpN^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/ReshapeP^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Reshape_1
�
^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/tuple/control_dependencyIdentityMoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/ReshapeW^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Reshape
�
`optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/tuple/control_dependency_1IdentityOoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Reshape_1W^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Reshape_1
�
Hoptimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/group_depsNoOp�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/control_dependency
�
Poptimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/control_dependencyIdentity�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/control_dependencyI^optimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/group_deps*
T0*�
_classz
xvloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul
�
Roptimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/control_dependency_1Identity�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/control_dependencyI^optimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/group_deps*
T0*�
_classz
xvloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul
�
optimizer/gradients_2/AddNAddN\optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/tuple/control_dependencySoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad*
N*
T0*^
_classT
RPloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Reshape
�
Soptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_2/AddN*
T0*
data_formatNHWC
�
Xoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_2/AddNT^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad
�
`optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_2/AddNY^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/Mul_grad/Reshape
�
boptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency_1IdentitySoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/BiasAddGradY^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/group_deps*
T0*f
_class\
ZXloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_1/gail_d_hidden_2/Sigmoid`optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/tuple/control_dependency_1*
T0
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_grad/ShapeShapeIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum*
T0*
out_type0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_grad/ReshapeReshapePoptimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/control_dependencynoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_grad/Shape*
T0*
Tshape0
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mulMulRoptimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/control_dependency_1Ooptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1*
T0
�
xoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mul_1/xConstS^optimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
voptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mul_1Mulxoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mul_1/xtoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mul*
T0
�
voptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mul_2Mulvoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mul_1.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/subSubtoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mulvoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/mul_2*
T0
�
|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_hidden_1/SigmoidRoptimizer/gradients_2/optimizer/gradients_1/AddN_1_grad/tuple/control_dependency_1*
T0
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/tuple/group_depsNoOp}^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/SigmoidGradu^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/sub
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependencyIdentitytoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/sub�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/tuple/group_deps*
T0*�
_class}
{yloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/sub
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependency_1Identity|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/SigmoidGrad�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/tuple/group_deps*
T0*�
_class�
��loc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/SigmoidGrad
�
Moptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMulMatMul`optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Ooptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMul_1MatMul(optimizer/GAIL_model/gail_d_hidden_1/Mul`optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Woptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/group_depsNoOpN^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMulP^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMul_1
�
_optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/control_dependencyIdentityMoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMulX^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMul
�
aoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/control_dependency_1IdentityOoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMul_1X^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMul_1
�
optimizer/gradients_2/AddN_1AddN^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/tuple/control_dependencyUoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad*
N*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Reshape
�
Uoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_2/AddN_1*
T0*
data_formatNHWC
�
Zoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_2/AddN_1V^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad
�
boptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_2/AddN_1[^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/Mul_grad/Reshape
�
doptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency_1IdentityUoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad[^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/ShapeShapeIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul*
T0*
out_type0
�
ioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/SizeConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape*
dtype0*
value	B :
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/addAddV2[optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgsioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Size*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/modFloorModhoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/addioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Size*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape_1Shapehoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/mod*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape*
out_type0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/range/startConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape*
dtype0*
value	B : 
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/range/deltaConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape*
dtype0*
value	B :
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/rangeRangepoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/range/startioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Sizepoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/range/delta*

Tidx0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape
�
ooptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Fill/valueConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape*
dtype0*
value	B :
�
ioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/FillFillloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape_1ooptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Fill/value*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape*

index_type0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/DynamicStitchDynamicStitchjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/rangehoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/modjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shapeioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Fill*
N*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/ReshapeReshapepoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_grad/Reshaperoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/DynamicStitch*
T0*
Tshape0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/BroadcastToBroadcastToloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Reshapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/Shape*
T0*

Tidx0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1_grad/ShapeShapeKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1*
T0*
out_type0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1_grad/ReshapeReshape�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependency_1poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1_grad/Shape*
T0*
Tshape0
�
Ioptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/ShapeShape,optimizer/GAIL_model/gail_d_hidden_1/BiasAdd*
T0*
out_type0
�
Koptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Shape_1Shape,optimizer/GAIL_model/gail_d_hidden_1/Sigmoid*
T0*
out_type0
�
Yoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/ShapeKoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Shape_1*
T0
�
Goptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/MulMul_optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/control_dependency,optimizer/GAIL_model/gail_d_hidden_1/Sigmoid*
T0
�
Goptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/SumSumGoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/MulYoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Koptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/ReshapeReshapeGoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/SumIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Ioptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Mul_1Mul,optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/control_dependency*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Sum_1SumIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Mul_1[optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Reshape_1ReshapeIoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Sum_1Koptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Toptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/tuple/group_depsNoOpL^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/ReshapeN^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Reshape_1
�
\optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/tuple/control_dependencyIdentityKoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/ReshapeU^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Reshape
�
^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/tuple/control_dependency_1IdentityMoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Reshape_1U^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Reshape_1
�
Ooptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMulMatMulboptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMul_1MatMul*optimizer/GAIL_model_1/gail_d_hidden_1/Mulboptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Yoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/group_depsNoOpP^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMulR^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMul_1
�
aoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/control_dependencyIdentityOoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMulZ^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMul
�
coptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/control_dependency_1IdentityQoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMul_1Z^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/group_deps*
T0*d
_classZ
XVloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/MatMul_1
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/ShapeShapeOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul*
T0*
out_type0
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Shape_1Shape.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0*
out_type0
�
zoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Shapeloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Shape_1*
T0
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/MulMulpoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/BroadcastTo.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/SumSumhoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Mulzoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/ReshapeReshapehoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Sumjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Shape*
T0*
Tshape0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Mul_1MulOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMulpoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_grad/BroadcastTo*
T0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Sum_1Sumjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Mul_1|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshape_1Reshapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Sum_1loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Shape_1*
T0*
Tshape0
�
uoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/tuple/group_depsNoOpm^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshapeo^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshape_1
�
}optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/tuple/control_dependencyIdentityloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshapev^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/tuple/group_deps*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshape
�
optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/tuple/control_dependency_1Identitynoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshape_1v^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/tuple/group_deps*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshape_1
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/ShapeShapeKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1*
T0*
out_type0
�
koptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/SizeConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B :
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/addAddV2]optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs:1koptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Size*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/modFloorModjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/addkoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Size*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape_1Shapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/mod*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape*
out_type0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/range/startConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B : 
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/range/deltaConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B :
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/rangeRangeroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/range/startkoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Sizeroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/range/delta*

Tidx0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape
�
qoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Fill/valueConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B :
�
koptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/FillFillnoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape_1qoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Fill/value*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape*

index_type0
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/DynamicStitchDynamicStitchloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/rangejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/modloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shapekoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Fill*
N*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/ReshapeReshaperoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1_grad/Reshapetoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/DynamicStitch*
T0*
Tshape0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/BroadcastToBroadcastTonoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Reshapeloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/Shape*
T0*

Tidx0
�
Soptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad,optimizer/GAIL_model/gail_d_hidden_1/Sigmoid^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
Koptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/ShapeShape.optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd*
T0*
out_type0
�
Moptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Shape_1Shape.optimizer/GAIL_model_1/gail_d_hidden_1/Sigmoid*
T0*
out_type0
�
[optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/ShapeMoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Shape_1*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/MulMulaoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/control_dependency.optimizer/GAIL_model_1/gail_d_hidden_1/Sigmoid*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/SumSumIoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Mul[optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/ReshapeReshapeIoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/SumKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Koptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Mul_1Mul.optimizer/GAIL_model_1/gail_d_hidden_1/BiasAddaoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/control_dependency*
T0
�
Koptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Sum_1SumKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Mul_1]optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ooptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Reshape_1ReshapeKoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Sum_1Moptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Voptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/tuple/group_depsNoOpN^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/ReshapeP^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Reshape_1
�
^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/tuple/control_dependencyIdentityMoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/ReshapeW^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Reshape
�
`optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/tuple/control_dependency_1IdentityOoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Reshape_1W^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Reshape_1
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/ShapeShape.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd*
T0*
out_type0
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Shape_1ShapeOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul*
T0*
out_type0
�
|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Shapenoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Shape_1*
T0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/MulMulroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/BroadcastToOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul*
T0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/SumSumjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Mul|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/ReshapeReshapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Sumloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Shape*
T0*
Tshape0
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Mul_1Mul.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAddroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1_grad/BroadcastTo*
T0
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Sum_1Sumloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Mul_1~optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshape_1Reshapeloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Sum_1noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Shape_1*
T0*
Tshape0
�
woptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/tuple/group_depsNoOpo^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshapeq^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshape_1
�
optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/tuple/control_dependencyIdentitynoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshapex^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/tuple/group_deps*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshape
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/tuple/control_dependency_1Identitypoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshape_1x^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/tuple/group_deps*
T0*�
_classy
wuloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshape_1
�
optimizer/gradients_2/AddN_2AddN\optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/tuple/control_dependencySoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*^
_classT
RPloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Reshape
�
Soptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_2/AddN_2*
T0*
data_formatNHWC
�
Xoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_2/AddN_2T^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad
�
`optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_2/AddN_2Y^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/Mul_grad/Reshape
�
boptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentitySoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/BiasAddGradY^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/group_deps*
T0*f
_class\
ZXloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_1/gail_d_hidden_1/Sigmoid`optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_2/AddN_3AddN}optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/tuple/control_dependency�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/tuple/control_dependency_1*
N*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/Reshape
�
qoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMulMatMuloptimizer/gradients_2/AddN_31optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
soptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul_1MatMuloptimizer/gradients_2/AddN_3optimizer/gradients_1/AddN*
T0*
transpose_a(*
transpose_b( 
�
{optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/group_depsNoOpr^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMult^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul_1
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/control_dependencyIdentityqoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul|^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/group_deps*
T0*�
_classz
xvloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/control_dependency_1Identitysoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul_1|^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/group_deps*
T0*�
_class|
zxloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul_1
�
Moptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMulMatMul`optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Ooptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMul_1MatMuloptimizer/concat_4/concat`optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Woptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/tuple/group_depsNoOpN^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMulP^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMul_1
�
_optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/tuple/control_dependencyIdentityMoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMulX^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMul
�
aoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/tuple/control_dependency_1IdentityOoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMul_1X^optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/MatMul_1
�
optimizer/gradients_2/AddN_4AddN^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/tuple/control_dependencyUoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Reshape
�
Uoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_2/AddN_4*
T0*
data_formatNHWC
�
Zoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_2/AddN_4V^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad
�
boptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_2/AddN_4[^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/Mul_grad/Reshape
�
doptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityUoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad[^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad
�
Foptimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/group_depsNoOp�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/control_dependency
�
Noptimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/control_dependencyIdentity�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/control_dependencyG^optimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/group_deps*
T0*�
_classz
xvloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul
�
Poptimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/control_dependency_1Identity�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/control_dependencyG^optimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/group_deps*
T0*�
_classz
xvloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/MatMul
�
Ooptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMulMatMulboptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMul_1MatMuloptimizer/concat_5/concatboptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Yoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/tuple/group_depsNoOpP^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMulR^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMul_1
�
aoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/tuple/control_dependencyIdentityOoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMulZ^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMul
�
coptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/tuple/control_dependency_1IdentityQoptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMul_1Z^optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/tuple/group_deps*
T0*d
_classZ
XVloc:@optimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/MatMul_1
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_grad/ShapeShapeIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum*
T0*
out_type0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_grad/ReshapeReshapeNoptimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/control_dependencynoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_grad/Shape*
T0*
Tshape0
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mulMulPoptimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/control_dependency_1Ooptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1*
T0
�
xoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mul_1/xConstQ^optimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
voptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mul_1Mulxoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mul_1/xtoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mul*
T0
�
voptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mul_2Mulvoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mul_1.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/subSubtoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mulvoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/mul_2*
T0
�
|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_hidden_2/SigmoidPoptimizer/gradients_2/optimizer/gradients_1/AddN_grad/tuple/control_dependency_1*
T0
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/tuple/group_depsNoOp}^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/SigmoidGradu^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/sub
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependencyIdentitytoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/sub�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/tuple/group_deps*
T0*�
_class}
{yloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/sub
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependency_1Identity|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/SigmoidGrad�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/tuple/group_deps*
T0*�
_class�
��loc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/SigmoidGrad
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/ShapeShapeIoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul*
T0*
out_type0
�
ioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/SizeConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape*
dtype0*
value	B :
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/addAddV2[optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgsioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Size*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/modFloorModhoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/addioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Size*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape_1Shapehoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/mod*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape*
out_type0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/range/startConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape*
dtype0*
value	B : 
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/range/deltaConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape*
dtype0*
value	B :
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/rangeRangepoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/range/startioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Sizepoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/range/delta*

Tidx0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape
�
ooptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Fill/valueConst*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape*
dtype0*
value	B :
�
ioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/FillFillloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape_1ooptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Fill/value*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape*

index_type0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/DynamicStitchDynamicStitchjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/rangehoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/modjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shapeioptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Fill*
N*
T0*}
_classs
qoloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/ReshapeReshapepoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_grad/Reshaperoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/DynamicStitch*
T0*
Tshape0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/BroadcastToBroadcastToloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Reshapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/Shape*
T0*

Tidx0
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1_grad/ShapeShapeKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1*
T0*
out_type0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1_grad/ReshapeReshape�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependency_1poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1_grad/Shape*
T0*
Tshape0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/ShapeShapeOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul*
T0*
out_type0
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Shape_1Shape.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0*
out_type0
�
zoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Shapeloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Shape_1*
T0
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/MulMulpoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/BroadcastTo.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0
�
hoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/SumSumhoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Mulzoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/ReshapeReshapehoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Sumjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Shape*
T0*
Tshape0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Mul_1MulOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMulpoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_grad/BroadcastTo*
T0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Sum_1Sumjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Mul_1|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshape_1Reshapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Sum_1loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Shape_1*
T0*
Tshape0
�
uoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/tuple/group_depsNoOpm^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshapeo^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshape_1
�
}optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/tuple/control_dependencyIdentityloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshapev^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/tuple/group_deps*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshape
�
optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/tuple/control_dependency_1Identitynoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshape_1v^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/tuple/group_deps*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshape_1
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/ShapeShapeKoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1*
T0*
out_type0
�
koptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/SizeConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B :
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/addAddV2]optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs:1koptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Size*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/modFloorModjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/addkoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Size*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape_1Shapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/mod*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape*
out_type0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/range/startConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B : 
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/range/deltaConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B :
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/rangeRangeroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/range/startkoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Sizeroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/range/delta*

Tidx0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape
�
qoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Fill/valueConst*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape*
dtype0*
value	B :
�
koptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/FillFillnoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape_1qoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Fill/value*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape*

index_type0
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/DynamicStitchDynamicStitchloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/rangejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/modloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shapekoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Fill*
N*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/ReshapeReshaperoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1_grad/Reshapetoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/DynamicStitch*
T0*
Tshape0
�
roptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/BroadcastToBroadcastTonoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Reshapeloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/Shape*
T0*

Tidx0
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/ShapeShape.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd*
T0*
out_type0
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Shape_1ShapeOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul*
T0*
out_type0
�
|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Shapenoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Shape_1*
T0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/MulMulroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/BroadcastToOoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul*
T0
�
joptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/SumSumjoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Mul|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/ReshapeReshapejoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Sumloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Shape*
T0*
Tshape0
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Mul_1Mul.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAddroptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1_grad/BroadcastTo*
T0
�
loptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Sum_1Sumloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Mul_1~optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
poptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshape_1Reshapeloptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Sum_1noptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Shape_1*
T0*
Tshape0
�
woptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/tuple/group_depsNoOpo^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshapeq^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshape_1
�
optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/tuple/control_dependencyIdentitynoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshapex^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/tuple/group_deps*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshape
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/tuple/control_dependency_1Identitypoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshape_1x^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/tuple/group_deps*
T0*�
_classy
wuloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshape_1
�
optimizer/gradients_2/AddN_5AddN}optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/tuple/control_dependency�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/tuple/control_dependency_1*
N*
T0*
_classu
sqloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/Reshape
�
qoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMulMatMuloptimizer/gradients_2/AddN_51optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
soptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMul_1MatMuloptimizer/gradients_2/AddN_5Uoptimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad*
T0*
transpose_a(*
transpose_b( 
�
{optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/group_depsNoOpr^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMult^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMul_1
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/control_dependencyIdentityqoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMul|^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/group_deps*
T0*�
_classz
xvloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMul
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/control_dependency_1Identitysoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMul_1|^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/group_deps*
T0*�
_class|
zxloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/MatMul_1
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mulMul�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/control_dependencyoptimizer/gradients_1/Fill*
T0
�
xoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mul_1/xConst�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
voptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mul_1Mulxoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mul_1/xtoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mul*
T0
�
voptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mul_2Mulvoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mul_1.optimizer/GAIL_model_2/gail_d_estimate/Sigmoid*
T0
�
toptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/subSubtoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mulvoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/mul_2*
T0
�
|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_estimate/Sigmoid�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/control_dependency*
T0
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/tuple/group_depsNoOp}^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/SigmoidGradu^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/sub
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependencyIdentitytoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/sub�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/tuple/group_deps*
T0*�
_class}
{yloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/sub
�
�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependency_1Identity|optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/SigmoidGrad�^optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/tuple/group_deps*
T0*�
_class�
��loc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/SigmoidGrad
�
Uoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_estimate/Sigmoid�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependency*
T0
�
Uoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/BiasAddGradBiasAddGradUoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad*
T0*
data_formatNHWC
�
Zoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/group_depsNoOpV^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/BiasAddGradV^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad
�
boptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/control_dependencyIdentityUoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad[^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/Sigmoid_grad/SigmoidGrad
�
doptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/control_dependency_1IdentityUoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/BiasAddGrad[^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/BiasAddGrad
�
Ooptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMulMatMulboptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_estimate/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_1MatMul*optimizer/GAIL_model_2/gail_d_hidden_2/Mulboptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Yoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/group_depsNoOpP^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMulR^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_1
�
aoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/control_dependencyIdentityOoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMulZ^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul
�
coptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/control_dependency_1IdentityQoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_1Z^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/group_deps*
T0*d
_classZ
XVloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_1
�
optimizer/gradients_2/AddN_6AddNboptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/tuple/control_dependency_1doptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/BiasAdd_grad/tuple/control_dependency_1doptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/BiasAdd_grad/tuple/control_dependency_1*
N*
T0*f
_class\
ZXloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/BiasAdd_grad/BiasAddGrad
�
Koptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ShapeShape.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd*
T0*
out_type0
�
Moptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape_1Shape.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0*
out_type0
�
[optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ShapeMoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape_1*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/MulMulaoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/control_dependency.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/SumSumIoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul[optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ReshapeReshapeIoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/SumKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape*
T0*
Tshape0
�
Koptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1Mul.optimizer/GAIL_model_2/gail_d_hidden_2/BiasAddaoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/control_dependency*
T0
�
Koptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1SumKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1]optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ooptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1ReshapeKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Sum_1Moptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Shape_1*
T0*
Tshape0
�
Voptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/tuple/group_depsNoOpN^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ReshapeP^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1
�
^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/tuple/control_dependencyIdentityMoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/ReshapeW^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape
�
`optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/tuple/control_dependency_1IdentityOoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1W^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Reshape_1
�
optimizer/gradients_2/AddN_7AddNaoptimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/tuple/control_dependency_1coptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_estimate/MatMul_grad/tuple/control_dependency_1�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/MatMul_grad/tuple/control_dependency_1coptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_estimate/MatMul_grad/tuple/control_dependency_1*
N*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_estimate/MatMul_grad/MatMul_1
�
optimizer/gradients_2/AddN_8AddN�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependencyoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_grad/tuple/control_dependency_1`optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/tuple/control_dependency_1*
N*
T0*�
_class}
{yloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad_grad/sub
�
Uoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoidoptimizer/gradients_2/AddN_8*
T0
�
optimizer/gradients_2/AddN_9AddNoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/tuple/control_dependency^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/tuple/control_dependencyUoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/Sigmoid_grad/SigmoidGrad*
N*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshape
�
Uoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_2/AddN_9*
T0*
data_formatNHWC
�
Zoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_2/AddN_9V^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad
�
boptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_2/AddN_9[^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/group_deps*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/Mul_grad/Mul_1_grad/Reshape
�
doptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency_1IdentityUoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad[^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad
�
Ooptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMulMatMulboptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_hidden_2/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_1MatMul*optimizer/GAIL_model_2/gail_d_hidden_1/Mulboptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Yoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/group_depsNoOpP^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMulR^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_1
�
aoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/control_dependencyIdentityOoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMulZ^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul
�
coptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/control_dependency_1IdentityQoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_1Z^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/group_deps*
T0*d
_classZ
XVloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_1
�
optimizer/gradients_2/AddN_10AddNboptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency_1doptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency_1doptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/BiasAdd_grad/tuple/control_dependency_1*
N*
T0*f
_class\
ZXloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/BiasAdd_grad/BiasAddGrad
�
Koptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ShapeShape.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd*
T0*
out_type0
�
Moptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape_1Shape.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0*
out_type0
�
[optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ShapeMoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape_1*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/MulMulaoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/control_dependency.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid*
T0
�
Ioptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/SumSumIoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul[optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Moptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ReshapeReshapeIoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/SumKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Koptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1Mul.optimizer/GAIL_model_2/gail_d_hidden_1/BiasAddaoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/control_dependency*
T0
�
Koptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1SumKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1]optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Ooptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1ReshapeKoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Sum_1Moptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Voptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/tuple/group_depsNoOpN^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ReshapeP^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1
�
^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/tuple/control_dependencyIdentityMoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/ReshapeW^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/tuple/group_deps*
T0*`
_classV
TRloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape
�
`optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/tuple/control_dependency_1IdentityOoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1W^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Reshape_1
�
optimizer/gradients_2/AddN_11AddNaoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/tuple/control_dependency_1coptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_2/MatMul_grad/tuple/control_dependency_1�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/MatMul_grad/tuple/control_dependency_1coptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_2/MatMul_grad/tuple/control_dependency_1*
N*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_2/MatMul_grad/MatMul_1
�
optimizer/gradients_2/AddN_12AddN�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/tuple/control_dependencyoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_grad/tuple/control_dependency_1`optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/tuple/control_dependency_1*
N*
T0*�
_class}
{yloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad_grad/sub
�
Uoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad.optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoidoptimizer/gradients_2/AddN_12*
T0
�
optimizer/gradients_2/AddN_13AddNoptimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/tuple/control_dependency^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/tuple/control_dependencyUoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshape
�
Uoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_2/AddN_13*
T0*
data_formatNHWC
�
Zoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_2/AddN_13V^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad
�
boptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_2/AddN_13[^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/group_deps*
T0*�
_classw
usloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/Mul_grad/Mul_1_grad/Reshape
�
doptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityUoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad[^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/group_deps*
T0*h
_class^
\Zloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad
�
Ooptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMulMatMulboptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency1optimizer//GAIL_model/gail_d_hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Qoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_1MatMuloptimizer/add_6boptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Yoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/tuple/group_depsNoOpP^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMulR^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_1
�
aoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/tuple/control_dependencyIdentityOoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMulZ^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/tuple/group_deps*
T0*b
_classX
VTloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul
�
coptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/tuple/control_dependency_1IdentityQoptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_1Z^optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/tuple/group_deps*
T0*d
_classZ
XVloc:@optimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_1
�
optimizer/gradients_2/AddN_14AddNboptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency_1doptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency_1doptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/BiasAdd_grad/tuple/control_dependency_1*
N*
T0*f
_class\
ZXloc:@optimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients_2/AddN_15AddN�optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/tuple/control_dependency_1aoptimizer/gradients_2/optimizer/GAIL_model/gail_d_hidden_1/MatMul_grad/tuple/control_dependency_1coptimizer/gradients_2/optimizer/GAIL_model_1/gail_d_hidden_1/MatMul_grad/tuple/control_dependency_1coptimizer/gradients_2/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/tuple/control_dependency_1*
N*
T0*�
_class|
zxloc:@optimizer/gradients_2/optimizer/gradients_1/optimizer/GAIL_model_2/gail_d_hidden_1/MatMul_grad/MatMul_grad/MatMul_1
�
%optimizer/beta1_power_1/initial_valueConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
dtype0*
valueB
 *fff?
�
optimizer/beta1_power_1
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta1_power_1/AssignAssignoptimizer/beta1_power_1%optimizer/beta1_power_1/initial_value*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
optimizer/beta1_power_1/readIdentityoptimizer/beta1_power_1*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias
�
%optimizer/beta2_power_1/initial_valueConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
dtype0*
valueB
 *w�?
�
optimizer/beta2_power_1
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta2_power_1/AssignAssignoptimizer/beta2_power_1%optimizer/beta2_power_1/initial_value*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
optimizer/beta2_power_1/readIdentityoptimizer/beta2_power_1*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias
�
^optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
valueB"   �   
�
Toptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/Initializer/zeros/ConstConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
valueB
 *    
�
Noptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/Initializer/zerosFill^optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorToptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*

index_type0
�
<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
Coptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/AssignAssign<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/AdamNoptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/Initializer/zeros*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
use_locking(*
validate_shape(
�
Aoptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/readIdentity<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel
�
`optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
valueB"   �   
�
Voptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
dtype0*
valueB
 *    
�
Poptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/Initializer/zerosFill`optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorVoptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*

index_type0
�
>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
Eoptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/AssignAssign>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1Poptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/Initializer/zeros*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
use_locking(*
validate_shape(
�
Coptimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/readIdentity>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel
�
Loptimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
dtype0*
valueB�*    
�
:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Aoptimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam/AssignAssign:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/AdamLoptimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
use_locking(*
validate_shape(
�
?optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam/readIdentity:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias
�
Noptimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
dtype0*
valueB�*    
�
<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Coptimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1/AssignAssign<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1Noptimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
use_locking(*
validate_shape(
�
Aoptimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1/readIdentity<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias
�
^optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/Initializer/zeros/shape_as_tensorConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
valueB"�   �   
�
Toptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/Initializer/zeros/ConstConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
valueB
 *    
�
Noptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/Initializer/zerosFill^optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/Initializer/zeros/shape_as_tensorToptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/Initializer/zeros/Const*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*

index_type0
�
<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
Coptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/AssignAssign<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/AdamNoptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/Initializer/zeros*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
use_locking(*
validate_shape(
�
Aoptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/readIdentity<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel
�
`optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
valueB"�   �   
�
Voptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/Initializer/zeros/ConstConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
dtype0*
valueB
 *    
�
Poptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/Initializer/zerosFill`optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/Initializer/zeros/shape_as_tensorVoptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/Initializer/zeros/Const*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*

index_type0
�
>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
Eoptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/AssignAssign>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1Poptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/Initializer/zeros*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
use_locking(*
validate_shape(
�
Coptimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/readIdentity>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel
�
Loptimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
dtype0*
valueB�*    
�
:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Aoptimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam/AssignAssign:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/AdamLoptimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
use_locking(*
validate_shape(
�
?optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam/readIdentity:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias
�
Noptimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
dtype0*
valueB�*    
�
<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
	container *
dtype0*
shape:�*
shared_name 
�
Coptimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1/AssignAssign<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1Noptimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
use_locking(*
validate_shape(
�
Aoptimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1/readIdentity<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias
�
Noptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam/Initializer/zerosConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
dtype0*
valueB	�*    
�
<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
Coptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam/AssignAssign<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/AdamNoptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam/Initializer/zeros*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
use_locking(*
validate_shape(
�
Aoptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam/readIdentity<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel
�
Poptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1/Initializer/zerosConst*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
dtype0*
valueB	�*    
�
>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1
VariableV2*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
Eoptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1/AssignAssign>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1Poptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1/Initializer/zeros*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
use_locking(*
validate_shape(
�
Coptimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1/readIdentity>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel
�
Loptimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
dtype0*
valueB*    
�
:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
	container *
dtype0*
shape:*
shared_name 
�
Aoptimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam/AssignAssign:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/AdamLoptimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
?optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam/readIdentity:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias
�
Noptimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1/Initializer/zerosConst*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
dtype0*
valueB*    
�
<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1
VariableV2*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
	container *
dtype0*
shape:*
shared_name 
�
Coptimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1/AssignAssign<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1Noptimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1/Initializer/zeros*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
Aoptimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1/readIdentity<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias
K
optimizer/Adam_1/learning_rateConst*
dtype0*
valueB
 *RI�9
C
optimizer/Adam_1/beta1Const*
dtype0*
valueB
 *fff?
C
optimizer/Adam_1/beta2Const*
dtype0*
valueB
 *w�?
E
optimizer/Adam_1/epsilonConst*
dtype0*
valueB
 *w�+2
�
Noptimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/kernel/ApplyAdam	ApplyAdam,optimizer//GAIL_model/gail_d_hidden_1/kernel<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1optimizer/beta1_power_1/readoptimizer/beta2_power_1/readoptimizer/Adam_1/learning_rateoptimizer/Adam_1/beta1optimizer/Adam_1/beta2optimizer/Adam_1/epsilonoptimizer/gradients_2/AddN_15*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Loptimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/bias/ApplyAdam	ApplyAdam*optimizer//GAIL_model/gail_d_hidden_1/bias:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1optimizer/beta1_power_1/readoptimizer/beta2_power_1/readoptimizer/Adam_1/learning_rateoptimizer/Adam_1/beta1optimizer/Adam_1/beta2optimizer/Adam_1/epsilonoptimizer/gradients_2/AddN_14*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
use_locking( *
use_nesterov( 
�
Noptimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/kernel/ApplyAdam	ApplyAdam,optimizer//GAIL_model/gail_d_hidden_2/kernel<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1optimizer/beta1_power_1/readoptimizer/beta2_power_1/readoptimizer/Adam_1/learning_rateoptimizer/Adam_1/beta1optimizer/Adam_1/beta2optimizer/Adam_1/epsilonoptimizer/gradients_2/AddN_11*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
use_locking( *
use_nesterov( 
�
Loptimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/bias/ApplyAdam	ApplyAdam*optimizer//GAIL_model/gail_d_hidden_2/bias:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1optimizer/beta1_power_1/readoptimizer/beta2_power_1/readoptimizer/Adam_1/learning_rateoptimizer/Adam_1/beta1optimizer/Adam_1/beta2optimizer/Adam_1/epsilonoptimizer/gradients_2/AddN_10*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
use_locking( *
use_nesterov( 
�
Noptimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/kernel/ApplyAdam	ApplyAdam,optimizer//GAIL_model/gail_d_estimate/kernel<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1optimizer/beta1_power_1/readoptimizer/beta2_power_1/readoptimizer/Adam_1/learning_rateoptimizer/Adam_1/beta1optimizer/Adam_1/beta2optimizer/Adam_1/epsilonoptimizer/gradients_2/AddN_7*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
use_locking( *
use_nesterov( 
�
Loptimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/bias/ApplyAdam	ApplyAdam*optimizer//GAIL_model/gail_d_estimate/bias:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1optimizer/beta1_power_1/readoptimizer/beta2_power_1/readoptimizer/Adam_1/learning_rateoptimizer/Adam_1/beta1optimizer/Adam_1/beta2optimizer/Adam_1/epsilonoptimizer/gradients_2/AddN_6*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking( *
use_nesterov( 
�
optimizer/Adam_1/mulMuloptimizer/beta1_power_1/readoptimizer/Adam_1/beta1M^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/kernel/ApplyAdamM^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/kernel/ApplyAdamM^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/kernel/ApplyAdam*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias
�
optimizer/Adam_1/AssignAssignoptimizer/beta1_power_1optimizer/Adam_1/mul*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking( *
validate_shape(
�
optimizer/Adam_1/mul_1Muloptimizer/beta2_power_1/readoptimizer/Adam_1/beta2M^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/kernel/ApplyAdamM^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/kernel/ApplyAdamM^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/kernel/ApplyAdam*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias
�
optimizer/Adam_1/Assign_1Assignoptimizer/beta2_power_1optimizer/Adam_1/mul_1*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking( *
validate_shape(
�
optimizer/Adam_1NoOp^optimizer/Adam_1/Assign^optimizer/Adam_1/Assign_1M^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_estimate/kernel/ApplyAdamM^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_1/kernel/ApplyAdamM^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/bias/ApplyAdamO^optimizer/Adam_1/update_optimizer//GAIL_model/gail_d_hidden_2/kernel/ApplyAdam
Q
optimizer/Placeholder_3Placeholder*
dtype0*
shape:���������
Q
optimizer/Placeholder_4Placeholder*
dtype0*
shape:���������
Q
optimizer/Placeholder_5Placeholder*
dtype0*
shape:���������
B
optimizer/Identity_1Identityoptimizer/Placeholder_5*
T0
Y
optimizer/SquaredDifference_2SquaredDifferenceactionoptimizer/Identity_1*
T0
F
optimizer/Const_8Const*
dtype0*
valueB"       
p
optimizer/Mean_8Meanoptimizer/SquaredDifference_2optimizer/Const_8*
T0*

Tidx0*
	keep_dims( 
\
/optimizer/PolynomialDecay/initial_learning_rateConst*
dtype0*
valueB
 *RI9
M
 optimizer/PolynomialDecay/Cast/xConst*
dtype0*
valueB
 *    
O
"optimizer/PolynomialDecay/Cast_1/xConst*
dtype0*
valueB
 *  �?
b
 optimizer/PolynomialDecay/Cast_2Castglobal_step/read*

DstT0*

SrcT0*
Truncate( 
N
"optimizer/PolynomialDecay/Cast_3/xConst*
dtype0*
valueB	 :�	
t
 optimizer/PolynomialDecay/Cast_3Cast"optimizer/PolynomialDecay/Cast_3/x*

DstT0*

SrcT0*
Truncate( 
y
!optimizer/PolynomialDecay/MinimumMinimum optimizer/PolynomialDecay/Cast_2 optimizer/PolynomialDecay/Cast_3*
T0
z
!optimizer/PolynomialDecay/truedivRealDiv!optimizer/PolynomialDecay/Minimum optimizer/PolynomialDecay/Cast_3*
T0
�
optimizer/PolynomialDecay/subSub/optimizer/PolynomialDecay/initial_learning_rate optimizer/PolynomialDecay/Cast/x*
T0
N
!optimizer/PolynomialDecay/sub_1/xConst*
dtype0*
valueB
 *  �?
u
optimizer/PolynomialDecay/sub_1Sub!optimizer/PolynomialDecay/sub_1/x!optimizer/PolynomialDecay/truediv*
T0
r
optimizer/PolynomialDecay/PowPowoptimizer/PolynomialDecay/sub_1"optimizer/PolynomialDecay/Cast_1/x*
T0
k
optimizer/PolynomialDecay/MulMuloptimizer/PolynomialDecay/suboptimizer/PolynomialDecay/Pow*
T0
j
optimizer/PolynomialDecayAddoptimizer/PolynomialDecay/Mul optimizer/PolynomialDecay/Cast/x*
T0
D
optimizer/gradients_3/ShapeConst*
dtype0*
valueB 
L
optimizer/gradients_3/grad_ys_0Const*
dtype0*
valueB
 *  �?
{
optimizer/gradients_3/FillFilloptimizer/gradients_3/Shapeoptimizer/gradients_3/grad_ys_0*
T0*

index_type0
n
9optimizer/gradients_3/optimizer/Mean_8_grad/Reshape/shapeConst*
dtype0*
valueB"      
�
3optimizer/gradients_3/optimizer/Mean_8_grad/ReshapeReshapeoptimizer/gradients_3/Fill9optimizer/gradients_3/optimizer/Mean_8_grad/Reshape/shape*
T0*
Tshape0
r
1optimizer/gradients_3/optimizer/Mean_8_grad/ShapeShapeoptimizer/SquaredDifference_2*
T0*
out_type0
�
0optimizer/gradients_3/optimizer/Mean_8_grad/TileTile3optimizer/gradients_3/optimizer/Mean_8_grad/Reshape1optimizer/gradients_3/optimizer/Mean_8_grad/Shape*
T0*

Tmultiples0
t
3optimizer/gradients_3/optimizer/Mean_8_grad/Shape_1Shapeoptimizer/SquaredDifference_2*
T0*
out_type0
\
3optimizer/gradients_3/optimizer/Mean_8_grad/Shape_2Const*
dtype0*
valueB 
_
1optimizer/gradients_3/optimizer/Mean_8_grad/ConstConst*
dtype0*
valueB: 
�
0optimizer/gradients_3/optimizer/Mean_8_grad/ProdProd3optimizer/gradients_3/optimizer/Mean_8_grad/Shape_11optimizer/gradients_3/optimizer/Mean_8_grad/Const*
T0*

Tidx0*
	keep_dims( 
a
3optimizer/gradients_3/optimizer/Mean_8_grad/Const_1Const*
dtype0*
valueB: 
�
2optimizer/gradients_3/optimizer/Mean_8_grad/Prod_1Prod3optimizer/gradients_3/optimizer/Mean_8_grad/Shape_23optimizer/gradients_3/optimizer/Mean_8_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
_
5optimizer/gradients_3/optimizer/Mean_8_grad/Maximum/yConst*
dtype0*
value	B :
�
3optimizer/gradients_3/optimizer/Mean_8_grad/MaximumMaximum2optimizer/gradients_3/optimizer/Mean_8_grad/Prod_15optimizer/gradients_3/optimizer/Mean_8_grad/Maximum/y*
T0
�
4optimizer/gradients_3/optimizer/Mean_8_grad/floordivFloorDiv0optimizer/gradients_3/optimizer/Mean_8_grad/Prod3optimizer/gradients_3/optimizer/Mean_8_grad/Maximum*
T0
�
0optimizer/gradients_3/optimizer/Mean_8_grad/CastCast4optimizer/gradients_3/optimizer/Mean_8_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
3optimizer/gradients_3/optimizer/Mean_8_grad/truedivRealDiv0optimizer/gradients_3/optimizer/Mean_8_grad/Tile0optimizer/gradients_3/optimizer/Mean_8_grad/Cast*
T0
�
?optimizer/gradients_3/optimizer/SquaredDifference_2_grad/scalarConst4^optimizer/gradients_3/optimizer/Mean_8_grad/truediv*
dtype0*
valueB
 *   @
�
<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/MulMul?optimizer/gradients_3/optimizer/SquaredDifference_2_grad/scalar3optimizer/gradients_3/optimizer/Mean_8_grad/truediv*
T0
�
<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/subSubactionoptimizer/Identity_14^optimizer/gradients_3/optimizer/Mean_8_grad/truediv*
T0
�
>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/mul_1Mul<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Mul<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/sub*
T0
h
>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/ShapeShapeaction*
T0*
out_type0
x
@optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Shape_1Shapeoptimizer/Identity_1*
T0*
out_type0
�
Noptimizer/gradients_3/optimizer/SquaredDifference_2_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Shape@optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Shape_1*
T0
�
<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/SumSum>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/mul_1Noptimizer/gradients_3/optimizer/SquaredDifference_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_3/optimizer/SquaredDifference_2_grad/ReshapeReshape<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Sum>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Sum_1Sum>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/mul_1Poptimizer/gradients_3/optimizer/SquaredDifference_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_3/optimizer/SquaredDifference_2_grad/Reshape_1Reshape>optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Sum_1@optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/NegNegBoptimizer/gradients_3/optimizer/SquaredDifference_2_grad/Reshape_1*
T0
�
Ioptimizer/gradients_3/optimizer/SquaredDifference_2_grad/tuple/group_depsNoOp=^optimizer/gradients_3/optimizer/SquaredDifference_2_grad/NegA^optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Reshape
�
Qoptimizer/gradients_3/optimizer/SquaredDifference_2_grad/tuple/control_dependencyIdentity@optimizer/gradients_3/optimizer/SquaredDifference_2_grad/ReshapeJ^optimizer/gradients_3/optimizer/SquaredDifference_2_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Reshape
�
Soptimizer/gradients_3/optimizer/SquaredDifference_2_grad/tuple/control_dependency_1Identity<optimizer/gradients_3/optimizer/SquaredDifference_2_grad/NegJ^optimizer/gradients_3/optimizer/SquaredDifference_2_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_3/optimizer/SquaredDifference_2_grad/Neg
[
*optimizer/gradients_3/truediv_3_grad/ShapeShapeclip_by_value*
T0*
out_type0
U
,optimizer/gradients_3/truediv_3_grad/Shape_1Const*
dtype0*
valueB 
�
:optimizer/gradients_3/truediv_3_grad/BroadcastGradientArgsBroadcastGradientArgs*optimizer/gradients_3/truediv_3_grad/Shape,optimizer/gradients_3/truediv_3_grad/Shape_1*
T0
�
,optimizer/gradients_3/truediv_3_grad/RealDivRealDivQoptimizer/gradients_3/optimizer/SquaredDifference_2_grad/tuple/control_dependencytruediv_3/y*
T0
�
(optimizer/gradients_3/truediv_3_grad/SumSum,optimizer/gradients_3/truediv_3_grad/RealDiv:optimizer/gradients_3/truediv_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
,optimizer/gradients_3/truediv_3_grad/ReshapeReshape(optimizer/gradients_3/truediv_3_grad/Sum*optimizer/gradients_3/truediv_3_grad/Shape*
T0*
Tshape0
G
(optimizer/gradients_3/truediv_3_grad/NegNegclip_by_value*
T0
y
.optimizer/gradients_3/truediv_3_grad/RealDiv_1RealDiv(optimizer/gradients_3/truediv_3_grad/Negtruediv_3/y*
T0

.optimizer/gradients_3/truediv_3_grad/RealDiv_2RealDiv.optimizer/gradients_3/truediv_3_grad/RealDiv_1truediv_3/y*
T0
�
(optimizer/gradients_3/truediv_3_grad/mulMulQoptimizer/gradients_3/optimizer/SquaredDifference_2_grad/tuple/control_dependency.optimizer/gradients_3/truediv_3_grad/RealDiv_2*
T0
�
*optimizer/gradients_3/truediv_3_grad/Sum_1Sum(optimizer/gradients_3/truediv_3_grad/mul<optimizer/gradients_3/truediv_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
.optimizer/gradients_3/truediv_3_grad/Reshape_1Reshape*optimizer/gradients_3/truediv_3_grad/Sum_1,optimizer/gradients_3/truediv_3_grad/Shape_1*
T0*
Tshape0
�
5optimizer/gradients_3/truediv_3_grad/tuple/group_depsNoOp-^optimizer/gradients_3/truediv_3_grad/Reshape/^optimizer/gradients_3/truediv_3_grad/Reshape_1
�
=optimizer/gradients_3/truediv_3_grad/tuple/control_dependencyIdentity,optimizer/gradients_3/truediv_3_grad/Reshape6^optimizer/gradients_3/truediv_3_grad/tuple/group_deps*
T0*?
_class5
31loc:@optimizer/gradients_3/truediv_3_grad/Reshape
�
?optimizer/gradients_3/truediv_3_grad/tuple/control_dependency_1Identity.optimizer/gradients_3/truediv_3_grad/Reshape_16^optimizer/gradients_3/truediv_3_grad/tuple/group_deps*
T0*A
_class7
53loc:@optimizer/gradients_3/truediv_3_grad/Reshape_1
g
.optimizer/gradients_3/clip_by_value_grad/ShapeShapeclip_by_value/Minimum*
T0*
out_type0
Y
0optimizer/gradients_3/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
�
0optimizer/gradients_3/clip_by_value_grad/Shape_2Shape=optimizer/gradients_3/truediv_3_grad/tuple/control_dependency*
T0*
out_type0
a
4optimizer/gradients_3/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
.optimizer/gradients_3/clip_by_value_grad/zerosFill0optimizer/gradients_3/clip_by_value_grad/Shape_24optimizer/gradients_3/clip_by_value_grad/zeros/Const*
T0*

index_type0
v
5optimizer/gradients_3/clip_by_value_grad/GreaterEqualGreaterEqualclip_by_value/Minimumclip_by_value/y*
T0
�
>optimizer/gradients_3/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs.optimizer/gradients_3/clip_by_value_grad/Shape0optimizer/gradients_3/clip_by_value_grad/Shape_1*
T0
�
1optimizer/gradients_3/clip_by_value_grad/SelectV2SelectV25optimizer/gradients_3/clip_by_value_grad/GreaterEqual=optimizer/gradients_3/truediv_3_grad/tuple/control_dependency.optimizer/gradients_3/clip_by_value_grad/zeros*
T0
�
,optimizer/gradients_3/clip_by_value_grad/SumSum1optimizer/gradients_3/clip_by_value_grad/SelectV2>optimizer/gradients_3/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
0optimizer/gradients_3/clip_by_value_grad/ReshapeReshape,optimizer/gradients_3/clip_by_value_grad/Sum.optimizer/gradients_3/clip_by_value_grad/Shape*
T0*
Tshape0
�
3optimizer/gradients_3/clip_by_value_grad/SelectV2_1SelectV25optimizer/gradients_3/clip_by_value_grad/GreaterEqual.optimizer/gradients_3/clip_by_value_grad/zeros=optimizer/gradients_3/truediv_3_grad/tuple/control_dependency*
T0
�
.optimizer/gradients_3/clip_by_value_grad/Sum_1Sum3optimizer/gradients_3/clip_by_value_grad/SelectV2_1@optimizer/gradients_3/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_3/clip_by_value_grad/Reshape_1Reshape.optimizer/gradients_3/clip_by_value_grad/Sum_10optimizer/gradients_3/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
9optimizer/gradients_3/clip_by_value_grad/tuple/group_depsNoOp1^optimizer/gradients_3/clip_by_value_grad/Reshape3^optimizer/gradients_3/clip_by_value_grad/Reshape_1
�
Aoptimizer/gradients_3/clip_by_value_grad/tuple/control_dependencyIdentity0optimizer/gradients_3/clip_by_value_grad/Reshape:^optimizer/gradients_3/clip_by_value_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients_3/clip_by_value_grad/Reshape
�
Coptimizer/gradients_3/clip_by_value_grad/tuple/control_dependency_1Identity2optimizer/gradients_3/clip_by_value_grad/Reshape_1:^optimizer/gradients_3/clip_by_value_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_3/clip_by_value_grad/Reshape_1
f
6optimizer/gradients_3/clip_by_value/Minimum_grad/ShapeShapepolicy_1/add*
T0*
out_type0
a
8optimizer/gradients_3/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
8optimizer/gradients_3/clip_by_value/Minimum_grad/Shape_2ShapeAoptimizer/gradients_3/clip_by_value_grad/tuple/control_dependency*
T0*
out_type0
i
<optimizer/gradients_3/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
6optimizer/gradients_3/clip_by_value/Minimum_grad/zerosFill8optimizer/gradients_3/clip_by_value/Minimum_grad/Shape_2<optimizer/gradients_3/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
w
:optimizer/gradients_3/clip_by_value/Minimum_grad/LessEqual	LessEqualpolicy_1/addclip_by_value/Minimum/y*
T0
�
Foptimizer/gradients_3/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs6optimizer/gradients_3/clip_by_value/Minimum_grad/Shape8optimizer/gradients_3/clip_by_value/Minimum_grad/Shape_1*
T0
�
9optimizer/gradients_3/clip_by_value/Minimum_grad/SelectV2SelectV2:optimizer/gradients_3/clip_by_value/Minimum_grad/LessEqualAoptimizer/gradients_3/clip_by_value_grad/tuple/control_dependency6optimizer/gradients_3/clip_by_value/Minimum_grad/zeros*
T0
�
4optimizer/gradients_3/clip_by_value/Minimum_grad/SumSum9optimizer/gradients_3/clip_by_value/Minimum_grad/SelectV2Foptimizer/gradients_3/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
8optimizer/gradients_3/clip_by_value/Minimum_grad/ReshapeReshape4optimizer/gradients_3/clip_by_value/Minimum_grad/Sum6optimizer/gradients_3/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
;optimizer/gradients_3/clip_by_value/Minimum_grad/SelectV2_1SelectV2:optimizer/gradients_3/clip_by_value/Minimum_grad/LessEqual6optimizer/gradients_3/clip_by_value/Minimum_grad/zerosAoptimizer/gradients_3/clip_by_value_grad/tuple/control_dependency*
T0
�
6optimizer/gradients_3/clip_by_value/Minimum_grad/Sum_1Sum;optimizer/gradients_3/clip_by_value/Minimum_grad/SelectV2_1Hoptimizer/gradients_3/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
:optimizer/gradients_3/clip_by_value/Minimum_grad/Reshape_1Reshape6optimizer/gradients_3/clip_by_value/Minimum_grad/Sum_18optimizer/gradients_3/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Aoptimizer/gradients_3/clip_by_value/Minimum_grad/tuple/group_depsNoOp9^optimizer/gradients_3/clip_by_value/Minimum_grad/Reshape;^optimizer/gradients_3/clip_by_value/Minimum_grad/Reshape_1
�
Ioptimizer/gradients_3/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity8optimizer/gradients_3/clip_by_value/Minimum_grad/ReshapeB^optimizer/gradients_3/clip_by_value/Minimum_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients_3/clip_by_value/Minimum_grad/Reshape
�
Koptimizer/gradients_3/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity:optimizer/gradients_3/clip_by_value/Minimum_grad/Reshape_1B^optimizer/gradients_3/clip_by_value/Minimum_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_3/clip_by_value/Minimum_grad/Reshape_1
d
-optimizer/gradients_3/policy_1/add_grad/ShapeShapepolicy_1/mu/BiasAdd*
T0*
out_type0
_
/optimizer/gradients_3/policy_1/add_grad/Shape_1Shapepolicy_1/mul*
T0*
out_type0
�
=optimizer/gradients_3/policy_1/add_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_3/policy_1/add_grad/Shape/optimizer/gradients_3/policy_1/add_grad/Shape_1*
T0
�
+optimizer/gradients_3/policy_1/add_grad/SumSumIoptimizer/gradients_3/clip_by_value/Minimum_grad/tuple/control_dependency=optimizer/gradients_3/policy_1/add_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_3/policy_1/add_grad/ReshapeReshape+optimizer/gradients_3/policy_1/add_grad/Sum-optimizer/gradients_3/policy_1/add_grad/Shape*
T0*
Tshape0
�
-optimizer/gradients_3/policy_1/add_grad/Sum_1SumIoptimizer/gradients_3/clip_by_value/Minimum_grad/tuple/control_dependency?optimizer/gradients_3/policy_1/add_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_3/policy_1/add_grad/Reshape_1Reshape-optimizer/gradients_3/policy_1/add_grad/Sum_1/optimizer/gradients_3/policy_1/add_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_3/policy_1/add_grad/tuple/group_depsNoOp0^optimizer/gradients_3/policy_1/add_grad/Reshape2^optimizer/gradients_3/policy_1/add_grad/Reshape_1
�
@optimizer/gradients_3/policy_1/add_grad/tuple/control_dependencyIdentity/optimizer/gradients_3/policy_1/add_grad/Reshape9^optimizer/gradients_3/policy_1/add_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_3/policy_1/add_grad/Reshape
�
Boptimizer/gradients_3/policy_1/add_grad/tuple/control_dependency_1Identity1optimizer/gradients_3/policy_1/add_grad/Reshape_19^optimizer/gradients_3/policy_1/add_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_3/policy_1/add_grad/Reshape_1
�
:optimizer/gradients_3/policy_1/mu/BiasAdd_grad/BiasAddGradBiasAddGrad@optimizer/gradients_3/policy_1/add_grad/tuple/control_dependency*
T0*
data_formatNHWC
�
?optimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/group_depsNoOpA^optimizer/gradients_3/policy_1/add_grad/tuple/control_dependency;^optimizer/gradients_3/policy_1/mu/BiasAdd_grad/BiasAddGrad
�
Goptimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/control_dependencyIdentity@optimizer/gradients_3/policy_1/add_grad/tuple/control_dependency@^optimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_3/policy_1/add_grad/Reshape
�
Ioptimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/control_dependency_1Identity:optimizer/gradients_3/policy_1/mu/BiasAdd_grad/BiasAddGrad@^optimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_3/policy_1/mu/BiasAdd_grad/BiasAddGrad
]
-optimizer/gradients_3/policy_1/mul_grad/ShapeShapepolicy_1/Exp*
T0*
out_type0
i
/optimizer/gradients_3/policy_1/mul_grad/Shape_1Shapepolicy_1/random_normal*
T0*
out_type0
�
=optimizer/gradients_3/policy_1/mul_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_3/policy_1/mul_grad/Shape/optimizer/gradients_3/policy_1/mul_grad/Shape_1*
T0
�
+optimizer/gradients_3/policy_1/mul_grad/MulMulBoptimizer/gradients_3/policy_1/add_grad/tuple/control_dependency_1policy_1/random_normal*
T0
�
+optimizer/gradients_3/policy_1/mul_grad/SumSum+optimizer/gradients_3/policy_1/mul_grad/Mul=optimizer/gradients_3/policy_1/mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_3/policy_1/mul_grad/ReshapeReshape+optimizer/gradients_3/policy_1/mul_grad/Sum-optimizer/gradients_3/policy_1/mul_grad/Shape*
T0*
Tshape0
�
-optimizer/gradients_3/policy_1/mul_grad/Mul_1Mulpolicy_1/ExpBoptimizer/gradients_3/policy_1/add_grad/tuple/control_dependency_1*
T0
�
-optimizer/gradients_3/policy_1/mul_grad/Sum_1Sum-optimizer/gradients_3/policy_1/mul_grad/Mul_1?optimizer/gradients_3/policy_1/mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_3/policy_1/mul_grad/Reshape_1Reshape-optimizer/gradients_3/policy_1/mul_grad/Sum_1/optimizer/gradients_3/policy_1/mul_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_3/policy_1/mul_grad/tuple/group_depsNoOp0^optimizer/gradients_3/policy_1/mul_grad/Reshape2^optimizer/gradients_3/policy_1/mul_grad/Reshape_1
�
@optimizer/gradients_3/policy_1/mul_grad/tuple/control_dependencyIdentity/optimizer/gradients_3/policy_1/mul_grad/Reshape9^optimizer/gradients_3/policy_1/mul_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_3/policy_1/mul_grad/Reshape
�
Boptimizer/gradients_3/policy_1/mul_grad/tuple/control_dependency_1Identity1optimizer/gradients_3/policy_1/mul_grad/Reshape_19^optimizer/gradients_3/policy_1/mul_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_3/policy_1/mul_grad/Reshape_1
�
4optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMulMatMulGoptimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/control_dependencypolicy/mu/kernel/read*
T0*
transpose_a( *
transpose_b(
�
6optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_1/MulGoptimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
>optimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/group_depsNoOp5^optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMul7^optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMul_1
�
Foptimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/control_dependencyIdentity4optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMul?^optimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMul
�
Hoptimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/control_dependency_1Identity6optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMul_1?^optimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_3/policy_1/mu/MatMul_grad/MatMul_1
�
+optimizer/gradients_3/policy_1/Exp_grad/mulMul@optimizer/gradients_3/policy_1/mul_grad/tuple/control_dependencypolicy_1/Exp*
T0
�
Aoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/ShapeShape$policy/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/ShapeCoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/MulMulFoptimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
?optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/SumSum?optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/MulQoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/ReshapeReshape?optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/SumAoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_1/BiasAddFoptimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Sum_1SumAoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Soptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Sum_1Coptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/ReshapeF^optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Toptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/ReshapeM^optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Voptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1M^optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
e
7optimizer/gradients_3/policy_1/clip_by_value_grad/ShapeConst*
dtype0*
valueB:
b
9optimizer/gradients_3/policy_1/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
g
9optimizer/gradients_3/policy_1/clip_by_value_grad/Shape_2Const*
dtype0*
valueB:
j
=optimizer/gradients_3/policy_1/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
7optimizer/gradients_3/policy_1/clip_by_value_grad/zerosFill9optimizer/gradients_3/policy_1/clip_by_value_grad/Shape_2=optimizer/gradients_3/policy_1/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
>optimizer/gradients_3/policy_1/clip_by_value_grad/GreaterEqualGreaterEqualpolicy_1/clip_by_value/Minimumpolicy_1/clip_by_value/y*
T0
�
Goptimizer/gradients_3/policy_1/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs7optimizer/gradients_3/policy_1/clip_by_value_grad/Shape9optimizer/gradients_3/policy_1/clip_by_value_grad/Shape_1*
T0
�
:optimizer/gradients_3/policy_1/clip_by_value_grad/SelectV2SelectV2>optimizer/gradients_3/policy_1/clip_by_value_grad/GreaterEqual+optimizer/gradients_3/policy_1/Exp_grad/mul7optimizer/gradients_3/policy_1/clip_by_value_grad/zeros*
T0
�
5optimizer/gradients_3/policy_1/clip_by_value_grad/SumSum:optimizer/gradients_3/policy_1/clip_by_value_grad/SelectV2Goptimizer/gradients_3/policy_1/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
9optimizer/gradients_3/policy_1/clip_by_value_grad/ReshapeReshape5optimizer/gradients_3/policy_1/clip_by_value_grad/Sum7optimizer/gradients_3/policy_1/clip_by_value_grad/Shape*
T0*
Tshape0
�
<optimizer/gradients_3/policy_1/clip_by_value_grad/SelectV2_1SelectV2>optimizer/gradients_3/policy_1/clip_by_value_grad/GreaterEqual7optimizer/gradients_3/policy_1/clip_by_value_grad/zeros+optimizer/gradients_3/policy_1/Exp_grad/mul*
T0
�
7optimizer/gradients_3/policy_1/clip_by_value_grad/Sum_1Sum<optimizer/gradients_3/policy_1/clip_by_value_grad/SelectV2_1Ioptimizer/gradients_3/policy_1/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
;optimizer/gradients_3/policy_1/clip_by_value_grad/Reshape_1Reshape7optimizer/gradients_3/policy_1/clip_by_value_grad/Sum_19optimizer/gradients_3/policy_1/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
Boptimizer/gradients_3/policy_1/clip_by_value_grad/tuple/group_depsNoOp:^optimizer/gradients_3/policy_1/clip_by_value_grad/Reshape<^optimizer/gradients_3/policy_1/clip_by_value_grad/Reshape_1
�
Joptimizer/gradients_3/policy_1/clip_by_value_grad/tuple/control_dependencyIdentity9optimizer/gradients_3/policy_1/clip_by_value_grad/ReshapeC^optimizer/gradients_3/policy_1/clip_by_value_grad/tuple/group_deps*
T0*L
_classB
@>loc:@optimizer/gradients_3/policy_1/clip_by_value_grad/Reshape
�
Loptimizer/gradients_3/policy_1/clip_by_value_grad/tuple/control_dependency_1Identity;optimizer/gradients_3/policy_1/clip_by_value_grad/Reshape_1C^optimizer/gradients_3/policy_1/clip_by_value_grad/tuple/group_deps*
T0*N
_classD
B@loc:@optimizer/gradients_3/policy_1/clip_by_value_grad/Reshape_1
�
Koptimizer/gradients_3/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_1/SigmoidVoptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
m
?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/ShapeConst*
dtype0*
valueB:
j
Aoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
o
Aoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Shape_2Const*
dtype0*
valueB:
r
Eoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/zerosFillAoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Shape_2Eoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
Coptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/LessEqual	LessEqualpolicy/log_std/read policy_1/clip_by_value/Minimum/y*
T0
�
Ooptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/ShapeAoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0
�
Boptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/SelectV2SelectV2Coptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/LessEqualJoptimizer/gradients_3/policy_1/clip_by_value_grad/tuple/control_dependency?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/zeros*
T0
�
=optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/SumSumBoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/SelectV2Ooptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Aoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/ReshapeReshape=optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Sum?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/SelectV2_1SelectV2Coptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/LessEqual?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/zerosJoptimizer/gradients_3/policy_1/clip_by_value_grad/tuple/control_dependency*
T0
�
?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Sum_1SumDoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/SelectV2_1Qoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Reshape_1Reshape?optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Sum_1Aoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Joptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/tuple/group_depsNoOpB^optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/ReshapeD^optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
Roptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/tuple/control_dependencyIdentityAoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/ReshapeK^optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Reshape
�
Toptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency_1IdentityCoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Reshape_1K^optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
optimizer/gradients_3/AddNAddNToptimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyKoptimizer/gradients_3/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Koptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_3/AddN*
T0*
data_formatNHWC
�
Poptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_3/AddNL^optimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_3/AddNQ^optimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_3/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Zoptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulXoptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_0/MulXoptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMulH^optimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Woptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMulP^optimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMul
�
Yoptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1P^optimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Aoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/ShapeShape$policy/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/ShapeCoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/MulMulWoptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
?optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/SumSum?optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/MulQoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/ReshapeReshape?optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/SumAoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_0/BiasAddWoptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Sum_1SumAoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Soptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Sum_1Coptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/ReshapeF^optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Toptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/ReshapeM^optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Voptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1M^optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Koptimizer/gradients_3/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_0/SigmoidVoptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_3/AddN_1AddNToptimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyKoptimizer/gradients_3/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Koptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_3/AddN_1*
T0*
data_formatNHWC
�
Poptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_3/AddN_1L^optimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_3/AddN_1Q^optimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_3/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Zoptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulXoptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateXoptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMulH^optimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Woptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMulP^optimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMul
�
Yoptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1P^optimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
u
%optimizer/beta1_power_2/initial_valueConst*!
_class
loc:@policy/log_std*
dtype0*
valueB
 *fff?
�
optimizer/beta1_power_2
VariableV2*!
_class
loc:@policy/log_std*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta1_power_2/AssignAssignoptimizer/beta1_power_2%optimizer/beta1_power_2/initial_value*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
m
optimizer/beta1_power_2/readIdentityoptimizer/beta1_power_2*
T0*!
_class
loc:@policy/log_std
u
%optimizer/beta2_power_2/initial_valueConst*!
_class
loc:@policy/log_std*
dtype0*
valueB
 *w�?
�
optimizer/beta2_power_2
VariableV2*!
_class
loc:@policy/log_std*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta2_power_2/AssignAssignoptimizer/beta2_power_2%optimizer/beta2_power_2/initial_value*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
m
optimizer/beta2_power_2/readIdentityoptimizer/beta2_power_2*
T0*!
_class
loc:@policy/log_std
�
Xoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Noptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Hoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/Initializer/zerosFillXoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/Initializer/zeros/shape_as_tensorNoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*

index_type0
�
6optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
=optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/AssignAssign6optimizer//policy/main_graph_0/hidden_0/kernel/bc_adamHoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
;optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/readIdentity6optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Zoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Poptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Joptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/Initializer/zerosFillZoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/Initializer/zeros/shape_as_tensorPoptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*

index_type0
�
8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
?optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/AssignAssign8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1Joptimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
=optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/readIdentity8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Foptimizer//policy/main_graph_0/hidden_0/bias/bc_adam/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
4optimizer//policy/main_graph_0/hidden_0/bias/bc_adam
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
;optimizer//policy/main_graph_0/hidden_0/bias/bc_adam/AssignAssign4optimizer//policy/main_graph_0/hidden_0/bias/bc_adamFoptimizer//policy/main_graph_0/hidden_0/bias/bc_adam/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
9optimizer//policy/main_graph_0/hidden_0/bias/bc_adam/readIdentity4optimizer//policy/main_graph_0/hidden_0/bias/bc_adam*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Hoptimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
=optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1/AssignAssign6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1Hoptimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
;optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1/readIdentity6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Xoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Noptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Hoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/Initializer/zerosFillXoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/Initializer/zeros/shape_as_tensorNoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
6optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
=optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/AssignAssign6optimizer//policy/main_graph_0/hidden_1/kernel/bc_adamHoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
;optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/readIdentity6optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Zoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Poptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Joptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/Initializer/zerosFillZoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/Initializer/zeros/shape_as_tensorPoptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
?optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/AssignAssign8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1Joptimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
=optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/readIdentity8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Foptimizer//policy/main_graph_0/hidden_1/bias/bc_adam/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
4optimizer//policy/main_graph_0/hidden_1/bias/bc_adam
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
;optimizer//policy/main_graph_0/hidden_1/bias/bc_adam/AssignAssign4optimizer//policy/main_graph_0/hidden_1/bias/bc_adamFoptimizer//policy/main_graph_0/hidden_1/bias/bc_adam/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
9optimizer//policy/main_graph_0/hidden_1/bias/bc_adam/readIdentity4optimizer//policy/main_graph_0/hidden_1/bias/bc_adam*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
Hoptimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
=optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1/AssignAssign6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1Hoptimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
;optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1/readIdentity6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
Eoptimizer//policy/mu/kernel/bc_adam/Initializer/zeros/shape_as_tensorConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB"      
�
;optimizer//policy/mu/kernel/bc_adam/Initializer/zeros/ConstConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *    
�
5optimizer//policy/mu/kernel/bc_adam/Initializer/zerosFillEoptimizer//policy/mu/kernel/bc_adam/Initializer/zeros/shape_as_tensor;optimizer//policy/mu/kernel/bc_adam/Initializer/zeros/Const*
T0*#
_class
loc:@policy/mu/kernel*

index_type0
�
#optimizer//policy/mu/kernel/bc_adam
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
*optimizer//policy/mu/kernel/bc_adam/AssignAssign#optimizer//policy/mu/kernel/bc_adam5optimizer//policy/mu/kernel/bc_adam/Initializer/zeros*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
(optimizer//policy/mu/kernel/bc_adam/readIdentity#optimizer//policy/mu/kernel/bc_adam*
T0*#
_class
loc:@policy/mu/kernel
�
Goptimizer//policy/mu/kernel/bc_adam_1/Initializer/zeros/shape_as_tensorConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB"      
�
=optimizer//policy/mu/kernel/bc_adam_1/Initializer/zeros/ConstConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *    
�
7optimizer//policy/mu/kernel/bc_adam_1/Initializer/zerosFillGoptimizer//policy/mu/kernel/bc_adam_1/Initializer/zeros/shape_as_tensor=optimizer//policy/mu/kernel/bc_adam_1/Initializer/zeros/Const*
T0*#
_class
loc:@policy/mu/kernel*

index_type0
�
%optimizer//policy/mu/kernel/bc_adam_1
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
,optimizer//policy/mu/kernel/bc_adam_1/AssignAssign%optimizer//policy/mu/kernel/bc_adam_17optimizer//policy/mu/kernel/bc_adam_1/Initializer/zeros*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
*optimizer//policy/mu/kernel/bc_adam_1/readIdentity%optimizer//policy/mu/kernel/bc_adam_1*
T0*#
_class
loc:@policy/mu/kernel
�
3optimizer//policy/mu/bias/bc_adam/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
!optimizer//policy/mu/bias/bc_adam
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
(optimizer//policy/mu/bias/bc_adam/AssignAssign!optimizer//policy/mu/bias/bc_adam3optimizer//policy/mu/bias/bc_adam/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
&optimizer//policy/mu/bias/bc_adam/readIdentity!optimizer//policy/mu/bias/bc_adam*
T0*!
_class
loc:@policy/mu/bias
�
5optimizer//policy/mu/bias/bc_adam_1/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
#optimizer//policy/mu/bias/bc_adam_1
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
*optimizer//policy/mu/bias/bc_adam_1/AssignAssign#optimizer//policy/mu/bias/bc_adam_15optimizer//policy/mu/bias/bc_adam_1/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
(optimizer//policy/mu/bias/bc_adam_1/readIdentity#optimizer//policy/mu/bias/bc_adam_1*
T0*!
_class
loc:@policy/mu/bias
�
3optimizer//policy/log_std/bc_adam/Initializer/zerosConst*!
_class
loc:@policy/log_std*
dtype0*
valueB*    
�
!optimizer//policy/log_std/bc_adam
VariableV2*!
_class
loc:@policy/log_std*
	container *
dtype0*
shape:*
shared_name 
�
(optimizer//policy/log_std/bc_adam/AssignAssign!optimizer//policy/log_std/bc_adam3optimizer//policy/log_std/bc_adam/Initializer/zeros*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
&optimizer//policy/log_std/bc_adam/readIdentity!optimizer//policy/log_std/bc_adam*
T0*!
_class
loc:@policy/log_std
�
5optimizer//policy/log_std/bc_adam_1/Initializer/zerosConst*!
_class
loc:@policy/log_std*
dtype0*
valueB*    
�
#optimizer//policy/log_std/bc_adam_1
VariableV2*!
_class
loc:@policy/log_std*
	container *
dtype0*
shape:*
shared_name 
�
*optimizer//policy/log_std/bc_adam_1/AssignAssign#optimizer//policy/log_std/bc_adam_15optimizer//policy/log_std/bc_adam_1/Initializer/zeros*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
(optimizer//policy/log_std/bc_adam_1/readIdentity#optimizer//policy/log_std/bc_adam_1*
T0*!
_class
loc:@policy/log_std
D
optimizer/bc_adam/beta1Const*
dtype0*
valueB
 *fff?
D
optimizer/bc_adam/beta2Const*
dtype0*
valueB
 *w�?
F
optimizer/bc_adam/epsilonConst*
dtype0*
valueB
 *w�+2
�
Foptimizer/bc_adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_0/kernel6optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1optimizer/beta1_power_2/readoptimizer/beta2_power_2/readoptimizer/PolynomialDecayoptimizer/bc_adam/beta1optimizer/bc_adam/beta2optimizer/bc_adam/epsilonYoptimizer/gradients_3/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Doptimizer/bc_adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_0/bias4optimizer//policy/main_graph_0/hidden_0/bias/bc_adam6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1optimizer/beta1_power_2/readoptimizer/beta2_power_2/readoptimizer/PolynomialDecayoptimizer/bc_adam/beta1optimizer/bc_adam/beta2optimizer/bc_adam/epsilonZoptimizer/gradients_3/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Foptimizer/bc_adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_1/kernel6optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1optimizer/beta1_power_2/readoptimizer/beta2_power_2/readoptimizer/PolynomialDecayoptimizer/bc_adam/beta1optimizer/bc_adam/beta2optimizer/bc_adam/epsilonYoptimizer/gradients_3/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Doptimizer/bc_adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_1/bias4optimizer//policy/main_graph_0/hidden_1/bias/bc_adam6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1optimizer/beta1_power_2/readoptimizer/beta2_power_2/readoptimizer/PolynomialDecayoptimizer/bc_adam/beta1optimizer/bc_adam/beta2optimizer/bc_adam/epsilonZoptimizer/gradients_3/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking( *
use_nesterov( 
�
3optimizer/bc_adam/update_policy/mu/kernel/ApplyAdam	ApplyAdampolicy/mu/kernel#optimizer//policy/mu/kernel/bc_adam%optimizer//policy/mu/kernel/bc_adam_1optimizer/beta1_power_2/readoptimizer/beta2_power_2/readoptimizer/PolynomialDecayoptimizer/bc_adam/beta1optimizer/bc_adam/beta2optimizer/bc_adam/epsilonHoptimizer/gradients_3/policy_1/mu/MatMul_grad/tuple/control_dependency_1*
T0*#
_class
loc:@policy/mu/kernel*
use_locking( *
use_nesterov( 
�
1optimizer/bc_adam/update_policy/mu/bias/ApplyAdam	ApplyAdampolicy/mu/bias!optimizer//policy/mu/bias/bc_adam#optimizer//policy/mu/bias/bc_adam_1optimizer/beta1_power_2/readoptimizer/beta2_power_2/readoptimizer/PolynomialDecayoptimizer/bc_adam/beta1optimizer/bc_adam/beta2optimizer/bc_adam/epsilonIoptimizer/gradients_3/policy_1/mu/BiasAdd_grad/tuple/control_dependency_1*
T0*!
_class
loc:@policy/mu/bias*
use_locking( *
use_nesterov( 
�
1optimizer/bc_adam/update_policy/log_std/ApplyAdam	ApplyAdampolicy/log_std!optimizer//policy/log_std/bc_adam#optimizer//policy/log_std/bc_adam_1optimizer/beta1_power_2/readoptimizer/beta2_power_2/readoptimizer/PolynomialDecayoptimizer/bc_adam/beta1optimizer/bc_adam/beta2optimizer/bc_adam/epsilonRoptimizer/gradients_3/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency*
T0*!
_class
loc:@policy/log_std*
use_locking( *
use_nesterov( 
�
optimizer/bc_adam/mulMuloptimizer/beta1_power_2/readoptimizer/bc_adam/beta12^optimizer/bc_adam/update_policy/log_std/ApplyAdamE^optimizer/bc_adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdamG^optimizer/bc_adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamE^optimizer/bc_adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdamG^optimizer/bc_adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam2^optimizer/bc_adam/update_policy/mu/bias/ApplyAdam4^optimizer/bc_adam/update_policy/mu/kernel/ApplyAdam*
T0*!
_class
loc:@policy/log_std
�
optimizer/bc_adam/AssignAssignoptimizer/beta1_power_2optimizer/bc_adam/mul*
T0*!
_class
loc:@policy/log_std*
use_locking( *
validate_shape(
�
optimizer/bc_adam/mul_1Muloptimizer/beta2_power_2/readoptimizer/bc_adam/beta22^optimizer/bc_adam/update_policy/log_std/ApplyAdamE^optimizer/bc_adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdamG^optimizer/bc_adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamE^optimizer/bc_adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdamG^optimizer/bc_adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam2^optimizer/bc_adam/update_policy/mu/bias/ApplyAdam4^optimizer/bc_adam/update_policy/mu/kernel/ApplyAdam*
T0*!
_class
loc:@policy/log_std
�
optimizer/bc_adam/Assign_1Assignoptimizer/beta2_power_2optimizer/bc_adam/mul_1*
T0*!
_class
loc:@policy/log_std*
use_locking( *
validate_shape(
�
optimizer/bc_adamNoOp^optimizer/bc_adam/Assign^optimizer/bc_adam/Assign_12^optimizer/bc_adam/update_policy/log_std/ApplyAdamE^optimizer/bc_adam/update_policy/main_graph_0/hidden_0/bias/ApplyAdamG^optimizer/bc_adam/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamE^optimizer/bc_adam/update_policy/main_graph_0/hidden_1/bias/ApplyAdamG^optimizer/bc_adam/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam2^optimizer/bc_adam/update_policy/mu/bias/ApplyAdam4^optimizer/bc_adam/update_policy/mu/kernel/ApplyAdam
�
Joptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shapeConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Ioptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/meanConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Koptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddevConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *���>
�
Toptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalJoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
seed�'*
seed2
�
Hoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulMulToptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalKoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
Doptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normalAddHoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulIoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
'optimizer//main_graph_0/hidden_0/kernel
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
.optimizer//main_graph_0/hidden_0/kernel/AssignAssign'optimizer//main_graph_0/hidden_0/kernelDoptimizer//main_graph_0/hidden_0/kernel/Initializer/truncated_normal*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
,optimizer//main_graph_0/hidden_0/kernel/readIdentity'optimizer//main_graph_0/hidden_0/kernel*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
7optimizer//main_graph_0/hidden_0/bias/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
%optimizer//main_graph_0/hidden_0/bias
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
,optimizer//main_graph_0/hidden_0/bias/AssignAssign%optimizer//main_graph_0/hidden_0/bias7optimizer//main_graph_0/hidden_0/bias/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
*optimizer//main_graph_0/hidden_0/bias/readIdentity%optimizer//main_graph_0/hidden_0/bias*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias
�
&optimizer/main_graph_0/hidden_0/MatMulMatMulnormalized_state,optimizer//main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
'optimizer/main_graph_0/hidden_0/BiasAddBiasAdd&optimizer/main_graph_0/hidden_0/MatMul*optimizer//main_graph_0/hidden_0/bias/read*
T0*
data_formatNHWC
d
'optimizer/main_graph_0/hidden_0/SigmoidSigmoid'optimizer/main_graph_0/hidden_0/BiasAdd*
T0
�
#optimizer/main_graph_0/hidden_0/MulMul'optimizer/main_graph_0/hidden_0/BiasAdd'optimizer/main_graph_0/hidden_0/Sigmoid*
T0
�
Joptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shapeConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Ioptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/meanConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Koptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddevConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *��M=
�
Toptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormalJoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
seed�'*
seed2
�
Hoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulMulToptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalKoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
Doptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normalAddHoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulIoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
'optimizer//main_graph_0/hidden_1/kernel
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
.optimizer//main_graph_0/hidden_1/kernel/AssignAssign'optimizer//main_graph_0/hidden_1/kernelDoptimizer//main_graph_0/hidden_1/kernel/Initializer/truncated_normal*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
,optimizer//main_graph_0/hidden_1/kernel/readIdentity'optimizer//main_graph_0/hidden_1/kernel*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
7optimizer//main_graph_0/hidden_1/bias/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
%optimizer//main_graph_0/hidden_1/bias
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
,optimizer//main_graph_0/hidden_1/bias/AssignAssign%optimizer//main_graph_0/hidden_1/bias7optimizer//main_graph_0/hidden_1/bias/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
*optimizer//main_graph_0/hidden_1/bias/readIdentity%optimizer//main_graph_0/hidden_1/bias*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias
�
&optimizer/main_graph_0/hidden_1/MatMulMatMul#optimizer/main_graph_0/hidden_0/Mul,optimizer//main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
'optimizer/main_graph_0/hidden_1/BiasAddBiasAdd&optimizer/main_graph_0/hidden_1/MatMul*optimizer//main_graph_0/hidden_1/bias/read*
T0*
data_formatNHWC
d
'optimizer/main_graph_0/hidden_1/SigmoidSigmoid'optimizer/main_graph_0/hidden_1/BiasAdd*
T0
�
#optimizer/main_graph_0/hidden_1/MulMul'optimizer/main_graph_0/hidden_1/BiasAdd'optimizer/main_graph_0/hidden_1/Sigmoid*
T0
�
Boptimizer//extrinsic_value/kernel/Initializer/random_uniform/shapeConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB"      
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/minConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB
 *|ݽ
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/maxConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB
 *|�=
�
Joptimizer//extrinsic_value/kernel/Initializer/random_uniform/RandomUniformRandomUniformBoptimizer//extrinsic_value/kernel/Initializer/random_uniform/shape*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
seed�'*
seed2
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/subSub@optimizer//extrinsic_value/kernel/Initializer/random_uniform/max@optimizer//extrinsic_value/kernel/Initializer/random_uniform/min*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
@optimizer//extrinsic_value/kernel/Initializer/random_uniform/mulMulJoptimizer//extrinsic_value/kernel/Initializer/random_uniform/RandomUniform@optimizer//extrinsic_value/kernel/Initializer/random_uniform/sub*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
<optimizer//extrinsic_value/kernel/Initializer/random_uniformAdd@optimizer//extrinsic_value/kernel/Initializer/random_uniform/mul@optimizer//extrinsic_value/kernel/Initializer/random_uniform/min*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
!optimizer//extrinsic_value/kernel
VariableV2*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
(optimizer//extrinsic_value/kernel/AssignAssign!optimizer//extrinsic_value/kernel<optimizer//extrinsic_value/kernel/Initializer/random_uniform*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
&optimizer//extrinsic_value/kernel/readIdentity!optimizer//extrinsic_value/kernel*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
1optimizer//extrinsic_value/bias/Initializer/zerosConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB*    
�
optimizer//extrinsic_value/bias
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
&optimizer//extrinsic_value/bias/AssignAssignoptimizer//extrinsic_value/bias1optimizer//extrinsic_value/bias/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
$optimizer//extrinsic_value/bias/readIdentityoptimizer//extrinsic_value/bias*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
 optimizer/extrinsic_value/MatMulMatMul#optimizer/main_graph_0/hidden_1/Mul&optimizer//extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
!optimizer/extrinsic_value/BiasAddBiasAdd optimizer/extrinsic_value/MatMul$optimizer//extrinsic_value/bias/read*
T0*
data_formatNHWC
�
Boptimizer//curiosity_value/kernel/Initializer/random_uniform/shapeConst*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
dtype0*
valueB"      
�
@optimizer//curiosity_value/kernel/Initializer/random_uniform/minConst*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
dtype0*
valueB
 *|ݽ
�
@optimizer//curiosity_value/kernel/Initializer/random_uniform/maxConst*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
dtype0*
valueB
 *|�=
�
Joptimizer//curiosity_value/kernel/Initializer/random_uniform/RandomUniformRandomUniformBoptimizer//curiosity_value/kernel/Initializer/random_uniform/shape*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
dtype0*
seed�'*
seed2
�
@optimizer//curiosity_value/kernel/Initializer/random_uniform/subSub@optimizer//curiosity_value/kernel/Initializer/random_uniform/max@optimizer//curiosity_value/kernel/Initializer/random_uniform/min*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel
�
@optimizer//curiosity_value/kernel/Initializer/random_uniform/mulMulJoptimizer//curiosity_value/kernel/Initializer/random_uniform/RandomUniform@optimizer//curiosity_value/kernel/Initializer/random_uniform/sub*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel
�
<optimizer//curiosity_value/kernel/Initializer/random_uniformAdd@optimizer//curiosity_value/kernel/Initializer/random_uniform/mul@optimizer//curiosity_value/kernel/Initializer/random_uniform/min*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel
�
!optimizer//curiosity_value/kernel
VariableV2*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
(optimizer//curiosity_value/kernel/AssignAssign!optimizer//curiosity_value/kernel<optimizer//curiosity_value/kernel/Initializer/random_uniform*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
use_locking(*
validate_shape(
�
&optimizer//curiosity_value/kernel/readIdentity!optimizer//curiosity_value/kernel*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel
�
1optimizer//curiosity_value/bias/Initializer/zerosConst*2
_class(
&$loc:@optimizer//curiosity_value/bias*
dtype0*
valueB*    
�
optimizer//curiosity_value/bias
VariableV2*2
_class(
&$loc:@optimizer//curiosity_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
&optimizer//curiosity_value/bias/AssignAssignoptimizer//curiosity_value/bias1optimizer//curiosity_value/bias/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
$optimizer//curiosity_value/bias/readIdentityoptimizer//curiosity_value/bias*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias
�
 optimizer/curiosity_value/MatMulMatMul#optimizer/main_graph_0/hidden_1/Mul&optimizer//curiosity_value/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
!optimizer/curiosity_value/BiasAddBiasAdd optimizer/curiosity_value/MatMul$optimizer//curiosity_value/bias/read*
T0*
data_formatNHWC
�
=optimizer//gail_value/kernel/Initializer/random_uniform/shapeConst*/
_class%
#!loc:@optimizer//gail_value/kernel*
dtype0*
valueB"      
�
;optimizer//gail_value/kernel/Initializer/random_uniform/minConst*/
_class%
#!loc:@optimizer//gail_value/kernel*
dtype0*
valueB
 *|ݽ
�
;optimizer//gail_value/kernel/Initializer/random_uniform/maxConst*/
_class%
#!loc:@optimizer//gail_value/kernel*
dtype0*
valueB
 *|�=
�
Eoptimizer//gail_value/kernel/Initializer/random_uniform/RandomUniformRandomUniform=optimizer//gail_value/kernel/Initializer/random_uniform/shape*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
dtype0*
seed�'*
seed2
�
;optimizer//gail_value/kernel/Initializer/random_uniform/subSub;optimizer//gail_value/kernel/Initializer/random_uniform/max;optimizer//gail_value/kernel/Initializer/random_uniform/min*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel
�
;optimizer//gail_value/kernel/Initializer/random_uniform/mulMulEoptimizer//gail_value/kernel/Initializer/random_uniform/RandomUniform;optimizer//gail_value/kernel/Initializer/random_uniform/sub*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel
�
7optimizer//gail_value/kernel/Initializer/random_uniformAdd;optimizer//gail_value/kernel/Initializer/random_uniform/mul;optimizer//gail_value/kernel/Initializer/random_uniform/min*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel
�
optimizer//gail_value/kernel
VariableV2*/
_class%
#!loc:@optimizer//gail_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
#optimizer//gail_value/kernel/AssignAssignoptimizer//gail_value/kernel7optimizer//gail_value/kernel/Initializer/random_uniform*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
use_locking(*
validate_shape(
�
!optimizer//gail_value/kernel/readIdentityoptimizer//gail_value/kernel*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel
�
,optimizer//gail_value/bias/Initializer/zerosConst*-
_class#
!loc:@optimizer//gail_value/bias*
dtype0*
valueB*    
�
optimizer//gail_value/bias
VariableV2*-
_class#
!loc:@optimizer//gail_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
!optimizer//gail_value/bias/AssignAssignoptimizer//gail_value/bias,optimizer//gail_value/bias/Initializer/zeros*
T0*-
_class#
!loc:@optimizer//gail_value/bias*
use_locking(*
validate_shape(

optimizer//gail_value/bias/readIdentityoptimizer//gail_value/bias*
T0*-
_class#
!loc:@optimizer//gail_value/bias
�
optimizer/gail_value/MatMulMatMul#optimizer/main_graph_0/hidden_1/Mul!optimizer//gail_value/kernel/read*
T0*
transpose_a( *
transpose_b( 
�
optimizer/gail_value/BiasAddBiasAddoptimizer/gail_value/MatMuloptimizer//gail_value/bias/read*
T0*
data_formatNHWC
�
optimizer/Mean_9/inputPack!optimizer/extrinsic_value/BiasAdd!optimizer/curiosity_value/BiasAddoptimizer/gail_value/BiasAdd*
N*
T0*

axis 
L
"optimizer/Mean_9/reduction_indicesConst*
dtype0*
value	B : 
z
optimizer/Mean_9Meanoptimizer/Mean_9/input"optimizer/Mean_9/reduction_indices*
T0*

Tidx0*
	keep_dims( 
U
optimizer/old_probabilitiesPlaceholder*
dtype0*
shape:���������
F
optimizer/Identity_2Identityoptimizer/old_probabilities*
T0
K
!optimizer/Sum_3/reduction_indicesConst*
dtype0*
value	B :
u
optimizer/Sum_3Sumoptimizer/Identity_2!optimizer/Sum_3/reduction_indices*
T0*

Tidx0*
	keep_dims(
^
1optimizer/PolynomialDecay_1/initial_learning_rateConst*
dtype0*
valueB
 *RI�9
O
"optimizer/PolynomialDecay_1/Cast/xConst*
dtype0*
valueB
 *���.
Q
$optimizer/PolynomialDecay_1/Cast_1/xConst*
dtype0*
valueB
 *  �?
d
"optimizer/PolynomialDecay_1/Cast_2Castglobal_step/read*

DstT0*

SrcT0*
Truncate( 
Q
$optimizer/PolynomialDecay_1/Cast_3/xConst*
dtype0*
valueB
 :���
x
"optimizer/PolynomialDecay_1/Cast_3Cast$optimizer/PolynomialDecay_1/Cast_3/x*

DstT0*

SrcT0*
Truncate( 

#optimizer/PolynomialDecay_1/MinimumMinimum"optimizer/PolynomialDecay_1/Cast_2"optimizer/PolynomialDecay_1/Cast_3*
T0
�
#optimizer/PolynomialDecay_1/truedivRealDiv#optimizer/PolynomialDecay_1/Minimum"optimizer/PolynomialDecay_1/Cast_3*
T0
�
optimizer/PolynomialDecay_1/subSub1optimizer/PolynomialDecay_1/initial_learning_rate"optimizer/PolynomialDecay_1/Cast/x*
T0
P
#optimizer/PolynomialDecay_1/sub_1/xConst*
dtype0*
valueB
 *  �?
{
!optimizer/PolynomialDecay_1/sub_1Sub#optimizer/PolynomialDecay_1/sub_1/x#optimizer/PolynomialDecay_1/truediv*
T0
x
optimizer/PolynomialDecay_1/PowPow!optimizer/PolynomialDecay_1/sub_1$optimizer/PolynomialDecay_1/Cast_1/x*
T0
q
optimizer/PolynomialDecay_1/MulMuloptimizer/PolynomialDecay_1/suboptimizer/PolynomialDecay_1/Pow*
T0
p
optimizer/PolynomialDecay_1Addoptimizer/PolynomialDecay_1/Mul"optimizer/PolynomialDecay_1/Cast/x*
T0
Q
optimizer/extrinsic_returnsPlaceholder*
dtype0*
shape:���������
X
"optimizer/extrinsic_value_estimatePlaceholder*
dtype0*
shape:���������
Q
optimizer/curiosity_returnsPlaceholder*
dtype0*
shape:���������
X
"optimizer/curiosity_value_estimatePlaceholder*
dtype0*
shape:���������
L
optimizer/gail_returnsPlaceholder*
dtype0*
shape:���������
S
optimizer/gail_value_estimatePlaceholder*
dtype0*
shape:���������
J
optimizer/advantagesPlaceholder*
dtype0*
shape:���������
M
optimizer/ExpandDims_2/dimConst*
dtype0*
valueB :
���������
k
optimizer/ExpandDims_2
ExpandDimsoptimizer/advantagesoptimizer/ExpandDims_2/dim*
T0*

Tdim0
^
1optimizer/PolynomialDecay_2/initial_learning_rateConst*
dtype0*
valueB
 *��L>
O
"optimizer/PolynomialDecay_2/Cast/xConst*
dtype0*
valueB
 *���=
Q
$optimizer/PolynomialDecay_2/Cast_1/xConst*
dtype0*
valueB
 *  �?
d
"optimizer/PolynomialDecay_2/Cast_2Castglobal_step/read*

DstT0*

SrcT0*
Truncate( 
Q
$optimizer/PolynomialDecay_2/Cast_3/xConst*
dtype0*
valueB
 *��K
�
#optimizer/PolynomialDecay_2/MinimumMinimum"optimizer/PolynomialDecay_2/Cast_2$optimizer/PolynomialDecay_2/Cast_3/x*
T0
�
#optimizer/PolynomialDecay_2/truedivRealDiv#optimizer/PolynomialDecay_2/Minimum$optimizer/PolynomialDecay_2/Cast_3/x*
T0
�
optimizer/PolynomialDecay_2/subSub1optimizer/PolynomialDecay_2/initial_learning_rate"optimizer/PolynomialDecay_2/Cast/x*
T0
P
#optimizer/PolynomialDecay_2/sub_1/xConst*
dtype0*
valueB
 *  �?
{
!optimizer/PolynomialDecay_2/sub_1Sub#optimizer/PolynomialDecay_2/sub_1/x#optimizer/PolynomialDecay_2/truediv*
T0
x
optimizer/PolynomialDecay_2/PowPow!optimizer/PolynomialDecay_2/sub_1$optimizer/PolynomialDecay_2/Cast_1/x*
T0
q
optimizer/PolynomialDecay_2/MulMuloptimizer/PolynomialDecay_2/suboptimizer/PolynomialDecay_2/Pow*
T0
p
optimizer/PolynomialDecay_2Addoptimizer/PolynomialDecay_2/Mul"optimizer/PolynomialDecay_2/Cast/x*
T0
^
1optimizer/PolynomialDecay_3/initial_learning_rateConst*
dtype0*
valueB
 *
ף;
O
"optimizer/PolynomialDecay_3/Cast/xConst*
dtype0*
valueB
 *��'7
Q
$optimizer/PolynomialDecay_3/Cast_1/xConst*
dtype0*
valueB
 *  �?
d
"optimizer/PolynomialDecay_3/Cast_2Castglobal_step/read*

DstT0*

SrcT0*
Truncate( 
Q
$optimizer/PolynomialDecay_3/Cast_3/xConst*
dtype0*
valueB
 *��K
�
#optimizer/PolynomialDecay_3/MinimumMinimum"optimizer/PolynomialDecay_3/Cast_2$optimizer/PolynomialDecay_3/Cast_3/x*
T0
�
#optimizer/PolynomialDecay_3/truedivRealDiv#optimizer/PolynomialDecay_3/Minimum$optimizer/PolynomialDecay_3/Cast_3/x*
T0
�
optimizer/PolynomialDecay_3/subSub1optimizer/PolynomialDecay_3/initial_learning_rate"optimizer/PolynomialDecay_3/Cast/x*
T0
P
#optimizer/PolynomialDecay_3/sub_1/xConst*
dtype0*
valueB
 *  �?
{
!optimizer/PolynomialDecay_3/sub_1Sub#optimizer/PolynomialDecay_3/sub_1/x#optimizer/PolynomialDecay_3/truediv*
T0
x
optimizer/PolynomialDecay_3/PowPow!optimizer/PolynomialDecay_3/sub_1$optimizer/PolynomialDecay_3/Cast_1/x*
T0
q
optimizer/PolynomialDecay_3/MulMuloptimizer/PolynomialDecay_3/suboptimizer/PolynomialDecay_3/Pow*
T0
p
optimizer/PolynomialDecay_3Addoptimizer/PolynomialDecay_3/Mul"optimizer/PolynomialDecay_3/Cast/x*
T0
K
!optimizer/Sum_4/reduction_indicesConst*
dtype0*
value	B :
�
optimizer/Sum_4Sum!optimizer/extrinsic_value/BiasAdd!optimizer/Sum_4/reduction_indices*
T0*

Tidx0*
	keep_dims( 
T
optimizer/sub_7Suboptimizer/Sum_4"optimizer/extrinsic_value_estimate*
T0
<
optimizer/Neg_2Negoptimizer/PolynomialDecay_2*
T0
a
optimizer/clip_by_value/MinimumMinimumoptimizer/sub_7optimizer/PolynomialDecay_2*
T0
]
optimizer/clip_by_valueMaximumoptimizer/clip_by_value/Minimumoptimizer/Neg_2*
T0
_
optimizer/add_11AddV2"optimizer/extrinsic_value_estimateoptimizer/clip_by_value*
T0
K
!optimizer/Sum_5/reduction_indicesConst*
dtype0*
value	B :
�
optimizer/Sum_5Sum!optimizer/extrinsic_value/BiasAdd!optimizer/Sum_5/reduction_indices*
T0*

Tidx0*
	keep_dims( 
i
optimizer/SquaredDifference_3SquaredDifferenceoptimizer/extrinsic_returnsoptimizer/Sum_5*
T0
j
optimizer/SquaredDifference_4SquaredDifferenceoptimizer/extrinsic_returnsoptimizer/add_11*
T0
c
optimizer/MaximumMaximumoptimizer/SquaredDifference_3optimizer/SquaredDifference_4*
T0
j
optimizer/DynamicPartition_2DynamicPartitionoptimizer/MaximumCast_3*
T0*
num_partitions
?
optimizer/Const_9Const*
dtype0*
valueB: 
r
optimizer/Mean_10Meanoptimizer/DynamicPartition_2:1optimizer/Const_9*
T0*

Tidx0*
	keep_dims( 
K
!optimizer/Sum_6/reduction_indicesConst*
dtype0*
value	B :
�
optimizer/Sum_6Sum!optimizer/curiosity_value/BiasAdd!optimizer/Sum_6/reduction_indices*
T0*

Tidx0*
	keep_dims( 
T
optimizer/sub_8Suboptimizer/Sum_6"optimizer/curiosity_value_estimate*
T0
<
optimizer/Neg_3Negoptimizer/PolynomialDecay_2*
T0
c
!optimizer/clip_by_value_1/MinimumMinimumoptimizer/sub_8optimizer/PolynomialDecay_2*
T0
a
optimizer/clip_by_value_1Maximum!optimizer/clip_by_value_1/Minimumoptimizer/Neg_3*
T0
a
optimizer/add_12AddV2"optimizer/curiosity_value_estimateoptimizer/clip_by_value_1*
T0
K
!optimizer/Sum_7/reduction_indicesConst*
dtype0*
value	B :
�
optimizer/Sum_7Sum!optimizer/curiosity_value/BiasAdd!optimizer/Sum_7/reduction_indices*
T0*

Tidx0*
	keep_dims( 
i
optimizer/SquaredDifference_5SquaredDifferenceoptimizer/curiosity_returnsoptimizer/Sum_7*
T0
j
optimizer/SquaredDifference_6SquaredDifferenceoptimizer/curiosity_returnsoptimizer/add_12*
T0
e
optimizer/Maximum_1Maximumoptimizer/SquaredDifference_5optimizer/SquaredDifference_6*
T0
l
optimizer/DynamicPartition_3DynamicPartitionoptimizer/Maximum_1Cast_3*
T0*
num_partitions
@
optimizer/Const_10Const*
dtype0*
valueB: 
s
optimizer/Mean_11Meanoptimizer/DynamicPartition_3:1optimizer/Const_10*
T0*

Tidx0*
	keep_dims( 
K
!optimizer/Sum_8/reduction_indicesConst*
dtype0*
value	B :
}
optimizer/Sum_8Sumoptimizer/gail_value/BiasAdd!optimizer/Sum_8/reduction_indices*
T0*

Tidx0*
	keep_dims( 
O
optimizer/sub_9Suboptimizer/Sum_8optimizer/gail_value_estimate*
T0
<
optimizer/Neg_4Negoptimizer/PolynomialDecay_2*
T0
c
!optimizer/clip_by_value_2/MinimumMinimumoptimizer/sub_9optimizer/PolynomialDecay_2*
T0
a
optimizer/clip_by_value_2Maximum!optimizer/clip_by_value_2/Minimumoptimizer/Neg_4*
T0
\
optimizer/add_13AddV2optimizer/gail_value_estimateoptimizer/clip_by_value_2*
T0
K
!optimizer/Sum_9/reduction_indicesConst*
dtype0*
value	B :
}
optimizer/Sum_9Sumoptimizer/gail_value/BiasAdd!optimizer/Sum_9/reduction_indices*
T0*

Tidx0*
	keep_dims( 
d
optimizer/SquaredDifference_7SquaredDifferenceoptimizer/gail_returnsoptimizer/Sum_9*
T0
e
optimizer/SquaredDifference_8SquaredDifferenceoptimizer/gail_returnsoptimizer/add_13*
T0
e
optimizer/Maximum_2Maximumoptimizer/SquaredDifference_7optimizer/SquaredDifference_8*
T0
l
optimizer/DynamicPartition_4DynamicPartitionoptimizer/Maximum_2Cast_3*
T0*
num_partitions
@
optimizer/Const_11Const*
dtype0*
valueB: 
s
optimizer/Mean_12Meanoptimizer/DynamicPartition_4:1optimizer/Const_11*
T0*

Tidx0*
	keep_dims( 
t
optimizer/Rank/packedPackoptimizer/Mean_10optimizer/Mean_11optimizer/Mean_12*
N*
T0*

axis 
8
optimizer/RankConst*
dtype0*
value	B :
?
optimizer/range/startConst*
dtype0*
value	B : 
?
optimizer/range/deltaConst*
dtype0*
value	B :
b
optimizer/rangeRangeoptimizer/range/startoptimizer/Rankoptimizer/range/delta*

Tidx0
v
optimizer/Mean_13/inputPackoptimizer/Mean_10optimizer/Mean_11optimizer/Mean_12*
N*
T0*

axis 
i
optimizer/Mean_13Meanoptimizer/Mean_13/inputoptimizer/range*
T0*

Tidx0*
	keep_dims( 
?
optimizer/sub_10Subpolicy_1/Sumoptimizer/Sum_3*
T0
/
optimizer/ExpExpoptimizer/sub_10*
T0
G
optimizer/mul_11Muloptimizer/Expoptimizer/ExpandDims_2*
T0
?
optimizer/sub_11/xConst*
dtype0*
valueB
 *  �?
Q
optimizer/sub_11Suboptimizer/sub_11/xoptimizer/PolynomialDecay_2*
T0
?
optimizer/add_14/xConst*
dtype0*
valueB
 *  �?
S
optimizer/add_14AddV2optimizer/add_14/xoptimizer/PolynomialDecay_2*
T0
V
!optimizer/clip_by_value_3/MinimumMinimumoptimizer/Expoptimizer/add_14*
T0
b
optimizer/clip_by_value_3Maximum!optimizer/clip_by_value_3/Minimumoptimizer/sub_11*
T0
S
optimizer/mul_12Muloptimizer/clip_by_value_3optimizer/ExpandDims_2*
T0
I
optimizer/MinimumMinimumoptimizer/mul_11optimizer/mul_12*
T0
j
optimizer/DynamicPartition_5DynamicPartitionoptimizer/MinimumCast_3*
T0*
num_partitions
G
optimizer/Const_12Const*
dtype0*
valueB"       
s
optimizer/Mean_14Meanoptimizer/DynamicPartition_5:1optimizer/Const_12*
T0*

Tidx0*
	keep_dims( 
2
optimizer/Neg_5Negoptimizer/Mean_14*
T0
.
optimizer/AbsAbsoptimizer/Neg_5*
T0
?
optimizer/mul_13/xConst*
dtype0*
valueB
 *   ?
G
optimizer/mul_13Muloptimizer/mul_13/xoptimizer/Mean_13*
T0
E
optimizer/add_15AddV2optimizer/Neg_5optimizer/mul_13*
T0
g
optimizer/DynamicPartition_6DynamicPartitionpolicy_1/mul_5Cast_3*
T0*
num_partitions
@
optimizer/Const_13Const*
dtype0*
valueB: 
s
optimizer/Mean_15Meanoptimizer/DynamicPartition_6:1optimizer/Const_13*
T0*

Tidx0*
	keep_dims( 
P
optimizer/mul_14Muloptimizer/PolynomialDecay_3optimizer/Mean_15*
T0
D
optimizer/sub_12Suboptimizer/add_15optimizer/mul_14*
T0
D
optimizer/gradients_4/ShapeConst*
dtype0*
valueB 
L
optimizer/gradients_4/grad_ys_0Const*
dtype0*
valueB
 *  �?
{
optimizer/gradients_4/FillFilloptimizer/gradients_4/Shapeoptimizer/gradients_4/grad_ys_0*
T0*

index_type0
[
/optimizer/gradients_4/optimizer/sub_12_grad/NegNegoptimizer/gradients_4/Fill*
T0
�
<optimizer/gradients_4/optimizer/sub_12_grad/tuple/group_depsNoOp^optimizer/gradients_4/Fill0^optimizer/gradients_4/optimizer/sub_12_grad/Neg
�
Doptimizer/gradients_4/optimizer/sub_12_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/Fill=^optimizer/gradients_4/optimizer/sub_12_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_4/Fill
�
Foptimizer/gradients_4/optimizer/sub_12_grad/tuple/control_dependency_1Identity/optimizer/gradients_4/optimizer/sub_12_grad/Neg=^optimizer/gradients_4/optimizer/sub_12_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/optimizer/sub_12_grad/Neg
�
<optimizer/gradients_4/optimizer/add_15_grad/tuple/group_depsNoOpE^optimizer/gradients_4/optimizer/sub_12_grad/tuple/control_dependency
�
Doptimizer/gradients_4/optimizer/add_15_grad/tuple/control_dependencyIdentityDoptimizer/gradients_4/optimizer/sub_12_grad/tuple/control_dependency=^optimizer/gradients_4/optimizer/add_15_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_4/Fill
�
Foptimizer/gradients_4/optimizer/add_15_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_4/optimizer/sub_12_grad/tuple/control_dependency=^optimizer/gradients_4/optimizer/add_15_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_4/Fill
�
/optimizer/gradients_4/optimizer/mul_14_grad/MulMulFoptimizer/gradients_4/optimizer/sub_12_grad/tuple/control_dependency_1optimizer/Mean_15*
T0
�
1optimizer/gradients_4/optimizer/mul_14_grad/Mul_1MulFoptimizer/gradients_4/optimizer/sub_12_grad/tuple/control_dependency_1optimizer/PolynomialDecay_3*
T0
�
<optimizer/gradients_4/optimizer/mul_14_grad/tuple/group_depsNoOp0^optimizer/gradients_4/optimizer/mul_14_grad/Mul2^optimizer/gradients_4/optimizer/mul_14_grad/Mul_1
�
Doptimizer/gradients_4/optimizer/mul_14_grad/tuple/control_dependencyIdentity/optimizer/gradients_4/optimizer/mul_14_grad/Mul=^optimizer/gradients_4/optimizer/mul_14_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/optimizer/mul_14_grad/Mul
�
Foptimizer/gradients_4/optimizer/mul_14_grad/tuple/control_dependency_1Identity1optimizer/gradients_4/optimizer/mul_14_grad/Mul_1=^optimizer/gradients_4/optimizer/mul_14_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/optimizer/mul_14_grad/Mul_1
�
.optimizer/gradients_4/optimizer/Neg_5_grad/NegNegDoptimizer/gradients_4/optimizer/add_15_grad/tuple/control_dependency*
T0
�
/optimizer/gradients_4/optimizer/mul_13_grad/MulMulFoptimizer/gradients_4/optimizer/add_15_grad/tuple/control_dependency_1optimizer/Mean_13*
T0
�
1optimizer/gradients_4/optimizer/mul_13_grad/Mul_1MulFoptimizer/gradients_4/optimizer/add_15_grad/tuple/control_dependency_1optimizer/mul_13/x*
T0
�
<optimizer/gradients_4/optimizer/mul_13_grad/tuple/group_depsNoOp0^optimizer/gradients_4/optimizer/mul_13_grad/Mul2^optimizer/gradients_4/optimizer/mul_13_grad/Mul_1
�
Doptimizer/gradients_4/optimizer/mul_13_grad/tuple/control_dependencyIdentity/optimizer/gradients_4/optimizer/mul_13_grad/Mul=^optimizer/gradients_4/optimizer/mul_13_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/optimizer/mul_13_grad/Mul
�
Foptimizer/gradients_4/optimizer/mul_13_grad/tuple/control_dependency_1Identity1optimizer/gradients_4/optimizer/mul_13_grad/Mul_1=^optimizer/gradients_4/optimizer/mul_13_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/optimizer/mul_13_grad/Mul_1
h
:optimizer/gradients_4/optimizer/Mean_15_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_4/optimizer/Mean_15_grad/ReshapeReshapeFoptimizer/gradients_4/optimizer/mul_14_grad/tuple/control_dependency_1:optimizer/gradients_4/optimizer/Mean_15_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_4/optimizer/Mean_15_grad/ShapeShapeoptimizer/DynamicPartition_6:1*
T0*
out_type0
�
1optimizer/gradients_4/optimizer/Mean_15_grad/TileTile4optimizer/gradients_4/optimizer/Mean_15_grad/Reshape2optimizer/gradients_4/optimizer/Mean_15_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_4/optimizer/Mean_15_grad/Shape_1Shapeoptimizer/DynamicPartition_6:1*
T0*
out_type0
]
4optimizer/gradients_4/optimizer/Mean_15_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_4/optimizer/Mean_15_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_4/optimizer/Mean_15_grad/ProdProd4optimizer/gradients_4/optimizer/Mean_15_grad/Shape_12optimizer/gradients_4/optimizer/Mean_15_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_4/optimizer/Mean_15_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_4/optimizer/Mean_15_grad/Prod_1Prod4optimizer/gradients_4/optimizer/Mean_15_grad/Shape_24optimizer/gradients_4/optimizer/Mean_15_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_4/optimizer/Mean_15_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_4/optimizer/Mean_15_grad/MaximumMaximum3optimizer/gradients_4/optimizer/Mean_15_grad/Prod_16optimizer/gradients_4/optimizer/Mean_15_grad/Maximum/y*
T0
�
5optimizer/gradients_4/optimizer/Mean_15_grad/floordivFloorDiv1optimizer/gradients_4/optimizer/Mean_15_grad/Prod4optimizer/gradients_4/optimizer/Mean_15_grad/Maximum*
T0
�
1optimizer/gradients_4/optimizer/Mean_15_grad/CastCast5optimizer/gradients_4/optimizer/Mean_15_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_4/optimizer/Mean_15_grad/truedivRealDiv1optimizer/gradients_4/optimizer/Mean_15_grad/Tile1optimizer/gradients_4/optimizer/Mean_15_grad/Cast*
T0
o
:optimizer/gradients_4/optimizer/Mean_14_grad/Reshape/shapeConst*
dtype0*
valueB"      
�
4optimizer/gradients_4/optimizer/Mean_14_grad/ReshapeReshape.optimizer/gradients_4/optimizer/Neg_5_grad/Neg:optimizer/gradients_4/optimizer/Mean_14_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_4/optimizer/Mean_14_grad/ShapeShapeoptimizer/DynamicPartition_5:1*
T0*
out_type0
�
1optimizer/gradients_4/optimizer/Mean_14_grad/TileTile4optimizer/gradients_4/optimizer/Mean_14_grad/Reshape2optimizer/gradients_4/optimizer/Mean_14_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_4/optimizer/Mean_14_grad/Shape_1Shapeoptimizer/DynamicPartition_5:1*
T0*
out_type0
]
4optimizer/gradients_4/optimizer/Mean_14_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_4/optimizer/Mean_14_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_4/optimizer/Mean_14_grad/ProdProd4optimizer/gradients_4/optimizer/Mean_14_grad/Shape_12optimizer/gradients_4/optimizer/Mean_14_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_4/optimizer/Mean_14_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_4/optimizer/Mean_14_grad/Prod_1Prod4optimizer/gradients_4/optimizer/Mean_14_grad/Shape_24optimizer/gradients_4/optimizer/Mean_14_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_4/optimizer/Mean_14_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_4/optimizer/Mean_14_grad/MaximumMaximum3optimizer/gradients_4/optimizer/Mean_14_grad/Prod_16optimizer/gradients_4/optimizer/Mean_14_grad/Maximum/y*
T0
�
5optimizer/gradients_4/optimizer/Mean_14_grad/floordivFloorDiv1optimizer/gradients_4/optimizer/Mean_14_grad/Prod4optimizer/gradients_4/optimizer/Mean_14_grad/Maximum*
T0
�
1optimizer/gradients_4/optimizer/Mean_14_grad/CastCast5optimizer/gradients_4/optimizer/Mean_14_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_4/optimizer/Mean_14_grad/truedivRealDiv1optimizer/gradients_4/optimizer/Mean_14_grad/Tile1optimizer/gradients_4/optimizer/Mean_14_grad/Cast*
T0
h
:optimizer/gradients_4/optimizer/Mean_13_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_4/optimizer/Mean_13_grad/ReshapeReshapeFoptimizer/gradients_4/optimizer/mul_13_grad/tuple/control_dependency_1:optimizer/gradients_4/optimizer/Mean_13_grad/Reshape/shape*
T0*
Tshape0
`
2optimizer/gradients_4/optimizer/Mean_13_grad/ConstConst*
dtype0*
valueB:
�
1optimizer/gradients_4/optimizer/Mean_13_grad/TileTile4optimizer/gradients_4/optimizer/Mean_13_grad/Reshape2optimizer/gradients_4/optimizer/Mean_13_grad/Const*
T0*

Tmultiples0
a
4optimizer/gradients_4/optimizer/Mean_13_grad/Const_1Const*
dtype0*
valueB
 *  @@
�
4optimizer/gradients_4/optimizer/Mean_13_grad/truedivRealDiv1optimizer/gradients_4/optimizer/Mean_13_grad/Tile4optimizer/gradients_4/optimizer/Mean_13_grad/Const_1*
T0
T
 optimizer/gradients_4/zeros_like	ZerosLikeoptimizer/DynamicPartition_6*
T0
g
=optimizer/gradients_4/optimizer/DynamicPartition_6_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_4/optimizer/DynamicPartition_6_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_4/optimizer/DynamicPartition_6_grad/ProdProd=optimizer/gradients_4/optimizer/DynamicPartition_6_grad/Shape=optimizer/gradients_4/optimizer/DynamicPartition_6_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_6_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_6_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_4/optimizer/DynamicPartition_6_grad/rangeRangeCoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/range/start<optimizer/gradients_4/optimizer/DynamicPartition_6_grad/ProdCoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/range/delta*

Tidx0
�
?optimizer/gradients_4/optimizer/DynamicPartition_6_grad/ReshapeReshape=optimizer/gradients_4/optimizer/DynamicPartition_6_grad/range=optimizer/gradients_4/optimizer/DynamicPartition_6_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/DynamicPartitionDynamicPartition?optimizer/gradients_4/optimizer/DynamicPartition_6_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_4/optimizer/DynamicPartition_6_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/DynamicPartitionJoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/DynamicPartition:1 optimizer/gradients_4/zeros_like4optimizer/gradients_4/optimizer/Mean_15_grad/truediv*
N*
T0
q
?optimizer/gradients_4/optimizer/DynamicPartition_6_grad/Shape_1Shapepolicy_1/mul_5*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/Reshape_1ReshapeMoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/ParallelDynamicStitch?optimizer/gradients_4/optimizer/DynamicPartition_6_grad/Shape_1*
T0*
Tshape0
V
"optimizer/gradients_4/zeros_like_1	ZerosLikeoptimizer/DynamicPartition_5*
T0
g
=optimizer/gradients_4/optimizer/DynamicPartition_5_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_4/optimizer/DynamicPartition_5_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_4/optimizer/DynamicPartition_5_grad/ProdProd=optimizer/gradients_4/optimizer/DynamicPartition_5_grad/Shape=optimizer/gradients_4/optimizer/DynamicPartition_5_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_5_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_5_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_4/optimizer/DynamicPartition_5_grad/rangeRangeCoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/range/start<optimizer/gradients_4/optimizer/DynamicPartition_5_grad/ProdCoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/range/delta*

Tidx0
�
?optimizer/gradients_4/optimizer/DynamicPartition_5_grad/ReshapeReshape=optimizer/gradients_4/optimizer/DynamicPartition_5_grad/range=optimizer/gradients_4/optimizer/DynamicPartition_5_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/DynamicPartitionDynamicPartition?optimizer/gradients_4/optimizer/DynamicPartition_5_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_4/optimizer/DynamicPartition_5_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/DynamicPartitionJoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/DynamicPartition:1"optimizer/gradients_4/zeros_like_14optimizer/gradients_4/optimizer/Mean_14_grad/truediv*
N*
T0
t
?optimizer/gradients_4/optimizer/DynamicPartition_5_grad/Shape_1Shapeoptimizer/Minimum*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/Reshape_1ReshapeMoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/ParallelDynamicStitch?optimizer/gradients_4/optimizer/DynamicPartition_5_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_4/optimizer/Mean_13/input_grad/unstackUnpack4optimizer/gradients_4/optimizer/Mean_13_grad/truediv*
T0*

axis *	
num
�
Coptimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/group_depsNoOp;^optimizer/gradients_4/optimizer/Mean_13/input_grad/unstack
�
Koptimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/control_dependencyIdentity:optimizer/gradients_4/optimizer/Mean_13/input_grad/unstackD^optimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_4/optimizer/Mean_13/input_grad/unstack
�
Moptimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/Mean_13/input_grad/unstack:1D^optimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_4/optimizer/Mean_13/input_grad/unstack
�
Moptimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/control_dependency_2Identity<optimizer/gradients_4/optimizer/Mean_13/input_grad/unstack:2D^optimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_4/optimizer/Mean_13/input_grad/unstack
e
/optimizer/gradients_4/policy_1/mul_5_grad/ShapeShapepolicy_1/ones_like*
T0*
out_type0
c
1optimizer/gradients_4/policy_1/mul_5_grad/Shape_1Shapepolicy_1/mul_4*
T0*
out_type0
�
?optimizer/gradients_4/policy_1/mul_5_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_4/policy_1/mul_5_grad/Shape1optimizer/gradients_4/policy_1/mul_5_grad/Shape_1*
T0
�
-optimizer/gradients_4/policy_1/mul_5_grad/MulMulAoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/Reshape_1policy_1/mul_4*
T0
�
-optimizer/gradients_4/policy_1/mul_5_grad/SumSum-optimizer/gradients_4/policy_1/mul_5_grad/Mul?optimizer/gradients_4/policy_1/mul_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_4/policy_1/mul_5_grad/ReshapeReshape-optimizer/gradients_4/policy_1/mul_5_grad/Sum/optimizer/gradients_4/policy_1/mul_5_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_4/policy_1/mul_5_grad/Mul_1Mulpolicy_1/ones_likeAoptimizer/gradients_4/optimizer/DynamicPartition_6_grad/Reshape_1*
T0
�
/optimizer/gradients_4/policy_1/mul_5_grad/Sum_1Sum/optimizer/gradients_4/policy_1/mul_5_grad/Mul_1Aoptimizer/gradients_4/policy_1/mul_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/policy_1/mul_5_grad/Reshape_1Reshape/optimizer/gradients_4/policy_1/mul_5_grad/Sum_11optimizer/gradients_4/policy_1/mul_5_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_4/policy_1/mul_5_grad/tuple/group_depsNoOp2^optimizer/gradients_4/policy_1/mul_5_grad/Reshape4^optimizer/gradients_4/policy_1/mul_5_grad/Reshape_1
�
Boptimizer/gradients_4/policy_1/mul_5_grad/tuple/control_dependencyIdentity1optimizer/gradients_4/policy_1/mul_5_grad/Reshape;^optimizer/gradients_4/policy_1/mul_5_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/mul_5_grad/Reshape
�
Doptimizer/gradients_4/policy_1/mul_5_grad/tuple/control_dependency_1Identity3optimizer/gradients_4/policy_1/mul_5_grad/Reshape_1;^optimizer/gradients_4/policy_1/mul_5_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/policy_1/mul_5_grad/Reshape_1
f
2optimizer/gradients_4/optimizer/Minimum_grad/ShapeShapeoptimizer/mul_11*
T0*
out_type0
h
4optimizer/gradients_4/optimizer/Minimum_grad/Shape_1Shapeoptimizer/mul_12*
T0*
out_type0
�
4optimizer/gradients_4/optimizer/Minimum_grad/Shape_2ShapeAoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/Reshape_1*
T0*
out_type0
e
8optimizer/gradients_4/optimizer/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
2optimizer/gradients_4/optimizer/Minimum_grad/zerosFill4optimizer/gradients_4/optimizer/Minimum_grad/Shape_28optimizer/gradients_4/optimizer/Minimum_grad/zeros/Const*
T0*

index_type0
p
6optimizer/gradients_4/optimizer/Minimum_grad/LessEqual	LessEqualoptimizer/mul_11optimizer/mul_12*
T0
�
Boptimizer/gradients_4/optimizer/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs2optimizer/gradients_4/optimizer/Minimum_grad/Shape4optimizer/gradients_4/optimizer/Minimum_grad/Shape_1*
T0
�
5optimizer/gradients_4/optimizer/Minimum_grad/SelectV2SelectV26optimizer/gradients_4/optimizer/Minimum_grad/LessEqualAoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/Reshape_12optimizer/gradients_4/optimizer/Minimum_grad/zeros*
T0
�
0optimizer/gradients_4/optimizer/Minimum_grad/SumSum5optimizer/gradients_4/optimizer/Minimum_grad/SelectV2Boptimizer/gradients_4/optimizer/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_4/optimizer/Minimum_grad/ReshapeReshape0optimizer/gradients_4/optimizer/Minimum_grad/Sum2optimizer/gradients_4/optimizer/Minimum_grad/Shape*
T0*
Tshape0
�
7optimizer/gradients_4/optimizer/Minimum_grad/SelectV2_1SelectV26optimizer/gradients_4/optimizer/Minimum_grad/LessEqual2optimizer/gradients_4/optimizer/Minimum_grad/zerosAoptimizer/gradients_4/optimizer/DynamicPartition_5_grad/Reshape_1*
T0
�
2optimizer/gradients_4/optimizer/Minimum_grad/Sum_1Sum7optimizer/gradients_4/optimizer/Minimum_grad/SelectV2_1Doptimizer/gradients_4/optimizer/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_4/optimizer/Minimum_grad/Reshape_1Reshape2optimizer/gradients_4/optimizer/Minimum_grad/Sum_14optimizer/gradients_4/optimizer/Minimum_grad/Shape_1*
T0*
Tshape0
�
=optimizer/gradients_4/optimizer/Minimum_grad/tuple/group_depsNoOp5^optimizer/gradients_4/optimizer/Minimum_grad/Reshape7^optimizer/gradients_4/optimizer/Minimum_grad/Reshape_1
�
Eoptimizer/gradients_4/optimizer/Minimum_grad/tuple/control_dependencyIdentity4optimizer/gradients_4/optimizer/Minimum_grad/Reshape>^optimizer/gradients_4/optimizer/Minimum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_4/optimizer/Minimum_grad/Reshape
�
Goptimizer/gradients_4/optimizer/Minimum_grad/tuple/control_dependency_1Identity6optimizer/gradients_4/optimizer/Minimum_grad/Reshape_1>^optimizer/gradients_4/optimizer/Minimum_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Minimum_grad/Reshape_1
h
:optimizer/gradients_4/optimizer/Mean_10_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_4/optimizer/Mean_10_grad/ReshapeReshapeKoptimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/control_dependency:optimizer/gradients_4/optimizer/Mean_10_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_4/optimizer/Mean_10_grad/ShapeShapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
�
1optimizer/gradients_4/optimizer/Mean_10_grad/TileTile4optimizer/gradients_4/optimizer/Mean_10_grad/Reshape2optimizer/gradients_4/optimizer/Mean_10_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_4/optimizer/Mean_10_grad/Shape_1Shapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
]
4optimizer/gradients_4/optimizer/Mean_10_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_4/optimizer/Mean_10_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_4/optimizer/Mean_10_grad/ProdProd4optimizer/gradients_4/optimizer/Mean_10_grad/Shape_12optimizer/gradients_4/optimizer/Mean_10_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_4/optimizer/Mean_10_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_4/optimizer/Mean_10_grad/Prod_1Prod4optimizer/gradients_4/optimizer/Mean_10_grad/Shape_24optimizer/gradients_4/optimizer/Mean_10_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_4/optimizer/Mean_10_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_4/optimizer/Mean_10_grad/MaximumMaximum3optimizer/gradients_4/optimizer/Mean_10_grad/Prod_16optimizer/gradients_4/optimizer/Mean_10_grad/Maximum/y*
T0
�
5optimizer/gradients_4/optimizer/Mean_10_grad/floordivFloorDiv1optimizer/gradients_4/optimizer/Mean_10_grad/Prod4optimizer/gradients_4/optimizer/Mean_10_grad/Maximum*
T0
�
1optimizer/gradients_4/optimizer/Mean_10_grad/CastCast5optimizer/gradients_4/optimizer/Mean_10_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_4/optimizer/Mean_10_grad/truedivRealDiv1optimizer/gradients_4/optimizer/Mean_10_grad/Tile1optimizer/gradients_4/optimizer/Mean_10_grad/Cast*
T0
h
:optimizer/gradients_4/optimizer/Mean_11_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_4/optimizer/Mean_11_grad/ReshapeReshapeMoptimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/control_dependency_1:optimizer/gradients_4/optimizer/Mean_11_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_4/optimizer/Mean_11_grad/ShapeShapeoptimizer/DynamicPartition_3:1*
T0*
out_type0
�
1optimizer/gradients_4/optimizer/Mean_11_grad/TileTile4optimizer/gradients_4/optimizer/Mean_11_grad/Reshape2optimizer/gradients_4/optimizer/Mean_11_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_4/optimizer/Mean_11_grad/Shape_1Shapeoptimizer/DynamicPartition_3:1*
T0*
out_type0
]
4optimizer/gradients_4/optimizer/Mean_11_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_4/optimizer/Mean_11_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_4/optimizer/Mean_11_grad/ProdProd4optimizer/gradients_4/optimizer/Mean_11_grad/Shape_12optimizer/gradients_4/optimizer/Mean_11_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_4/optimizer/Mean_11_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_4/optimizer/Mean_11_grad/Prod_1Prod4optimizer/gradients_4/optimizer/Mean_11_grad/Shape_24optimizer/gradients_4/optimizer/Mean_11_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_4/optimizer/Mean_11_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_4/optimizer/Mean_11_grad/MaximumMaximum3optimizer/gradients_4/optimizer/Mean_11_grad/Prod_16optimizer/gradients_4/optimizer/Mean_11_grad/Maximum/y*
T0
�
5optimizer/gradients_4/optimizer/Mean_11_grad/floordivFloorDiv1optimizer/gradients_4/optimizer/Mean_11_grad/Prod4optimizer/gradients_4/optimizer/Mean_11_grad/Maximum*
T0
�
1optimizer/gradients_4/optimizer/Mean_11_grad/CastCast5optimizer/gradients_4/optimizer/Mean_11_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_4/optimizer/Mean_11_grad/truedivRealDiv1optimizer/gradients_4/optimizer/Mean_11_grad/Tile1optimizer/gradients_4/optimizer/Mean_11_grad/Cast*
T0
h
:optimizer/gradients_4/optimizer/Mean_12_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_4/optimizer/Mean_12_grad/ReshapeReshapeMoptimizer/gradients_4/optimizer/Mean_13/input_grad/tuple/control_dependency_2:optimizer/gradients_4/optimizer/Mean_12_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_4/optimizer/Mean_12_grad/ShapeShapeoptimizer/DynamicPartition_4:1*
T0*
out_type0
�
1optimizer/gradients_4/optimizer/Mean_12_grad/TileTile4optimizer/gradients_4/optimizer/Mean_12_grad/Reshape2optimizer/gradients_4/optimizer/Mean_12_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_4/optimizer/Mean_12_grad/Shape_1Shapeoptimizer/DynamicPartition_4:1*
T0*
out_type0
]
4optimizer/gradients_4/optimizer/Mean_12_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_4/optimizer/Mean_12_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_4/optimizer/Mean_12_grad/ProdProd4optimizer/gradients_4/optimizer/Mean_12_grad/Shape_12optimizer/gradients_4/optimizer/Mean_12_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_4/optimizer/Mean_12_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_4/optimizer/Mean_12_grad/Prod_1Prod4optimizer/gradients_4/optimizer/Mean_12_grad/Shape_24optimizer/gradients_4/optimizer/Mean_12_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_4/optimizer/Mean_12_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_4/optimizer/Mean_12_grad/MaximumMaximum3optimizer/gradients_4/optimizer/Mean_12_grad/Prod_16optimizer/gradients_4/optimizer/Mean_12_grad/Maximum/y*
T0
�
5optimizer/gradients_4/optimizer/Mean_12_grad/floordivFloorDiv1optimizer/gradients_4/optimizer/Mean_12_grad/Prod4optimizer/gradients_4/optimizer/Mean_12_grad/Maximum*
T0
�
1optimizer/gradients_4/optimizer/Mean_12_grad/CastCast5optimizer/gradients_4/optimizer/Mean_12_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_4/optimizer/Mean_12_grad/truedivRealDiv1optimizer/gradients_4/optimizer/Mean_12_grad/Tile1optimizer/gradients_4/optimizer/Mean_12_grad/Cast*
T0
�
-optimizer/gradients_4/policy_1/mul_4_grad/MulMulDoptimizer/gradients_4/policy_1/mul_5_grad/tuple/control_dependency_1policy_1/Mean*
T0
�
/optimizer/gradients_4/policy_1/mul_4_grad/Mul_1MulDoptimizer/gradients_4/policy_1/mul_5_grad/tuple/control_dependency_1policy_1/mul_4/x*
T0
�
:optimizer/gradients_4/policy_1/mul_4_grad/tuple/group_depsNoOp.^optimizer/gradients_4/policy_1/mul_4_grad/Mul0^optimizer/gradients_4/policy_1/mul_4_grad/Mul_1
�
Boptimizer/gradients_4/policy_1/mul_4_grad/tuple/control_dependencyIdentity-optimizer/gradients_4/policy_1/mul_4_grad/Mul;^optimizer/gradients_4/policy_1/mul_4_grad/tuple/group_deps*
T0*@
_class6
42loc:@optimizer/gradients_4/policy_1/mul_4_grad/Mul
�
Doptimizer/gradients_4/policy_1/mul_4_grad/tuple/control_dependency_1Identity/optimizer/gradients_4/policy_1/mul_4_grad/Mul_1;^optimizer/gradients_4/policy_1/mul_4_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/policy_1/mul_4_grad/Mul_1
b
1optimizer/gradients_4/optimizer/mul_11_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
m
3optimizer/gradients_4/optimizer/mul_11_grad/Shape_1Shapeoptimizer/ExpandDims_2*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/mul_11_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_4/optimizer/mul_11_grad/Shape3optimizer/gradients_4/optimizer/mul_11_grad/Shape_1*
T0
�
/optimizer/gradients_4/optimizer/mul_11_grad/MulMulEoptimizer/gradients_4/optimizer/Minimum_grad/tuple/control_dependencyoptimizer/ExpandDims_2*
T0
�
/optimizer/gradients_4/optimizer/mul_11_grad/SumSum/optimizer/gradients_4/optimizer/mul_11_grad/MulAoptimizer/gradients_4/optimizer/mul_11_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/optimizer/mul_11_grad/ReshapeReshape/optimizer/gradients_4/optimizer/mul_11_grad/Sum1optimizer/gradients_4/optimizer/mul_11_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_4/optimizer/mul_11_grad/Mul_1Muloptimizer/ExpEoptimizer/gradients_4/optimizer/Minimum_grad/tuple/control_dependency*
T0
�
1optimizer/gradients_4/optimizer/mul_11_grad/Sum_1Sum1optimizer/gradients_4/optimizer/mul_11_grad/Mul_1Coptimizer/gradients_4/optimizer/mul_11_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_4/optimizer/mul_11_grad/Reshape_1Reshape1optimizer/gradients_4/optimizer/mul_11_grad/Sum_13optimizer/gradients_4/optimizer/mul_11_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/mul_11_grad/tuple/group_depsNoOp4^optimizer/gradients_4/optimizer/mul_11_grad/Reshape6^optimizer/gradients_4/optimizer/mul_11_grad/Reshape_1
�
Doptimizer/gradients_4/optimizer/mul_11_grad/tuple/control_dependencyIdentity3optimizer/gradients_4/optimizer/mul_11_grad/Reshape=^optimizer/gradients_4/optimizer/mul_11_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/optimizer/mul_11_grad/Reshape
�
Foptimizer/gradients_4/optimizer/mul_11_grad/tuple/control_dependency_1Identity5optimizer/gradients_4/optimizer/mul_11_grad/Reshape_1=^optimizer/gradients_4/optimizer/mul_11_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/optimizer/mul_11_grad/Reshape_1
n
1optimizer/gradients_4/optimizer/mul_12_grad/ShapeShapeoptimizer/clip_by_value_3*
T0*
out_type0
m
3optimizer/gradients_4/optimizer/mul_12_grad/Shape_1Shapeoptimizer/ExpandDims_2*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/mul_12_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_4/optimizer/mul_12_grad/Shape3optimizer/gradients_4/optimizer/mul_12_grad/Shape_1*
T0
�
/optimizer/gradients_4/optimizer/mul_12_grad/MulMulGoptimizer/gradients_4/optimizer/Minimum_grad/tuple/control_dependency_1optimizer/ExpandDims_2*
T0
�
/optimizer/gradients_4/optimizer/mul_12_grad/SumSum/optimizer/gradients_4/optimizer/mul_12_grad/MulAoptimizer/gradients_4/optimizer/mul_12_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/optimizer/mul_12_grad/ReshapeReshape/optimizer/gradients_4/optimizer/mul_12_grad/Sum1optimizer/gradients_4/optimizer/mul_12_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_4/optimizer/mul_12_grad/Mul_1Muloptimizer/clip_by_value_3Goptimizer/gradients_4/optimizer/Minimum_grad/tuple/control_dependency_1*
T0
�
1optimizer/gradients_4/optimizer/mul_12_grad/Sum_1Sum1optimizer/gradients_4/optimizer/mul_12_grad/Mul_1Coptimizer/gradients_4/optimizer/mul_12_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_4/optimizer/mul_12_grad/Reshape_1Reshape1optimizer/gradients_4/optimizer/mul_12_grad/Sum_13optimizer/gradients_4/optimizer/mul_12_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/mul_12_grad/tuple/group_depsNoOp4^optimizer/gradients_4/optimizer/mul_12_grad/Reshape6^optimizer/gradients_4/optimizer/mul_12_grad/Reshape_1
�
Doptimizer/gradients_4/optimizer/mul_12_grad/tuple/control_dependencyIdentity3optimizer/gradients_4/optimizer/mul_12_grad/Reshape=^optimizer/gradients_4/optimizer/mul_12_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/optimizer/mul_12_grad/Reshape
�
Foptimizer/gradients_4/optimizer/mul_12_grad/tuple/control_dependency_1Identity5optimizer/gradients_4/optimizer/mul_12_grad/Reshape_1=^optimizer/gradients_4/optimizer/mul_12_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/optimizer/mul_12_grad/Reshape_1
V
"optimizer/gradients_4/zeros_like_2	ZerosLikeoptimizer/DynamicPartition_2*
T0
g
=optimizer/gradients_4/optimizer/DynamicPartition_2_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_4/optimizer/DynamicPartition_2_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_4/optimizer/DynamicPartition_2_grad/ProdProd=optimizer/gradients_4/optimizer/DynamicPartition_2_grad/Shape=optimizer/gradients_4/optimizer/DynamicPartition_2_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_2_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_2_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_4/optimizer/DynamicPartition_2_grad/rangeRangeCoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/range/start<optimizer/gradients_4/optimizer/DynamicPartition_2_grad/ProdCoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/range/delta*

Tidx0
�
?optimizer/gradients_4/optimizer/DynamicPartition_2_grad/ReshapeReshape=optimizer/gradients_4/optimizer/DynamicPartition_2_grad/range=optimizer/gradients_4/optimizer/DynamicPartition_2_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/DynamicPartitionDynamicPartition?optimizer/gradients_4/optimizer/DynamicPartition_2_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_4/optimizer/DynamicPartition_2_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/DynamicPartitionJoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/DynamicPartition:1"optimizer/gradients_4/zeros_like_24optimizer/gradients_4/optimizer/Mean_10_grad/truediv*
N*
T0
t
?optimizer/gradients_4/optimizer/DynamicPartition_2_grad/Shape_1Shapeoptimizer/Maximum*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/Reshape_1ReshapeMoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/ParallelDynamicStitch?optimizer/gradients_4/optimizer/DynamicPartition_2_grad/Shape_1*
T0*
Tshape0
V
"optimizer/gradients_4/zeros_like_3	ZerosLikeoptimizer/DynamicPartition_3*
T0
g
=optimizer/gradients_4/optimizer/DynamicPartition_3_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_4/optimizer/DynamicPartition_3_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_4/optimizer/DynamicPartition_3_grad/ProdProd=optimizer/gradients_4/optimizer/DynamicPartition_3_grad/Shape=optimizer/gradients_4/optimizer/DynamicPartition_3_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_3_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_3_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_4/optimizer/DynamicPartition_3_grad/rangeRangeCoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/range/start<optimizer/gradients_4/optimizer/DynamicPartition_3_grad/ProdCoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/range/delta*

Tidx0
�
?optimizer/gradients_4/optimizer/DynamicPartition_3_grad/ReshapeReshape=optimizer/gradients_4/optimizer/DynamicPartition_3_grad/range=optimizer/gradients_4/optimizer/DynamicPartition_3_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/DynamicPartitionDynamicPartition?optimizer/gradients_4/optimizer/DynamicPartition_3_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_4/optimizer/DynamicPartition_3_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/DynamicPartitionJoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/DynamicPartition:1"optimizer/gradients_4/zeros_like_34optimizer/gradients_4/optimizer/Mean_11_grad/truediv*
N*
T0
v
?optimizer/gradients_4/optimizer/DynamicPartition_3_grad/Shape_1Shapeoptimizer/Maximum_1*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/Reshape_1ReshapeMoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/ParallelDynamicStitch?optimizer/gradients_4/optimizer/DynamicPartition_3_grad/Shape_1*
T0*
Tshape0
V
"optimizer/gradients_4/zeros_like_4	ZerosLikeoptimizer/DynamicPartition_4*
T0
g
=optimizer/gradients_4/optimizer/DynamicPartition_4_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_4/optimizer/DynamicPartition_4_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_4/optimizer/DynamicPartition_4_grad/ProdProd=optimizer/gradients_4/optimizer/DynamicPartition_4_grad/Shape=optimizer/gradients_4/optimizer/DynamicPartition_4_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_4_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_4/optimizer/DynamicPartition_4_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_4/optimizer/DynamicPartition_4_grad/rangeRangeCoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/range/start<optimizer/gradients_4/optimizer/DynamicPartition_4_grad/ProdCoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/range/delta*

Tidx0
�
?optimizer/gradients_4/optimizer/DynamicPartition_4_grad/ReshapeReshape=optimizer/gradients_4/optimizer/DynamicPartition_4_grad/range=optimizer/gradients_4/optimizer/DynamicPartition_4_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/DynamicPartitionDynamicPartition?optimizer/gradients_4/optimizer/DynamicPartition_4_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_4/optimizer/DynamicPartition_4_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/DynamicPartitionJoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/DynamicPartition:1"optimizer/gradients_4/zeros_like_44optimizer/gradients_4/optimizer/Mean_12_grad/truediv*
N*
T0
v
?optimizer/gradients_4/optimizer/DynamicPartition_4_grad/Shape_1Shapeoptimizer/Maximum_2*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/Reshape_1ReshapeMoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/ParallelDynamicStitch?optimizer/gradients_4/optimizer/DynamicPartition_4_grad/Shape_1*
T0*
Tshape0
d
6optimizer/gradients_4/policy_1/Mean_grad/Reshape/shapeConst*
dtype0*
valueB:
�
0optimizer/gradients_4/policy_1/Mean_grad/ReshapeReshapeDoptimizer/gradients_4/policy_1/mul_4_grad/tuple/control_dependency_16optimizer/gradients_4/policy_1/Mean_grad/Reshape/shape*
T0*
Tshape0
\
.optimizer/gradients_4/policy_1/Mean_grad/ConstConst*
dtype0*
valueB:
�
-optimizer/gradients_4/policy_1/Mean_grad/TileTile0optimizer/gradients_4/policy_1/Mean_grad/Reshape.optimizer/gradients_4/policy_1/Mean_grad/Const*
T0*

Tmultiples0
]
0optimizer/gradients_4/policy_1/Mean_grad/Const_1Const*
dtype0*
valueB
 *  @@
�
0optimizer/gradients_4/policy_1/Mean_grad/truedivRealDiv-optimizer/gradients_4/policy_1/Mean_grad/Tile0optimizer/gradients_4/policy_1/Mean_grad/Const_1*
T0

:optimizer/gradients_4/optimizer/clip_by_value_3_grad/ShapeShape!optimizer/clip_by_value_3/Minimum*
T0*
out_type0
e
<optimizer/gradients_4/optimizer/clip_by_value_3_grad/Shape_1Const*
dtype0*
valueB 
�
<optimizer/gradients_4/optimizer/clip_by_value_3_grad/Shape_2ShapeDoptimizer/gradients_4/optimizer/mul_12_grad/tuple/control_dependency*
T0*
out_type0
m
@optimizer/gradients_4/optimizer/clip_by_value_3_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
:optimizer/gradients_4/optimizer/clip_by_value_3_grad/zerosFill<optimizer/gradients_4/optimizer/clip_by_value_3_grad/Shape_2@optimizer/gradients_4/optimizer/clip_by_value_3_grad/zeros/Const*
T0*

index_type0
�
Aoptimizer/gradients_4/optimizer/clip_by_value_3_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_3/Minimumoptimizer/sub_11*
T0
�
Joptimizer/gradients_4/optimizer/clip_by_value_3_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients_4/optimizer/clip_by_value_3_grad/Shape<optimizer/gradients_4/optimizer/clip_by_value_3_grad/Shape_1*
T0
�
=optimizer/gradients_4/optimizer/clip_by_value_3_grad/SelectV2SelectV2Aoptimizer/gradients_4/optimizer/clip_by_value_3_grad/GreaterEqualDoptimizer/gradients_4/optimizer/mul_12_grad/tuple/control_dependency:optimizer/gradients_4/optimizer/clip_by_value_3_grad/zeros*
T0
�
8optimizer/gradients_4/optimizer/clip_by_value_3_grad/SumSum=optimizer/gradients_4/optimizer/clip_by_value_3_grad/SelectV2Joptimizer/gradients_4/optimizer/clip_by_value_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_4/optimizer/clip_by_value_3_grad/ReshapeReshape8optimizer/gradients_4/optimizer/clip_by_value_3_grad/Sum:optimizer/gradients_4/optimizer/clip_by_value_3_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients_4/optimizer/clip_by_value_3_grad/SelectV2_1SelectV2Aoptimizer/gradients_4/optimizer/clip_by_value_3_grad/GreaterEqual:optimizer/gradients_4/optimizer/clip_by_value_3_grad/zerosDoptimizer/gradients_4/optimizer/mul_12_grad/tuple/control_dependency*
T0
�
:optimizer/gradients_4/optimizer/clip_by_value_3_grad/Sum_1Sum?optimizer/gradients_4/optimizer/clip_by_value_3_grad/SelectV2_1Loptimizer/gradients_4/optimizer/clip_by_value_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_4/optimizer/clip_by_value_3_grad/Reshape_1Reshape:optimizer/gradients_4/optimizer/clip_by_value_3_grad/Sum_1<optimizer/gradients_4/optimizer/clip_by_value_3_grad/Shape_1*
T0*
Tshape0
�
Eoptimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/clip_by_value_3_grad/Reshape?^optimizer/gradients_4/optimizer/clip_by_value_3_grad/Reshape_1
�
Moptimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/control_dependencyIdentity<optimizer/gradients_4/optimizer/clip_by_value_3_grad/ReshapeF^optimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/clip_by_value_3_grad/Reshape
�
Ooptimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/control_dependency_1Identity>optimizer/gradients_4/optimizer/clip_by_value_3_grad/Reshape_1F^optimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_4/optimizer/clip_by_value_3_grad/Reshape_1
s
2optimizer/gradients_4/optimizer/Maximum_grad/ShapeShapeoptimizer/SquaredDifference_3*
T0*
out_type0
u
4optimizer/gradients_4/optimizer/Maximum_grad/Shape_1Shapeoptimizer/SquaredDifference_4*
T0*
out_type0
�
4optimizer/gradients_4/optimizer/Maximum_grad/Shape_2ShapeAoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/Reshape_1*
T0*
out_type0
e
8optimizer/gradients_4/optimizer/Maximum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
2optimizer/gradients_4/optimizer/Maximum_grad/zerosFill4optimizer/gradients_4/optimizer/Maximum_grad/Shape_28optimizer/gradients_4/optimizer/Maximum_grad/zeros/Const*
T0*

index_type0
�
9optimizer/gradients_4/optimizer/Maximum_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifference_3optimizer/SquaredDifference_4*
T0
�
Boptimizer/gradients_4/optimizer/Maximum_grad/BroadcastGradientArgsBroadcastGradientArgs2optimizer/gradients_4/optimizer/Maximum_grad/Shape4optimizer/gradients_4/optimizer/Maximum_grad/Shape_1*
T0
�
5optimizer/gradients_4/optimizer/Maximum_grad/SelectV2SelectV29optimizer/gradients_4/optimizer/Maximum_grad/GreaterEqualAoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/Reshape_12optimizer/gradients_4/optimizer/Maximum_grad/zeros*
T0
�
0optimizer/gradients_4/optimizer/Maximum_grad/SumSum5optimizer/gradients_4/optimizer/Maximum_grad/SelectV2Boptimizer/gradients_4/optimizer/Maximum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_4/optimizer/Maximum_grad/ReshapeReshape0optimizer/gradients_4/optimizer/Maximum_grad/Sum2optimizer/gradients_4/optimizer/Maximum_grad/Shape*
T0*
Tshape0
�
7optimizer/gradients_4/optimizer/Maximum_grad/SelectV2_1SelectV29optimizer/gradients_4/optimizer/Maximum_grad/GreaterEqual2optimizer/gradients_4/optimizer/Maximum_grad/zerosAoptimizer/gradients_4/optimizer/DynamicPartition_2_grad/Reshape_1*
T0
�
2optimizer/gradients_4/optimizer/Maximum_grad/Sum_1Sum7optimizer/gradients_4/optimizer/Maximum_grad/SelectV2_1Doptimizer/gradients_4/optimizer/Maximum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_4/optimizer/Maximum_grad/Reshape_1Reshape2optimizer/gradients_4/optimizer/Maximum_grad/Sum_14optimizer/gradients_4/optimizer/Maximum_grad/Shape_1*
T0*
Tshape0
�
=optimizer/gradients_4/optimizer/Maximum_grad/tuple/group_depsNoOp5^optimizer/gradients_4/optimizer/Maximum_grad/Reshape7^optimizer/gradients_4/optimizer/Maximum_grad/Reshape_1
�
Eoptimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependencyIdentity4optimizer/gradients_4/optimizer/Maximum_grad/Reshape>^optimizer/gradients_4/optimizer/Maximum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_4/optimizer/Maximum_grad/Reshape
�
Goptimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependency_1Identity6optimizer/gradients_4/optimizer/Maximum_grad/Reshape_1>^optimizer/gradients_4/optimizer/Maximum_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Maximum_grad/Reshape_1
u
4optimizer/gradients_4/optimizer/Maximum_1_grad/ShapeShapeoptimizer/SquaredDifference_5*
T0*
out_type0
w
6optimizer/gradients_4/optimizer/Maximum_1_grad/Shape_1Shapeoptimizer/SquaredDifference_6*
T0*
out_type0
�
6optimizer/gradients_4/optimizer/Maximum_1_grad/Shape_2ShapeAoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/Reshape_1*
T0*
out_type0
g
:optimizer/gradients_4/optimizer/Maximum_1_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
4optimizer/gradients_4/optimizer/Maximum_1_grad/zerosFill6optimizer/gradients_4/optimizer/Maximum_1_grad/Shape_2:optimizer/gradients_4/optimizer/Maximum_1_grad/zeros/Const*
T0*

index_type0
�
;optimizer/gradients_4/optimizer/Maximum_1_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifference_5optimizer/SquaredDifference_6*
T0
�
Doptimizer/gradients_4/optimizer/Maximum_1_grad/BroadcastGradientArgsBroadcastGradientArgs4optimizer/gradients_4/optimizer/Maximum_1_grad/Shape6optimizer/gradients_4/optimizer/Maximum_1_grad/Shape_1*
T0
�
7optimizer/gradients_4/optimizer/Maximum_1_grad/SelectV2SelectV2;optimizer/gradients_4/optimizer/Maximum_1_grad/GreaterEqualAoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/Reshape_14optimizer/gradients_4/optimizer/Maximum_1_grad/zeros*
T0
�
2optimizer/gradients_4/optimizer/Maximum_1_grad/SumSum7optimizer/gradients_4/optimizer/Maximum_1_grad/SelectV2Doptimizer/gradients_4/optimizer/Maximum_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_4/optimizer/Maximum_1_grad/ReshapeReshape2optimizer/gradients_4/optimizer/Maximum_1_grad/Sum4optimizer/gradients_4/optimizer/Maximum_1_grad/Shape*
T0*
Tshape0
�
9optimizer/gradients_4/optimizer/Maximum_1_grad/SelectV2_1SelectV2;optimizer/gradients_4/optimizer/Maximum_1_grad/GreaterEqual4optimizer/gradients_4/optimizer/Maximum_1_grad/zerosAoptimizer/gradients_4/optimizer/DynamicPartition_3_grad/Reshape_1*
T0
�
4optimizer/gradients_4/optimizer/Maximum_1_grad/Sum_1Sum9optimizer/gradients_4/optimizer/Maximum_1_grad/SelectV2_1Foptimizer/gradients_4/optimizer/Maximum_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
8optimizer/gradients_4/optimizer/Maximum_1_grad/Reshape_1Reshape4optimizer/gradients_4/optimizer/Maximum_1_grad/Sum_16optimizer/gradients_4/optimizer/Maximum_1_grad/Shape_1*
T0*
Tshape0
�
?optimizer/gradients_4/optimizer/Maximum_1_grad/tuple/group_depsNoOp7^optimizer/gradients_4/optimizer/Maximum_1_grad/Reshape9^optimizer/gradients_4/optimizer/Maximum_1_grad/Reshape_1
�
Goptimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependencyIdentity6optimizer/gradients_4/optimizer/Maximum_1_grad/Reshape@^optimizer/gradients_4/optimizer/Maximum_1_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Maximum_1_grad/Reshape
�
Ioptimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependency_1Identity8optimizer/gradients_4/optimizer/Maximum_1_grad/Reshape_1@^optimizer/gradients_4/optimizer/Maximum_1_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients_4/optimizer/Maximum_1_grad/Reshape_1
u
4optimizer/gradients_4/optimizer/Maximum_2_grad/ShapeShapeoptimizer/SquaredDifference_7*
T0*
out_type0
w
6optimizer/gradients_4/optimizer/Maximum_2_grad/Shape_1Shapeoptimizer/SquaredDifference_8*
T0*
out_type0
�
6optimizer/gradients_4/optimizer/Maximum_2_grad/Shape_2ShapeAoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/Reshape_1*
T0*
out_type0
g
:optimizer/gradients_4/optimizer/Maximum_2_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
4optimizer/gradients_4/optimizer/Maximum_2_grad/zerosFill6optimizer/gradients_4/optimizer/Maximum_2_grad/Shape_2:optimizer/gradients_4/optimizer/Maximum_2_grad/zeros/Const*
T0*

index_type0
�
;optimizer/gradients_4/optimizer/Maximum_2_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifference_7optimizer/SquaredDifference_8*
T0
�
Doptimizer/gradients_4/optimizer/Maximum_2_grad/BroadcastGradientArgsBroadcastGradientArgs4optimizer/gradients_4/optimizer/Maximum_2_grad/Shape6optimizer/gradients_4/optimizer/Maximum_2_grad/Shape_1*
T0
�
7optimizer/gradients_4/optimizer/Maximum_2_grad/SelectV2SelectV2;optimizer/gradients_4/optimizer/Maximum_2_grad/GreaterEqualAoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/Reshape_14optimizer/gradients_4/optimizer/Maximum_2_grad/zeros*
T0
�
2optimizer/gradients_4/optimizer/Maximum_2_grad/SumSum7optimizer/gradients_4/optimizer/Maximum_2_grad/SelectV2Doptimizer/gradients_4/optimizer/Maximum_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_4/optimizer/Maximum_2_grad/ReshapeReshape2optimizer/gradients_4/optimizer/Maximum_2_grad/Sum4optimizer/gradients_4/optimizer/Maximum_2_grad/Shape*
T0*
Tshape0
�
9optimizer/gradients_4/optimizer/Maximum_2_grad/SelectV2_1SelectV2;optimizer/gradients_4/optimizer/Maximum_2_grad/GreaterEqual4optimizer/gradients_4/optimizer/Maximum_2_grad/zerosAoptimizer/gradients_4/optimizer/DynamicPartition_4_grad/Reshape_1*
T0
�
4optimizer/gradients_4/optimizer/Maximum_2_grad/Sum_1Sum9optimizer/gradients_4/optimizer/Maximum_2_grad/SelectV2_1Foptimizer/gradients_4/optimizer/Maximum_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
8optimizer/gradients_4/optimizer/Maximum_2_grad/Reshape_1Reshape4optimizer/gradients_4/optimizer/Maximum_2_grad/Sum_16optimizer/gradients_4/optimizer/Maximum_2_grad/Shape_1*
T0*
Tshape0
�
?optimizer/gradients_4/optimizer/Maximum_2_grad/tuple/group_depsNoOp7^optimizer/gradients_4/optimizer/Maximum_2_grad/Reshape9^optimizer/gradients_4/optimizer/Maximum_2_grad/Reshape_1
�
Goptimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependencyIdentity6optimizer/gradients_4/optimizer/Maximum_2_grad/Reshape@^optimizer/gradients_4/optimizer/Maximum_2_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Maximum_2_grad/Reshape
�
Ioptimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependency_1Identity8optimizer/gradients_4/optimizer/Maximum_2_grad/Reshape_1@^optimizer/gradients_4/optimizer/Maximum_2_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients_4/optimizer/Maximum_2_grad/Reshape_1
k
Boptimizer/gradients_4/policy_1/add_4_grad/BroadcastGradientArgs/s0Const*
dtype0*
valueB 
p
Boptimizer/gradients_4/policy_1/add_4_grad/BroadcastGradientArgs/s1Const*
dtype0*
valueB:
�
?optimizer/gradients_4/policy_1/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_4/policy_1/add_4_grad/BroadcastGradientArgs/s0Boptimizer/gradients_4/policy_1/add_4_grad/BroadcastGradientArgs/s1*
T0
m
?optimizer/gradients_4/policy_1/add_4_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_4/policy_1/add_4_grad/SumSum0optimizer/gradients_4/policy_1/Mean_grad/truediv?optimizer/gradients_4/policy_1/add_4_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_4/policy_1/add_4_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_4/policy_1/add_4_grad/ReshapeReshape-optimizer/gradients_4/policy_1/add_4_grad/Sum7optimizer/gradients_4/policy_1/add_4_grad/Reshape/shape*
T0*
Tshape0
�
:optimizer/gradients_4/policy_1/add_4_grad/tuple/group_depsNoOp1^optimizer/gradients_4/policy_1/Mean_grad/truediv2^optimizer/gradients_4/policy_1/add_4_grad/Reshape
�
Boptimizer/gradients_4/policy_1/add_4_grad/tuple/control_dependencyIdentity1optimizer/gradients_4/policy_1/add_4_grad/Reshape;^optimizer/gradients_4/policy_1/add_4_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/add_4_grad/Reshape
�
Doptimizer/gradients_4/policy_1/add_4_grad/tuple/control_dependency_1Identity0optimizer/gradients_4/policy_1/Mean_grad/truediv;^optimizer/gradients_4/policy_1/add_4_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients_4/policy_1/Mean_grad/truediv
s
Boptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
m
Doptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Doptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Shape_2ShapeMoptimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/control_dependency*
T0*
out_type0
u
Hoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
Boptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/zerosFillDoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Shape_2Hoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/zeros/Const*
T0*

index_type0
}
Foptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/LessEqual	LessEqualoptimizer/Expoptimizer/add_14*
T0
�
Roptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/ShapeDoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Shape_1*
T0
�
Eoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/SelectV2SelectV2Foptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/LessEqualMoptimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/control_dependencyBoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/zeros*
T0
�
@optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/SumSumEoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/SelectV2Roptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/ReshapeReshape@optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/SumBoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Shape*
T0*
Tshape0
�
Goptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/SelectV2_1SelectV2Foptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/LessEqualBoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/zerosMoptimizer/gradients_4/optimizer/clip_by_value_3_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Sum_1SumGoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/SelectV2_1Toptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Reshape_1ReshapeBoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Sum_1Doptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/tuple/group_depsNoOpE^optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/ReshapeG^optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Reshape_1
�
Uoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/tuple/control_dependencyIdentityDoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/ReshapeN^optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Reshape
�
Woptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/tuple/control_dependency_1IdentityFoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Reshape_1N^optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/Reshape_1
�
?optimizer/gradients_4/optimizer/SquaredDifference_3_grad/scalarConstF^optimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/MulMul?optimizer/gradients_4/optimizer/SquaredDifference_3_grad/scalarEoptimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/subSuboptimizer/extrinsic_returnsoptimizer/Sum_5F^optimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/mul_1Mul<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Mul<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/sub*
T0
}
>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
s
@optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Shape_1Shapeoptimizer/Sum_5*
T0*
out_type0
�
Noptimizer/gradients_4/optimizer/SquaredDifference_3_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Shape@optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Shape_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/SumSum>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/mul_1Noptimizer/gradients_4/optimizer/SquaredDifference_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_4/optimizer/SquaredDifference_3_grad/ReshapeReshape<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Sum>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Sum_1Sum>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/mul_1Poptimizer/gradients_4/optimizer/SquaredDifference_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_4/optimizer/SquaredDifference_3_grad/Reshape_1Reshape>optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Sum_1@optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/NegNegBoptimizer/gradients_4/optimizer/SquaredDifference_3_grad/Reshape_1*
T0
�
Ioptimizer/gradients_4/optimizer/SquaredDifference_3_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/SquaredDifference_3_grad/NegA^optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Reshape
�
Qoptimizer/gradients_4/optimizer/SquaredDifference_3_grad/tuple/control_dependencyIdentity@optimizer/gradients_4/optimizer/SquaredDifference_3_grad/ReshapeJ^optimizer/gradients_4/optimizer/SquaredDifference_3_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Reshape
�
Soptimizer/gradients_4/optimizer/SquaredDifference_3_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/SquaredDifference_3_grad/NegJ^optimizer/gradients_4/optimizer/SquaredDifference_3_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/SquaredDifference_3_grad/Neg
�
?optimizer/gradients_4/optimizer/SquaredDifference_4_grad/scalarConstH^optimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/MulMul?optimizer/gradients_4/optimizer/SquaredDifference_4_grad/scalarGoptimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/subSuboptimizer/extrinsic_returnsoptimizer/add_11H^optimizer/gradients_4/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/mul_1Mul<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Mul<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/sub*
T0
}
>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
t
@optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Shape_1Shapeoptimizer/add_11*
T0*
out_type0
�
Noptimizer/gradients_4/optimizer/SquaredDifference_4_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Shape@optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Shape_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/SumSum>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/mul_1Noptimizer/gradients_4/optimizer/SquaredDifference_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_4/optimizer/SquaredDifference_4_grad/ReshapeReshape<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Sum>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Sum_1Sum>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/mul_1Poptimizer/gradients_4/optimizer/SquaredDifference_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_4/optimizer/SquaredDifference_4_grad/Reshape_1Reshape>optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Sum_1@optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/NegNegBoptimizer/gradients_4/optimizer/SquaredDifference_4_grad/Reshape_1*
T0
�
Ioptimizer/gradients_4/optimizer/SquaredDifference_4_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/SquaredDifference_4_grad/NegA^optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Reshape
�
Qoptimizer/gradients_4/optimizer/SquaredDifference_4_grad/tuple/control_dependencyIdentity@optimizer/gradients_4/optimizer/SquaredDifference_4_grad/ReshapeJ^optimizer/gradients_4/optimizer/SquaredDifference_4_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Reshape
�
Soptimizer/gradients_4/optimizer/SquaredDifference_4_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/SquaredDifference_4_grad/NegJ^optimizer/gradients_4/optimizer/SquaredDifference_4_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/SquaredDifference_4_grad/Neg
�
?optimizer/gradients_4/optimizer/SquaredDifference_5_grad/scalarConstH^optimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/MulMul?optimizer/gradients_4/optimizer/SquaredDifference_5_grad/scalarGoptimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependency*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/subSuboptimizer/curiosity_returnsoptimizer/Sum_7H^optimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependency*
T0
�
>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/mul_1Mul<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Mul<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/sub*
T0
}
>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/ShapeShapeoptimizer/curiosity_returns*
T0*
out_type0
s
@optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Shape_1Shapeoptimizer/Sum_7*
T0*
out_type0
�
Noptimizer/gradients_4/optimizer/SquaredDifference_5_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Shape@optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Shape_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/SumSum>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/mul_1Noptimizer/gradients_4/optimizer/SquaredDifference_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_4/optimizer/SquaredDifference_5_grad/ReshapeReshape<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Sum>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Sum_1Sum>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/mul_1Poptimizer/gradients_4/optimizer/SquaredDifference_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_4/optimizer/SquaredDifference_5_grad/Reshape_1Reshape>optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Sum_1@optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/NegNegBoptimizer/gradients_4/optimizer/SquaredDifference_5_grad/Reshape_1*
T0
�
Ioptimizer/gradients_4/optimizer/SquaredDifference_5_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/SquaredDifference_5_grad/NegA^optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Reshape
�
Qoptimizer/gradients_4/optimizer/SquaredDifference_5_grad/tuple/control_dependencyIdentity@optimizer/gradients_4/optimizer/SquaredDifference_5_grad/ReshapeJ^optimizer/gradients_4/optimizer/SquaredDifference_5_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Reshape
�
Soptimizer/gradients_4/optimizer/SquaredDifference_5_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/SquaredDifference_5_grad/NegJ^optimizer/gradients_4/optimizer/SquaredDifference_5_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/SquaredDifference_5_grad/Neg
�
?optimizer/gradients_4/optimizer/SquaredDifference_6_grad/scalarConstJ^optimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/MulMul?optimizer/gradients_4/optimizer/SquaredDifference_6_grad/scalarIoptimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/subSuboptimizer/curiosity_returnsoptimizer/add_12J^optimizer/gradients_4/optimizer/Maximum_1_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/mul_1Mul<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Mul<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/sub*
T0
}
>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/ShapeShapeoptimizer/curiosity_returns*
T0*
out_type0
t
@optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Shape_1Shapeoptimizer/add_12*
T0*
out_type0
�
Noptimizer/gradients_4/optimizer/SquaredDifference_6_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Shape@optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Shape_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/SumSum>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/mul_1Noptimizer/gradients_4/optimizer/SquaredDifference_6_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_4/optimizer/SquaredDifference_6_grad/ReshapeReshape<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Sum>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Sum_1Sum>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/mul_1Poptimizer/gradients_4/optimizer/SquaredDifference_6_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_4/optimizer/SquaredDifference_6_grad/Reshape_1Reshape>optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Sum_1@optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/NegNegBoptimizer/gradients_4/optimizer/SquaredDifference_6_grad/Reshape_1*
T0
�
Ioptimizer/gradients_4/optimizer/SquaredDifference_6_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/SquaredDifference_6_grad/NegA^optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Reshape
�
Qoptimizer/gradients_4/optimizer/SquaredDifference_6_grad/tuple/control_dependencyIdentity@optimizer/gradients_4/optimizer/SquaredDifference_6_grad/ReshapeJ^optimizer/gradients_4/optimizer/SquaredDifference_6_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Reshape
�
Soptimizer/gradients_4/optimizer/SquaredDifference_6_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/SquaredDifference_6_grad/NegJ^optimizer/gradients_4/optimizer/SquaredDifference_6_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/SquaredDifference_6_grad/Neg
�
?optimizer/gradients_4/optimizer/SquaredDifference_7_grad/scalarConstH^optimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/MulMul?optimizer/gradients_4/optimizer/SquaredDifference_7_grad/scalarGoptimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependency*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/subSuboptimizer/gail_returnsoptimizer/Sum_9H^optimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependency*
T0
�
>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/mul_1Mul<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Mul<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/sub*
T0
x
>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/ShapeShapeoptimizer/gail_returns*
T0*
out_type0
s
@optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Shape_1Shapeoptimizer/Sum_9*
T0*
out_type0
�
Noptimizer/gradients_4/optimizer/SquaredDifference_7_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Shape@optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Shape_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/SumSum>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/mul_1Noptimizer/gradients_4/optimizer/SquaredDifference_7_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_4/optimizer/SquaredDifference_7_grad/ReshapeReshape<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Sum>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Sum_1Sum>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/mul_1Poptimizer/gradients_4/optimizer/SquaredDifference_7_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_4/optimizer/SquaredDifference_7_grad/Reshape_1Reshape>optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Sum_1@optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/NegNegBoptimizer/gradients_4/optimizer/SquaredDifference_7_grad/Reshape_1*
T0
�
Ioptimizer/gradients_4/optimizer/SquaredDifference_7_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/SquaredDifference_7_grad/NegA^optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Reshape
�
Qoptimizer/gradients_4/optimizer/SquaredDifference_7_grad/tuple/control_dependencyIdentity@optimizer/gradients_4/optimizer/SquaredDifference_7_grad/ReshapeJ^optimizer/gradients_4/optimizer/SquaredDifference_7_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Reshape
�
Soptimizer/gradients_4/optimizer/SquaredDifference_7_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/SquaredDifference_7_grad/NegJ^optimizer/gradients_4/optimizer/SquaredDifference_7_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/SquaredDifference_7_grad/Neg
�
?optimizer/gradients_4/optimizer/SquaredDifference_8_grad/scalarConstJ^optimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/MulMul?optimizer/gradients_4/optimizer/SquaredDifference_8_grad/scalarIoptimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/subSuboptimizer/gail_returnsoptimizer/add_13J^optimizer/gradients_4/optimizer/Maximum_2_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/mul_1Mul<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Mul<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/sub*
T0
x
>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/ShapeShapeoptimizer/gail_returns*
T0*
out_type0
t
@optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Shape_1Shapeoptimizer/add_13*
T0*
out_type0
�
Noptimizer/gradients_4/optimizer/SquaredDifference_8_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Shape@optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Shape_1*
T0
�
<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/SumSum>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/mul_1Noptimizer/gradients_4/optimizer/SquaredDifference_8_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_4/optimizer/SquaredDifference_8_grad/ReshapeReshape<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Sum>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Sum_1Sum>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/mul_1Poptimizer/gradients_4/optimizer/SquaredDifference_8_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_4/optimizer/SquaredDifference_8_grad/Reshape_1Reshape>optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Sum_1@optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/NegNegBoptimizer/gradients_4/optimizer/SquaredDifference_8_grad/Reshape_1*
T0
�
Ioptimizer/gradients_4/optimizer/SquaredDifference_8_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/SquaredDifference_8_grad/NegA^optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Reshape
�
Qoptimizer/gradients_4/optimizer/SquaredDifference_8_grad/tuple/control_dependencyIdentity@optimizer/gradients_4/optimizer/SquaredDifference_8_grad/ReshapeJ^optimizer/gradients_4/optimizer/SquaredDifference_8_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Reshape
�
Soptimizer/gradients_4/optimizer/SquaredDifference_8_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/SquaredDifference_8_grad/NegJ^optimizer/gradients_4/optimizer/SquaredDifference_8_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/SquaredDifference_8_grad/Neg
�
-optimizer/gradients_4/policy_1/mul_3_grad/MulMulDoptimizer/gradients_4/policy_1/add_4_grad/tuple/control_dependency_1policy_1/clip_by_value*
T0
m
?optimizer/gradients_4/policy_1/mul_3_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_4/policy_1/mul_3_grad/SumSum-optimizer/gradients_4/policy_1/mul_3_grad/Mul?optimizer/gradients_4/policy_1/mul_3_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_4/policy_1/mul_3_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_4/policy_1/mul_3_grad/ReshapeReshape-optimizer/gradients_4/policy_1/mul_3_grad/Sum7optimizer/gradients_4/policy_1/mul_3_grad/Reshape/shape*
T0*
Tshape0
�
/optimizer/gradients_4/policy_1/mul_3_grad/Mul_1Mulpolicy_1/mul_3/xDoptimizer/gradients_4/policy_1/add_4_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_4/policy_1/mul_3_grad/tuple/group_depsNoOp0^optimizer/gradients_4/policy_1/mul_3_grad/Mul_12^optimizer/gradients_4/policy_1/mul_3_grad/Reshape
�
Boptimizer/gradients_4/policy_1/mul_3_grad/tuple/control_dependencyIdentity1optimizer/gradients_4/policy_1/mul_3_grad/Reshape;^optimizer/gradients_4/policy_1/mul_3_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/mul_3_grad/Reshape
�
Doptimizer/gradients_4/policy_1/mul_3_grad/tuple/control_dependency_1Identity/optimizer/gradients_4/policy_1/mul_3_grad/Mul_1;^optimizer/gradients_4/policy_1/mul_3_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/policy_1/mul_3_grad/Mul_1
�
optimizer/gradients_4/AddNAddNDoptimizer/gradients_4/optimizer/mul_11_grad/tuple/control_dependencyUoptimizer/gradients_4/optimizer/clip_by_value_3/Minimum_grad/tuple/control_dependency*
N*
T0*F
_class<
:8loc:@optimizer/gradients_4/optimizer/mul_11_grad/Reshape
g
,optimizer/gradients_4/optimizer/Exp_grad/mulMuloptimizer/gradients_4/AddNoptimizer/Exp*
T0
u
0optimizer/gradients_4/optimizer/Sum_5_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_4/optimizer/Sum_5_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_4/optimizer/Sum_5_grad/addAddV2!optimizer/Sum_5/reduction_indices/optimizer/gradients_4/optimizer/Sum_5_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape
�
.optimizer/gradients_4/optimizer/Sum_5_grad/modFloorMod.optimizer/gradients_4/optimizer/Sum_5_grad/add/optimizer/gradients_4/optimizer/Sum_5_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_5_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_4/optimizer/Sum_5_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_4/optimizer/Sum_5_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_4/optimizer/Sum_5_grad/rangeRange6optimizer/gradients_4/optimizer/Sum_5_grad/range/start/optimizer/gradients_4/optimizer/Sum_5_grad/Size6optimizer/gradients_4/optimizer/Sum_5_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape
�
5optimizer/gradients_4/optimizer/Sum_5_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_4/optimizer/Sum_5_grad/FillFill2optimizer/gradients_4/optimizer/Sum_5_grad/Shape_15optimizer/gradients_4/optimizer/Sum_5_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape*

index_type0
�
8optimizer/gradients_4/optimizer/Sum_5_grad/DynamicStitchDynamicStitch0optimizer/gradients_4/optimizer/Sum_5_grad/range.optimizer/gradients_4/optimizer/Sum_5_grad/mod0optimizer/gradients_4/optimizer/Sum_5_grad/Shape/optimizer/gradients_4/optimizer/Sum_5_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_5_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_5_grad/ReshapeReshapeSoptimizer/gradients_4/optimizer/SquaredDifference_3_grad/tuple/control_dependency_18optimizer/gradients_4/optimizer/Sum_5_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_4/optimizer/Sum_5_grad/BroadcastToBroadcastTo2optimizer/gradients_4/optimizer/Sum_5_grad/Reshape0optimizer/gradients_4/optimizer/Sum_5_grad/Shape*
T0*

Tidx0
w
1optimizer/gradients_4/optimizer/add_11_grad/ShapeShape"optimizer/extrinsic_value_estimate*
T0*
out_type0
n
3optimizer/gradients_4/optimizer/add_11_grad/Shape_1Shapeoptimizer/clip_by_value*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/add_11_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_4/optimizer/add_11_grad/Shape3optimizer/gradients_4/optimizer/add_11_grad/Shape_1*
T0
�
/optimizer/gradients_4/optimizer/add_11_grad/SumSumSoptimizer/gradients_4/optimizer/SquaredDifference_4_grad/tuple/control_dependency_1Aoptimizer/gradients_4/optimizer/add_11_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/optimizer/add_11_grad/ReshapeReshape/optimizer/gradients_4/optimizer/add_11_grad/Sum1optimizer/gradients_4/optimizer/add_11_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_4/optimizer/add_11_grad/Sum_1SumSoptimizer/gradients_4/optimizer/SquaredDifference_4_grad/tuple/control_dependency_1Coptimizer/gradients_4/optimizer/add_11_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_4/optimizer/add_11_grad/Reshape_1Reshape1optimizer/gradients_4/optimizer/add_11_grad/Sum_13optimizer/gradients_4/optimizer/add_11_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/add_11_grad/tuple/group_depsNoOp4^optimizer/gradients_4/optimizer/add_11_grad/Reshape6^optimizer/gradients_4/optimizer/add_11_grad/Reshape_1
�
Doptimizer/gradients_4/optimizer/add_11_grad/tuple/control_dependencyIdentity3optimizer/gradients_4/optimizer/add_11_grad/Reshape=^optimizer/gradients_4/optimizer/add_11_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/optimizer/add_11_grad/Reshape
�
Foptimizer/gradients_4/optimizer/add_11_grad/tuple/control_dependency_1Identity5optimizer/gradients_4/optimizer/add_11_grad/Reshape_1=^optimizer/gradients_4/optimizer/add_11_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/optimizer/add_11_grad/Reshape_1
u
0optimizer/gradients_4/optimizer/Sum_7_grad/ShapeShape!optimizer/curiosity_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_4/optimizer/Sum_7_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_4/optimizer/Sum_7_grad/addAddV2!optimizer/Sum_7/reduction_indices/optimizer/gradients_4/optimizer/Sum_7_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape
�
.optimizer/gradients_4/optimizer/Sum_7_grad/modFloorMod.optimizer/gradients_4/optimizer/Sum_7_grad/add/optimizer/gradients_4/optimizer/Sum_7_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_7_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_4/optimizer/Sum_7_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_4/optimizer/Sum_7_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_4/optimizer/Sum_7_grad/rangeRange6optimizer/gradients_4/optimizer/Sum_7_grad/range/start/optimizer/gradients_4/optimizer/Sum_7_grad/Size6optimizer/gradients_4/optimizer/Sum_7_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape
�
5optimizer/gradients_4/optimizer/Sum_7_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_4/optimizer/Sum_7_grad/FillFill2optimizer/gradients_4/optimizer/Sum_7_grad/Shape_15optimizer/gradients_4/optimizer/Sum_7_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape*

index_type0
�
8optimizer/gradients_4/optimizer/Sum_7_grad/DynamicStitchDynamicStitch0optimizer/gradients_4/optimizer/Sum_7_grad/range.optimizer/gradients_4/optimizer/Sum_7_grad/mod0optimizer/gradients_4/optimizer/Sum_7_grad/Shape/optimizer/gradients_4/optimizer/Sum_7_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_7_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_7_grad/ReshapeReshapeSoptimizer/gradients_4/optimizer/SquaredDifference_5_grad/tuple/control_dependency_18optimizer/gradients_4/optimizer/Sum_7_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_4/optimizer/Sum_7_grad/BroadcastToBroadcastTo2optimizer/gradients_4/optimizer/Sum_7_grad/Reshape0optimizer/gradients_4/optimizer/Sum_7_grad/Shape*
T0*

Tidx0
w
1optimizer/gradients_4/optimizer/add_12_grad/ShapeShape"optimizer/curiosity_value_estimate*
T0*
out_type0
p
3optimizer/gradients_4/optimizer/add_12_grad/Shape_1Shapeoptimizer/clip_by_value_1*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/add_12_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_4/optimizer/add_12_grad/Shape3optimizer/gradients_4/optimizer/add_12_grad/Shape_1*
T0
�
/optimizer/gradients_4/optimizer/add_12_grad/SumSumSoptimizer/gradients_4/optimizer/SquaredDifference_6_grad/tuple/control_dependency_1Aoptimizer/gradients_4/optimizer/add_12_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/optimizer/add_12_grad/ReshapeReshape/optimizer/gradients_4/optimizer/add_12_grad/Sum1optimizer/gradients_4/optimizer/add_12_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_4/optimizer/add_12_grad/Sum_1SumSoptimizer/gradients_4/optimizer/SquaredDifference_6_grad/tuple/control_dependency_1Coptimizer/gradients_4/optimizer/add_12_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_4/optimizer/add_12_grad/Reshape_1Reshape1optimizer/gradients_4/optimizer/add_12_grad/Sum_13optimizer/gradients_4/optimizer/add_12_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/add_12_grad/tuple/group_depsNoOp4^optimizer/gradients_4/optimizer/add_12_grad/Reshape6^optimizer/gradients_4/optimizer/add_12_grad/Reshape_1
�
Doptimizer/gradients_4/optimizer/add_12_grad/tuple/control_dependencyIdentity3optimizer/gradients_4/optimizer/add_12_grad/Reshape=^optimizer/gradients_4/optimizer/add_12_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/optimizer/add_12_grad/Reshape
�
Foptimizer/gradients_4/optimizer/add_12_grad/tuple/control_dependency_1Identity5optimizer/gradients_4/optimizer/add_12_grad/Reshape_1=^optimizer/gradients_4/optimizer/add_12_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/optimizer/add_12_grad/Reshape_1
p
0optimizer/gradients_4/optimizer/Sum_9_grad/ShapeShapeoptimizer/gail_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_4/optimizer/Sum_9_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_4/optimizer/Sum_9_grad/addAddV2!optimizer/Sum_9/reduction_indices/optimizer/gradients_4/optimizer/Sum_9_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape
�
.optimizer/gradients_4/optimizer/Sum_9_grad/modFloorMod.optimizer/gradients_4/optimizer/Sum_9_grad/add/optimizer/gradients_4/optimizer/Sum_9_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_9_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_4/optimizer/Sum_9_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_4/optimizer/Sum_9_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_4/optimizer/Sum_9_grad/rangeRange6optimizer/gradients_4/optimizer/Sum_9_grad/range/start/optimizer/gradients_4/optimizer/Sum_9_grad/Size6optimizer/gradients_4/optimizer/Sum_9_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape
�
5optimizer/gradients_4/optimizer/Sum_9_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_4/optimizer/Sum_9_grad/FillFill2optimizer/gradients_4/optimizer/Sum_9_grad/Shape_15optimizer/gradients_4/optimizer/Sum_9_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape*

index_type0
�
8optimizer/gradients_4/optimizer/Sum_9_grad/DynamicStitchDynamicStitch0optimizer/gradients_4/optimizer/Sum_9_grad/range.optimizer/gradients_4/optimizer/Sum_9_grad/mod0optimizer/gradients_4/optimizer/Sum_9_grad/Shape/optimizer/gradients_4/optimizer/Sum_9_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_9_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_9_grad/ReshapeReshapeSoptimizer/gradients_4/optimizer/SquaredDifference_7_grad/tuple/control_dependency_18optimizer/gradients_4/optimizer/Sum_9_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_4/optimizer/Sum_9_grad/BroadcastToBroadcastTo2optimizer/gradients_4/optimizer/Sum_9_grad/Reshape0optimizer/gradients_4/optimizer/Sum_9_grad/Shape*
T0*

Tidx0
r
1optimizer/gradients_4/optimizer/add_13_grad/ShapeShapeoptimizer/gail_value_estimate*
T0*
out_type0
p
3optimizer/gradients_4/optimizer/add_13_grad/Shape_1Shapeoptimizer/clip_by_value_2*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/add_13_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_4/optimizer/add_13_grad/Shape3optimizer/gradients_4/optimizer/add_13_grad/Shape_1*
T0
�
/optimizer/gradients_4/optimizer/add_13_grad/SumSumSoptimizer/gradients_4/optimizer/SquaredDifference_8_grad/tuple/control_dependency_1Aoptimizer/gradients_4/optimizer/add_13_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/optimizer/add_13_grad/ReshapeReshape/optimizer/gradients_4/optimizer/add_13_grad/Sum1optimizer/gradients_4/optimizer/add_13_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_4/optimizer/add_13_grad/Sum_1SumSoptimizer/gradients_4/optimizer/SquaredDifference_8_grad/tuple/control_dependency_1Coptimizer/gradients_4/optimizer/add_13_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_4/optimizer/add_13_grad/Reshape_1Reshape1optimizer/gradients_4/optimizer/add_13_grad/Sum_13optimizer/gradients_4/optimizer/add_13_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/add_13_grad/tuple/group_depsNoOp4^optimizer/gradients_4/optimizer/add_13_grad/Reshape6^optimizer/gradients_4/optimizer/add_13_grad/Reshape_1
�
Doptimizer/gradients_4/optimizer/add_13_grad/tuple/control_dependencyIdentity3optimizer/gradients_4/optimizer/add_13_grad/Reshape=^optimizer/gradients_4/optimizer/add_13_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/optimizer/add_13_grad/Reshape
�
Foptimizer/gradients_4/optimizer/add_13_grad/tuple/control_dependency_1Identity5optimizer/gradients_4/optimizer/add_13_grad/Reshape_1=^optimizer/gradients_4/optimizer/add_13_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/optimizer/add_13_grad/Reshape_1
a
1optimizer/gradients_4/optimizer/sub_10_grad/ShapeShapepolicy_1/Sum*
T0*
out_type0
f
3optimizer/gradients_4/optimizer/sub_10_grad/Shape_1Shapeoptimizer/Sum_3*
T0*
out_type0
�
Aoptimizer/gradients_4/optimizer/sub_10_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_4/optimizer/sub_10_grad/Shape3optimizer/gradients_4/optimizer/sub_10_grad/Shape_1*
T0
�
/optimizer/gradients_4/optimizer/sub_10_grad/SumSum,optimizer/gradients_4/optimizer/Exp_grad/mulAoptimizer/gradients_4/optimizer/sub_10_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/optimizer/sub_10_grad/ReshapeReshape/optimizer/gradients_4/optimizer/sub_10_grad/Sum1optimizer/gradients_4/optimizer/sub_10_grad/Shape*
T0*
Tshape0
m
/optimizer/gradients_4/optimizer/sub_10_grad/NegNeg,optimizer/gradients_4/optimizer/Exp_grad/mul*
T0
�
1optimizer/gradients_4/optimizer/sub_10_grad/Sum_1Sum/optimizer/gradients_4/optimizer/sub_10_grad/NegCoptimizer/gradients_4/optimizer/sub_10_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_4/optimizer/sub_10_grad/Reshape_1Reshape1optimizer/gradients_4/optimizer/sub_10_grad/Sum_13optimizer/gradients_4/optimizer/sub_10_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/optimizer/sub_10_grad/tuple/group_depsNoOp4^optimizer/gradients_4/optimizer/sub_10_grad/Reshape6^optimizer/gradients_4/optimizer/sub_10_grad/Reshape_1
�
Doptimizer/gradients_4/optimizer/sub_10_grad/tuple/control_dependencyIdentity3optimizer/gradients_4/optimizer/sub_10_grad/Reshape=^optimizer/gradients_4/optimizer/sub_10_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/optimizer/sub_10_grad/Reshape
�
Foptimizer/gradients_4/optimizer/sub_10_grad/tuple/control_dependency_1Identity5optimizer/gradients_4/optimizer/sub_10_grad/Reshape_1=^optimizer/gradients_4/optimizer/sub_10_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/optimizer/sub_10_grad/Reshape_1
{
8optimizer/gradients_4/optimizer/clip_by_value_grad/ShapeShapeoptimizer/clip_by_value/Minimum*
T0*
out_type0
c
:optimizer/gradients_4/optimizer/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
�
:optimizer/gradients_4/optimizer/clip_by_value_grad/Shape_2ShapeFoptimizer/gradients_4/optimizer/add_11_grad/tuple/control_dependency_1*
T0*
out_type0
k
>optimizer/gradients_4/optimizer/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
8optimizer/gradients_4/optimizer/clip_by_value_grad/zerosFill:optimizer/gradients_4/optimizer/clip_by_value_grad/Shape_2>optimizer/gradients_4/optimizer/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
?optimizer/gradients_4/optimizer/clip_by_value_grad/GreaterEqualGreaterEqualoptimizer/clip_by_value/Minimumoptimizer/Neg_2*
T0
�
Hoptimizer/gradients_4/optimizer/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs8optimizer/gradients_4/optimizer/clip_by_value_grad/Shape:optimizer/gradients_4/optimizer/clip_by_value_grad/Shape_1*
T0
�
;optimizer/gradients_4/optimizer/clip_by_value_grad/SelectV2SelectV2?optimizer/gradients_4/optimizer/clip_by_value_grad/GreaterEqualFoptimizer/gradients_4/optimizer/add_11_grad/tuple/control_dependency_18optimizer/gradients_4/optimizer/clip_by_value_grad/zeros*
T0
�
6optimizer/gradients_4/optimizer/clip_by_value_grad/SumSum;optimizer/gradients_4/optimizer/clip_by_value_grad/SelectV2Hoptimizer/gradients_4/optimizer/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
:optimizer/gradients_4/optimizer/clip_by_value_grad/ReshapeReshape6optimizer/gradients_4/optimizer/clip_by_value_grad/Sum8optimizer/gradients_4/optimizer/clip_by_value_grad/Shape*
T0*
Tshape0
�
=optimizer/gradients_4/optimizer/clip_by_value_grad/SelectV2_1SelectV2?optimizer/gradients_4/optimizer/clip_by_value_grad/GreaterEqual8optimizer/gradients_4/optimizer/clip_by_value_grad/zerosFoptimizer/gradients_4/optimizer/add_11_grad/tuple/control_dependency_1*
T0
�
8optimizer/gradients_4/optimizer/clip_by_value_grad/Sum_1Sum=optimizer/gradients_4/optimizer/clip_by_value_grad/SelectV2_1Joptimizer/gradients_4/optimizer/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_4/optimizer/clip_by_value_grad/Reshape_1Reshape8optimizer/gradients_4/optimizer/clip_by_value_grad/Sum_1:optimizer/gradients_4/optimizer/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
Coptimizer/gradients_4/optimizer/clip_by_value_grad/tuple/group_depsNoOp;^optimizer/gradients_4/optimizer/clip_by_value_grad/Reshape=^optimizer/gradients_4/optimizer/clip_by_value_grad/Reshape_1
�
Koptimizer/gradients_4/optimizer/clip_by_value_grad/tuple/control_dependencyIdentity:optimizer/gradients_4/optimizer/clip_by_value_grad/ReshapeD^optimizer/gradients_4/optimizer/clip_by_value_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_4/optimizer/clip_by_value_grad/Reshape
�
Moptimizer/gradients_4/optimizer/clip_by_value_grad/tuple/control_dependency_1Identity<optimizer/gradients_4/optimizer/clip_by_value_grad/Reshape_1D^optimizer/gradients_4/optimizer/clip_by_value_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/clip_by_value_grad/Reshape_1

:optimizer/gradients_4/optimizer/clip_by_value_1_grad/ShapeShape!optimizer/clip_by_value_1/Minimum*
T0*
out_type0
e
<optimizer/gradients_4/optimizer/clip_by_value_1_grad/Shape_1Const*
dtype0*
valueB 
�
<optimizer/gradients_4/optimizer/clip_by_value_1_grad/Shape_2ShapeFoptimizer/gradients_4/optimizer/add_12_grad/tuple/control_dependency_1*
T0*
out_type0
m
@optimizer/gradients_4/optimizer/clip_by_value_1_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
:optimizer/gradients_4/optimizer/clip_by_value_1_grad/zerosFill<optimizer/gradients_4/optimizer/clip_by_value_1_grad/Shape_2@optimizer/gradients_4/optimizer/clip_by_value_1_grad/zeros/Const*
T0*

index_type0
�
Aoptimizer/gradients_4/optimizer/clip_by_value_1_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_1/Minimumoptimizer/Neg_3*
T0
�
Joptimizer/gradients_4/optimizer/clip_by_value_1_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients_4/optimizer/clip_by_value_1_grad/Shape<optimizer/gradients_4/optimizer/clip_by_value_1_grad/Shape_1*
T0
�
=optimizer/gradients_4/optimizer/clip_by_value_1_grad/SelectV2SelectV2Aoptimizer/gradients_4/optimizer/clip_by_value_1_grad/GreaterEqualFoptimizer/gradients_4/optimizer/add_12_grad/tuple/control_dependency_1:optimizer/gradients_4/optimizer/clip_by_value_1_grad/zeros*
T0
�
8optimizer/gradients_4/optimizer/clip_by_value_1_grad/SumSum=optimizer/gradients_4/optimizer/clip_by_value_1_grad/SelectV2Joptimizer/gradients_4/optimizer/clip_by_value_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_4/optimizer/clip_by_value_1_grad/ReshapeReshape8optimizer/gradients_4/optimizer/clip_by_value_1_grad/Sum:optimizer/gradients_4/optimizer/clip_by_value_1_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients_4/optimizer/clip_by_value_1_grad/SelectV2_1SelectV2Aoptimizer/gradients_4/optimizer/clip_by_value_1_grad/GreaterEqual:optimizer/gradients_4/optimizer/clip_by_value_1_grad/zerosFoptimizer/gradients_4/optimizer/add_12_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_4/optimizer/clip_by_value_1_grad/Sum_1Sum?optimizer/gradients_4/optimizer/clip_by_value_1_grad/SelectV2_1Loptimizer/gradients_4/optimizer/clip_by_value_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_4/optimizer/clip_by_value_1_grad/Reshape_1Reshape:optimizer/gradients_4/optimizer/clip_by_value_1_grad/Sum_1<optimizer/gradients_4/optimizer/clip_by_value_1_grad/Shape_1*
T0*
Tshape0
�
Eoptimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/clip_by_value_1_grad/Reshape?^optimizer/gradients_4/optimizer/clip_by_value_1_grad/Reshape_1
�
Moptimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/control_dependencyIdentity<optimizer/gradients_4/optimizer/clip_by_value_1_grad/ReshapeF^optimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/clip_by_value_1_grad/Reshape
�
Ooptimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/control_dependency_1Identity>optimizer/gradients_4/optimizer/clip_by_value_1_grad/Reshape_1F^optimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_4/optimizer/clip_by_value_1_grad/Reshape_1

:optimizer/gradients_4/optimizer/clip_by_value_2_grad/ShapeShape!optimizer/clip_by_value_2/Minimum*
T0*
out_type0
e
<optimizer/gradients_4/optimizer/clip_by_value_2_grad/Shape_1Const*
dtype0*
valueB 
�
<optimizer/gradients_4/optimizer/clip_by_value_2_grad/Shape_2ShapeFoptimizer/gradients_4/optimizer/add_13_grad/tuple/control_dependency_1*
T0*
out_type0
m
@optimizer/gradients_4/optimizer/clip_by_value_2_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
:optimizer/gradients_4/optimizer/clip_by_value_2_grad/zerosFill<optimizer/gradients_4/optimizer/clip_by_value_2_grad/Shape_2@optimizer/gradients_4/optimizer/clip_by_value_2_grad/zeros/Const*
T0*

index_type0
�
Aoptimizer/gradients_4/optimizer/clip_by_value_2_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_2/Minimumoptimizer/Neg_4*
T0
�
Joptimizer/gradients_4/optimizer/clip_by_value_2_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients_4/optimizer/clip_by_value_2_grad/Shape<optimizer/gradients_4/optimizer/clip_by_value_2_grad/Shape_1*
T0
�
=optimizer/gradients_4/optimizer/clip_by_value_2_grad/SelectV2SelectV2Aoptimizer/gradients_4/optimizer/clip_by_value_2_grad/GreaterEqualFoptimizer/gradients_4/optimizer/add_13_grad/tuple/control_dependency_1:optimizer/gradients_4/optimizer/clip_by_value_2_grad/zeros*
T0
�
8optimizer/gradients_4/optimizer/clip_by_value_2_grad/SumSum=optimizer/gradients_4/optimizer/clip_by_value_2_grad/SelectV2Joptimizer/gradients_4/optimizer/clip_by_value_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_4/optimizer/clip_by_value_2_grad/ReshapeReshape8optimizer/gradients_4/optimizer/clip_by_value_2_grad/Sum:optimizer/gradients_4/optimizer/clip_by_value_2_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients_4/optimizer/clip_by_value_2_grad/SelectV2_1SelectV2Aoptimizer/gradients_4/optimizer/clip_by_value_2_grad/GreaterEqual:optimizer/gradients_4/optimizer/clip_by_value_2_grad/zerosFoptimizer/gradients_4/optimizer/add_13_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_4/optimizer/clip_by_value_2_grad/Sum_1Sum?optimizer/gradients_4/optimizer/clip_by_value_2_grad/SelectV2_1Loptimizer/gradients_4/optimizer/clip_by_value_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_4/optimizer/clip_by_value_2_grad/Reshape_1Reshape:optimizer/gradients_4/optimizer/clip_by_value_2_grad/Sum_1<optimizer/gradients_4/optimizer/clip_by_value_2_grad/Shape_1*
T0*
Tshape0
�
Eoptimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/group_depsNoOp=^optimizer/gradients_4/optimizer/clip_by_value_2_grad/Reshape?^optimizer/gradients_4/optimizer/clip_by_value_2_grad/Reshape_1
�
Moptimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/control_dependencyIdentity<optimizer/gradients_4/optimizer/clip_by_value_2_grad/ReshapeF^optimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_4/optimizer/clip_by_value_2_grad/Reshape
�
Ooptimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/control_dependency_1Identity>optimizer/gradients_4/optimizer/clip_by_value_2_grad/Reshape_1F^optimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_4/optimizer/clip_by_value_2_grad/Reshape_1
_
-optimizer/gradients_4/policy_1/Sum_grad/ShapeShapepolicy_1/mul_2*
T0*
out_type0
�
3optimizer/gradients_4/policy_1/Sum_grad/BroadcastToBroadcastToDoptimizer/gradients_4/optimizer/sub_10_grad/tuple/control_dependency-optimizer/gradients_4/policy_1/Sum_grad/Shape*
T0*

Tidx0
s
@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/ShapeShapeoptimizer/sub_7*
T0*
out_type0
k
Boptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Boptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Shape_2ShapeKoptimizer/gradients_4/optimizer/clip_by_value_grad/tuple/control_dependency*
T0*
out_type0
s
Foptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/zerosFillBoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Shape_2Foptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
Doptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/LessEqual	LessEqualoptimizer/sub_7optimizer/PolynomialDecay_2*
T0
�
Poptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/ShapeBoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0
�
Coptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/SelectV2SelectV2Doptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/LessEqualKoptimizer/gradients_4/optimizer/clip_by_value_grad/tuple/control_dependency@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/zeros*
T0
�
>optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/SumSumCoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/SelectV2Poptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/ReshapeReshape>optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Sum@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
Eoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/SelectV2_1SelectV2Doptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/LessEqual@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/zerosKoptimizer/gradients_4/optimizer/clip_by_value_grad/tuple/control_dependency*
T0
�
@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Sum_1SumEoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/SelectV2_1Roptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Reshape_1Reshape@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Sum_1Boptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Koptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/tuple/group_depsNoOpC^optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/ReshapeE^optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Reshape_1
�
Soptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/tuple/control_dependencyIdentityBoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/ReshapeL^optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Reshape
�
Uoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Reshape_1L^optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/Reshape_1
u
Boptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/ShapeShapeoptimizer/sub_8*
T0*
out_type0
m
Doptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Doptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Shape_2ShapeMoptimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0*
out_type0
u
Hoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
Boptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/zerosFillDoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Shape_2Hoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/zeros/Const*
T0*

index_type0
�
Foptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/LessEqual	LessEqualoptimizer/sub_8optimizer/PolynomialDecay_2*
T0
�
Roptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/ShapeDoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0
�
Eoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/SelectV2SelectV2Foptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/LessEqualMoptimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/control_dependencyBoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/zeros*
T0
�
@optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/SumSumEoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/SelectV2Roptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/ReshapeReshape@optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/SumBoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Shape*
T0*
Tshape0
�
Goptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1SelectV2Foptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/LessEqualBoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/zerosMoptimizer/gradients_4/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Sum_1SumGoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1Toptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Reshape_1ReshapeBoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Sum_1Doptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/tuple/group_depsNoOpE^optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/ReshapeG^optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
�
Uoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependencyIdentityDoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/ReshapeN^optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Reshape
�
Woptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency_1IdentityFoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Reshape_1N^optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
u
Boptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/ShapeShapeoptimizer/sub_9*
T0*
out_type0
m
Doptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Doptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Shape_2ShapeMoptimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/control_dependency*
T0*
out_type0
u
Hoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
Boptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/zerosFillDoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Shape_2Hoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/zeros/Const*
T0*

index_type0
�
Foptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/LessEqual	LessEqualoptimizer/sub_9optimizer/PolynomialDecay_2*
T0
�
Roptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/ShapeDoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Shape_1*
T0
�
Eoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/SelectV2SelectV2Foptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/LessEqualMoptimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/control_dependencyBoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/zeros*
T0
�
@optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/SumSumEoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/SelectV2Roptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/ReshapeReshape@optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/SumBoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Shape*
T0*
Tshape0
�
Goptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/SelectV2_1SelectV2Foptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/LessEqualBoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/zerosMoptimizer/gradients_4/optimizer/clip_by_value_2_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Sum_1SumGoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/SelectV2_1Toptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Reshape_1ReshapeBoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Sum_1Doptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/tuple/group_depsNoOpE^optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/ReshapeG^optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Reshape_1
�
Uoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependencyIdentityDoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/ReshapeN^optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Reshape
�
Woptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependency_1IdentityFoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Reshape_1N^optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/Reshape_1
c
/optimizer/gradients_4/policy_1/mul_2_grad/ShapeShapepolicy_1/mul_2/x*
T0*
out_type0
c
1optimizer/gradients_4/policy_1/mul_2_grad/Shape_1Shapepolicy_1/add_3*
T0*
out_type0
�
?optimizer/gradients_4/policy_1/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_4/policy_1/mul_2_grad/Shape1optimizer/gradients_4/policy_1/mul_2_grad/Shape_1*
T0
�
-optimizer/gradients_4/policy_1/mul_2_grad/MulMul3optimizer/gradients_4/policy_1/Sum_grad/BroadcastTopolicy_1/add_3*
T0
�
-optimizer/gradients_4/policy_1/mul_2_grad/SumSum-optimizer/gradients_4/policy_1/mul_2_grad/Mul?optimizer/gradients_4/policy_1/mul_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_4/policy_1/mul_2_grad/ReshapeReshape-optimizer/gradients_4/policy_1/mul_2_grad/Sum/optimizer/gradients_4/policy_1/mul_2_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_4/policy_1/mul_2_grad/Mul_1Mulpolicy_1/mul_2/x3optimizer/gradients_4/policy_1/Sum_grad/BroadcastTo*
T0
�
/optimizer/gradients_4/policy_1/mul_2_grad/Sum_1Sum/optimizer/gradients_4/policy_1/mul_2_grad/Mul_1Aoptimizer/gradients_4/policy_1/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/policy_1/mul_2_grad/Reshape_1Reshape/optimizer/gradients_4/policy_1/mul_2_grad/Sum_11optimizer/gradients_4/policy_1/mul_2_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_4/policy_1/mul_2_grad/tuple/group_depsNoOp2^optimizer/gradients_4/policy_1/mul_2_grad/Reshape4^optimizer/gradients_4/policy_1/mul_2_grad/Reshape_1
�
Boptimizer/gradients_4/policy_1/mul_2_grad/tuple/control_dependencyIdentity1optimizer/gradients_4/policy_1/mul_2_grad/Reshape;^optimizer/gradients_4/policy_1/mul_2_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/mul_2_grad/Reshape
�
Doptimizer/gradients_4/policy_1/mul_2_grad/tuple/control_dependency_1Identity3optimizer/gradients_4/policy_1/mul_2_grad/Reshape_1;^optimizer/gradients_4/policy_1/mul_2_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/policy_1/mul_2_grad/Reshape_1
c
0optimizer/gradients_4/optimizer/sub_7_grad/ShapeShapeoptimizer/Sum_4*
T0*
out_type0
x
2optimizer/gradients_4/optimizer/sub_7_grad/Shape_1Shape"optimizer/extrinsic_value_estimate*
T0*
out_type0
�
@optimizer/gradients_4/optimizer/sub_7_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_4/optimizer/sub_7_grad/Shape2optimizer/gradients_4/optimizer/sub_7_grad/Shape_1*
T0
�
.optimizer/gradients_4/optimizer/sub_7_grad/SumSumSoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency@optimizer/gradients_4/optimizer/sub_7_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_4/optimizer/sub_7_grad/ReshapeReshape.optimizer/gradients_4/optimizer/sub_7_grad/Sum0optimizer/gradients_4/optimizer/sub_7_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_4/optimizer/sub_7_grad/NegNegSoptimizer/gradients_4/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_4/optimizer/sub_7_grad/Sum_1Sum.optimizer/gradients_4/optimizer/sub_7_grad/NegBoptimizer/gradients_4/optimizer/sub_7_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_4/optimizer/sub_7_grad/Reshape_1Reshape0optimizer/gradients_4/optimizer/sub_7_grad/Sum_12optimizer/gradients_4/optimizer/sub_7_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_4/optimizer/sub_7_grad/tuple/group_depsNoOp3^optimizer/gradients_4/optimizer/sub_7_grad/Reshape5^optimizer/gradients_4/optimizer/sub_7_grad/Reshape_1
�
Coptimizer/gradients_4/optimizer/sub_7_grad/tuple/control_dependencyIdentity2optimizer/gradients_4/optimizer/sub_7_grad/Reshape<^optimizer/gradients_4/optimizer/sub_7_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_4/optimizer/sub_7_grad/Reshape
�
Eoptimizer/gradients_4/optimizer/sub_7_grad/tuple/control_dependency_1Identity4optimizer/gradients_4/optimizer/sub_7_grad/Reshape_1<^optimizer/gradients_4/optimizer/sub_7_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_4/optimizer/sub_7_grad/Reshape_1
c
0optimizer/gradients_4/optimizer/sub_8_grad/ShapeShapeoptimizer/Sum_6*
T0*
out_type0
x
2optimizer/gradients_4/optimizer/sub_8_grad/Shape_1Shape"optimizer/curiosity_value_estimate*
T0*
out_type0
�
@optimizer/gradients_4/optimizer/sub_8_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_4/optimizer/sub_8_grad/Shape2optimizer/gradients_4/optimizer/sub_8_grad/Shape_1*
T0
�
.optimizer/gradients_4/optimizer/sub_8_grad/SumSumUoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency@optimizer/gradients_4/optimizer/sub_8_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_4/optimizer/sub_8_grad/ReshapeReshape.optimizer/gradients_4/optimizer/sub_8_grad/Sum0optimizer/gradients_4/optimizer/sub_8_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_4/optimizer/sub_8_grad/NegNegUoptimizer/gradients_4/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_4/optimizer/sub_8_grad/Sum_1Sum.optimizer/gradients_4/optimizer/sub_8_grad/NegBoptimizer/gradients_4/optimizer/sub_8_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_4/optimizer/sub_8_grad/Reshape_1Reshape0optimizer/gradients_4/optimizer/sub_8_grad/Sum_12optimizer/gradients_4/optimizer/sub_8_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_4/optimizer/sub_8_grad/tuple/group_depsNoOp3^optimizer/gradients_4/optimizer/sub_8_grad/Reshape5^optimizer/gradients_4/optimizer/sub_8_grad/Reshape_1
�
Coptimizer/gradients_4/optimizer/sub_8_grad/tuple/control_dependencyIdentity2optimizer/gradients_4/optimizer/sub_8_grad/Reshape<^optimizer/gradients_4/optimizer/sub_8_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_4/optimizer/sub_8_grad/Reshape
�
Eoptimizer/gradients_4/optimizer/sub_8_grad/tuple/control_dependency_1Identity4optimizer/gradients_4/optimizer/sub_8_grad/Reshape_1<^optimizer/gradients_4/optimizer/sub_8_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_4/optimizer/sub_8_grad/Reshape_1
c
0optimizer/gradients_4/optimizer/sub_9_grad/ShapeShapeoptimizer/Sum_8*
T0*
out_type0
s
2optimizer/gradients_4/optimizer/sub_9_grad/Shape_1Shapeoptimizer/gail_value_estimate*
T0*
out_type0
�
@optimizer/gradients_4/optimizer/sub_9_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_4/optimizer/sub_9_grad/Shape2optimizer/gradients_4/optimizer/sub_9_grad/Shape_1*
T0
�
.optimizer/gradients_4/optimizer/sub_9_grad/SumSumUoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependency@optimizer/gradients_4/optimizer/sub_9_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_4/optimizer/sub_9_grad/ReshapeReshape.optimizer/gradients_4/optimizer/sub_9_grad/Sum0optimizer/gradients_4/optimizer/sub_9_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_4/optimizer/sub_9_grad/NegNegUoptimizer/gradients_4/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_4/optimizer/sub_9_grad/Sum_1Sum.optimizer/gradients_4/optimizer/sub_9_grad/NegBoptimizer/gradients_4/optimizer/sub_9_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_4/optimizer/sub_9_grad/Reshape_1Reshape0optimizer/gradients_4/optimizer/sub_9_grad/Sum_12optimizer/gradients_4/optimizer/sub_9_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_4/optimizer/sub_9_grad/tuple/group_depsNoOp3^optimizer/gradients_4/optimizer/sub_9_grad/Reshape5^optimizer/gradients_4/optimizer/sub_9_grad/Reshape_1
�
Coptimizer/gradients_4/optimizer/sub_9_grad/tuple/control_dependencyIdentity2optimizer/gradients_4/optimizer/sub_9_grad/Reshape<^optimizer/gradients_4/optimizer/sub_9_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_4/optimizer/sub_9_grad/Reshape
�
Eoptimizer/gradients_4/optimizer/sub_9_grad/tuple/control_dependency_1Identity4optimizer/gradients_4/optimizer/sub_9_grad/Reshape_1<^optimizer/gradients_4/optimizer/sub_9_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_4/optimizer/sub_9_grad/Reshape_1
a
/optimizer/gradients_4/policy_1/add_3_grad/ShapeShapepolicy_1/add_2*
T0*
out_type0
e
1optimizer/gradients_4/policy_1/add_3_grad/Shape_1Shapepolicy_1/add_3/y*
T0*
out_type0
�
?optimizer/gradients_4/policy_1/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_4/policy_1/add_3_grad/Shape1optimizer/gradients_4/policy_1/add_3_grad/Shape_1*
T0
�
-optimizer/gradients_4/policy_1/add_3_grad/SumSumDoptimizer/gradients_4/policy_1/mul_2_grad/tuple/control_dependency_1?optimizer/gradients_4/policy_1/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_4/policy_1/add_3_grad/ReshapeReshape-optimizer/gradients_4/policy_1/add_3_grad/Sum/optimizer/gradients_4/policy_1/add_3_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_4/policy_1/add_3_grad/Sum_1SumDoptimizer/gradients_4/policy_1/mul_2_grad/tuple/control_dependency_1Aoptimizer/gradients_4/policy_1/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/policy_1/add_3_grad/Reshape_1Reshape/optimizer/gradients_4/policy_1/add_3_grad/Sum_11optimizer/gradients_4/policy_1/add_3_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_4/policy_1/add_3_grad/tuple/group_depsNoOp2^optimizer/gradients_4/policy_1/add_3_grad/Reshape4^optimizer/gradients_4/policy_1/add_3_grad/Reshape_1
�
Boptimizer/gradients_4/policy_1/add_3_grad/tuple/control_dependencyIdentity1optimizer/gradients_4/policy_1/add_3_grad/Reshape;^optimizer/gradients_4/policy_1/add_3_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/add_3_grad/Reshape
�
Doptimizer/gradients_4/policy_1/add_3_grad/tuple/control_dependency_1Identity3optimizer/gradients_4/policy_1/add_3_grad/Reshape_1;^optimizer/gradients_4/policy_1/add_3_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/policy_1/add_3_grad/Reshape_1
u
0optimizer/gradients_4/optimizer/Sum_4_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_4/optimizer/Sum_4_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_4/optimizer/Sum_4_grad/addAddV2!optimizer/Sum_4/reduction_indices/optimizer/gradients_4/optimizer/Sum_4_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape
�
.optimizer/gradients_4/optimizer/Sum_4_grad/modFloorMod.optimizer/gradients_4/optimizer/Sum_4_grad/add/optimizer/gradients_4/optimizer/Sum_4_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_4_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_4/optimizer/Sum_4_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_4/optimizer/Sum_4_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_4/optimizer/Sum_4_grad/rangeRange6optimizer/gradients_4/optimizer/Sum_4_grad/range/start/optimizer/gradients_4/optimizer/Sum_4_grad/Size6optimizer/gradients_4/optimizer/Sum_4_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape
�
5optimizer/gradients_4/optimizer/Sum_4_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_4/optimizer/Sum_4_grad/FillFill2optimizer/gradients_4/optimizer/Sum_4_grad/Shape_15optimizer/gradients_4/optimizer/Sum_4_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape*

index_type0
�
8optimizer/gradients_4/optimizer/Sum_4_grad/DynamicStitchDynamicStitch0optimizer/gradients_4/optimizer/Sum_4_grad/range.optimizer/gradients_4/optimizer/Sum_4_grad/mod0optimizer/gradients_4/optimizer/Sum_4_grad/Shape/optimizer/gradients_4/optimizer/Sum_4_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_4_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_4_grad/ReshapeReshapeCoptimizer/gradients_4/optimizer/sub_7_grad/tuple/control_dependency8optimizer/gradients_4/optimizer/Sum_4_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_4/optimizer/Sum_4_grad/BroadcastToBroadcastTo2optimizer/gradients_4/optimizer/Sum_4_grad/Reshape0optimizer/gradients_4/optimizer/Sum_4_grad/Shape*
T0*

Tidx0
u
0optimizer/gradients_4/optimizer/Sum_6_grad/ShapeShape!optimizer/curiosity_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_4/optimizer/Sum_6_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_4/optimizer/Sum_6_grad/addAddV2!optimizer/Sum_6/reduction_indices/optimizer/gradients_4/optimizer/Sum_6_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape
�
.optimizer/gradients_4/optimizer/Sum_6_grad/modFloorMod.optimizer/gradients_4/optimizer/Sum_6_grad/add/optimizer/gradients_4/optimizer/Sum_6_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_6_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_4/optimizer/Sum_6_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_4/optimizer/Sum_6_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_4/optimizer/Sum_6_grad/rangeRange6optimizer/gradients_4/optimizer/Sum_6_grad/range/start/optimizer/gradients_4/optimizer/Sum_6_grad/Size6optimizer/gradients_4/optimizer/Sum_6_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape
�
5optimizer/gradients_4/optimizer/Sum_6_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_4/optimizer/Sum_6_grad/FillFill2optimizer/gradients_4/optimizer/Sum_6_grad/Shape_15optimizer/gradients_4/optimizer/Sum_6_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape*

index_type0
�
8optimizer/gradients_4/optimizer/Sum_6_grad/DynamicStitchDynamicStitch0optimizer/gradients_4/optimizer/Sum_6_grad/range.optimizer/gradients_4/optimizer/Sum_6_grad/mod0optimizer/gradients_4/optimizer/Sum_6_grad/Shape/optimizer/gradients_4/optimizer/Sum_6_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_6_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_6_grad/ReshapeReshapeCoptimizer/gradients_4/optimizer/sub_8_grad/tuple/control_dependency8optimizer/gradients_4/optimizer/Sum_6_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_4/optimizer/Sum_6_grad/BroadcastToBroadcastTo2optimizer/gradients_4/optimizer/Sum_6_grad/Reshape0optimizer/gradients_4/optimizer/Sum_6_grad/Shape*
T0*

Tidx0
p
0optimizer/gradients_4/optimizer/Sum_8_grad/ShapeShapeoptimizer/gail_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_4/optimizer/Sum_8_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_4/optimizer/Sum_8_grad/addAddV2!optimizer/Sum_8/reduction_indices/optimizer/gradients_4/optimizer/Sum_8_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape
�
.optimizer/gradients_4/optimizer/Sum_8_grad/modFloorMod.optimizer/gradients_4/optimizer/Sum_8_grad/add/optimizer/gradients_4/optimizer/Sum_8_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_8_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_4/optimizer/Sum_8_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_4/optimizer/Sum_8_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_4/optimizer/Sum_8_grad/rangeRange6optimizer/gradients_4/optimizer/Sum_8_grad/range/start/optimizer/gradients_4/optimizer/Sum_8_grad/Size6optimizer/gradients_4/optimizer/Sum_8_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape
�
5optimizer/gradients_4/optimizer/Sum_8_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_4/optimizer/Sum_8_grad/FillFill2optimizer/gradients_4/optimizer/Sum_8_grad/Shape_15optimizer/gradients_4/optimizer/Sum_8_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape*

index_type0
�
8optimizer/gradients_4/optimizer/Sum_8_grad/DynamicStitchDynamicStitch0optimizer/gradients_4/optimizer/Sum_8_grad/range.optimizer/gradients_4/optimizer/Sum_8_grad/mod0optimizer/gradients_4/optimizer/Sum_8_grad/Shape/optimizer/gradients_4/optimizer/Sum_8_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_4/optimizer/Sum_8_grad/Shape
�
2optimizer/gradients_4/optimizer/Sum_8_grad/ReshapeReshapeCoptimizer/gradients_4/optimizer/sub_9_grad/tuple/control_dependency8optimizer/gradients_4/optimizer/Sum_8_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_4/optimizer/Sum_8_grad/BroadcastToBroadcastTo2optimizer/gradients_4/optimizer/Sum_8_grad/Reshape0optimizer/gradients_4/optimizer/Sum_8_grad/Shape*
T0*

Tidx0
_
/optimizer/gradients_4/policy_1/add_2_grad/ShapeShapepolicy_1/pow*
T0*
out_type0
c
1optimizer/gradients_4/policy_1/add_2_grad/Shape_1Shapepolicy_1/mul_1*
T0*
out_type0
�
?optimizer/gradients_4/policy_1/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_4/policy_1/add_2_grad/Shape1optimizer/gradients_4/policy_1/add_2_grad/Shape_1*
T0
�
-optimizer/gradients_4/policy_1/add_2_grad/SumSumBoptimizer/gradients_4/policy_1/add_3_grad/tuple/control_dependency?optimizer/gradients_4/policy_1/add_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_4/policy_1/add_2_grad/ReshapeReshape-optimizer/gradients_4/policy_1/add_2_grad/Sum/optimizer/gradients_4/policy_1/add_2_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_4/policy_1/add_2_grad/Sum_1SumBoptimizer/gradients_4/policy_1/add_3_grad/tuple/control_dependencyAoptimizer/gradients_4/policy_1/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/policy_1/add_2_grad/Reshape_1Reshape/optimizer/gradients_4/policy_1/add_2_grad/Sum_11optimizer/gradients_4/policy_1/add_2_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_4/policy_1/add_2_grad/tuple/group_depsNoOp2^optimizer/gradients_4/policy_1/add_2_grad/Reshape4^optimizer/gradients_4/policy_1/add_2_grad/Reshape_1
�
Boptimizer/gradients_4/policy_1/add_2_grad/tuple/control_dependencyIdentity1optimizer/gradients_4/policy_1/add_2_grad/Reshape;^optimizer/gradients_4/policy_1/add_2_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/add_2_grad/Reshape
�
Doptimizer/gradients_4/policy_1/add_2_grad/tuple/control_dependency_1Identity3optimizer/gradients_4/policy_1/add_2_grad/Reshape_1;^optimizer/gradients_4/policy_1/add_2_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/policy_1/add_2_grad/Reshape_1
�
optimizer/gradients_4/AddN_1AddN6optimizer/gradients_4/optimizer/Sum_5_grad/BroadcastTo6optimizer/gradients_4/optimizer/Sum_4_grad/BroadcastTo*
N*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Sum_5_grad/BroadcastTo
�
Hoptimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_4/AddN_1*
T0*
data_formatNHWC
�
Moptimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_4/AddN_1I^optimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/AddN_1N^optimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Sum_5_grad/BroadcastTo
�
Woptimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradN^optimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients_4/AddN_2AddN6optimizer/gradients_4/optimizer/Sum_7_grad/BroadcastTo6optimizer/gradients_4/optimizer/Sum_6_grad/BroadcastTo*
N*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Sum_7_grad/BroadcastTo
�
Hoptimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_4/AddN_2*
T0*
data_formatNHWC
�
Moptimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_4/AddN_2I^optimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/AddN_2N^optimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Sum_7_grad/BroadcastTo
�
Woptimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/BiasAddGradN^optimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients_4/AddN_3AddN6optimizer/gradients_4/optimizer/Sum_9_grad/BroadcastTo6optimizer/gradients_4/optimizer/Sum_8_grad/BroadcastTo*
N*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Sum_9_grad/BroadcastTo
�
Coptimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_4/AddN_3*
T0*
data_formatNHWC
�
Hoptimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_4/AddN_3D^optimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/BiasAddGrad
�
Poptimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/AddN_3I^optimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/optimizer/Sum_9_grad/BroadcastTo
�
Roptimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/tuple/control_dependency_1IdentityCoptimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/BiasAddGradI^optimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/BiasAddGrad
a
-optimizer/gradients_4/policy_1/pow_grad/ShapeShapepolicy_1/truediv*
T0*
out_type0
a
/optimizer/gradients_4/policy_1/pow_grad/Shape_1Shapepolicy_1/pow/y*
T0*
out_type0
�
=optimizer/gradients_4/policy_1/pow_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_4/policy_1/pow_grad/Shape/optimizer/gradients_4/policy_1/pow_grad/Shape_1*
T0
�
+optimizer/gradients_4/policy_1/pow_grad/mulMulBoptimizer/gradients_4/policy_1/add_2_grad/tuple/control_dependencypolicy_1/pow/y*
T0
Z
-optimizer/gradients_4/policy_1/pow_grad/sub/yConst*
dtype0*
valueB
 *  �?
z
+optimizer/gradients_4/policy_1/pow_grad/subSubpolicy_1/pow/y-optimizer/gradients_4/policy_1/pow_grad/sub/y*
T0
z
+optimizer/gradients_4/policy_1/pow_grad/PowPowpolicy_1/truediv+optimizer/gradients_4/policy_1/pow_grad/sub*
T0
�
-optimizer/gradients_4/policy_1/pow_grad/mul_1Mul+optimizer/gradients_4/policy_1/pow_grad/mul+optimizer/gradients_4/policy_1/pow_grad/Pow*
T0
�
+optimizer/gradients_4/policy_1/pow_grad/SumSum-optimizer/gradients_4/policy_1/pow_grad/mul_1=optimizer/gradients_4/policy_1/pow_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_4/policy_1/pow_grad/ReshapeReshape+optimizer/gradients_4/policy_1/pow_grad/Sum-optimizer/gradients_4/policy_1/pow_grad/Shape*
T0*
Tshape0
^
1optimizer/gradients_4/policy_1/pow_grad/Greater/yConst*
dtype0*
valueB
 *    
�
/optimizer/gradients_4/policy_1/pow_grad/GreaterGreaterpolicy_1/truediv1optimizer/gradients_4/policy_1/pow_grad/Greater/y*
T0
k
7optimizer/gradients_4/policy_1/pow_grad/ones_like/ShapeShapepolicy_1/truediv*
T0*
out_type0
d
7optimizer/gradients_4/policy_1/pow_grad/ones_like/ConstConst*
dtype0*
valueB
 *  �?
�
1optimizer/gradients_4/policy_1/pow_grad/ones_likeFill7optimizer/gradients_4/policy_1/pow_grad/ones_like/Shape7optimizer/gradients_4/policy_1/pow_grad/ones_like/Const*
T0*

index_type0
�
.optimizer/gradients_4/policy_1/pow_grad/SelectSelect/optimizer/gradients_4/policy_1/pow_grad/Greaterpolicy_1/truediv1optimizer/gradients_4/policy_1/pow_grad/ones_like*
T0
k
+optimizer/gradients_4/policy_1/pow_grad/LogLog.optimizer/gradients_4/policy_1/pow_grad/Select*
T0
Z
2optimizer/gradients_4/policy_1/pow_grad/zeros_like	ZerosLikepolicy_1/truediv*
T0
�
0optimizer/gradients_4/policy_1/pow_grad/Select_1Select/optimizer/gradients_4/policy_1/pow_grad/Greater+optimizer/gradients_4/policy_1/pow_grad/Log2optimizer/gradients_4/policy_1/pow_grad/zeros_like*
T0
�
-optimizer/gradients_4/policy_1/pow_grad/mul_2MulBoptimizer/gradients_4/policy_1/add_2_grad/tuple/control_dependencypolicy_1/pow*
T0
�
-optimizer/gradients_4/policy_1/pow_grad/mul_3Mul-optimizer/gradients_4/policy_1/pow_grad/mul_20optimizer/gradients_4/policy_1/pow_grad/Select_1*
T0
�
-optimizer/gradients_4/policy_1/pow_grad/Sum_1Sum-optimizer/gradients_4/policy_1/pow_grad/mul_3?optimizer/gradients_4/policy_1/pow_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_4/policy_1/pow_grad/Reshape_1Reshape-optimizer/gradients_4/policy_1/pow_grad/Sum_1/optimizer/gradients_4/policy_1/pow_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_4/policy_1/pow_grad/tuple/group_depsNoOp0^optimizer/gradients_4/policy_1/pow_grad/Reshape2^optimizer/gradients_4/policy_1/pow_grad/Reshape_1
�
@optimizer/gradients_4/policy_1/pow_grad/tuple/control_dependencyIdentity/optimizer/gradients_4/policy_1/pow_grad/Reshape9^optimizer/gradients_4/policy_1/pow_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/policy_1/pow_grad/Reshape
�
Boptimizer/gradients_4/policy_1/pow_grad/tuple/control_dependency_1Identity1optimizer/gradients_4/policy_1/pow_grad/Reshape_19^optimizer/gradients_4/policy_1/pow_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/pow_grad/Reshape_1
�
-optimizer/gradients_4/policy_1/mul_1_grad/MulMulDoptimizer/gradients_4/policy_1/add_2_grad/tuple/control_dependency_1policy_1/clip_by_value*
T0
m
?optimizer/gradients_4/policy_1/mul_1_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_4/policy_1/mul_1_grad/SumSum-optimizer/gradients_4/policy_1/mul_1_grad/Mul?optimizer/gradients_4/policy_1/mul_1_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_4/policy_1/mul_1_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_4/policy_1/mul_1_grad/ReshapeReshape-optimizer/gradients_4/policy_1/mul_1_grad/Sum7optimizer/gradients_4/policy_1/mul_1_grad/Reshape/shape*
T0*
Tshape0
�
/optimizer/gradients_4/policy_1/mul_1_grad/Mul_1Mulpolicy_1/mul_1/xDoptimizer/gradients_4/policy_1/add_2_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_4/policy_1/mul_1_grad/tuple/group_depsNoOp0^optimizer/gradients_4/policy_1/mul_1_grad/Mul_12^optimizer/gradients_4/policy_1/mul_1_grad/Reshape
�
Boptimizer/gradients_4/policy_1/mul_1_grad/tuple/control_dependencyIdentity1optimizer/gradients_4/policy_1/mul_1_grad/Reshape;^optimizer/gradients_4/policy_1/mul_1_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/mul_1_grad/Reshape
�
Doptimizer/gradients_4/policy_1/mul_1_grad/tuple/control_dependency_1Identity/optimizer/gradients_4/policy_1/mul_1_grad/Mul_1;^optimizer/gradients_4/policy_1/mul_1_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/policy_1/mul_1_grad/Mul_1
�
Boptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMulMatMulUoptimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency&optimizer//extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Doptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulUoptimizer/gradients_4/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Loptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/tuple/group_depsNoOpC^optimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMulE^optimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Toptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependencyIdentityBoptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMulM^optimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMul
�
Voptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMul_1M^optimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Boptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMulMatMulUoptimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependency&optimizer//curiosity_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Doptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulUoptimizer/gradients_4/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Loptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/tuple/group_depsNoOpC^optimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMulE^optimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMul_1
�
Toptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/tuple/control_dependencyIdentityBoptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMulM^optimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMul
�
Voptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMul_1M^optimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/MatMul_1
�
=optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMulMatMulPoptimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/tuple/control_dependency!optimizer//gail_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
?optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulPoptimizer/gradients_4/optimizer/gail_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Goptimizer/gradients_4/optimizer/gail_value/MatMul_grad/tuple/group_depsNoOp>^optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMul@^optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMul_1
�
Ooptimizer/gradients_4/optimizer/gail_value/MatMul_grad/tuple/control_dependencyIdentity=optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMulH^optimizer/gradients_4/optimizer/gail_value/MatMul_grad/tuple/group_deps*
T0*P
_classF
DBloc:@optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMul
�
Qoptimizer/gradients_4/optimizer/gail_value/MatMul_grad/tuple/control_dependency_1Identity?optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMul_1H^optimizer/gradients_4/optimizer/gail_value/MatMul_grad/tuple/group_deps*
T0*R
_classH
FDloc:@optimizer/gradients_4/optimizer/gail_value/MatMul_grad/MatMul_1
a
1optimizer/gradients_4/policy_1/truediv_grad/ShapeShapepolicy_1/sub*
T0*
out_type0
a
3optimizer/gradients_4/policy_1/truediv_grad/Shape_1Const*
dtype0*
valueB:
�
Aoptimizer/gradients_4/policy_1/truediv_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_4/policy_1/truediv_grad/Shape3optimizer/gradients_4/policy_1/truediv_grad/Shape_1*
T0
�
3optimizer/gradients_4/policy_1/truediv_grad/RealDivRealDiv@optimizer/gradients_4/policy_1/pow_grad/tuple/control_dependencypolicy_1/add_1*
T0
�
/optimizer/gradients_4/policy_1/truediv_grad/SumSum3optimizer/gradients_4/policy_1/truediv_grad/RealDivAoptimizer/gradients_4/policy_1/truediv_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_4/policy_1/truediv_grad/ReshapeReshape/optimizer/gradients_4/policy_1/truediv_grad/Sum1optimizer/gradients_4/policy_1/truediv_grad/Shape*
T0*
Tshape0
M
/optimizer/gradients_4/policy_1/truediv_grad/NegNegpolicy_1/sub*
T0
�
5optimizer/gradients_4/policy_1/truediv_grad/RealDiv_1RealDiv/optimizer/gradients_4/policy_1/truediv_grad/Negpolicy_1/add_1*
T0
�
5optimizer/gradients_4/policy_1/truediv_grad/RealDiv_2RealDiv5optimizer/gradients_4/policy_1/truediv_grad/RealDiv_1policy_1/add_1*
T0
�
/optimizer/gradients_4/policy_1/truediv_grad/mulMul@optimizer/gradients_4/policy_1/pow_grad/tuple/control_dependency5optimizer/gradients_4/policy_1/truediv_grad/RealDiv_2*
T0
�
1optimizer/gradients_4/policy_1/truediv_grad/Sum_1Sum/optimizer/gradients_4/policy_1/truediv_grad/mulCoptimizer/gradients_4/policy_1/truediv_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_4/policy_1/truediv_grad/Reshape_1Reshape1optimizer/gradients_4/policy_1/truediv_grad/Sum_13optimizer/gradients_4/policy_1/truediv_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_4/policy_1/truediv_grad/tuple/group_depsNoOp4^optimizer/gradients_4/policy_1/truediv_grad/Reshape6^optimizer/gradients_4/policy_1/truediv_grad/Reshape_1
�
Doptimizer/gradients_4/policy_1/truediv_grad/tuple/control_dependencyIdentity3optimizer/gradients_4/policy_1/truediv_grad/Reshape=^optimizer/gradients_4/policy_1/truediv_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_4/policy_1/truediv_grad/Reshape
�
Foptimizer/gradients_4/policy_1/truediv_grad/tuple/control_dependency_1Identity5optimizer/gradients_4/policy_1/truediv_grad/Reshape_1=^optimizer/gradients_4/policy_1/truediv_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/policy_1/truediv_grad/Reshape_1
�
optimizer/gradients_4/AddN_4AddNToptimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependencyToptimizer/gradients_4/optimizer/curiosity_value/MatMul_grad/tuple/control_dependencyOoptimizer/gradients_4/optimizer/gail_value/MatMul_grad/tuple/control_dependency*
N*
T0*U
_classK
IGloc:@optimizer/gradients_4/optimizer/extrinsic_value/MatMul_grad/MatMul
�
Doptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Foptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Toptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsDoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeFoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
Boptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/MulMuloptimizer/gradients_4/AddN_4'optimizer/main_graph_0/hidden_1/Sigmoid*
T0
�
Boptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/SumSumBoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/MulToptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeReshapeBoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/SumDoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_1/BiasAddoptimizer/gradients_4/AddN_4*
T0
�
Doptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1SumDoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Voptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Hoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeDoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1Foptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Ooptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpG^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeI^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Woptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityFoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeP^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Yoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1P^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
f
-optimizer/gradients_4/policy_1/sub_grad/ShapeShapepolicy_1/StopGradient*
T0*
out_type0
f
/optimizer/gradients_4/policy_1/sub_grad/Shape_1Shapepolicy_1/mu/BiasAdd*
T0*
out_type0
�
=optimizer/gradients_4/policy_1/sub_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_4/policy_1/sub_grad/Shape/optimizer/gradients_4/policy_1/sub_grad/Shape_1*
T0
�
+optimizer/gradients_4/policy_1/sub_grad/SumSumDoptimizer/gradients_4/policy_1/truediv_grad/tuple/control_dependency=optimizer/gradients_4/policy_1/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_4/policy_1/sub_grad/ReshapeReshape+optimizer/gradients_4/policy_1/sub_grad/Sum-optimizer/gradients_4/policy_1/sub_grad/Shape*
T0*
Tshape0
�
+optimizer/gradients_4/policy_1/sub_grad/NegNegDoptimizer/gradients_4/policy_1/truediv_grad/tuple/control_dependency*
T0
�
-optimizer/gradients_4/policy_1/sub_grad/Sum_1Sum+optimizer/gradients_4/policy_1/sub_grad/Neg?optimizer/gradients_4/policy_1/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_4/policy_1/sub_grad/Reshape_1Reshape-optimizer/gradients_4/policy_1/sub_grad/Sum_1/optimizer/gradients_4/policy_1/sub_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_4/policy_1/sub_grad/tuple/group_depsNoOp0^optimizer/gradients_4/policy_1/sub_grad/Reshape2^optimizer/gradients_4/policy_1/sub_grad/Reshape_1
�
@optimizer/gradients_4/policy_1/sub_grad/tuple/control_dependencyIdentity/optimizer/gradients_4/policy_1/sub_grad/Reshape9^optimizer/gradients_4/policy_1/sub_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_4/policy_1/sub_grad/Reshape
�
Boptimizer/gradients_4/policy_1/sub_grad/tuple/control_dependency_1Identity1optimizer/gradients_4/policy_1/sub_grad/Reshape_19^optimizer/gradients_4/policy_1/sub_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/sub_grad/Reshape_1
p
Boptimizer/gradients_4/policy_1/add_1_grad/BroadcastGradientArgs/s0Const*
dtype0*
valueB:
k
Boptimizer/gradients_4/policy_1/add_1_grad/BroadcastGradientArgs/s1Const*
dtype0*
valueB 
�
?optimizer/gradients_4/policy_1/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_4/policy_1/add_1_grad/BroadcastGradientArgs/s0Boptimizer/gradients_4/policy_1/add_1_grad/BroadcastGradientArgs/s1*
T0
m
?optimizer/gradients_4/policy_1/add_1_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_4/policy_1/add_1_grad/SumSumFoptimizer/gradients_4/policy_1/truediv_grad/tuple/control_dependency_1?optimizer/gradients_4/policy_1/add_1_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_4/policy_1/add_1_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_4/policy_1/add_1_grad/ReshapeReshape-optimizer/gradients_4/policy_1/add_1_grad/Sum7optimizer/gradients_4/policy_1/add_1_grad/Reshape/shape*
T0*
Tshape0
�
:optimizer/gradients_4/policy_1/add_1_grad/tuple/group_depsNoOp2^optimizer/gradients_4/policy_1/add_1_grad/ReshapeG^optimizer/gradients_4/policy_1/truediv_grad/tuple/control_dependency_1
�
Boptimizer/gradients_4/policy_1/add_1_grad/tuple/control_dependencyIdentityFoptimizer/gradients_4/policy_1/truediv_grad/tuple/control_dependency_1;^optimizer/gradients_4/policy_1/add_1_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_4/policy_1/truediv_grad/Reshape_1
�
Doptimizer/gradients_4/policy_1/add_1_grad/tuple/control_dependency_1Identity1optimizer/gradients_4/policy_1/add_1_grad/Reshape;^optimizer/gradients_4/policy_1/add_1_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/add_1_grad/Reshape
�
Noptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_1/SigmoidYoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_4/AddN_5AddNWoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyNoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Noptimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_4/AddN_5*
T0*
data_formatNHWC
�
Soptimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_4/AddN_5O^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
[optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/AddN_5T^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
]optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityNoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradT^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*a
_classW
USloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Hoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulMatMul[optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Joptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_0/Mul[optimizer/gradients_4/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Roptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpI^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulK^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Zoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityHoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulS^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul
�
\optimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityJoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1S^optimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*]
_classS
QOloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
:optimizer/gradients_4/policy_1/mu/BiasAdd_grad/BiasAddGradBiasAddGradBoptimizer/gradients_4/policy_1/sub_grad/tuple/control_dependency_1*
T0*
data_formatNHWC
�
?optimizer/gradients_4/policy_1/mu/BiasAdd_grad/tuple/group_depsNoOp;^optimizer/gradients_4/policy_1/mu/BiasAdd_grad/BiasAddGradC^optimizer/gradients_4/policy_1/sub_grad/tuple/control_dependency_1
�
Goptimizer/gradients_4/policy_1/mu/BiasAdd_grad/tuple/control_dependencyIdentityBoptimizer/gradients_4/policy_1/sub_grad/tuple/control_dependency_1@^optimizer/gradients_4/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_4/policy_1/sub_grad/Reshape_1
�
Ioptimizer/gradients_4/policy_1/mu/BiasAdd_grad/tuple/control_dependency_1Identity:optimizer/gradients_4/policy_1/mu/BiasAdd_grad/BiasAddGrad@^optimizer/gradients_4/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_4/policy_1/mu/BiasAdd_grad/BiasAddGrad
�
Doptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Foptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Toptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsDoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeFoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
Boptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/MulMulZoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency'optimizer/main_graph_0/hidden_0/Sigmoid*
T0
�
Boptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/SumSumBoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/MulToptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeReshapeBoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/SumDoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_0/BiasAddZoptimizer/gradients_4/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Doptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1SumDoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Voptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Hoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeDoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1Foptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Ooptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpG^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeI^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Woptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityFoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeP^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Yoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1P^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
4optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMulMatMulGoptimizer/gradients_4/policy_1/mu/BiasAdd_grad/tuple/control_dependencypolicy/mu/kernel/read*
T0*
transpose_a( *
transpose_b(
�
6optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_1/MulGoptimizer/gradients_4/policy_1/mu/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
>optimizer/gradients_4/policy_1/mu/MatMul_grad/tuple/group_depsNoOp5^optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMul7^optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMul_1
�
Foptimizer/gradients_4/policy_1/mu/MatMul_grad/tuple/control_dependencyIdentity4optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMul?^optimizer/gradients_4/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMul
�
Hoptimizer/gradients_4/policy_1/mu/MatMul_grad/tuple/control_dependency_1Identity6optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMul_1?^optimizer/gradients_4/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_4/policy_1/mu/MatMul_grad/MatMul_1
�
+optimizer/gradients_4/policy_1/Exp_grad/mulMulBoptimizer/gradients_4/policy_1/add_1_grad/tuple/control_dependencypolicy_1/Exp*
T0
�
Noptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_0/SigmoidYoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
Aoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/ShapeShape$policy/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/ShapeCoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/MulMulFoptimizer/gradients_4/policy_1/mu/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
?optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/SumSum?optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/MulQoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/ReshapeReshape?optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/SumAoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_1/BiasAddFoptimizer/gradients_4/policy_1/mu/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Sum_1SumAoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Soptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Sum_1Coptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/ReshapeF^optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Toptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/ReshapeM^optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Voptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1M^optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
optimizer/gradients_4/AddN_6AddNDoptimizer/gradients_4/policy_1/mul_3_grad/tuple/control_dependency_1Doptimizer/gradients_4/policy_1/mul_1_grad/tuple/control_dependency_1+optimizer/gradients_4/policy_1/Exp_grad/mul*
N*
T0*B
_class8
64loc:@optimizer/gradients_4/policy_1/mul_3_grad/Mul_1
e
7optimizer/gradients_4/policy_1/clip_by_value_grad/ShapeConst*
dtype0*
valueB:
b
9optimizer/gradients_4/policy_1/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
g
9optimizer/gradients_4/policy_1/clip_by_value_grad/Shape_2Const*
dtype0*
valueB:
j
=optimizer/gradients_4/policy_1/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
7optimizer/gradients_4/policy_1/clip_by_value_grad/zerosFill9optimizer/gradients_4/policy_1/clip_by_value_grad/Shape_2=optimizer/gradients_4/policy_1/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
>optimizer/gradients_4/policy_1/clip_by_value_grad/GreaterEqualGreaterEqualpolicy_1/clip_by_value/Minimumpolicy_1/clip_by_value/y*
T0
�
Goptimizer/gradients_4/policy_1/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs7optimizer/gradients_4/policy_1/clip_by_value_grad/Shape9optimizer/gradients_4/policy_1/clip_by_value_grad/Shape_1*
T0
�
:optimizer/gradients_4/policy_1/clip_by_value_grad/SelectV2SelectV2>optimizer/gradients_4/policy_1/clip_by_value_grad/GreaterEqualoptimizer/gradients_4/AddN_67optimizer/gradients_4/policy_1/clip_by_value_grad/zeros*
T0
�
5optimizer/gradients_4/policy_1/clip_by_value_grad/SumSum:optimizer/gradients_4/policy_1/clip_by_value_grad/SelectV2Goptimizer/gradients_4/policy_1/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
9optimizer/gradients_4/policy_1/clip_by_value_grad/ReshapeReshape5optimizer/gradients_4/policy_1/clip_by_value_grad/Sum7optimizer/gradients_4/policy_1/clip_by_value_grad/Shape*
T0*
Tshape0
�
<optimizer/gradients_4/policy_1/clip_by_value_grad/SelectV2_1SelectV2>optimizer/gradients_4/policy_1/clip_by_value_grad/GreaterEqual7optimizer/gradients_4/policy_1/clip_by_value_grad/zerosoptimizer/gradients_4/AddN_6*
T0
�
7optimizer/gradients_4/policy_1/clip_by_value_grad/Sum_1Sum<optimizer/gradients_4/policy_1/clip_by_value_grad/SelectV2_1Ioptimizer/gradients_4/policy_1/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
;optimizer/gradients_4/policy_1/clip_by_value_grad/Reshape_1Reshape7optimizer/gradients_4/policy_1/clip_by_value_grad/Sum_19optimizer/gradients_4/policy_1/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
Boptimizer/gradients_4/policy_1/clip_by_value_grad/tuple/group_depsNoOp:^optimizer/gradients_4/policy_1/clip_by_value_grad/Reshape<^optimizer/gradients_4/policy_1/clip_by_value_grad/Reshape_1
�
Joptimizer/gradients_4/policy_1/clip_by_value_grad/tuple/control_dependencyIdentity9optimizer/gradients_4/policy_1/clip_by_value_grad/ReshapeC^optimizer/gradients_4/policy_1/clip_by_value_grad/tuple/group_deps*
T0*L
_classB
@>loc:@optimizer/gradients_4/policy_1/clip_by_value_grad/Reshape
�
Loptimizer/gradients_4/policy_1/clip_by_value_grad/tuple/control_dependency_1Identity;optimizer/gradients_4/policy_1/clip_by_value_grad/Reshape_1C^optimizer/gradients_4/policy_1/clip_by_value_grad/tuple/group_deps*
T0*N
_classD
B@loc:@optimizer/gradients_4/policy_1/clip_by_value_grad/Reshape_1
�
optimizer/gradients_4/AddN_7AddNWoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyNoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Noptimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_4/AddN_7*
T0*
data_formatNHWC
�
Soptimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_4/AddN_7O^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
[optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/AddN_7T^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
]optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityNoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradT^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*a
_classW
USloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Koptimizer/gradients_4/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_1/SigmoidVoptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
m
?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/ShapeConst*
dtype0*
valueB:
j
Aoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
o
Aoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Shape_2Const*
dtype0*
valueB:
r
Eoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/zerosFillAoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Shape_2Eoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
Coptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/LessEqual	LessEqualpolicy/log_std/read policy_1/clip_by_value/Minimum/y*
T0
�
Ooptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/ShapeAoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0
�
Boptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/SelectV2SelectV2Coptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/LessEqualJoptimizer/gradients_4/policy_1/clip_by_value_grad/tuple/control_dependency?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/zeros*
T0
�
=optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/SumSumBoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/SelectV2Ooptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Aoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/ReshapeReshape=optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Sum?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/SelectV2_1SelectV2Coptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/LessEqual?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/zerosJoptimizer/gradients_4/policy_1/clip_by_value_grad/tuple/control_dependency*
T0
�
?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Sum_1SumDoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/SelectV2_1Qoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Reshape_1Reshape?optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Sum_1Aoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Joptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/tuple/group_depsNoOpB^optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/ReshapeD^optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
Roptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/tuple/control_dependencyIdentityAoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/ReshapeK^optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Reshape
�
Toptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency_1IdentityCoptimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Reshape_1K^optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_4/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
Hoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulMatMul[optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Joptimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_state[optimizer/gradients_4/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Roptimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpI^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulK^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Zoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityHoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulS^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul
�
\optimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityJoptimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1S^optimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*]
_classS
QOloc:@optimizer/gradients_4/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
optimizer/gradients_4/AddN_8AddNToptimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyKoptimizer/gradients_4/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Koptimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_4/AddN_8*
T0*
data_formatNHWC
�
Poptimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_4/AddN_8L^optimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/AddN_8Q^optimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_4/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Zoptimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulXoptimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_0/MulXoptimizer/gradients_4/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMulH^optimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Woptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMulP^optimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMul
�
Yoptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1P^optimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Aoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/ShapeShape$policy/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/ShapeCoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/MulMulWoptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
?optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/SumSum?optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/MulQoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/ReshapeReshape?optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/SumAoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_0/BiasAddWoptimizer/gradients_4/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Sum_1SumAoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Soptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Sum_1Coptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/ReshapeF^optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Toptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/ReshapeM^optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Voptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1M^optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Koptimizer/gradients_4/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_0/SigmoidVoptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_4/AddN_9AddNToptimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyKoptimizer/gradients_4/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Koptimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_4/AddN_9*
T0*
data_formatNHWC
�
Poptimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_4/AddN_9L^optimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_4/AddN_9Q^optimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_4/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Zoptimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulXoptimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateXoptimizer/gradients_4/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMulH^optimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Woptimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMulP^optimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMul
�
Yoptimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1P^optimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_4/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
D
optimizer/gradients_5/ShapeConst*
dtype0*
valueB 
L
optimizer/gradients_5/grad_ys_0Const*
dtype0*
valueB
 *  �?
{
optimizer/gradients_5/FillFilloptimizer/gradients_5/Shapeoptimizer/gradients_5/grad_ys_0*
T0*

index_type0
[
/optimizer/gradients_5/optimizer/sub_12_grad/NegNegoptimizer/gradients_5/Fill*
T0
�
<optimizer/gradients_5/optimizer/sub_12_grad/tuple/group_depsNoOp^optimizer/gradients_5/Fill0^optimizer/gradients_5/optimizer/sub_12_grad/Neg
�
Doptimizer/gradients_5/optimizer/sub_12_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/Fill=^optimizer/gradients_5/optimizer/sub_12_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_5/Fill
�
Foptimizer/gradients_5/optimizer/sub_12_grad/tuple/control_dependency_1Identity/optimizer/gradients_5/optimizer/sub_12_grad/Neg=^optimizer/gradients_5/optimizer/sub_12_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/optimizer/sub_12_grad/Neg
�
<optimizer/gradients_5/optimizer/add_15_grad/tuple/group_depsNoOpE^optimizer/gradients_5/optimizer/sub_12_grad/tuple/control_dependency
�
Doptimizer/gradients_5/optimizer/add_15_grad/tuple/control_dependencyIdentityDoptimizer/gradients_5/optimizer/sub_12_grad/tuple/control_dependency=^optimizer/gradients_5/optimizer/add_15_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_5/Fill
�
Foptimizer/gradients_5/optimizer/add_15_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_5/optimizer/sub_12_grad/tuple/control_dependency=^optimizer/gradients_5/optimizer/add_15_grad/tuple/group_deps*
T0*-
_class#
!loc:@optimizer/gradients_5/Fill
�
/optimizer/gradients_5/optimizer/mul_14_grad/MulMulFoptimizer/gradients_5/optimizer/sub_12_grad/tuple/control_dependency_1optimizer/Mean_15*
T0
�
1optimizer/gradients_5/optimizer/mul_14_grad/Mul_1MulFoptimizer/gradients_5/optimizer/sub_12_grad/tuple/control_dependency_1optimizer/PolynomialDecay_3*
T0
�
<optimizer/gradients_5/optimizer/mul_14_grad/tuple/group_depsNoOp0^optimizer/gradients_5/optimizer/mul_14_grad/Mul2^optimizer/gradients_5/optimizer/mul_14_grad/Mul_1
�
Doptimizer/gradients_5/optimizer/mul_14_grad/tuple/control_dependencyIdentity/optimizer/gradients_5/optimizer/mul_14_grad/Mul=^optimizer/gradients_5/optimizer/mul_14_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/optimizer/mul_14_grad/Mul
�
Foptimizer/gradients_5/optimizer/mul_14_grad/tuple/control_dependency_1Identity1optimizer/gradients_5/optimizer/mul_14_grad/Mul_1=^optimizer/gradients_5/optimizer/mul_14_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/optimizer/mul_14_grad/Mul_1
�
.optimizer/gradients_5/optimizer/Neg_5_grad/NegNegDoptimizer/gradients_5/optimizer/add_15_grad/tuple/control_dependency*
T0
�
/optimizer/gradients_5/optimizer/mul_13_grad/MulMulFoptimizer/gradients_5/optimizer/add_15_grad/tuple/control_dependency_1optimizer/Mean_13*
T0
�
1optimizer/gradients_5/optimizer/mul_13_grad/Mul_1MulFoptimizer/gradients_5/optimizer/add_15_grad/tuple/control_dependency_1optimizer/mul_13/x*
T0
�
<optimizer/gradients_5/optimizer/mul_13_grad/tuple/group_depsNoOp0^optimizer/gradients_5/optimizer/mul_13_grad/Mul2^optimizer/gradients_5/optimizer/mul_13_grad/Mul_1
�
Doptimizer/gradients_5/optimizer/mul_13_grad/tuple/control_dependencyIdentity/optimizer/gradients_5/optimizer/mul_13_grad/Mul=^optimizer/gradients_5/optimizer/mul_13_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/optimizer/mul_13_grad/Mul
�
Foptimizer/gradients_5/optimizer/mul_13_grad/tuple/control_dependency_1Identity1optimizer/gradients_5/optimizer/mul_13_grad/Mul_1=^optimizer/gradients_5/optimizer/mul_13_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/optimizer/mul_13_grad/Mul_1
h
:optimizer/gradients_5/optimizer/Mean_15_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_5/optimizer/Mean_15_grad/ReshapeReshapeFoptimizer/gradients_5/optimizer/mul_14_grad/tuple/control_dependency_1:optimizer/gradients_5/optimizer/Mean_15_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_5/optimizer/Mean_15_grad/ShapeShapeoptimizer/DynamicPartition_6:1*
T0*
out_type0
�
1optimizer/gradients_5/optimizer/Mean_15_grad/TileTile4optimizer/gradients_5/optimizer/Mean_15_grad/Reshape2optimizer/gradients_5/optimizer/Mean_15_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_5/optimizer/Mean_15_grad/Shape_1Shapeoptimizer/DynamicPartition_6:1*
T0*
out_type0
]
4optimizer/gradients_5/optimizer/Mean_15_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_5/optimizer/Mean_15_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_5/optimizer/Mean_15_grad/ProdProd4optimizer/gradients_5/optimizer/Mean_15_grad/Shape_12optimizer/gradients_5/optimizer/Mean_15_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_5/optimizer/Mean_15_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_5/optimizer/Mean_15_grad/Prod_1Prod4optimizer/gradients_5/optimizer/Mean_15_grad/Shape_24optimizer/gradients_5/optimizer/Mean_15_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_5/optimizer/Mean_15_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_5/optimizer/Mean_15_grad/MaximumMaximum3optimizer/gradients_5/optimizer/Mean_15_grad/Prod_16optimizer/gradients_5/optimizer/Mean_15_grad/Maximum/y*
T0
�
5optimizer/gradients_5/optimizer/Mean_15_grad/floordivFloorDiv1optimizer/gradients_5/optimizer/Mean_15_grad/Prod4optimizer/gradients_5/optimizer/Mean_15_grad/Maximum*
T0
�
1optimizer/gradients_5/optimizer/Mean_15_grad/CastCast5optimizer/gradients_5/optimizer/Mean_15_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_5/optimizer/Mean_15_grad/truedivRealDiv1optimizer/gradients_5/optimizer/Mean_15_grad/Tile1optimizer/gradients_5/optimizer/Mean_15_grad/Cast*
T0
o
:optimizer/gradients_5/optimizer/Mean_14_grad/Reshape/shapeConst*
dtype0*
valueB"      
�
4optimizer/gradients_5/optimizer/Mean_14_grad/ReshapeReshape.optimizer/gradients_5/optimizer/Neg_5_grad/Neg:optimizer/gradients_5/optimizer/Mean_14_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_5/optimizer/Mean_14_grad/ShapeShapeoptimizer/DynamicPartition_5:1*
T0*
out_type0
�
1optimizer/gradients_5/optimizer/Mean_14_grad/TileTile4optimizer/gradients_5/optimizer/Mean_14_grad/Reshape2optimizer/gradients_5/optimizer/Mean_14_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_5/optimizer/Mean_14_grad/Shape_1Shapeoptimizer/DynamicPartition_5:1*
T0*
out_type0
]
4optimizer/gradients_5/optimizer/Mean_14_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_5/optimizer/Mean_14_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_5/optimizer/Mean_14_grad/ProdProd4optimizer/gradients_5/optimizer/Mean_14_grad/Shape_12optimizer/gradients_5/optimizer/Mean_14_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_5/optimizer/Mean_14_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_5/optimizer/Mean_14_grad/Prod_1Prod4optimizer/gradients_5/optimizer/Mean_14_grad/Shape_24optimizer/gradients_5/optimizer/Mean_14_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_5/optimizer/Mean_14_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_5/optimizer/Mean_14_grad/MaximumMaximum3optimizer/gradients_5/optimizer/Mean_14_grad/Prod_16optimizer/gradients_5/optimizer/Mean_14_grad/Maximum/y*
T0
�
5optimizer/gradients_5/optimizer/Mean_14_grad/floordivFloorDiv1optimizer/gradients_5/optimizer/Mean_14_grad/Prod4optimizer/gradients_5/optimizer/Mean_14_grad/Maximum*
T0
�
1optimizer/gradients_5/optimizer/Mean_14_grad/CastCast5optimizer/gradients_5/optimizer/Mean_14_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_5/optimizer/Mean_14_grad/truedivRealDiv1optimizer/gradients_5/optimizer/Mean_14_grad/Tile1optimizer/gradients_5/optimizer/Mean_14_grad/Cast*
T0
h
:optimizer/gradients_5/optimizer/Mean_13_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_5/optimizer/Mean_13_grad/ReshapeReshapeFoptimizer/gradients_5/optimizer/mul_13_grad/tuple/control_dependency_1:optimizer/gradients_5/optimizer/Mean_13_grad/Reshape/shape*
T0*
Tshape0
`
2optimizer/gradients_5/optimizer/Mean_13_grad/ConstConst*
dtype0*
valueB:
�
1optimizer/gradients_5/optimizer/Mean_13_grad/TileTile4optimizer/gradients_5/optimizer/Mean_13_grad/Reshape2optimizer/gradients_5/optimizer/Mean_13_grad/Const*
T0*

Tmultiples0
a
4optimizer/gradients_5/optimizer/Mean_13_grad/Const_1Const*
dtype0*
valueB
 *  @@
�
4optimizer/gradients_5/optimizer/Mean_13_grad/truedivRealDiv1optimizer/gradients_5/optimizer/Mean_13_grad/Tile4optimizer/gradients_5/optimizer/Mean_13_grad/Const_1*
T0
T
 optimizer/gradients_5/zeros_like	ZerosLikeoptimizer/DynamicPartition_6*
T0
g
=optimizer/gradients_5/optimizer/DynamicPartition_6_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_5/optimizer/DynamicPartition_6_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_5/optimizer/DynamicPartition_6_grad/ProdProd=optimizer/gradients_5/optimizer/DynamicPartition_6_grad/Shape=optimizer/gradients_5/optimizer/DynamicPartition_6_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_6_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_6_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_5/optimizer/DynamicPartition_6_grad/rangeRangeCoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/range/start<optimizer/gradients_5/optimizer/DynamicPartition_6_grad/ProdCoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/range/delta*

Tidx0
�
?optimizer/gradients_5/optimizer/DynamicPartition_6_grad/ReshapeReshape=optimizer/gradients_5/optimizer/DynamicPartition_6_grad/range=optimizer/gradients_5/optimizer/DynamicPartition_6_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/DynamicPartitionDynamicPartition?optimizer/gradients_5/optimizer/DynamicPartition_6_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_5/optimizer/DynamicPartition_6_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/DynamicPartitionJoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/DynamicPartition:1 optimizer/gradients_5/zeros_like4optimizer/gradients_5/optimizer/Mean_15_grad/truediv*
N*
T0
q
?optimizer/gradients_5/optimizer/DynamicPartition_6_grad/Shape_1Shapepolicy_1/mul_5*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/Reshape_1ReshapeMoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/ParallelDynamicStitch?optimizer/gradients_5/optimizer/DynamicPartition_6_grad/Shape_1*
T0*
Tshape0
V
"optimizer/gradients_5/zeros_like_1	ZerosLikeoptimizer/DynamicPartition_5*
T0
g
=optimizer/gradients_5/optimizer/DynamicPartition_5_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_5/optimizer/DynamicPartition_5_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_5/optimizer/DynamicPartition_5_grad/ProdProd=optimizer/gradients_5/optimizer/DynamicPartition_5_grad/Shape=optimizer/gradients_5/optimizer/DynamicPartition_5_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_5_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_5_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_5/optimizer/DynamicPartition_5_grad/rangeRangeCoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/range/start<optimizer/gradients_5/optimizer/DynamicPartition_5_grad/ProdCoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/range/delta*

Tidx0
�
?optimizer/gradients_5/optimizer/DynamicPartition_5_grad/ReshapeReshape=optimizer/gradients_5/optimizer/DynamicPartition_5_grad/range=optimizer/gradients_5/optimizer/DynamicPartition_5_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/DynamicPartitionDynamicPartition?optimizer/gradients_5/optimizer/DynamicPartition_5_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_5/optimizer/DynamicPartition_5_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/DynamicPartitionJoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/DynamicPartition:1"optimizer/gradients_5/zeros_like_14optimizer/gradients_5/optimizer/Mean_14_grad/truediv*
N*
T0
t
?optimizer/gradients_5/optimizer/DynamicPartition_5_grad/Shape_1Shapeoptimizer/Minimum*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/Reshape_1ReshapeMoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/ParallelDynamicStitch?optimizer/gradients_5/optimizer/DynamicPartition_5_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_5/optimizer/Mean_13/input_grad/unstackUnpack4optimizer/gradients_5/optimizer/Mean_13_grad/truediv*
T0*

axis *	
num
�
Coptimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/group_depsNoOp;^optimizer/gradients_5/optimizer/Mean_13/input_grad/unstack
�
Koptimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/control_dependencyIdentity:optimizer/gradients_5/optimizer/Mean_13/input_grad/unstackD^optimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_5/optimizer/Mean_13/input_grad/unstack
�
Moptimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/Mean_13/input_grad/unstack:1D^optimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_5/optimizer/Mean_13/input_grad/unstack
�
Moptimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/control_dependency_2Identity<optimizer/gradients_5/optimizer/Mean_13/input_grad/unstack:2D^optimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_5/optimizer/Mean_13/input_grad/unstack
e
/optimizer/gradients_5/policy_1/mul_5_grad/ShapeShapepolicy_1/ones_like*
T0*
out_type0
c
1optimizer/gradients_5/policy_1/mul_5_grad/Shape_1Shapepolicy_1/mul_4*
T0*
out_type0
�
?optimizer/gradients_5/policy_1/mul_5_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_5/policy_1/mul_5_grad/Shape1optimizer/gradients_5/policy_1/mul_5_grad/Shape_1*
T0
�
-optimizer/gradients_5/policy_1/mul_5_grad/MulMulAoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/Reshape_1policy_1/mul_4*
T0
�
-optimizer/gradients_5/policy_1/mul_5_grad/SumSum-optimizer/gradients_5/policy_1/mul_5_grad/Mul?optimizer/gradients_5/policy_1/mul_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_5/policy_1/mul_5_grad/ReshapeReshape-optimizer/gradients_5/policy_1/mul_5_grad/Sum/optimizer/gradients_5/policy_1/mul_5_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_5/policy_1/mul_5_grad/Mul_1Mulpolicy_1/ones_likeAoptimizer/gradients_5/optimizer/DynamicPartition_6_grad/Reshape_1*
T0
�
/optimizer/gradients_5/policy_1/mul_5_grad/Sum_1Sum/optimizer/gradients_5/policy_1/mul_5_grad/Mul_1Aoptimizer/gradients_5/policy_1/mul_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/policy_1/mul_5_grad/Reshape_1Reshape/optimizer/gradients_5/policy_1/mul_5_grad/Sum_11optimizer/gradients_5/policy_1/mul_5_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_5/policy_1/mul_5_grad/tuple/group_depsNoOp2^optimizer/gradients_5/policy_1/mul_5_grad/Reshape4^optimizer/gradients_5/policy_1/mul_5_grad/Reshape_1
�
Boptimizer/gradients_5/policy_1/mul_5_grad/tuple/control_dependencyIdentity1optimizer/gradients_5/policy_1/mul_5_grad/Reshape;^optimizer/gradients_5/policy_1/mul_5_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/mul_5_grad/Reshape
�
Doptimizer/gradients_5/policy_1/mul_5_grad/tuple/control_dependency_1Identity3optimizer/gradients_5/policy_1/mul_5_grad/Reshape_1;^optimizer/gradients_5/policy_1/mul_5_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/policy_1/mul_5_grad/Reshape_1
f
2optimizer/gradients_5/optimizer/Minimum_grad/ShapeShapeoptimizer/mul_11*
T0*
out_type0
h
4optimizer/gradients_5/optimizer/Minimum_grad/Shape_1Shapeoptimizer/mul_12*
T0*
out_type0
�
4optimizer/gradients_5/optimizer/Minimum_grad/Shape_2ShapeAoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/Reshape_1*
T0*
out_type0
e
8optimizer/gradients_5/optimizer/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
2optimizer/gradients_5/optimizer/Minimum_grad/zerosFill4optimizer/gradients_5/optimizer/Minimum_grad/Shape_28optimizer/gradients_5/optimizer/Minimum_grad/zeros/Const*
T0*

index_type0
p
6optimizer/gradients_5/optimizer/Minimum_grad/LessEqual	LessEqualoptimizer/mul_11optimizer/mul_12*
T0
�
Boptimizer/gradients_5/optimizer/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs2optimizer/gradients_5/optimizer/Minimum_grad/Shape4optimizer/gradients_5/optimizer/Minimum_grad/Shape_1*
T0
�
5optimizer/gradients_5/optimizer/Minimum_grad/SelectV2SelectV26optimizer/gradients_5/optimizer/Minimum_grad/LessEqualAoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/Reshape_12optimizer/gradients_5/optimizer/Minimum_grad/zeros*
T0
�
0optimizer/gradients_5/optimizer/Minimum_grad/SumSum5optimizer/gradients_5/optimizer/Minimum_grad/SelectV2Boptimizer/gradients_5/optimizer/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_5/optimizer/Minimum_grad/ReshapeReshape0optimizer/gradients_5/optimizer/Minimum_grad/Sum2optimizer/gradients_5/optimizer/Minimum_grad/Shape*
T0*
Tshape0
�
7optimizer/gradients_5/optimizer/Minimum_grad/SelectV2_1SelectV26optimizer/gradients_5/optimizer/Minimum_grad/LessEqual2optimizer/gradients_5/optimizer/Minimum_grad/zerosAoptimizer/gradients_5/optimizer/DynamicPartition_5_grad/Reshape_1*
T0
�
2optimizer/gradients_5/optimizer/Minimum_grad/Sum_1Sum7optimizer/gradients_5/optimizer/Minimum_grad/SelectV2_1Doptimizer/gradients_5/optimizer/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_5/optimizer/Minimum_grad/Reshape_1Reshape2optimizer/gradients_5/optimizer/Minimum_grad/Sum_14optimizer/gradients_5/optimizer/Minimum_grad/Shape_1*
T0*
Tshape0
�
=optimizer/gradients_5/optimizer/Minimum_grad/tuple/group_depsNoOp5^optimizer/gradients_5/optimizer/Minimum_grad/Reshape7^optimizer/gradients_5/optimizer/Minimum_grad/Reshape_1
�
Eoptimizer/gradients_5/optimizer/Minimum_grad/tuple/control_dependencyIdentity4optimizer/gradients_5/optimizer/Minimum_grad/Reshape>^optimizer/gradients_5/optimizer/Minimum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_5/optimizer/Minimum_grad/Reshape
�
Goptimizer/gradients_5/optimizer/Minimum_grad/tuple/control_dependency_1Identity6optimizer/gradients_5/optimizer/Minimum_grad/Reshape_1>^optimizer/gradients_5/optimizer/Minimum_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Minimum_grad/Reshape_1
h
:optimizer/gradients_5/optimizer/Mean_10_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_5/optimizer/Mean_10_grad/ReshapeReshapeKoptimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/control_dependency:optimizer/gradients_5/optimizer/Mean_10_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_5/optimizer/Mean_10_grad/ShapeShapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
�
1optimizer/gradients_5/optimizer/Mean_10_grad/TileTile4optimizer/gradients_5/optimizer/Mean_10_grad/Reshape2optimizer/gradients_5/optimizer/Mean_10_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_5/optimizer/Mean_10_grad/Shape_1Shapeoptimizer/DynamicPartition_2:1*
T0*
out_type0
]
4optimizer/gradients_5/optimizer/Mean_10_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_5/optimizer/Mean_10_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_5/optimizer/Mean_10_grad/ProdProd4optimizer/gradients_5/optimizer/Mean_10_grad/Shape_12optimizer/gradients_5/optimizer/Mean_10_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_5/optimizer/Mean_10_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_5/optimizer/Mean_10_grad/Prod_1Prod4optimizer/gradients_5/optimizer/Mean_10_grad/Shape_24optimizer/gradients_5/optimizer/Mean_10_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_5/optimizer/Mean_10_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_5/optimizer/Mean_10_grad/MaximumMaximum3optimizer/gradients_5/optimizer/Mean_10_grad/Prod_16optimizer/gradients_5/optimizer/Mean_10_grad/Maximum/y*
T0
�
5optimizer/gradients_5/optimizer/Mean_10_grad/floordivFloorDiv1optimizer/gradients_5/optimizer/Mean_10_grad/Prod4optimizer/gradients_5/optimizer/Mean_10_grad/Maximum*
T0
�
1optimizer/gradients_5/optimizer/Mean_10_grad/CastCast5optimizer/gradients_5/optimizer/Mean_10_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_5/optimizer/Mean_10_grad/truedivRealDiv1optimizer/gradients_5/optimizer/Mean_10_grad/Tile1optimizer/gradients_5/optimizer/Mean_10_grad/Cast*
T0
h
:optimizer/gradients_5/optimizer/Mean_11_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_5/optimizer/Mean_11_grad/ReshapeReshapeMoptimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/control_dependency_1:optimizer/gradients_5/optimizer/Mean_11_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_5/optimizer/Mean_11_grad/ShapeShapeoptimizer/DynamicPartition_3:1*
T0*
out_type0
�
1optimizer/gradients_5/optimizer/Mean_11_grad/TileTile4optimizer/gradients_5/optimizer/Mean_11_grad/Reshape2optimizer/gradients_5/optimizer/Mean_11_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_5/optimizer/Mean_11_grad/Shape_1Shapeoptimizer/DynamicPartition_3:1*
T0*
out_type0
]
4optimizer/gradients_5/optimizer/Mean_11_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_5/optimizer/Mean_11_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_5/optimizer/Mean_11_grad/ProdProd4optimizer/gradients_5/optimizer/Mean_11_grad/Shape_12optimizer/gradients_5/optimizer/Mean_11_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_5/optimizer/Mean_11_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_5/optimizer/Mean_11_grad/Prod_1Prod4optimizer/gradients_5/optimizer/Mean_11_grad/Shape_24optimizer/gradients_5/optimizer/Mean_11_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_5/optimizer/Mean_11_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_5/optimizer/Mean_11_grad/MaximumMaximum3optimizer/gradients_5/optimizer/Mean_11_grad/Prod_16optimizer/gradients_5/optimizer/Mean_11_grad/Maximum/y*
T0
�
5optimizer/gradients_5/optimizer/Mean_11_grad/floordivFloorDiv1optimizer/gradients_5/optimizer/Mean_11_grad/Prod4optimizer/gradients_5/optimizer/Mean_11_grad/Maximum*
T0
�
1optimizer/gradients_5/optimizer/Mean_11_grad/CastCast5optimizer/gradients_5/optimizer/Mean_11_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_5/optimizer/Mean_11_grad/truedivRealDiv1optimizer/gradients_5/optimizer/Mean_11_grad/Tile1optimizer/gradients_5/optimizer/Mean_11_grad/Cast*
T0
h
:optimizer/gradients_5/optimizer/Mean_12_grad/Reshape/shapeConst*
dtype0*
valueB:
�
4optimizer/gradients_5/optimizer/Mean_12_grad/ReshapeReshapeMoptimizer/gradients_5/optimizer/Mean_13/input_grad/tuple/control_dependency_2:optimizer/gradients_5/optimizer/Mean_12_grad/Reshape/shape*
T0*
Tshape0
t
2optimizer/gradients_5/optimizer/Mean_12_grad/ShapeShapeoptimizer/DynamicPartition_4:1*
T0*
out_type0
�
1optimizer/gradients_5/optimizer/Mean_12_grad/TileTile4optimizer/gradients_5/optimizer/Mean_12_grad/Reshape2optimizer/gradients_5/optimizer/Mean_12_grad/Shape*
T0*

Tmultiples0
v
4optimizer/gradients_5/optimizer/Mean_12_grad/Shape_1Shapeoptimizer/DynamicPartition_4:1*
T0*
out_type0
]
4optimizer/gradients_5/optimizer/Mean_12_grad/Shape_2Const*
dtype0*
valueB 
`
2optimizer/gradients_5/optimizer/Mean_12_grad/ConstConst*
dtype0*
valueB: 
�
1optimizer/gradients_5/optimizer/Mean_12_grad/ProdProd4optimizer/gradients_5/optimizer/Mean_12_grad/Shape_12optimizer/gradients_5/optimizer/Mean_12_grad/Const*
T0*

Tidx0*
	keep_dims( 
b
4optimizer/gradients_5/optimizer/Mean_12_grad/Const_1Const*
dtype0*
valueB: 
�
3optimizer/gradients_5/optimizer/Mean_12_grad/Prod_1Prod4optimizer/gradients_5/optimizer/Mean_12_grad/Shape_24optimizer/gradients_5/optimizer/Mean_12_grad/Const_1*
T0*

Tidx0*
	keep_dims( 
`
6optimizer/gradients_5/optimizer/Mean_12_grad/Maximum/yConst*
dtype0*
value	B :
�
4optimizer/gradients_5/optimizer/Mean_12_grad/MaximumMaximum3optimizer/gradients_5/optimizer/Mean_12_grad/Prod_16optimizer/gradients_5/optimizer/Mean_12_grad/Maximum/y*
T0
�
5optimizer/gradients_5/optimizer/Mean_12_grad/floordivFloorDiv1optimizer/gradients_5/optimizer/Mean_12_grad/Prod4optimizer/gradients_5/optimizer/Mean_12_grad/Maximum*
T0
�
1optimizer/gradients_5/optimizer/Mean_12_grad/CastCast5optimizer/gradients_5/optimizer/Mean_12_grad/floordiv*

DstT0*

SrcT0*
Truncate( 
�
4optimizer/gradients_5/optimizer/Mean_12_grad/truedivRealDiv1optimizer/gradients_5/optimizer/Mean_12_grad/Tile1optimizer/gradients_5/optimizer/Mean_12_grad/Cast*
T0
�
-optimizer/gradients_5/policy_1/mul_4_grad/MulMulDoptimizer/gradients_5/policy_1/mul_5_grad/tuple/control_dependency_1policy_1/Mean*
T0
�
/optimizer/gradients_5/policy_1/mul_4_grad/Mul_1MulDoptimizer/gradients_5/policy_1/mul_5_grad/tuple/control_dependency_1policy_1/mul_4/x*
T0
�
:optimizer/gradients_5/policy_1/mul_4_grad/tuple/group_depsNoOp.^optimizer/gradients_5/policy_1/mul_4_grad/Mul0^optimizer/gradients_5/policy_1/mul_4_grad/Mul_1
�
Boptimizer/gradients_5/policy_1/mul_4_grad/tuple/control_dependencyIdentity-optimizer/gradients_5/policy_1/mul_4_grad/Mul;^optimizer/gradients_5/policy_1/mul_4_grad/tuple/group_deps*
T0*@
_class6
42loc:@optimizer/gradients_5/policy_1/mul_4_grad/Mul
�
Doptimizer/gradients_5/policy_1/mul_4_grad/tuple/control_dependency_1Identity/optimizer/gradients_5/policy_1/mul_4_grad/Mul_1;^optimizer/gradients_5/policy_1/mul_4_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/policy_1/mul_4_grad/Mul_1
b
1optimizer/gradients_5/optimizer/mul_11_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
m
3optimizer/gradients_5/optimizer/mul_11_grad/Shape_1Shapeoptimizer/ExpandDims_2*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/mul_11_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_5/optimizer/mul_11_grad/Shape3optimizer/gradients_5/optimizer/mul_11_grad/Shape_1*
T0
�
/optimizer/gradients_5/optimizer/mul_11_grad/MulMulEoptimizer/gradients_5/optimizer/Minimum_grad/tuple/control_dependencyoptimizer/ExpandDims_2*
T0
�
/optimizer/gradients_5/optimizer/mul_11_grad/SumSum/optimizer/gradients_5/optimizer/mul_11_grad/MulAoptimizer/gradients_5/optimizer/mul_11_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/optimizer/mul_11_grad/ReshapeReshape/optimizer/gradients_5/optimizer/mul_11_grad/Sum1optimizer/gradients_5/optimizer/mul_11_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_5/optimizer/mul_11_grad/Mul_1Muloptimizer/ExpEoptimizer/gradients_5/optimizer/Minimum_grad/tuple/control_dependency*
T0
�
1optimizer/gradients_5/optimizer/mul_11_grad/Sum_1Sum1optimizer/gradients_5/optimizer/mul_11_grad/Mul_1Coptimizer/gradients_5/optimizer/mul_11_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_5/optimizer/mul_11_grad/Reshape_1Reshape1optimizer/gradients_5/optimizer/mul_11_grad/Sum_13optimizer/gradients_5/optimizer/mul_11_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/mul_11_grad/tuple/group_depsNoOp4^optimizer/gradients_5/optimizer/mul_11_grad/Reshape6^optimizer/gradients_5/optimizer/mul_11_grad/Reshape_1
�
Doptimizer/gradients_5/optimizer/mul_11_grad/tuple/control_dependencyIdentity3optimizer/gradients_5/optimizer/mul_11_grad/Reshape=^optimizer/gradients_5/optimizer/mul_11_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/optimizer/mul_11_grad/Reshape
�
Foptimizer/gradients_5/optimizer/mul_11_grad/tuple/control_dependency_1Identity5optimizer/gradients_5/optimizer/mul_11_grad/Reshape_1=^optimizer/gradients_5/optimizer/mul_11_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/optimizer/mul_11_grad/Reshape_1
n
1optimizer/gradients_5/optimizer/mul_12_grad/ShapeShapeoptimizer/clip_by_value_3*
T0*
out_type0
m
3optimizer/gradients_5/optimizer/mul_12_grad/Shape_1Shapeoptimizer/ExpandDims_2*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/mul_12_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_5/optimizer/mul_12_grad/Shape3optimizer/gradients_5/optimizer/mul_12_grad/Shape_1*
T0
�
/optimizer/gradients_5/optimizer/mul_12_grad/MulMulGoptimizer/gradients_5/optimizer/Minimum_grad/tuple/control_dependency_1optimizer/ExpandDims_2*
T0
�
/optimizer/gradients_5/optimizer/mul_12_grad/SumSum/optimizer/gradients_5/optimizer/mul_12_grad/MulAoptimizer/gradients_5/optimizer/mul_12_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/optimizer/mul_12_grad/ReshapeReshape/optimizer/gradients_5/optimizer/mul_12_grad/Sum1optimizer/gradients_5/optimizer/mul_12_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_5/optimizer/mul_12_grad/Mul_1Muloptimizer/clip_by_value_3Goptimizer/gradients_5/optimizer/Minimum_grad/tuple/control_dependency_1*
T0
�
1optimizer/gradients_5/optimizer/mul_12_grad/Sum_1Sum1optimizer/gradients_5/optimizer/mul_12_grad/Mul_1Coptimizer/gradients_5/optimizer/mul_12_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_5/optimizer/mul_12_grad/Reshape_1Reshape1optimizer/gradients_5/optimizer/mul_12_grad/Sum_13optimizer/gradients_5/optimizer/mul_12_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/mul_12_grad/tuple/group_depsNoOp4^optimizer/gradients_5/optimizer/mul_12_grad/Reshape6^optimizer/gradients_5/optimizer/mul_12_grad/Reshape_1
�
Doptimizer/gradients_5/optimizer/mul_12_grad/tuple/control_dependencyIdentity3optimizer/gradients_5/optimizer/mul_12_grad/Reshape=^optimizer/gradients_5/optimizer/mul_12_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/optimizer/mul_12_grad/Reshape
�
Foptimizer/gradients_5/optimizer/mul_12_grad/tuple/control_dependency_1Identity5optimizer/gradients_5/optimizer/mul_12_grad/Reshape_1=^optimizer/gradients_5/optimizer/mul_12_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/optimizer/mul_12_grad/Reshape_1
V
"optimizer/gradients_5/zeros_like_2	ZerosLikeoptimizer/DynamicPartition_2*
T0
g
=optimizer/gradients_5/optimizer/DynamicPartition_2_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_5/optimizer/DynamicPartition_2_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_5/optimizer/DynamicPartition_2_grad/ProdProd=optimizer/gradients_5/optimizer/DynamicPartition_2_grad/Shape=optimizer/gradients_5/optimizer/DynamicPartition_2_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_2_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_2_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_5/optimizer/DynamicPartition_2_grad/rangeRangeCoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/range/start<optimizer/gradients_5/optimizer/DynamicPartition_2_grad/ProdCoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/range/delta*

Tidx0
�
?optimizer/gradients_5/optimizer/DynamicPartition_2_grad/ReshapeReshape=optimizer/gradients_5/optimizer/DynamicPartition_2_grad/range=optimizer/gradients_5/optimizer/DynamicPartition_2_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/DynamicPartitionDynamicPartition?optimizer/gradients_5/optimizer/DynamicPartition_2_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_5/optimizer/DynamicPartition_2_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/DynamicPartitionJoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/DynamicPartition:1"optimizer/gradients_5/zeros_like_24optimizer/gradients_5/optimizer/Mean_10_grad/truediv*
N*
T0
t
?optimizer/gradients_5/optimizer/DynamicPartition_2_grad/Shape_1Shapeoptimizer/Maximum*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/Reshape_1ReshapeMoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/ParallelDynamicStitch?optimizer/gradients_5/optimizer/DynamicPartition_2_grad/Shape_1*
T0*
Tshape0
V
"optimizer/gradients_5/zeros_like_3	ZerosLikeoptimizer/DynamicPartition_3*
T0
g
=optimizer/gradients_5/optimizer/DynamicPartition_3_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_5/optimizer/DynamicPartition_3_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_5/optimizer/DynamicPartition_3_grad/ProdProd=optimizer/gradients_5/optimizer/DynamicPartition_3_grad/Shape=optimizer/gradients_5/optimizer/DynamicPartition_3_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_3_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_3_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_5/optimizer/DynamicPartition_3_grad/rangeRangeCoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/range/start<optimizer/gradients_5/optimizer/DynamicPartition_3_grad/ProdCoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/range/delta*

Tidx0
�
?optimizer/gradients_5/optimizer/DynamicPartition_3_grad/ReshapeReshape=optimizer/gradients_5/optimizer/DynamicPartition_3_grad/range=optimizer/gradients_5/optimizer/DynamicPartition_3_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/DynamicPartitionDynamicPartition?optimizer/gradients_5/optimizer/DynamicPartition_3_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_5/optimizer/DynamicPartition_3_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/DynamicPartitionJoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/DynamicPartition:1"optimizer/gradients_5/zeros_like_34optimizer/gradients_5/optimizer/Mean_11_grad/truediv*
N*
T0
v
?optimizer/gradients_5/optimizer/DynamicPartition_3_grad/Shape_1Shapeoptimizer/Maximum_1*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/Reshape_1ReshapeMoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/ParallelDynamicStitch?optimizer/gradients_5/optimizer/DynamicPartition_3_grad/Shape_1*
T0*
Tshape0
V
"optimizer/gradients_5/zeros_like_4	ZerosLikeoptimizer/DynamicPartition_4*
T0
g
=optimizer/gradients_5/optimizer/DynamicPartition_4_grad/ShapeShapeCast_3*
T0*
out_type0
k
=optimizer/gradients_5/optimizer/DynamicPartition_4_grad/ConstConst*
dtype0*
valueB: 
�
<optimizer/gradients_5/optimizer/DynamicPartition_4_grad/ProdProd=optimizer/gradients_5/optimizer/DynamicPartition_4_grad/Shape=optimizer/gradients_5/optimizer/DynamicPartition_4_grad/Const*
T0*

Tidx0*
	keep_dims( 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_4_grad/range/startConst*
dtype0*
value	B : 
m
Coptimizer/gradients_5/optimizer/DynamicPartition_4_grad/range/deltaConst*
dtype0*
value	B :
�
=optimizer/gradients_5/optimizer/DynamicPartition_4_grad/rangeRangeCoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/range/start<optimizer/gradients_5/optimizer/DynamicPartition_4_grad/ProdCoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/range/delta*

Tidx0
�
?optimizer/gradients_5/optimizer/DynamicPartition_4_grad/ReshapeReshape=optimizer/gradients_5/optimizer/DynamicPartition_4_grad/range=optimizer/gradients_5/optimizer/DynamicPartition_4_grad/Shape*
T0*
Tshape0
�
Hoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/DynamicPartitionDynamicPartition?optimizer/gradients_5/optimizer/DynamicPartition_4_grad/ReshapeCast_3*
T0*
num_partitions
�
Moptimizer/gradients_5/optimizer/DynamicPartition_4_grad/ParallelDynamicStitchParallelDynamicStitchHoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/DynamicPartitionJoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/DynamicPartition:1"optimizer/gradients_5/zeros_like_44optimizer/gradients_5/optimizer/Mean_12_grad/truediv*
N*
T0
v
?optimizer/gradients_5/optimizer/DynamicPartition_4_grad/Shape_1Shapeoptimizer/Maximum_2*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/Reshape_1ReshapeMoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/ParallelDynamicStitch?optimizer/gradients_5/optimizer/DynamicPartition_4_grad/Shape_1*
T0*
Tshape0
d
6optimizer/gradients_5/policy_1/Mean_grad/Reshape/shapeConst*
dtype0*
valueB:
�
0optimizer/gradients_5/policy_1/Mean_grad/ReshapeReshapeDoptimizer/gradients_5/policy_1/mul_4_grad/tuple/control_dependency_16optimizer/gradients_5/policy_1/Mean_grad/Reshape/shape*
T0*
Tshape0
\
.optimizer/gradients_5/policy_1/Mean_grad/ConstConst*
dtype0*
valueB:
�
-optimizer/gradients_5/policy_1/Mean_grad/TileTile0optimizer/gradients_5/policy_1/Mean_grad/Reshape.optimizer/gradients_5/policy_1/Mean_grad/Const*
T0*

Tmultiples0
]
0optimizer/gradients_5/policy_1/Mean_grad/Const_1Const*
dtype0*
valueB
 *  @@
�
0optimizer/gradients_5/policy_1/Mean_grad/truedivRealDiv-optimizer/gradients_5/policy_1/Mean_grad/Tile0optimizer/gradients_5/policy_1/Mean_grad/Const_1*
T0

:optimizer/gradients_5/optimizer/clip_by_value_3_grad/ShapeShape!optimizer/clip_by_value_3/Minimum*
T0*
out_type0
e
<optimizer/gradients_5/optimizer/clip_by_value_3_grad/Shape_1Const*
dtype0*
valueB 
�
<optimizer/gradients_5/optimizer/clip_by_value_3_grad/Shape_2ShapeDoptimizer/gradients_5/optimizer/mul_12_grad/tuple/control_dependency*
T0*
out_type0
m
@optimizer/gradients_5/optimizer/clip_by_value_3_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
:optimizer/gradients_5/optimizer/clip_by_value_3_grad/zerosFill<optimizer/gradients_5/optimizer/clip_by_value_3_grad/Shape_2@optimizer/gradients_5/optimizer/clip_by_value_3_grad/zeros/Const*
T0*

index_type0
�
Aoptimizer/gradients_5/optimizer/clip_by_value_3_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_3/Minimumoptimizer/sub_11*
T0
�
Joptimizer/gradients_5/optimizer/clip_by_value_3_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients_5/optimizer/clip_by_value_3_grad/Shape<optimizer/gradients_5/optimizer/clip_by_value_3_grad/Shape_1*
T0
�
=optimizer/gradients_5/optimizer/clip_by_value_3_grad/SelectV2SelectV2Aoptimizer/gradients_5/optimizer/clip_by_value_3_grad/GreaterEqualDoptimizer/gradients_5/optimizer/mul_12_grad/tuple/control_dependency:optimizer/gradients_5/optimizer/clip_by_value_3_grad/zeros*
T0
�
8optimizer/gradients_5/optimizer/clip_by_value_3_grad/SumSum=optimizer/gradients_5/optimizer/clip_by_value_3_grad/SelectV2Joptimizer/gradients_5/optimizer/clip_by_value_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_5/optimizer/clip_by_value_3_grad/ReshapeReshape8optimizer/gradients_5/optimizer/clip_by_value_3_grad/Sum:optimizer/gradients_5/optimizer/clip_by_value_3_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients_5/optimizer/clip_by_value_3_grad/SelectV2_1SelectV2Aoptimizer/gradients_5/optimizer/clip_by_value_3_grad/GreaterEqual:optimizer/gradients_5/optimizer/clip_by_value_3_grad/zerosDoptimizer/gradients_5/optimizer/mul_12_grad/tuple/control_dependency*
T0
�
:optimizer/gradients_5/optimizer/clip_by_value_3_grad/Sum_1Sum?optimizer/gradients_5/optimizer/clip_by_value_3_grad/SelectV2_1Loptimizer/gradients_5/optimizer/clip_by_value_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_5/optimizer/clip_by_value_3_grad/Reshape_1Reshape:optimizer/gradients_5/optimizer/clip_by_value_3_grad/Sum_1<optimizer/gradients_5/optimizer/clip_by_value_3_grad/Shape_1*
T0*
Tshape0
�
Eoptimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/clip_by_value_3_grad/Reshape?^optimizer/gradients_5/optimizer/clip_by_value_3_grad/Reshape_1
�
Moptimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/control_dependencyIdentity<optimizer/gradients_5/optimizer/clip_by_value_3_grad/ReshapeF^optimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/clip_by_value_3_grad/Reshape
�
Ooptimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/control_dependency_1Identity>optimizer/gradients_5/optimizer/clip_by_value_3_grad/Reshape_1F^optimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_5/optimizer/clip_by_value_3_grad/Reshape_1
s
2optimizer/gradients_5/optimizer/Maximum_grad/ShapeShapeoptimizer/SquaredDifference_3*
T0*
out_type0
u
4optimizer/gradients_5/optimizer/Maximum_grad/Shape_1Shapeoptimizer/SquaredDifference_4*
T0*
out_type0
�
4optimizer/gradients_5/optimizer/Maximum_grad/Shape_2ShapeAoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/Reshape_1*
T0*
out_type0
e
8optimizer/gradients_5/optimizer/Maximum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
2optimizer/gradients_5/optimizer/Maximum_grad/zerosFill4optimizer/gradients_5/optimizer/Maximum_grad/Shape_28optimizer/gradients_5/optimizer/Maximum_grad/zeros/Const*
T0*

index_type0
�
9optimizer/gradients_5/optimizer/Maximum_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifference_3optimizer/SquaredDifference_4*
T0
�
Boptimizer/gradients_5/optimizer/Maximum_grad/BroadcastGradientArgsBroadcastGradientArgs2optimizer/gradients_5/optimizer/Maximum_grad/Shape4optimizer/gradients_5/optimizer/Maximum_grad/Shape_1*
T0
�
5optimizer/gradients_5/optimizer/Maximum_grad/SelectV2SelectV29optimizer/gradients_5/optimizer/Maximum_grad/GreaterEqualAoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/Reshape_12optimizer/gradients_5/optimizer/Maximum_grad/zeros*
T0
�
0optimizer/gradients_5/optimizer/Maximum_grad/SumSum5optimizer/gradients_5/optimizer/Maximum_grad/SelectV2Boptimizer/gradients_5/optimizer/Maximum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_5/optimizer/Maximum_grad/ReshapeReshape0optimizer/gradients_5/optimizer/Maximum_grad/Sum2optimizer/gradients_5/optimizer/Maximum_grad/Shape*
T0*
Tshape0
�
7optimizer/gradients_5/optimizer/Maximum_grad/SelectV2_1SelectV29optimizer/gradients_5/optimizer/Maximum_grad/GreaterEqual2optimizer/gradients_5/optimizer/Maximum_grad/zerosAoptimizer/gradients_5/optimizer/DynamicPartition_2_grad/Reshape_1*
T0
�
2optimizer/gradients_5/optimizer/Maximum_grad/Sum_1Sum7optimizer/gradients_5/optimizer/Maximum_grad/SelectV2_1Doptimizer/gradients_5/optimizer/Maximum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_5/optimizer/Maximum_grad/Reshape_1Reshape2optimizer/gradients_5/optimizer/Maximum_grad/Sum_14optimizer/gradients_5/optimizer/Maximum_grad/Shape_1*
T0*
Tshape0
�
=optimizer/gradients_5/optimizer/Maximum_grad/tuple/group_depsNoOp5^optimizer/gradients_5/optimizer/Maximum_grad/Reshape7^optimizer/gradients_5/optimizer/Maximum_grad/Reshape_1
�
Eoptimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependencyIdentity4optimizer/gradients_5/optimizer/Maximum_grad/Reshape>^optimizer/gradients_5/optimizer/Maximum_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_5/optimizer/Maximum_grad/Reshape
�
Goptimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependency_1Identity6optimizer/gradients_5/optimizer/Maximum_grad/Reshape_1>^optimizer/gradients_5/optimizer/Maximum_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Maximum_grad/Reshape_1
u
4optimizer/gradients_5/optimizer/Maximum_1_grad/ShapeShapeoptimizer/SquaredDifference_5*
T0*
out_type0
w
6optimizer/gradients_5/optimizer/Maximum_1_grad/Shape_1Shapeoptimizer/SquaredDifference_6*
T0*
out_type0
�
6optimizer/gradients_5/optimizer/Maximum_1_grad/Shape_2ShapeAoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/Reshape_1*
T0*
out_type0
g
:optimizer/gradients_5/optimizer/Maximum_1_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
4optimizer/gradients_5/optimizer/Maximum_1_grad/zerosFill6optimizer/gradients_5/optimizer/Maximum_1_grad/Shape_2:optimizer/gradients_5/optimizer/Maximum_1_grad/zeros/Const*
T0*

index_type0
�
;optimizer/gradients_5/optimizer/Maximum_1_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifference_5optimizer/SquaredDifference_6*
T0
�
Doptimizer/gradients_5/optimizer/Maximum_1_grad/BroadcastGradientArgsBroadcastGradientArgs4optimizer/gradients_5/optimizer/Maximum_1_grad/Shape6optimizer/gradients_5/optimizer/Maximum_1_grad/Shape_1*
T0
�
7optimizer/gradients_5/optimizer/Maximum_1_grad/SelectV2SelectV2;optimizer/gradients_5/optimizer/Maximum_1_grad/GreaterEqualAoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/Reshape_14optimizer/gradients_5/optimizer/Maximum_1_grad/zeros*
T0
�
2optimizer/gradients_5/optimizer/Maximum_1_grad/SumSum7optimizer/gradients_5/optimizer/Maximum_1_grad/SelectV2Doptimizer/gradients_5/optimizer/Maximum_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_5/optimizer/Maximum_1_grad/ReshapeReshape2optimizer/gradients_5/optimizer/Maximum_1_grad/Sum4optimizer/gradients_5/optimizer/Maximum_1_grad/Shape*
T0*
Tshape0
�
9optimizer/gradients_5/optimizer/Maximum_1_grad/SelectV2_1SelectV2;optimizer/gradients_5/optimizer/Maximum_1_grad/GreaterEqual4optimizer/gradients_5/optimizer/Maximum_1_grad/zerosAoptimizer/gradients_5/optimizer/DynamicPartition_3_grad/Reshape_1*
T0
�
4optimizer/gradients_5/optimizer/Maximum_1_grad/Sum_1Sum9optimizer/gradients_5/optimizer/Maximum_1_grad/SelectV2_1Foptimizer/gradients_5/optimizer/Maximum_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
8optimizer/gradients_5/optimizer/Maximum_1_grad/Reshape_1Reshape4optimizer/gradients_5/optimizer/Maximum_1_grad/Sum_16optimizer/gradients_5/optimizer/Maximum_1_grad/Shape_1*
T0*
Tshape0
�
?optimizer/gradients_5/optimizer/Maximum_1_grad/tuple/group_depsNoOp7^optimizer/gradients_5/optimizer/Maximum_1_grad/Reshape9^optimizer/gradients_5/optimizer/Maximum_1_grad/Reshape_1
�
Goptimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependencyIdentity6optimizer/gradients_5/optimizer/Maximum_1_grad/Reshape@^optimizer/gradients_5/optimizer/Maximum_1_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Maximum_1_grad/Reshape
�
Ioptimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependency_1Identity8optimizer/gradients_5/optimizer/Maximum_1_grad/Reshape_1@^optimizer/gradients_5/optimizer/Maximum_1_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients_5/optimizer/Maximum_1_grad/Reshape_1
u
4optimizer/gradients_5/optimizer/Maximum_2_grad/ShapeShapeoptimizer/SquaredDifference_7*
T0*
out_type0
w
6optimizer/gradients_5/optimizer/Maximum_2_grad/Shape_1Shapeoptimizer/SquaredDifference_8*
T0*
out_type0
�
6optimizer/gradients_5/optimizer/Maximum_2_grad/Shape_2ShapeAoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/Reshape_1*
T0*
out_type0
g
:optimizer/gradients_5/optimizer/Maximum_2_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
4optimizer/gradients_5/optimizer/Maximum_2_grad/zerosFill6optimizer/gradients_5/optimizer/Maximum_2_grad/Shape_2:optimizer/gradients_5/optimizer/Maximum_2_grad/zeros/Const*
T0*

index_type0
�
;optimizer/gradients_5/optimizer/Maximum_2_grad/GreaterEqualGreaterEqualoptimizer/SquaredDifference_7optimizer/SquaredDifference_8*
T0
�
Doptimizer/gradients_5/optimizer/Maximum_2_grad/BroadcastGradientArgsBroadcastGradientArgs4optimizer/gradients_5/optimizer/Maximum_2_grad/Shape6optimizer/gradients_5/optimizer/Maximum_2_grad/Shape_1*
T0
�
7optimizer/gradients_5/optimizer/Maximum_2_grad/SelectV2SelectV2;optimizer/gradients_5/optimizer/Maximum_2_grad/GreaterEqualAoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/Reshape_14optimizer/gradients_5/optimizer/Maximum_2_grad/zeros*
T0
�
2optimizer/gradients_5/optimizer/Maximum_2_grad/SumSum7optimizer/gradients_5/optimizer/Maximum_2_grad/SelectV2Doptimizer/gradients_5/optimizer/Maximum_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
6optimizer/gradients_5/optimizer/Maximum_2_grad/ReshapeReshape2optimizer/gradients_5/optimizer/Maximum_2_grad/Sum4optimizer/gradients_5/optimizer/Maximum_2_grad/Shape*
T0*
Tshape0
�
9optimizer/gradients_5/optimizer/Maximum_2_grad/SelectV2_1SelectV2;optimizer/gradients_5/optimizer/Maximum_2_grad/GreaterEqual4optimizer/gradients_5/optimizer/Maximum_2_grad/zerosAoptimizer/gradients_5/optimizer/DynamicPartition_4_grad/Reshape_1*
T0
�
4optimizer/gradients_5/optimizer/Maximum_2_grad/Sum_1Sum9optimizer/gradients_5/optimizer/Maximum_2_grad/SelectV2_1Foptimizer/gradients_5/optimizer/Maximum_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
8optimizer/gradients_5/optimizer/Maximum_2_grad/Reshape_1Reshape4optimizer/gradients_5/optimizer/Maximum_2_grad/Sum_16optimizer/gradients_5/optimizer/Maximum_2_grad/Shape_1*
T0*
Tshape0
�
?optimizer/gradients_5/optimizer/Maximum_2_grad/tuple/group_depsNoOp7^optimizer/gradients_5/optimizer/Maximum_2_grad/Reshape9^optimizer/gradients_5/optimizer/Maximum_2_grad/Reshape_1
�
Goptimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependencyIdentity6optimizer/gradients_5/optimizer/Maximum_2_grad/Reshape@^optimizer/gradients_5/optimizer/Maximum_2_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Maximum_2_grad/Reshape
�
Ioptimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependency_1Identity8optimizer/gradients_5/optimizer/Maximum_2_grad/Reshape_1@^optimizer/gradients_5/optimizer/Maximum_2_grad/tuple/group_deps*
T0*K
_classA
?=loc:@optimizer/gradients_5/optimizer/Maximum_2_grad/Reshape_1
m
?optimizer/gradients_5/policy_1/add_4_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_5/policy_1/add_4_grad/SumSum0optimizer/gradients_5/policy_1/Mean_grad/truediv?optimizer/gradients_5/policy_1/add_4_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_5/policy_1/add_4_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_5/policy_1/add_4_grad/ReshapeReshape-optimizer/gradients_5/policy_1/add_4_grad/Sum7optimizer/gradients_5/policy_1/add_4_grad/Reshape/shape*
T0*
Tshape0
�
:optimizer/gradients_5/policy_1/add_4_grad/tuple/group_depsNoOp1^optimizer/gradients_5/policy_1/Mean_grad/truediv2^optimizer/gradients_5/policy_1/add_4_grad/Reshape
�
Boptimizer/gradients_5/policy_1/add_4_grad/tuple/control_dependencyIdentity1optimizer/gradients_5/policy_1/add_4_grad/Reshape;^optimizer/gradients_5/policy_1/add_4_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/add_4_grad/Reshape
�
Doptimizer/gradients_5/policy_1/add_4_grad/tuple/control_dependency_1Identity0optimizer/gradients_5/policy_1/Mean_grad/truediv;^optimizer/gradients_5/policy_1/add_4_grad/tuple/group_deps*
T0*C
_class9
75loc:@optimizer/gradients_5/policy_1/Mean_grad/truediv
s
Boptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/ShapeShapeoptimizer/Exp*
T0*
out_type0
m
Doptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Doptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Shape_2ShapeMoptimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/control_dependency*
T0*
out_type0
u
Hoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
Boptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/zerosFillDoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Shape_2Hoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/zeros/Const*
T0*

index_type0
}
Foptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/LessEqual	LessEqualoptimizer/Expoptimizer/add_14*
T0
�
Roptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/ShapeDoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Shape_1*
T0
�
Eoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/SelectV2SelectV2Foptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/LessEqualMoptimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/control_dependencyBoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/zeros*
T0
�
@optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/SumSumEoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/SelectV2Roptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/ReshapeReshape@optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/SumBoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Shape*
T0*
Tshape0
�
Goptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/SelectV2_1SelectV2Foptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/LessEqualBoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/zerosMoptimizer/gradients_5/optimizer/clip_by_value_3_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Sum_1SumGoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/SelectV2_1Toptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Reshape_1ReshapeBoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Sum_1Doptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/tuple/group_depsNoOpE^optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/ReshapeG^optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Reshape_1
�
Uoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/tuple/control_dependencyIdentityDoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/ReshapeN^optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Reshape
�
Woptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/tuple/control_dependency_1IdentityFoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Reshape_1N^optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/Reshape_1
�
?optimizer/gradients_5/optimizer/SquaredDifference_3_grad/scalarConstF^optimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/MulMul?optimizer/gradients_5/optimizer/SquaredDifference_3_grad/scalarEoptimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/subSuboptimizer/extrinsic_returnsoptimizer/Sum_5F^optimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependency*
T0
�
>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/mul_1Mul<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Mul<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/sub*
T0
}
>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
s
@optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Shape_1Shapeoptimizer/Sum_5*
T0*
out_type0
�
Noptimizer/gradients_5/optimizer/SquaredDifference_3_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Shape@optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Shape_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/SumSum>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/mul_1Noptimizer/gradients_5/optimizer/SquaredDifference_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_5/optimizer/SquaredDifference_3_grad/ReshapeReshape<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Sum>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Sum_1Sum>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/mul_1Poptimizer/gradients_5/optimizer/SquaredDifference_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_5/optimizer/SquaredDifference_3_grad/Reshape_1Reshape>optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Sum_1@optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/NegNegBoptimizer/gradients_5/optimizer/SquaredDifference_3_grad/Reshape_1*
T0
�
Ioptimizer/gradients_5/optimizer/SquaredDifference_3_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/SquaredDifference_3_grad/NegA^optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Reshape
�
Qoptimizer/gradients_5/optimizer/SquaredDifference_3_grad/tuple/control_dependencyIdentity@optimizer/gradients_5/optimizer/SquaredDifference_3_grad/ReshapeJ^optimizer/gradients_5/optimizer/SquaredDifference_3_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Reshape
�
Soptimizer/gradients_5/optimizer/SquaredDifference_3_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/SquaredDifference_3_grad/NegJ^optimizer/gradients_5/optimizer/SquaredDifference_3_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/SquaredDifference_3_grad/Neg
�
?optimizer/gradients_5/optimizer/SquaredDifference_4_grad/scalarConstH^optimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/MulMul?optimizer/gradients_5/optimizer/SquaredDifference_4_grad/scalarGoptimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/subSuboptimizer/extrinsic_returnsoptimizer/add_11H^optimizer/gradients_5/optimizer/Maximum_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/mul_1Mul<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Mul<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/sub*
T0
}
>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/ShapeShapeoptimizer/extrinsic_returns*
T0*
out_type0
t
@optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Shape_1Shapeoptimizer/add_11*
T0*
out_type0
�
Noptimizer/gradients_5/optimizer/SquaredDifference_4_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Shape@optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Shape_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/SumSum>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/mul_1Noptimizer/gradients_5/optimizer/SquaredDifference_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_5/optimizer/SquaredDifference_4_grad/ReshapeReshape<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Sum>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Sum_1Sum>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/mul_1Poptimizer/gradients_5/optimizer/SquaredDifference_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_5/optimizer/SquaredDifference_4_grad/Reshape_1Reshape>optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Sum_1@optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/NegNegBoptimizer/gradients_5/optimizer/SquaredDifference_4_grad/Reshape_1*
T0
�
Ioptimizer/gradients_5/optimizer/SquaredDifference_4_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/SquaredDifference_4_grad/NegA^optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Reshape
�
Qoptimizer/gradients_5/optimizer/SquaredDifference_4_grad/tuple/control_dependencyIdentity@optimizer/gradients_5/optimizer/SquaredDifference_4_grad/ReshapeJ^optimizer/gradients_5/optimizer/SquaredDifference_4_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Reshape
�
Soptimizer/gradients_5/optimizer/SquaredDifference_4_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/SquaredDifference_4_grad/NegJ^optimizer/gradients_5/optimizer/SquaredDifference_4_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/SquaredDifference_4_grad/Neg
�
?optimizer/gradients_5/optimizer/SquaredDifference_5_grad/scalarConstH^optimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/MulMul?optimizer/gradients_5/optimizer/SquaredDifference_5_grad/scalarGoptimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependency*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/subSuboptimizer/curiosity_returnsoptimizer/Sum_7H^optimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependency*
T0
�
>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/mul_1Mul<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Mul<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/sub*
T0
}
>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/ShapeShapeoptimizer/curiosity_returns*
T0*
out_type0
s
@optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Shape_1Shapeoptimizer/Sum_7*
T0*
out_type0
�
Noptimizer/gradients_5/optimizer/SquaredDifference_5_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Shape@optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Shape_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/SumSum>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/mul_1Noptimizer/gradients_5/optimizer/SquaredDifference_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_5/optimizer/SquaredDifference_5_grad/ReshapeReshape<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Sum>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Sum_1Sum>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/mul_1Poptimizer/gradients_5/optimizer/SquaredDifference_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_5/optimizer/SquaredDifference_5_grad/Reshape_1Reshape>optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Sum_1@optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/NegNegBoptimizer/gradients_5/optimizer/SquaredDifference_5_grad/Reshape_1*
T0
�
Ioptimizer/gradients_5/optimizer/SquaredDifference_5_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/SquaredDifference_5_grad/NegA^optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Reshape
�
Qoptimizer/gradients_5/optimizer/SquaredDifference_5_grad/tuple/control_dependencyIdentity@optimizer/gradients_5/optimizer/SquaredDifference_5_grad/ReshapeJ^optimizer/gradients_5/optimizer/SquaredDifference_5_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Reshape
�
Soptimizer/gradients_5/optimizer/SquaredDifference_5_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/SquaredDifference_5_grad/NegJ^optimizer/gradients_5/optimizer/SquaredDifference_5_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/SquaredDifference_5_grad/Neg
�
?optimizer/gradients_5/optimizer/SquaredDifference_6_grad/scalarConstJ^optimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/MulMul?optimizer/gradients_5/optimizer/SquaredDifference_6_grad/scalarIoptimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/subSuboptimizer/curiosity_returnsoptimizer/add_12J^optimizer/gradients_5/optimizer/Maximum_1_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/mul_1Mul<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Mul<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/sub*
T0
}
>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/ShapeShapeoptimizer/curiosity_returns*
T0*
out_type0
t
@optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Shape_1Shapeoptimizer/add_12*
T0*
out_type0
�
Noptimizer/gradients_5/optimizer/SquaredDifference_6_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Shape@optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Shape_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/SumSum>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/mul_1Noptimizer/gradients_5/optimizer/SquaredDifference_6_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_5/optimizer/SquaredDifference_6_grad/ReshapeReshape<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Sum>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Sum_1Sum>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/mul_1Poptimizer/gradients_5/optimizer/SquaredDifference_6_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_5/optimizer/SquaredDifference_6_grad/Reshape_1Reshape>optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Sum_1@optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/NegNegBoptimizer/gradients_5/optimizer/SquaredDifference_6_grad/Reshape_1*
T0
�
Ioptimizer/gradients_5/optimizer/SquaredDifference_6_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/SquaredDifference_6_grad/NegA^optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Reshape
�
Qoptimizer/gradients_5/optimizer/SquaredDifference_6_grad/tuple/control_dependencyIdentity@optimizer/gradients_5/optimizer/SquaredDifference_6_grad/ReshapeJ^optimizer/gradients_5/optimizer/SquaredDifference_6_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Reshape
�
Soptimizer/gradients_5/optimizer/SquaredDifference_6_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/SquaredDifference_6_grad/NegJ^optimizer/gradients_5/optimizer/SquaredDifference_6_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/SquaredDifference_6_grad/Neg
�
?optimizer/gradients_5/optimizer/SquaredDifference_7_grad/scalarConstH^optimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependency*
dtype0*
valueB
 *   @
�
<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/MulMul?optimizer/gradients_5/optimizer/SquaredDifference_7_grad/scalarGoptimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependency*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/subSuboptimizer/gail_returnsoptimizer/Sum_9H^optimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependency*
T0
�
>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/mul_1Mul<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Mul<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/sub*
T0
x
>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/ShapeShapeoptimizer/gail_returns*
T0*
out_type0
s
@optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Shape_1Shapeoptimizer/Sum_9*
T0*
out_type0
�
Noptimizer/gradients_5/optimizer/SquaredDifference_7_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Shape@optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Shape_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/SumSum>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/mul_1Noptimizer/gradients_5/optimizer/SquaredDifference_7_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_5/optimizer/SquaredDifference_7_grad/ReshapeReshape<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Sum>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Sum_1Sum>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/mul_1Poptimizer/gradients_5/optimizer/SquaredDifference_7_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_5/optimizer/SquaredDifference_7_grad/Reshape_1Reshape>optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Sum_1@optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/NegNegBoptimizer/gradients_5/optimizer/SquaredDifference_7_grad/Reshape_1*
T0
�
Ioptimizer/gradients_5/optimizer/SquaredDifference_7_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/SquaredDifference_7_grad/NegA^optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Reshape
�
Qoptimizer/gradients_5/optimizer/SquaredDifference_7_grad/tuple/control_dependencyIdentity@optimizer/gradients_5/optimizer/SquaredDifference_7_grad/ReshapeJ^optimizer/gradients_5/optimizer/SquaredDifference_7_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Reshape
�
Soptimizer/gradients_5/optimizer/SquaredDifference_7_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/SquaredDifference_7_grad/NegJ^optimizer/gradients_5/optimizer/SquaredDifference_7_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/SquaredDifference_7_grad/Neg
�
?optimizer/gradients_5/optimizer/SquaredDifference_8_grad/scalarConstJ^optimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependency_1*
dtype0*
valueB
 *   @
�
<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/MulMul?optimizer/gradients_5/optimizer/SquaredDifference_8_grad/scalarIoptimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependency_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/subSuboptimizer/gail_returnsoptimizer/add_13J^optimizer/gradients_5/optimizer/Maximum_2_grad/tuple/control_dependency_1*
T0
�
>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/mul_1Mul<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Mul<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/sub*
T0
x
>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/ShapeShapeoptimizer/gail_returns*
T0*
out_type0
t
@optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Shape_1Shapeoptimizer/add_13*
T0*
out_type0
�
Noptimizer/gradients_5/optimizer/SquaredDifference_8_grad/BroadcastGradientArgsBroadcastGradientArgs>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Shape@optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Shape_1*
T0
�
<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/SumSum>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/mul_1Noptimizer/gradients_5/optimizer/SquaredDifference_8_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
@optimizer/gradients_5/optimizer/SquaredDifference_8_grad/ReshapeReshape<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Sum>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Shape*
T0*
Tshape0
�
>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Sum_1Sum>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/mul_1Poptimizer/gradients_5/optimizer/SquaredDifference_8_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_5/optimizer/SquaredDifference_8_grad/Reshape_1Reshape>optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Sum_1@optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/NegNegBoptimizer/gradients_5/optimizer/SquaredDifference_8_grad/Reshape_1*
T0
�
Ioptimizer/gradients_5/optimizer/SquaredDifference_8_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/SquaredDifference_8_grad/NegA^optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Reshape
�
Qoptimizer/gradients_5/optimizer/SquaredDifference_8_grad/tuple/control_dependencyIdentity@optimizer/gradients_5/optimizer/SquaredDifference_8_grad/ReshapeJ^optimizer/gradients_5/optimizer/SquaredDifference_8_grad/tuple/group_deps*
T0*S
_classI
GEloc:@optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Reshape
�
Soptimizer/gradients_5/optimizer/SquaredDifference_8_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/SquaredDifference_8_grad/NegJ^optimizer/gradients_5/optimizer/SquaredDifference_8_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/SquaredDifference_8_grad/Neg
�
-optimizer/gradients_5/policy_1/mul_3_grad/MulMulDoptimizer/gradients_5/policy_1/add_4_grad/tuple/control_dependency_1policy_1/clip_by_value*
T0
m
?optimizer/gradients_5/policy_1/mul_3_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_5/policy_1/mul_3_grad/SumSum-optimizer/gradients_5/policy_1/mul_3_grad/Mul?optimizer/gradients_5/policy_1/mul_3_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_5/policy_1/mul_3_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_5/policy_1/mul_3_grad/ReshapeReshape-optimizer/gradients_5/policy_1/mul_3_grad/Sum7optimizer/gradients_5/policy_1/mul_3_grad/Reshape/shape*
T0*
Tshape0
�
/optimizer/gradients_5/policy_1/mul_3_grad/Mul_1Mulpolicy_1/mul_3/xDoptimizer/gradients_5/policy_1/add_4_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_5/policy_1/mul_3_grad/tuple/group_depsNoOp0^optimizer/gradients_5/policy_1/mul_3_grad/Mul_12^optimizer/gradients_5/policy_1/mul_3_grad/Reshape
�
Boptimizer/gradients_5/policy_1/mul_3_grad/tuple/control_dependencyIdentity1optimizer/gradients_5/policy_1/mul_3_grad/Reshape;^optimizer/gradients_5/policy_1/mul_3_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/mul_3_grad/Reshape
�
Doptimizer/gradients_5/policy_1/mul_3_grad/tuple/control_dependency_1Identity/optimizer/gradients_5/policy_1/mul_3_grad/Mul_1;^optimizer/gradients_5/policy_1/mul_3_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/policy_1/mul_3_grad/Mul_1
�
optimizer/gradients_5/AddNAddNDoptimizer/gradients_5/optimizer/mul_11_grad/tuple/control_dependencyUoptimizer/gradients_5/optimizer/clip_by_value_3/Minimum_grad/tuple/control_dependency*
N*
T0*F
_class<
:8loc:@optimizer/gradients_5/optimizer/mul_11_grad/Reshape
g
,optimizer/gradients_5/optimizer/Exp_grad/mulMuloptimizer/gradients_5/AddNoptimizer/Exp*
T0
u
0optimizer/gradients_5/optimizer/Sum_5_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_5/optimizer/Sum_5_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_5/optimizer/Sum_5_grad/addAddV2!optimizer/Sum_5/reduction_indices/optimizer/gradients_5/optimizer/Sum_5_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape
�
.optimizer/gradients_5/optimizer/Sum_5_grad/modFloorMod.optimizer/gradients_5/optimizer/Sum_5_grad/add/optimizer/gradients_5/optimizer/Sum_5_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_5_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_5/optimizer/Sum_5_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_5/optimizer/Sum_5_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_5/optimizer/Sum_5_grad/rangeRange6optimizer/gradients_5/optimizer/Sum_5_grad/range/start/optimizer/gradients_5/optimizer/Sum_5_grad/Size6optimizer/gradients_5/optimizer/Sum_5_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape
�
5optimizer/gradients_5/optimizer/Sum_5_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_5/optimizer/Sum_5_grad/FillFill2optimizer/gradients_5/optimizer/Sum_5_grad/Shape_15optimizer/gradients_5/optimizer/Sum_5_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape*

index_type0
�
8optimizer/gradients_5/optimizer/Sum_5_grad/DynamicStitchDynamicStitch0optimizer/gradients_5/optimizer/Sum_5_grad/range.optimizer/gradients_5/optimizer/Sum_5_grad/mod0optimizer/gradients_5/optimizer/Sum_5_grad/Shape/optimizer/gradients_5/optimizer/Sum_5_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_5_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_5_grad/ReshapeReshapeSoptimizer/gradients_5/optimizer/SquaredDifference_3_grad/tuple/control_dependency_18optimizer/gradients_5/optimizer/Sum_5_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_5/optimizer/Sum_5_grad/BroadcastToBroadcastTo2optimizer/gradients_5/optimizer/Sum_5_grad/Reshape0optimizer/gradients_5/optimizer/Sum_5_grad/Shape*
T0*

Tidx0
w
1optimizer/gradients_5/optimizer/add_11_grad/ShapeShape"optimizer/extrinsic_value_estimate*
T0*
out_type0
n
3optimizer/gradients_5/optimizer/add_11_grad/Shape_1Shapeoptimizer/clip_by_value*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/add_11_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_5/optimizer/add_11_grad/Shape3optimizer/gradients_5/optimizer/add_11_grad/Shape_1*
T0
�
/optimizer/gradients_5/optimizer/add_11_grad/SumSumSoptimizer/gradients_5/optimizer/SquaredDifference_4_grad/tuple/control_dependency_1Aoptimizer/gradients_5/optimizer/add_11_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/optimizer/add_11_grad/ReshapeReshape/optimizer/gradients_5/optimizer/add_11_grad/Sum1optimizer/gradients_5/optimizer/add_11_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_5/optimizer/add_11_grad/Sum_1SumSoptimizer/gradients_5/optimizer/SquaredDifference_4_grad/tuple/control_dependency_1Coptimizer/gradients_5/optimizer/add_11_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_5/optimizer/add_11_grad/Reshape_1Reshape1optimizer/gradients_5/optimizer/add_11_grad/Sum_13optimizer/gradients_5/optimizer/add_11_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/add_11_grad/tuple/group_depsNoOp4^optimizer/gradients_5/optimizer/add_11_grad/Reshape6^optimizer/gradients_5/optimizer/add_11_grad/Reshape_1
�
Doptimizer/gradients_5/optimizer/add_11_grad/tuple/control_dependencyIdentity3optimizer/gradients_5/optimizer/add_11_grad/Reshape=^optimizer/gradients_5/optimizer/add_11_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/optimizer/add_11_grad/Reshape
�
Foptimizer/gradients_5/optimizer/add_11_grad/tuple/control_dependency_1Identity5optimizer/gradients_5/optimizer/add_11_grad/Reshape_1=^optimizer/gradients_5/optimizer/add_11_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/optimizer/add_11_grad/Reshape_1
u
0optimizer/gradients_5/optimizer/Sum_7_grad/ShapeShape!optimizer/curiosity_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_5/optimizer/Sum_7_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_5/optimizer/Sum_7_grad/addAddV2!optimizer/Sum_7/reduction_indices/optimizer/gradients_5/optimizer/Sum_7_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape
�
.optimizer/gradients_5/optimizer/Sum_7_grad/modFloorMod.optimizer/gradients_5/optimizer/Sum_7_grad/add/optimizer/gradients_5/optimizer/Sum_7_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_7_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_5/optimizer/Sum_7_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_5/optimizer/Sum_7_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_5/optimizer/Sum_7_grad/rangeRange6optimizer/gradients_5/optimizer/Sum_7_grad/range/start/optimizer/gradients_5/optimizer/Sum_7_grad/Size6optimizer/gradients_5/optimizer/Sum_7_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape
�
5optimizer/gradients_5/optimizer/Sum_7_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_5/optimizer/Sum_7_grad/FillFill2optimizer/gradients_5/optimizer/Sum_7_grad/Shape_15optimizer/gradients_5/optimizer/Sum_7_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape*

index_type0
�
8optimizer/gradients_5/optimizer/Sum_7_grad/DynamicStitchDynamicStitch0optimizer/gradients_5/optimizer/Sum_7_grad/range.optimizer/gradients_5/optimizer/Sum_7_grad/mod0optimizer/gradients_5/optimizer/Sum_7_grad/Shape/optimizer/gradients_5/optimizer/Sum_7_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_7_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_7_grad/ReshapeReshapeSoptimizer/gradients_5/optimizer/SquaredDifference_5_grad/tuple/control_dependency_18optimizer/gradients_5/optimizer/Sum_7_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_5/optimizer/Sum_7_grad/BroadcastToBroadcastTo2optimizer/gradients_5/optimizer/Sum_7_grad/Reshape0optimizer/gradients_5/optimizer/Sum_7_grad/Shape*
T0*

Tidx0
w
1optimizer/gradients_5/optimizer/add_12_grad/ShapeShape"optimizer/curiosity_value_estimate*
T0*
out_type0
p
3optimizer/gradients_5/optimizer/add_12_grad/Shape_1Shapeoptimizer/clip_by_value_1*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/add_12_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_5/optimizer/add_12_grad/Shape3optimizer/gradients_5/optimizer/add_12_grad/Shape_1*
T0
�
/optimizer/gradients_5/optimizer/add_12_grad/SumSumSoptimizer/gradients_5/optimizer/SquaredDifference_6_grad/tuple/control_dependency_1Aoptimizer/gradients_5/optimizer/add_12_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/optimizer/add_12_grad/ReshapeReshape/optimizer/gradients_5/optimizer/add_12_grad/Sum1optimizer/gradients_5/optimizer/add_12_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_5/optimizer/add_12_grad/Sum_1SumSoptimizer/gradients_5/optimizer/SquaredDifference_6_grad/tuple/control_dependency_1Coptimizer/gradients_5/optimizer/add_12_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_5/optimizer/add_12_grad/Reshape_1Reshape1optimizer/gradients_5/optimizer/add_12_grad/Sum_13optimizer/gradients_5/optimizer/add_12_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/add_12_grad/tuple/group_depsNoOp4^optimizer/gradients_5/optimizer/add_12_grad/Reshape6^optimizer/gradients_5/optimizer/add_12_grad/Reshape_1
�
Doptimizer/gradients_5/optimizer/add_12_grad/tuple/control_dependencyIdentity3optimizer/gradients_5/optimizer/add_12_grad/Reshape=^optimizer/gradients_5/optimizer/add_12_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/optimizer/add_12_grad/Reshape
�
Foptimizer/gradients_5/optimizer/add_12_grad/tuple/control_dependency_1Identity5optimizer/gradients_5/optimizer/add_12_grad/Reshape_1=^optimizer/gradients_5/optimizer/add_12_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/optimizer/add_12_grad/Reshape_1
p
0optimizer/gradients_5/optimizer/Sum_9_grad/ShapeShapeoptimizer/gail_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_5/optimizer/Sum_9_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_5/optimizer/Sum_9_grad/addAddV2!optimizer/Sum_9/reduction_indices/optimizer/gradients_5/optimizer/Sum_9_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape
�
.optimizer/gradients_5/optimizer/Sum_9_grad/modFloorMod.optimizer/gradients_5/optimizer/Sum_9_grad/add/optimizer/gradients_5/optimizer/Sum_9_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_9_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_5/optimizer/Sum_9_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_5/optimizer/Sum_9_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_5/optimizer/Sum_9_grad/rangeRange6optimizer/gradients_5/optimizer/Sum_9_grad/range/start/optimizer/gradients_5/optimizer/Sum_9_grad/Size6optimizer/gradients_5/optimizer/Sum_9_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape
�
5optimizer/gradients_5/optimizer/Sum_9_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_5/optimizer/Sum_9_grad/FillFill2optimizer/gradients_5/optimizer/Sum_9_grad/Shape_15optimizer/gradients_5/optimizer/Sum_9_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape*

index_type0
�
8optimizer/gradients_5/optimizer/Sum_9_grad/DynamicStitchDynamicStitch0optimizer/gradients_5/optimizer/Sum_9_grad/range.optimizer/gradients_5/optimizer/Sum_9_grad/mod0optimizer/gradients_5/optimizer/Sum_9_grad/Shape/optimizer/gradients_5/optimizer/Sum_9_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_9_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_9_grad/ReshapeReshapeSoptimizer/gradients_5/optimizer/SquaredDifference_7_grad/tuple/control_dependency_18optimizer/gradients_5/optimizer/Sum_9_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_5/optimizer/Sum_9_grad/BroadcastToBroadcastTo2optimizer/gradients_5/optimizer/Sum_9_grad/Reshape0optimizer/gradients_5/optimizer/Sum_9_grad/Shape*
T0*

Tidx0
r
1optimizer/gradients_5/optimizer/add_13_grad/ShapeShapeoptimizer/gail_value_estimate*
T0*
out_type0
p
3optimizer/gradients_5/optimizer/add_13_grad/Shape_1Shapeoptimizer/clip_by_value_2*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/add_13_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_5/optimizer/add_13_grad/Shape3optimizer/gradients_5/optimizer/add_13_grad/Shape_1*
T0
�
/optimizer/gradients_5/optimizer/add_13_grad/SumSumSoptimizer/gradients_5/optimizer/SquaredDifference_8_grad/tuple/control_dependency_1Aoptimizer/gradients_5/optimizer/add_13_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/optimizer/add_13_grad/ReshapeReshape/optimizer/gradients_5/optimizer/add_13_grad/Sum1optimizer/gradients_5/optimizer/add_13_grad/Shape*
T0*
Tshape0
�
1optimizer/gradients_5/optimizer/add_13_grad/Sum_1SumSoptimizer/gradients_5/optimizer/SquaredDifference_8_grad/tuple/control_dependency_1Coptimizer/gradients_5/optimizer/add_13_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_5/optimizer/add_13_grad/Reshape_1Reshape1optimizer/gradients_5/optimizer/add_13_grad/Sum_13optimizer/gradients_5/optimizer/add_13_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/add_13_grad/tuple/group_depsNoOp4^optimizer/gradients_5/optimizer/add_13_grad/Reshape6^optimizer/gradients_5/optimizer/add_13_grad/Reshape_1
�
Doptimizer/gradients_5/optimizer/add_13_grad/tuple/control_dependencyIdentity3optimizer/gradients_5/optimizer/add_13_grad/Reshape=^optimizer/gradients_5/optimizer/add_13_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/optimizer/add_13_grad/Reshape
�
Foptimizer/gradients_5/optimizer/add_13_grad/tuple/control_dependency_1Identity5optimizer/gradients_5/optimizer/add_13_grad/Reshape_1=^optimizer/gradients_5/optimizer/add_13_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/optimizer/add_13_grad/Reshape_1
a
1optimizer/gradients_5/optimizer/sub_10_grad/ShapeShapepolicy_1/Sum*
T0*
out_type0
f
3optimizer/gradients_5/optimizer/sub_10_grad/Shape_1Shapeoptimizer/Sum_3*
T0*
out_type0
�
Aoptimizer/gradients_5/optimizer/sub_10_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_5/optimizer/sub_10_grad/Shape3optimizer/gradients_5/optimizer/sub_10_grad/Shape_1*
T0
�
/optimizer/gradients_5/optimizer/sub_10_grad/SumSum,optimizer/gradients_5/optimizer/Exp_grad/mulAoptimizer/gradients_5/optimizer/sub_10_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/optimizer/sub_10_grad/ReshapeReshape/optimizer/gradients_5/optimizer/sub_10_grad/Sum1optimizer/gradients_5/optimizer/sub_10_grad/Shape*
T0*
Tshape0
m
/optimizer/gradients_5/optimizer/sub_10_grad/NegNeg,optimizer/gradients_5/optimizer/Exp_grad/mul*
T0
�
1optimizer/gradients_5/optimizer/sub_10_grad/Sum_1Sum/optimizer/gradients_5/optimizer/sub_10_grad/NegCoptimizer/gradients_5/optimizer/sub_10_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_5/optimizer/sub_10_grad/Reshape_1Reshape1optimizer/gradients_5/optimizer/sub_10_grad/Sum_13optimizer/gradients_5/optimizer/sub_10_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/optimizer/sub_10_grad/tuple/group_depsNoOp4^optimizer/gradients_5/optimizer/sub_10_grad/Reshape6^optimizer/gradients_5/optimizer/sub_10_grad/Reshape_1
�
Doptimizer/gradients_5/optimizer/sub_10_grad/tuple/control_dependencyIdentity3optimizer/gradients_5/optimizer/sub_10_grad/Reshape=^optimizer/gradients_5/optimizer/sub_10_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/optimizer/sub_10_grad/Reshape
�
Foptimizer/gradients_5/optimizer/sub_10_grad/tuple/control_dependency_1Identity5optimizer/gradients_5/optimizer/sub_10_grad/Reshape_1=^optimizer/gradients_5/optimizer/sub_10_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/optimizer/sub_10_grad/Reshape_1
{
8optimizer/gradients_5/optimizer/clip_by_value_grad/ShapeShapeoptimizer/clip_by_value/Minimum*
T0*
out_type0
c
:optimizer/gradients_5/optimizer/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
�
:optimizer/gradients_5/optimizer/clip_by_value_grad/Shape_2ShapeFoptimizer/gradients_5/optimizer/add_11_grad/tuple/control_dependency_1*
T0*
out_type0
k
>optimizer/gradients_5/optimizer/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
8optimizer/gradients_5/optimizer/clip_by_value_grad/zerosFill:optimizer/gradients_5/optimizer/clip_by_value_grad/Shape_2>optimizer/gradients_5/optimizer/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
?optimizer/gradients_5/optimizer/clip_by_value_grad/GreaterEqualGreaterEqualoptimizer/clip_by_value/Minimumoptimizer/Neg_2*
T0
�
Hoptimizer/gradients_5/optimizer/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs8optimizer/gradients_5/optimizer/clip_by_value_grad/Shape:optimizer/gradients_5/optimizer/clip_by_value_grad/Shape_1*
T0
�
;optimizer/gradients_5/optimizer/clip_by_value_grad/SelectV2SelectV2?optimizer/gradients_5/optimizer/clip_by_value_grad/GreaterEqualFoptimizer/gradients_5/optimizer/add_11_grad/tuple/control_dependency_18optimizer/gradients_5/optimizer/clip_by_value_grad/zeros*
T0
�
6optimizer/gradients_5/optimizer/clip_by_value_grad/SumSum;optimizer/gradients_5/optimizer/clip_by_value_grad/SelectV2Hoptimizer/gradients_5/optimizer/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
:optimizer/gradients_5/optimizer/clip_by_value_grad/ReshapeReshape6optimizer/gradients_5/optimizer/clip_by_value_grad/Sum8optimizer/gradients_5/optimizer/clip_by_value_grad/Shape*
T0*
Tshape0
�
=optimizer/gradients_5/optimizer/clip_by_value_grad/SelectV2_1SelectV2?optimizer/gradients_5/optimizer/clip_by_value_grad/GreaterEqual8optimizer/gradients_5/optimizer/clip_by_value_grad/zerosFoptimizer/gradients_5/optimizer/add_11_grad/tuple/control_dependency_1*
T0
�
8optimizer/gradients_5/optimizer/clip_by_value_grad/Sum_1Sum=optimizer/gradients_5/optimizer/clip_by_value_grad/SelectV2_1Joptimizer/gradients_5/optimizer/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_5/optimizer/clip_by_value_grad/Reshape_1Reshape8optimizer/gradients_5/optimizer/clip_by_value_grad/Sum_1:optimizer/gradients_5/optimizer/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
Coptimizer/gradients_5/optimizer/clip_by_value_grad/tuple/group_depsNoOp;^optimizer/gradients_5/optimizer/clip_by_value_grad/Reshape=^optimizer/gradients_5/optimizer/clip_by_value_grad/Reshape_1
�
Koptimizer/gradients_5/optimizer/clip_by_value_grad/tuple/control_dependencyIdentity:optimizer/gradients_5/optimizer/clip_by_value_grad/ReshapeD^optimizer/gradients_5/optimizer/clip_by_value_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_5/optimizer/clip_by_value_grad/Reshape
�
Moptimizer/gradients_5/optimizer/clip_by_value_grad/tuple/control_dependency_1Identity<optimizer/gradients_5/optimizer/clip_by_value_grad/Reshape_1D^optimizer/gradients_5/optimizer/clip_by_value_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/clip_by_value_grad/Reshape_1

:optimizer/gradients_5/optimizer/clip_by_value_1_grad/ShapeShape!optimizer/clip_by_value_1/Minimum*
T0*
out_type0
e
<optimizer/gradients_5/optimizer/clip_by_value_1_grad/Shape_1Const*
dtype0*
valueB 
�
<optimizer/gradients_5/optimizer/clip_by_value_1_grad/Shape_2ShapeFoptimizer/gradients_5/optimizer/add_12_grad/tuple/control_dependency_1*
T0*
out_type0
m
@optimizer/gradients_5/optimizer/clip_by_value_1_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
:optimizer/gradients_5/optimizer/clip_by_value_1_grad/zerosFill<optimizer/gradients_5/optimizer/clip_by_value_1_grad/Shape_2@optimizer/gradients_5/optimizer/clip_by_value_1_grad/zeros/Const*
T0*

index_type0
�
Aoptimizer/gradients_5/optimizer/clip_by_value_1_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_1/Minimumoptimizer/Neg_3*
T0
�
Joptimizer/gradients_5/optimizer/clip_by_value_1_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients_5/optimizer/clip_by_value_1_grad/Shape<optimizer/gradients_5/optimizer/clip_by_value_1_grad/Shape_1*
T0
�
=optimizer/gradients_5/optimizer/clip_by_value_1_grad/SelectV2SelectV2Aoptimizer/gradients_5/optimizer/clip_by_value_1_grad/GreaterEqualFoptimizer/gradients_5/optimizer/add_12_grad/tuple/control_dependency_1:optimizer/gradients_5/optimizer/clip_by_value_1_grad/zeros*
T0
�
8optimizer/gradients_5/optimizer/clip_by_value_1_grad/SumSum=optimizer/gradients_5/optimizer/clip_by_value_1_grad/SelectV2Joptimizer/gradients_5/optimizer/clip_by_value_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_5/optimizer/clip_by_value_1_grad/ReshapeReshape8optimizer/gradients_5/optimizer/clip_by_value_1_grad/Sum:optimizer/gradients_5/optimizer/clip_by_value_1_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients_5/optimizer/clip_by_value_1_grad/SelectV2_1SelectV2Aoptimizer/gradients_5/optimizer/clip_by_value_1_grad/GreaterEqual:optimizer/gradients_5/optimizer/clip_by_value_1_grad/zerosFoptimizer/gradients_5/optimizer/add_12_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_5/optimizer/clip_by_value_1_grad/Sum_1Sum?optimizer/gradients_5/optimizer/clip_by_value_1_grad/SelectV2_1Loptimizer/gradients_5/optimizer/clip_by_value_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_5/optimizer/clip_by_value_1_grad/Reshape_1Reshape:optimizer/gradients_5/optimizer/clip_by_value_1_grad/Sum_1<optimizer/gradients_5/optimizer/clip_by_value_1_grad/Shape_1*
T0*
Tshape0
�
Eoptimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/clip_by_value_1_grad/Reshape?^optimizer/gradients_5/optimizer/clip_by_value_1_grad/Reshape_1
�
Moptimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/control_dependencyIdentity<optimizer/gradients_5/optimizer/clip_by_value_1_grad/ReshapeF^optimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/clip_by_value_1_grad/Reshape
�
Ooptimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/control_dependency_1Identity>optimizer/gradients_5/optimizer/clip_by_value_1_grad/Reshape_1F^optimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_5/optimizer/clip_by_value_1_grad/Reshape_1

:optimizer/gradients_5/optimizer/clip_by_value_2_grad/ShapeShape!optimizer/clip_by_value_2/Minimum*
T0*
out_type0
e
<optimizer/gradients_5/optimizer/clip_by_value_2_grad/Shape_1Const*
dtype0*
valueB 
�
<optimizer/gradients_5/optimizer/clip_by_value_2_grad/Shape_2ShapeFoptimizer/gradients_5/optimizer/add_13_grad/tuple/control_dependency_1*
T0*
out_type0
m
@optimizer/gradients_5/optimizer/clip_by_value_2_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
:optimizer/gradients_5/optimizer/clip_by_value_2_grad/zerosFill<optimizer/gradients_5/optimizer/clip_by_value_2_grad/Shape_2@optimizer/gradients_5/optimizer/clip_by_value_2_grad/zeros/Const*
T0*

index_type0
�
Aoptimizer/gradients_5/optimizer/clip_by_value_2_grad/GreaterEqualGreaterEqual!optimizer/clip_by_value_2/Minimumoptimizer/Neg_4*
T0
�
Joptimizer/gradients_5/optimizer/clip_by_value_2_grad/BroadcastGradientArgsBroadcastGradientArgs:optimizer/gradients_5/optimizer/clip_by_value_2_grad/Shape<optimizer/gradients_5/optimizer/clip_by_value_2_grad/Shape_1*
T0
�
=optimizer/gradients_5/optimizer/clip_by_value_2_grad/SelectV2SelectV2Aoptimizer/gradients_5/optimizer/clip_by_value_2_grad/GreaterEqualFoptimizer/gradients_5/optimizer/add_13_grad/tuple/control_dependency_1:optimizer/gradients_5/optimizer/clip_by_value_2_grad/zeros*
T0
�
8optimizer/gradients_5/optimizer/clip_by_value_2_grad/SumSum=optimizer/gradients_5/optimizer/clip_by_value_2_grad/SelectV2Joptimizer/gradients_5/optimizer/clip_by_value_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
<optimizer/gradients_5/optimizer/clip_by_value_2_grad/ReshapeReshape8optimizer/gradients_5/optimizer/clip_by_value_2_grad/Sum:optimizer/gradients_5/optimizer/clip_by_value_2_grad/Shape*
T0*
Tshape0
�
?optimizer/gradients_5/optimizer/clip_by_value_2_grad/SelectV2_1SelectV2Aoptimizer/gradients_5/optimizer/clip_by_value_2_grad/GreaterEqual:optimizer/gradients_5/optimizer/clip_by_value_2_grad/zerosFoptimizer/gradients_5/optimizer/add_13_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_5/optimizer/clip_by_value_2_grad/Sum_1Sum?optimizer/gradients_5/optimizer/clip_by_value_2_grad/SelectV2_1Loptimizer/gradients_5/optimizer/clip_by_value_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
>optimizer/gradients_5/optimizer/clip_by_value_2_grad/Reshape_1Reshape:optimizer/gradients_5/optimizer/clip_by_value_2_grad/Sum_1<optimizer/gradients_5/optimizer/clip_by_value_2_grad/Shape_1*
T0*
Tshape0
�
Eoptimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/group_depsNoOp=^optimizer/gradients_5/optimizer/clip_by_value_2_grad/Reshape?^optimizer/gradients_5/optimizer/clip_by_value_2_grad/Reshape_1
�
Moptimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/control_dependencyIdentity<optimizer/gradients_5/optimizer/clip_by_value_2_grad/ReshapeF^optimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/group_deps*
T0*O
_classE
CAloc:@optimizer/gradients_5/optimizer/clip_by_value_2_grad/Reshape
�
Ooptimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/control_dependency_1Identity>optimizer/gradients_5/optimizer/clip_by_value_2_grad/Reshape_1F^optimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/group_deps*
T0*Q
_classG
ECloc:@optimizer/gradients_5/optimizer/clip_by_value_2_grad/Reshape_1
_
-optimizer/gradients_5/policy_1/Sum_grad/ShapeShapepolicy_1/mul_2*
T0*
out_type0
�
3optimizer/gradients_5/policy_1/Sum_grad/BroadcastToBroadcastToDoptimizer/gradients_5/optimizer/sub_10_grad/tuple/control_dependency-optimizer/gradients_5/policy_1/Sum_grad/Shape*
T0*

Tidx0
s
@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/ShapeShapeoptimizer/sub_7*
T0*
out_type0
k
Boptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Boptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Shape_2ShapeKoptimizer/gradients_5/optimizer/clip_by_value_grad/tuple/control_dependency*
T0*
out_type0
s
Foptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/zerosFillBoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Shape_2Foptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
Doptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/LessEqual	LessEqualoptimizer/sub_7optimizer/PolynomialDecay_2*
T0
�
Poptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/ShapeBoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0
�
Coptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/SelectV2SelectV2Doptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/LessEqualKoptimizer/gradients_5/optimizer/clip_by_value_grad/tuple/control_dependency@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/zeros*
T0
�
>optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/SumSumCoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/SelectV2Poptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Boptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/ReshapeReshape>optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Sum@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
Eoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/SelectV2_1SelectV2Doptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/LessEqual@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/zerosKoptimizer/gradients_5/optimizer/clip_by_value_grad/tuple/control_dependency*
T0
�
@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Sum_1SumEoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/SelectV2_1Roptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Reshape_1Reshape@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Sum_1Boptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Koptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/tuple/group_depsNoOpC^optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/ReshapeE^optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Reshape_1
�
Soptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/tuple/control_dependencyIdentityBoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/ReshapeL^optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Reshape
�
Uoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Reshape_1L^optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/Reshape_1
u
Boptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/ShapeShapeoptimizer/sub_8*
T0*
out_type0
m
Doptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Doptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Shape_2ShapeMoptimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0*
out_type0
u
Hoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
Boptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/zerosFillDoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Shape_2Hoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/zeros/Const*
T0*

index_type0
�
Foptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/LessEqual	LessEqualoptimizer/sub_8optimizer/PolynomialDecay_2*
T0
�
Roptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/ShapeDoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0
�
Eoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/SelectV2SelectV2Foptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/LessEqualMoptimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/control_dependencyBoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/zeros*
T0
�
@optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/SumSumEoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/SelectV2Roptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/ReshapeReshape@optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/SumBoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Shape*
T0*
Tshape0
�
Goptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1SelectV2Foptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/LessEqualBoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/zerosMoptimizer/gradients_5/optimizer/clip_by_value_1_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Sum_1SumGoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/SelectV2_1Toptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Reshape_1ReshapeBoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Sum_1Doptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/tuple/group_depsNoOpE^optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/ReshapeG^optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
�
Uoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependencyIdentityDoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/ReshapeN^optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Reshape
�
Woptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency_1IdentityFoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Reshape_1N^optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/Reshape_1
u
Boptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/ShapeShapeoptimizer/sub_9*
T0*
out_type0
m
Doptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Shape_1Const*
dtype0*
valueB 
�
Doptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Shape_2ShapeMoptimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/control_dependency*
T0*
out_type0
u
Hoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
Boptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/zerosFillDoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Shape_2Hoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/zeros/Const*
T0*

index_type0
�
Foptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/LessEqual	LessEqualoptimizer/sub_9optimizer/PolynomialDecay_2*
T0
�
Roptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsBoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/ShapeDoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Shape_1*
T0
�
Eoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/SelectV2SelectV2Foptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/LessEqualMoptimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/control_dependencyBoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/zeros*
T0
�
@optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/SumSumEoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/SelectV2Roptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Doptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/ReshapeReshape@optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/SumBoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Shape*
T0*
Tshape0
�
Goptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/SelectV2_1SelectV2Foptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/LessEqualBoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/zerosMoptimizer/gradients_5/optimizer/clip_by_value_2_grad/tuple/control_dependency*
T0
�
Boptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Sum_1SumGoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/SelectV2_1Toptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Reshape_1ReshapeBoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Sum_1Doptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Shape_1*
T0*
Tshape0
�
Moptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/tuple/group_depsNoOpE^optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/ReshapeG^optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Reshape_1
�
Uoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependencyIdentityDoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/ReshapeN^optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Reshape
�
Woptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependency_1IdentityFoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Reshape_1N^optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/Reshape_1
c
/optimizer/gradients_5/policy_1/mul_2_grad/ShapeShapepolicy_1/mul_2/x*
T0*
out_type0
c
1optimizer/gradients_5/policy_1/mul_2_grad/Shape_1Shapepolicy_1/add_3*
T0*
out_type0
�
?optimizer/gradients_5/policy_1/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_5/policy_1/mul_2_grad/Shape1optimizer/gradients_5/policy_1/mul_2_grad/Shape_1*
T0
�
-optimizer/gradients_5/policy_1/mul_2_grad/MulMul3optimizer/gradients_5/policy_1/Sum_grad/BroadcastTopolicy_1/add_3*
T0
�
-optimizer/gradients_5/policy_1/mul_2_grad/SumSum-optimizer/gradients_5/policy_1/mul_2_grad/Mul?optimizer/gradients_5/policy_1/mul_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_5/policy_1/mul_2_grad/ReshapeReshape-optimizer/gradients_5/policy_1/mul_2_grad/Sum/optimizer/gradients_5/policy_1/mul_2_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_5/policy_1/mul_2_grad/Mul_1Mulpolicy_1/mul_2/x3optimizer/gradients_5/policy_1/Sum_grad/BroadcastTo*
T0
�
/optimizer/gradients_5/policy_1/mul_2_grad/Sum_1Sum/optimizer/gradients_5/policy_1/mul_2_grad/Mul_1Aoptimizer/gradients_5/policy_1/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/policy_1/mul_2_grad/Reshape_1Reshape/optimizer/gradients_5/policy_1/mul_2_grad/Sum_11optimizer/gradients_5/policy_1/mul_2_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_5/policy_1/mul_2_grad/tuple/group_depsNoOp2^optimizer/gradients_5/policy_1/mul_2_grad/Reshape4^optimizer/gradients_5/policy_1/mul_2_grad/Reshape_1
�
Boptimizer/gradients_5/policy_1/mul_2_grad/tuple/control_dependencyIdentity1optimizer/gradients_5/policy_1/mul_2_grad/Reshape;^optimizer/gradients_5/policy_1/mul_2_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/mul_2_grad/Reshape
�
Doptimizer/gradients_5/policy_1/mul_2_grad/tuple/control_dependency_1Identity3optimizer/gradients_5/policy_1/mul_2_grad/Reshape_1;^optimizer/gradients_5/policy_1/mul_2_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/policy_1/mul_2_grad/Reshape_1
c
0optimizer/gradients_5/optimizer/sub_7_grad/ShapeShapeoptimizer/Sum_4*
T0*
out_type0
x
2optimizer/gradients_5/optimizer/sub_7_grad/Shape_1Shape"optimizer/extrinsic_value_estimate*
T0*
out_type0
�
@optimizer/gradients_5/optimizer/sub_7_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_5/optimizer/sub_7_grad/Shape2optimizer/gradients_5/optimizer/sub_7_grad/Shape_1*
T0
�
.optimizer/gradients_5/optimizer/sub_7_grad/SumSumSoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency@optimizer/gradients_5/optimizer/sub_7_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_5/optimizer/sub_7_grad/ReshapeReshape.optimizer/gradients_5/optimizer/sub_7_grad/Sum0optimizer/gradients_5/optimizer/sub_7_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_5/optimizer/sub_7_grad/NegNegSoptimizer/gradients_5/optimizer/clip_by_value/Minimum_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_5/optimizer/sub_7_grad/Sum_1Sum.optimizer/gradients_5/optimizer/sub_7_grad/NegBoptimizer/gradients_5/optimizer/sub_7_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_5/optimizer/sub_7_grad/Reshape_1Reshape0optimizer/gradients_5/optimizer/sub_7_grad/Sum_12optimizer/gradients_5/optimizer/sub_7_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_5/optimizer/sub_7_grad/tuple/group_depsNoOp3^optimizer/gradients_5/optimizer/sub_7_grad/Reshape5^optimizer/gradients_5/optimizer/sub_7_grad/Reshape_1
�
Coptimizer/gradients_5/optimizer/sub_7_grad/tuple/control_dependencyIdentity2optimizer/gradients_5/optimizer/sub_7_grad/Reshape<^optimizer/gradients_5/optimizer/sub_7_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_5/optimizer/sub_7_grad/Reshape
�
Eoptimizer/gradients_5/optimizer/sub_7_grad/tuple/control_dependency_1Identity4optimizer/gradients_5/optimizer/sub_7_grad/Reshape_1<^optimizer/gradients_5/optimizer/sub_7_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_5/optimizer/sub_7_grad/Reshape_1
c
0optimizer/gradients_5/optimizer/sub_8_grad/ShapeShapeoptimizer/Sum_6*
T0*
out_type0
x
2optimizer/gradients_5/optimizer/sub_8_grad/Shape_1Shape"optimizer/curiosity_value_estimate*
T0*
out_type0
�
@optimizer/gradients_5/optimizer/sub_8_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_5/optimizer/sub_8_grad/Shape2optimizer/gradients_5/optimizer/sub_8_grad/Shape_1*
T0
�
.optimizer/gradients_5/optimizer/sub_8_grad/SumSumUoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency@optimizer/gradients_5/optimizer/sub_8_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_5/optimizer/sub_8_grad/ReshapeReshape.optimizer/gradients_5/optimizer/sub_8_grad/Sum0optimizer/gradients_5/optimizer/sub_8_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_5/optimizer/sub_8_grad/NegNegUoptimizer/gradients_5/optimizer/clip_by_value_1/Minimum_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_5/optimizer/sub_8_grad/Sum_1Sum.optimizer/gradients_5/optimizer/sub_8_grad/NegBoptimizer/gradients_5/optimizer/sub_8_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_5/optimizer/sub_8_grad/Reshape_1Reshape0optimizer/gradients_5/optimizer/sub_8_grad/Sum_12optimizer/gradients_5/optimizer/sub_8_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_5/optimizer/sub_8_grad/tuple/group_depsNoOp3^optimizer/gradients_5/optimizer/sub_8_grad/Reshape5^optimizer/gradients_5/optimizer/sub_8_grad/Reshape_1
�
Coptimizer/gradients_5/optimizer/sub_8_grad/tuple/control_dependencyIdentity2optimizer/gradients_5/optimizer/sub_8_grad/Reshape<^optimizer/gradients_5/optimizer/sub_8_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_5/optimizer/sub_8_grad/Reshape
�
Eoptimizer/gradients_5/optimizer/sub_8_grad/tuple/control_dependency_1Identity4optimizer/gradients_5/optimizer/sub_8_grad/Reshape_1<^optimizer/gradients_5/optimizer/sub_8_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_5/optimizer/sub_8_grad/Reshape_1
c
0optimizer/gradients_5/optimizer/sub_9_grad/ShapeShapeoptimizer/Sum_8*
T0*
out_type0
s
2optimizer/gradients_5/optimizer/sub_9_grad/Shape_1Shapeoptimizer/gail_value_estimate*
T0*
out_type0
�
@optimizer/gradients_5/optimizer/sub_9_grad/BroadcastGradientArgsBroadcastGradientArgs0optimizer/gradients_5/optimizer/sub_9_grad/Shape2optimizer/gradients_5/optimizer/sub_9_grad/Shape_1*
T0
�
.optimizer/gradients_5/optimizer/sub_9_grad/SumSumUoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependency@optimizer/gradients_5/optimizer/sub_9_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
2optimizer/gradients_5/optimizer/sub_9_grad/ReshapeReshape.optimizer/gradients_5/optimizer/sub_9_grad/Sum0optimizer/gradients_5/optimizer/sub_9_grad/Shape*
T0*
Tshape0
�
.optimizer/gradients_5/optimizer/sub_9_grad/NegNegUoptimizer/gradients_5/optimizer/clip_by_value_2/Minimum_grad/tuple/control_dependency*
T0
�
0optimizer/gradients_5/optimizer/sub_9_grad/Sum_1Sum.optimizer/gradients_5/optimizer/sub_9_grad/NegBoptimizer/gradients_5/optimizer/sub_9_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
4optimizer/gradients_5/optimizer/sub_9_grad/Reshape_1Reshape0optimizer/gradients_5/optimizer/sub_9_grad/Sum_12optimizer/gradients_5/optimizer/sub_9_grad/Shape_1*
T0*
Tshape0
�
;optimizer/gradients_5/optimizer/sub_9_grad/tuple/group_depsNoOp3^optimizer/gradients_5/optimizer/sub_9_grad/Reshape5^optimizer/gradients_5/optimizer/sub_9_grad/Reshape_1
�
Coptimizer/gradients_5/optimizer/sub_9_grad/tuple/control_dependencyIdentity2optimizer/gradients_5/optimizer/sub_9_grad/Reshape<^optimizer/gradients_5/optimizer/sub_9_grad/tuple/group_deps*
T0*E
_class;
97loc:@optimizer/gradients_5/optimizer/sub_9_grad/Reshape
�
Eoptimizer/gradients_5/optimizer/sub_9_grad/tuple/control_dependency_1Identity4optimizer/gradients_5/optimizer/sub_9_grad/Reshape_1<^optimizer/gradients_5/optimizer/sub_9_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_5/optimizer/sub_9_grad/Reshape_1
a
/optimizer/gradients_5/policy_1/add_3_grad/ShapeShapepolicy_1/add_2*
T0*
out_type0
e
1optimizer/gradients_5/policy_1/add_3_grad/Shape_1Shapepolicy_1/add_3/y*
T0*
out_type0
�
?optimizer/gradients_5/policy_1/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_5/policy_1/add_3_grad/Shape1optimizer/gradients_5/policy_1/add_3_grad/Shape_1*
T0
�
-optimizer/gradients_5/policy_1/add_3_grad/SumSumDoptimizer/gradients_5/policy_1/mul_2_grad/tuple/control_dependency_1?optimizer/gradients_5/policy_1/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_5/policy_1/add_3_grad/ReshapeReshape-optimizer/gradients_5/policy_1/add_3_grad/Sum/optimizer/gradients_5/policy_1/add_3_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_5/policy_1/add_3_grad/Sum_1SumDoptimizer/gradients_5/policy_1/mul_2_grad/tuple/control_dependency_1Aoptimizer/gradients_5/policy_1/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/policy_1/add_3_grad/Reshape_1Reshape/optimizer/gradients_5/policy_1/add_3_grad/Sum_11optimizer/gradients_5/policy_1/add_3_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_5/policy_1/add_3_grad/tuple/group_depsNoOp2^optimizer/gradients_5/policy_1/add_3_grad/Reshape4^optimizer/gradients_5/policy_1/add_3_grad/Reshape_1
�
Boptimizer/gradients_5/policy_1/add_3_grad/tuple/control_dependencyIdentity1optimizer/gradients_5/policy_1/add_3_grad/Reshape;^optimizer/gradients_5/policy_1/add_3_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/add_3_grad/Reshape
�
Doptimizer/gradients_5/policy_1/add_3_grad/tuple/control_dependency_1Identity3optimizer/gradients_5/policy_1/add_3_grad/Reshape_1;^optimizer/gradients_5/policy_1/add_3_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/policy_1/add_3_grad/Reshape_1
u
0optimizer/gradients_5/optimizer/Sum_4_grad/ShapeShape!optimizer/extrinsic_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_5/optimizer/Sum_4_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_5/optimizer/Sum_4_grad/addAddV2!optimizer/Sum_4/reduction_indices/optimizer/gradients_5/optimizer/Sum_4_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape
�
.optimizer/gradients_5/optimizer/Sum_4_grad/modFloorMod.optimizer/gradients_5/optimizer/Sum_4_grad/add/optimizer/gradients_5/optimizer/Sum_4_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_4_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_5/optimizer/Sum_4_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_5/optimizer/Sum_4_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_5/optimizer/Sum_4_grad/rangeRange6optimizer/gradients_5/optimizer/Sum_4_grad/range/start/optimizer/gradients_5/optimizer/Sum_4_grad/Size6optimizer/gradients_5/optimizer/Sum_4_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape
�
5optimizer/gradients_5/optimizer/Sum_4_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_5/optimizer/Sum_4_grad/FillFill2optimizer/gradients_5/optimizer/Sum_4_grad/Shape_15optimizer/gradients_5/optimizer/Sum_4_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape*

index_type0
�
8optimizer/gradients_5/optimizer/Sum_4_grad/DynamicStitchDynamicStitch0optimizer/gradients_5/optimizer/Sum_4_grad/range.optimizer/gradients_5/optimizer/Sum_4_grad/mod0optimizer/gradients_5/optimizer/Sum_4_grad/Shape/optimizer/gradients_5/optimizer/Sum_4_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_4_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_4_grad/ReshapeReshapeCoptimizer/gradients_5/optimizer/sub_7_grad/tuple/control_dependency8optimizer/gradients_5/optimizer/Sum_4_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_5/optimizer/Sum_4_grad/BroadcastToBroadcastTo2optimizer/gradients_5/optimizer/Sum_4_grad/Reshape0optimizer/gradients_5/optimizer/Sum_4_grad/Shape*
T0*

Tidx0
u
0optimizer/gradients_5/optimizer/Sum_6_grad/ShapeShape!optimizer/curiosity_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_5/optimizer/Sum_6_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_5/optimizer/Sum_6_grad/addAddV2!optimizer/Sum_6/reduction_indices/optimizer/gradients_5/optimizer/Sum_6_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape
�
.optimizer/gradients_5/optimizer/Sum_6_grad/modFloorMod.optimizer/gradients_5/optimizer/Sum_6_grad/add/optimizer/gradients_5/optimizer/Sum_6_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_6_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_5/optimizer/Sum_6_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_5/optimizer/Sum_6_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_5/optimizer/Sum_6_grad/rangeRange6optimizer/gradients_5/optimizer/Sum_6_grad/range/start/optimizer/gradients_5/optimizer/Sum_6_grad/Size6optimizer/gradients_5/optimizer/Sum_6_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape
�
5optimizer/gradients_5/optimizer/Sum_6_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_5/optimizer/Sum_6_grad/FillFill2optimizer/gradients_5/optimizer/Sum_6_grad/Shape_15optimizer/gradients_5/optimizer/Sum_6_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape*

index_type0
�
8optimizer/gradients_5/optimizer/Sum_6_grad/DynamicStitchDynamicStitch0optimizer/gradients_5/optimizer/Sum_6_grad/range.optimizer/gradients_5/optimizer/Sum_6_grad/mod0optimizer/gradients_5/optimizer/Sum_6_grad/Shape/optimizer/gradients_5/optimizer/Sum_6_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_6_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_6_grad/ReshapeReshapeCoptimizer/gradients_5/optimizer/sub_8_grad/tuple/control_dependency8optimizer/gradients_5/optimizer/Sum_6_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_5/optimizer/Sum_6_grad/BroadcastToBroadcastTo2optimizer/gradients_5/optimizer/Sum_6_grad/Reshape0optimizer/gradients_5/optimizer/Sum_6_grad/Shape*
T0*

Tidx0
p
0optimizer/gradients_5/optimizer/Sum_8_grad/ShapeShapeoptimizer/gail_value/BiasAdd*
T0*
out_type0
�
/optimizer/gradients_5/optimizer/Sum_8_grad/SizeConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape*
dtype0*
value	B :
�
.optimizer/gradients_5/optimizer/Sum_8_grad/addAddV2!optimizer/Sum_8/reduction_indices/optimizer/gradients_5/optimizer/Sum_8_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape
�
.optimizer/gradients_5/optimizer/Sum_8_grad/modFloorMod.optimizer/gradients_5/optimizer/Sum_8_grad/add/optimizer/gradients_5/optimizer/Sum_8_grad/Size*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_8_grad/Shape_1Const*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape*
dtype0*
valueB 
�
6optimizer/gradients_5/optimizer/Sum_8_grad/range/startConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape*
dtype0*
value	B : 
�
6optimizer/gradients_5/optimizer/Sum_8_grad/range/deltaConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape*
dtype0*
value	B :
�
0optimizer/gradients_5/optimizer/Sum_8_grad/rangeRange6optimizer/gradients_5/optimizer/Sum_8_grad/range/start/optimizer/gradients_5/optimizer/Sum_8_grad/Size6optimizer/gradients_5/optimizer/Sum_8_grad/range/delta*

Tidx0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape
�
5optimizer/gradients_5/optimizer/Sum_8_grad/Fill/valueConst*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape*
dtype0*
value	B :
�
/optimizer/gradients_5/optimizer/Sum_8_grad/FillFill2optimizer/gradients_5/optimizer/Sum_8_grad/Shape_15optimizer/gradients_5/optimizer/Sum_8_grad/Fill/value*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape*

index_type0
�
8optimizer/gradients_5/optimizer/Sum_8_grad/DynamicStitchDynamicStitch0optimizer/gradients_5/optimizer/Sum_8_grad/range.optimizer/gradients_5/optimizer/Sum_8_grad/mod0optimizer/gradients_5/optimizer/Sum_8_grad/Shape/optimizer/gradients_5/optimizer/Sum_8_grad/Fill*
N*
T0*C
_class9
75loc:@optimizer/gradients_5/optimizer/Sum_8_grad/Shape
�
2optimizer/gradients_5/optimizer/Sum_8_grad/ReshapeReshapeCoptimizer/gradients_5/optimizer/sub_9_grad/tuple/control_dependency8optimizer/gradients_5/optimizer/Sum_8_grad/DynamicStitch*
T0*
Tshape0
�
6optimizer/gradients_5/optimizer/Sum_8_grad/BroadcastToBroadcastTo2optimizer/gradients_5/optimizer/Sum_8_grad/Reshape0optimizer/gradients_5/optimizer/Sum_8_grad/Shape*
T0*

Tidx0
_
/optimizer/gradients_5/policy_1/add_2_grad/ShapeShapepolicy_1/pow*
T0*
out_type0
c
1optimizer/gradients_5/policy_1/add_2_grad/Shape_1Shapepolicy_1/mul_1*
T0*
out_type0
�
?optimizer/gradients_5/policy_1/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs/optimizer/gradients_5/policy_1/add_2_grad/Shape1optimizer/gradients_5/policy_1/add_2_grad/Shape_1*
T0
�
-optimizer/gradients_5/policy_1/add_2_grad/SumSumBoptimizer/gradients_5/policy_1/add_3_grad/tuple/control_dependency?optimizer/gradients_5/policy_1/add_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_5/policy_1/add_2_grad/ReshapeReshape-optimizer/gradients_5/policy_1/add_2_grad/Sum/optimizer/gradients_5/policy_1/add_2_grad/Shape*
T0*
Tshape0
�
/optimizer/gradients_5/policy_1/add_2_grad/Sum_1SumBoptimizer/gradients_5/policy_1/add_3_grad/tuple/control_dependencyAoptimizer/gradients_5/policy_1/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/policy_1/add_2_grad/Reshape_1Reshape/optimizer/gradients_5/policy_1/add_2_grad/Sum_11optimizer/gradients_5/policy_1/add_2_grad/Shape_1*
T0*
Tshape0
�
:optimizer/gradients_5/policy_1/add_2_grad/tuple/group_depsNoOp2^optimizer/gradients_5/policy_1/add_2_grad/Reshape4^optimizer/gradients_5/policy_1/add_2_grad/Reshape_1
�
Boptimizer/gradients_5/policy_1/add_2_grad/tuple/control_dependencyIdentity1optimizer/gradients_5/policy_1/add_2_grad/Reshape;^optimizer/gradients_5/policy_1/add_2_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/add_2_grad/Reshape
�
Doptimizer/gradients_5/policy_1/add_2_grad/tuple/control_dependency_1Identity3optimizer/gradients_5/policy_1/add_2_grad/Reshape_1;^optimizer/gradients_5/policy_1/add_2_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/policy_1/add_2_grad/Reshape_1
�
optimizer/gradients_5/AddN_1AddN6optimizer/gradients_5/optimizer/Sum_5_grad/BroadcastTo6optimizer/gradients_5/optimizer/Sum_4_grad/BroadcastTo*
N*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Sum_5_grad/BroadcastTo
�
Hoptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_5/AddN_1*
T0*
data_formatNHWC
�
Moptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_5/AddN_1I^optimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/AddN_1N^optimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Sum_5_grad/BroadcastTo
�
Woptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGradN^optimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients_5/AddN_2AddN6optimizer/gradients_5/optimizer/Sum_7_grad/BroadcastTo6optimizer/gradients_5/optimizer/Sum_6_grad/BroadcastTo*
N*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Sum_7_grad/BroadcastTo
�
Hoptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_5/AddN_2*
T0*
data_formatNHWC
�
Moptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_5/AddN_2I^optimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/BiasAddGrad
�
Uoptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/AddN_2N^optimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Sum_7_grad/BroadcastTo
�
Woptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/BiasAddGradN^optimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/BiasAddGrad
�
optimizer/gradients_5/AddN_3AddN6optimizer/gradients_5/optimizer/Sum_9_grad/BroadcastTo6optimizer/gradients_5/optimizer/Sum_8_grad/BroadcastTo*
N*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Sum_9_grad/BroadcastTo
�
Coptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_5/AddN_3*
T0*
data_formatNHWC
�
Hoptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_5/AddN_3D^optimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/BiasAddGrad
�
Poptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/AddN_3I^optimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/optimizer/Sum_9_grad/BroadcastTo
�
Roptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/control_dependency_1IdentityCoptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/BiasAddGradI^optimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/BiasAddGrad
a
-optimizer/gradients_5/policy_1/pow_grad/ShapeShapepolicy_1/truediv*
T0*
out_type0
a
/optimizer/gradients_5/policy_1/pow_grad/Shape_1Shapepolicy_1/pow/y*
T0*
out_type0
�
=optimizer/gradients_5/policy_1/pow_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_5/policy_1/pow_grad/Shape/optimizer/gradients_5/policy_1/pow_grad/Shape_1*
T0
�
+optimizer/gradients_5/policy_1/pow_grad/mulMulBoptimizer/gradients_5/policy_1/add_2_grad/tuple/control_dependencypolicy_1/pow/y*
T0
Z
-optimizer/gradients_5/policy_1/pow_grad/sub/yConst*
dtype0*
valueB
 *  �?
z
+optimizer/gradients_5/policy_1/pow_grad/subSubpolicy_1/pow/y-optimizer/gradients_5/policy_1/pow_grad/sub/y*
T0
z
+optimizer/gradients_5/policy_1/pow_grad/PowPowpolicy_1/truediv+optimizer/gradients_5/policy_1/pow_grad/sub*
T0
�
-optimizer/gradients_5/policy_1/pow_grad/mul_1Mul+optimizer/gradients_5/policy_1/pow_grad/mul+optimizer/gradients_5/policy_1/pow_grad/Pow*
T0
�
+optimizer/gradients_5/policy_1/pow_grad/SumSum-optimizer/gradients_5/policy_1/pow_grad/mul_1=optimizer/gradients_5/policy_1/pow_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_5/policy_1/pow_grad/ReshapeReshape+optimizer/gradients_5/policy_1/pow_grad/Sum-optimizer/gradients_5/policy_1/pow_grad/Shape*
T0*
Tshape0
^
1optimizer/gradients_5/policy_1/pow_grad/Greater/yConst*
dtype0*
valueB
 *    
�
/optimizer/gradients_5/policy_1/pow_grad/GreaterGreaterpolicy_1/truediv1optimizer/gradients_5/policy_1/pow_grad/Greater/y*
T0
k
7optimizer/gradients_5/policy_1/pow_grad/ones_like/ShapeShapepolicy_1/truediv*
T0*
out_type0
d
7optimizer/gradients_5/policy_1/pow_grad/ones_like/ConstConst*
dtype0*
valueB
 *  �?
�
1optimizer/gradients_5/policy_1/pow_grad/ones_likeFill7optimizer/gradients_5/policy_1/pow_grad/ones_like/Shape7optimizer/gradients_5/policy_1/pow_grad/ones_like/Const*
T0*

index_type0
�
.optimizer/gradients_5/policy_1/pow_grad/SelectSelect/optimizer/gradients_5/policy_1/pow_grad/Greaterpolicy_1/truediv1optimizer/gradients_5/policy_1/pow_grad/ones_like*
T0
k
+optimizer/gradients_5/policy_1/pow_grad/LogLog.optimizer/gradients_5/policy_1/pow_grad/Select*
T0
Z
2optimizer/gradients_5/policy_1/pow_grad/zeros_like	ZerosLikepolicy_1/truediv*
T0
�
0optimizer/gradients_5/policy_1/pow_grad/Select_1Select/optimizer/gradients_5/policy_1/pow_grad/Greater+optimizer/gradients_5/policy_1/pow_grad/Log2optimizer/gradients_5/policy_1/pow_grad/zeros_like*
T0
�
-optimizer/gradients_5/policy_1/pow_grad/mul_2MulBoptimizer/gradients_5/policy_1/add_2_grad/tuple/control_dependencypolicy_1/pow*
T0
�
-optimizer/gradients_5/policy_1/pow_grad/mul_3Mul-optimizer/gradients_5/policy_1/pow_grad/mul_20optimizer/gradients_5/policy_1/pow_grad/Select_1*
T0
�
-optimizer/gradients_5/policy_1/pow_grad/Sum_1Sum-optimizer/gradients_5/policy_1/pow_grad/mul_3?optimizer/gradients_5/policy_1/pow_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_5/policy_1/pow_grad/Reshape_1Reshape-optimizer/gradients_5/policy_1/pow_grad/Sum_1/optimizer/gradients_5/policy_1/pow_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_5/policy_1/pow_grad/tuple/group_depsNoOp0^optimizer/gradients_5/policy_1/pow_grad/Reshape2^optimizer/gradients_5/policy_1/pow_grad/Reshape_1
�
@optimizer/gradients_5/policy_1/pow_grad/tuple/control_dependencyIdentity/optimizer/gradients_5/policy_1/pow_grad/Reshape9^optimizer/gradients_5/policy_1/pow_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/policy_1/pow_grad/Reshape
�
Boptimizer/gradients_5/policy_1/pow_grad/tuple/control_dependency_1Identity1optimizer/gradients_5/policy_1/pow_grad/Reshape_19^optimizer/gradients_5/policy_1/pow_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/pow_grad/Reshape_1
�
-optimizer/gradients_5/policy_1/mul_1_grad/MulMulDoptimizer/gradients_5/policy_1/add_2_grad/tuple/control_dependency_1policy_1/clip_by_value*
T0
m
?optimizer/gradients_5/policy_1/mul_1_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_5/policy_1/mul_1_grad/SumSum-optimizer/gradients_5/policy_1/mul_1_grad/Mul?optimizer/gradients_5/policy_1/mul_1_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_5/policy_1/mul_1_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_5/policy_1/mul_1_grad/ReshapeReshape-optimizer/gradients_5/policy_1/mul_1_grad/Sum7optimizer/gradients_5/policy_1/mul_1_grad/Reshape/shape*
T0*
Tshape0
�
/optimizer/gradients_5/policy_1/mul_1_grad/Mul_1Mulpolicy_1/mul_1/xDoptimizer/gradients_5/policy_1/add_2_grad/tuple/control_dependency_1*
T0
�
:optimizer/gradients_5/policy_1/mul_1_grad/tuple/group_depsNoOp0^optimizer/gradients_5/policy_1/mul_1_grad/Mul_12^optimizer/gradients_5/policy_1/mul_1_grad/Reshape
�
Boptimizer/gradients_5/policy_1/mul_1_grad/tuple/control_dependencyIdentity1optimizer/gradients_5/policy_1/mul_1_grad/Reshape;^optimizer/gradients_5/policy_1/mul_1_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/mul_1_grad/Reshape
�
Doptimizer/gradients_5/policy_1/mul_1_grad/tuple/control_dependency_1Identity/optimizer/gradients_5/policy_1/mul_1_grad/Mul_1;^optimizer/gradients_5/policy_1/mul_1_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/policy_1/mul_1_grad/Mul_1
�
Boptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMulMatMulUoptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency&optimizer//extrinsic_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Doptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulUoptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Loptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/tuple/group_depsNoOpC^optimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMulE^optimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Toptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependencyIdentityBoptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMulM^optimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMul
�
Voptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMul_1M^optimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMul_1
�
Boptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMulMatMulUoptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependency&optimizer//curiosity_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Doptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulUoptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Loptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/tuple/group_depsNoOpC^optimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMulE^optimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMul_1
�
Toptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/tuple/control_dependencyIdentityBoptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMulM^optimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/tuple/group_deps*
T0*U
_classK
IGloc:@optimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMul
�
Voptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/tuple/control_dependency_1IdentityDoptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMul_1M^optimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/tuple/group_deps*
T0*W
_classM
KIloc:@optimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/MatMul_1
�
=optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMulMatMulPoptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/control_dependency!optimizer//gail_value/kernel/read*
T0*
transpose_a( *
transpose_b(
�
?optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_1/MulPoptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Goptimizer/gradients_5/optimizer/gail_value/MatMul_grad/tuple/group_depsNoOp>^optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMul@^optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMul_1
�
Ooptimizer/gradients_5/optimizer/gail_value/MatMul_grad/tuple/control_dependencyIdentity=optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMulH^optimizer/gradients_5/optimizer/gail_value/MatMul_grad/tuple/group_deps*
T0*P
_classF
DBloc:@optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMul
�
Qoptimizer/gradients_5/optimizer/gail_value/MatMul_grad/tuple/control_dependency_1Identity?optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMul_1H^optimizer/gradients_5/optimizer/gail_value/MatMul_grad/tuple/group_deps*
T0*R
_classH
FDloc:@optimizer/gradients_5/optimizer/gail_value/MatMul_grad/MatMul_1
a
1optimizer/gradients_5/policy_1/truediv_grad/ShapeShapepolicy_1/sub*
T0*
out_type0
a
3optimizer/gradients_5/policy_1/truediv_grad/Shape_1Const*
dtype0*
valueB:
�
Aoptimizer/gradients_5/policy_1/truediv_grad/BroadcastGradientArgsBroadcastGradientArgs1optimizer/gradients_5/policy_1/truediv_grad/Shape3optimizer/gradients_5/policy_1/truediv_grad/Shape_1*
T0
�
3optimizer/gradients_5/policy_1/truediv_grad/RealDivRealDiv@optimizer/gradients_5/policy_1/pow_grad/tuple/control_dependencypolicy_1/add_1*
T0
�
/optimizer/gradients_5/policy_1/truediv_grad/SumSum3optimizer/gradients_5/policy_1/truediv_grad/RealDivAoptimizer/gradients_5/policy_1/truediv_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
3optimizer/gradients_5/policy_1/truediv_grad/ReshapeReshape/optimizer/gradients_5/policy_1/truediv_grad/Sum1optimizer/gradients_5/policy_1/truediv_grad/Shape*
T0*
Tshape0
M
/optimizer/gradients_5/policy_1/truediv_grad/NegNegpolicy_1/sub*
T0
�
5optimizer/gradients_5/policy_1/truediv_grad/RealDiv_1RealDiv/optimizer/gradients_5/policy_1/truediv_grad/Negpolicy_1/add_1*
T0
�
5optimizer/gradients_5/policy_1/truediv_grad/RealDiv_2RealDiv5optimizer/gradients_5/policy_1/truediv_grad/RealDiv_1policy_1/add_1*
T0
�
/optimizer/gradients_5/policy_1/truediv_grad/mulMul@optimizer/gradients_5/policy_1/pow_grad/tuple/control_dependency5optimizer/gradients_5/policy_1/truediv_grad/RealDiv_2*
T0
�
1optimizer/gradients_5/policy_1/truediv_grad/Sum_1Sum/optimizer/gradients_5/policy_1/truediv_grad/mulCoptimizer/gradients_5/policy_1/truediv_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
5optimizer/gradients_5/policy_1/truediv_grad/Reshape_1Reshape1optimizer/gradients_5/policy_1/truediv_grad/Sum_13optimizer/gradients_5/policy_1/truediv_grad/Shape_1*
T0*
Tshape0
�
<optimizer/gradients_5/policy_1/truediv_grad/tuple/group_depsNoOp4^optimizer/gradients_5/policy_1/truediv_grad/Reshape6^optimizer/gradients_5/policy_1/truediv_grad/Reshape_1
�
Doptimizer/gradients_5/policy_1/truediv_grad/tuple/control_dependencyIdentity3optimizer/gradients_5/policy_1/truediv_grad/Reshape=^optimizer/gradients_5/policy_1/truediv_grad/tuple/group_deps*
T0*F
_class<
:8loc:@optimizer/gradients_5/policy_1/truediv_grad/Reshape
�
Foptimizer/gradients_5/policy_1/truediv_grad/tuple/control_dependency_1Identity5optimizer/gradients_5/policy_1/truediv_grad/Reshape_1=^optimizer/gradients_5/policy_1/truediv_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/policy_1/truediv_grad/Reshape_1
�
optimizer/gradients_5/AddN_4AddNToptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependencyToptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/tuple/control_dependencyOoptimizer/gradients_5/optimizer/gail_value/MatMul_grad/tuple/control_dependency*
N*
T0*U
_classK
IGloc:@optimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/MatMul
�
Doptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Foptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Toptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsDoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/ShapeFoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
Boptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/MulMuloptimizer/gradients_5/AddN_4'optimizer/main_graph_0/hidden_1/Sigmoid*
T0
�
Boptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/SumSumBoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/MulToptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeReshapeBoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/SumDoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_1/BiasAddoptimizer/gradients_5/AddN_4*
T0
�
Doptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1SumDoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Mul_1Voptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Hoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeDoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Sum_1Foptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Ooptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpG^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeI^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Woptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityFoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/ReshapeP^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Yoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1P^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape_1
f
-optimizer/gradients_5/policy_1/sub_grad/ShapeShapepolicy_1/StopGradient*
T0*
out_type0
f
/optimizer/gradients_5/policy_1/sub_grad/Shape_1Shapepolicy_1/mu/BiasAdd*
T0*
out_type0
�
=optimizer/gradients_5/policy_1/sub_grad/BroadcastGradientArgsBroadcastGradientArgs-optimizer/gradients_5/policy_1/sub_grad/Shape/optimizer/gradients_5/policy_1/sub_grad/Shape_1*
T0
�
+optimizer/gradients_5/policy_1/sub_grad/SumSumDoptimizer/gradients_5/policy_1/truediv_grad/tuple/control_dependency=optimizer/gradients_5/policy_1/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
/optimizer/gradients_5/policy_1/sub_grad/ReshapeReshape+optimizer/gradients_5/policy_1/sub_grad/Sum-optimizer/gradients_5/policy_1/sub_grad/Shape*
T0*
Tshape0
�
+optimizer/gradients_5/policy_1/sub_grad/NegNegDoptimizer/gradients_5/policy_1/truediv_grad/tuple/control_dependency*
T0
�
-optimizer/gradients_5/policy_1/sub_grad/Sum_1Sum+optimizer/gradients_5/policy_1/sub_grad/Neg?optimizer/gradients_5/policy_1/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
1optimizer/gradients_5/policy_1/sub_grad/Reshape_1Reshape-optimizer/gradients_5/policy_1/sub_grad/Sum_1/optimizer/gradients_5/policy_1/sub_grad/Shape_1*
T0*
Tshape0
�
8optimizer/gradients_5/policy_1/sub_grad/tuple/group_depsNoOp0^optimizer/gradients_5/policy_1/sub_grad/Reshape2^optimizer/gradients_5/policy_1/sub_grad/Reshape_1
�
@optimizer/gradients_5/policy_1/sub_grad/tuple/control_dependencyIdentity/optimizer/gradients_5/policy_1/sub_grad/Reshape9^optimizer/gradients_5/policy_1/sub_grad/tuple/group_deps*
T0*B
_class8
64loc:@optimizer/gradients_5/policy_1/sub_grad/Reshape
�
Boptimizer/gradients_5/policy_1/sub_grad/tuple/control_dependency_1Identity1optimizer/gradients_5/policy_1/sub_grad/Reshape_19^optimizer/gradients_5/policy_1/sub_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/sub_grad/Reshape_1
m
?optimizer/gradients_5/policy_1/add_1_grad/Sum/reduction_indicesConst*
dtype0*
valueB: 
�
-optimizer/gradients_5/policy_1/add_1_grad/SumSumFoptimizer/gradients_5/policy_1/truediv_grad/tuple/control_dependency_1?optimizer/gradients_5/policy_1/add_1_grad/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( 
`
7optimizer/gradients_5/policy_1/add_1_grad/Reshape/shapeConst*
dtype0*
valueB 
�
1optimizer/gradients_5/policy_1/add_1_grad/ReshapeReshape-optimizer/gradients_5/policy_1/add_1_grad/Sum7optimizer/gradients_5/policy_1/add_1_grad/Reshape/shape*
T0*
Tshape0
�
:optimizer/gradients_5/policy_1/add_1_grad/tuple/group_depsNoOp2^optimizer/gradients_5/policy_1/add_1_grad/ReshapeG^optimizer/gradients_5/policy_1/truediv_grad/tuple/control_dependency_1
�
Boptimizer/gradients_5/policy_1/add_1_grad/tuple/control_dependencyIdentityFoptimizer/gradients_5/policy_1/truediv_grad/tuple/control_dependency_1;^optimizer/gradients_5/policy_1/add_1_grad/tuple/group_deps*
T0*H
_class>
<:loc:@optimizer/gradients_5/policy_1/truediv_grad/Reshape_1
�
Doptimizer/gradients_5/policy_1/add_1_grad/tuple/control_dependency_1Identity1optimizer/gradients_5/policy_1/add_1_grad/Reshape;^optimizer/gradients_5/policy_1/add_1_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/add_1_grad/Reshape
�
Noptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_1/SigmoidYoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_5/AddN_5AddNWoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyNoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
Noptimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_5/AddN_5*
T0*
data_formatNHWC
�
Soptimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_5/AddN_5O^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
[optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/AddN_5T^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_1/Mul_grad/Reshape
�
]optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityNoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradT^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*a
_classW
USloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Hoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulMatMul[optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Joptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul#optimizer/main_graph_0/hidden_0/Mul[optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Roptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpI^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulK^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Zoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityHoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMulS^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul
�
\optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityJoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1S^optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*]
_classS
QOloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
:optimizer/gradients_5/policy_1/mu/BiasAdd_grad/BiasAddGradBiasAddGradBoptimizer/gradients_5/policy_1/sub_grad/tuple/control_dependency_1*
T0*
data_formatNHWC
�
?optimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/group_depsNoOp;^optimizer/gradients_5/policy_1/mu/BiasAdd_grad/BiasAddGradC^optimizer/gradients_5/policy_1/sub_grad/tuple/control_dependency_1
�
Goptimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/control_dependencyIdentityBoptimizer/gradients_5/policy_1/sub_grad/tuple/control_dependency_1@^optimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*D
_class:
86loc:@optimizer/gradients_5/policy_1/sub_grad/Reshape_1
�
Ioptimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/control_dependency_1Identity:optimizer/gradients_5/policy_1/mu/BiasAdd_grad/BiasAddGrad@^optimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/group_deps*
T0*M
_classC
A?loc:@optimizer/gradients_5/policy_1/mu/BiasAdd_grad/BiasAddGrad
�
Doptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeShape'optimizer/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Foptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1Shape'optimizer/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Toptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsDoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/ShapeFoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
Boptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/MulMulZoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency'optimizer/main_graph_0/hidden_0/Sigmoid*
T0
�
Boptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/SumSumBoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/MulToptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Foptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeReshapeBoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/SumDoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Mul'optimizer/main_graph_0/hidden_0/BiasAddZoptimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Doptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1SumDoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Mul_1Voptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Hoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeDoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Sum_1Foptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Ooptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpG^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeI^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Woptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityFoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/ReshapeP^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Yoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityHoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1P^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
4optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMulMatMulGoptimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/control_dependencypolicy/mu/kernel/read*
T0*
transpose_a( *
transpose_b(
�
6optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_1/MulGoptimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
>optimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/group_depsNoOp5^optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMul7^optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMul_1
�
Foptimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/control_dependencyIdentity4optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMul?^optimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMul
�
Hoptimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/control_dependency_1Identity6optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMul_1?^optimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/group_deps*
T0*I
_class?
=;loc:@optimizer/gradients_5/policy_1/mu/MatMul_grad/MatMul_1
�
+optimizer/gradients_5/policy_1/Exp_grad/mulMulBoptimizer/gradients_5/policy_1/add_1_grad/tuple/control_dependencypolicy_1/Exp*
T0
�
Noptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad'optimizer/main_graph_0/hidden_0/SigmoidYoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
Aoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/ShapeShape$policy/main_graph_0/hidden_1/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_1/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/ShapeCoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/MulMulFoptimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_1/Sigmoid*
T0
�
?optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/SumSum?optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/MulQoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/ReshapeReshape?optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/SumAoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_1/BiasAddFoptimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Sum_1SumAoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Mul_1Soptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Sum_1Coptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/ReshapeF^optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
Toptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/ReshapeM^optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Voptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1M^optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Reshape_1
�
optimizer/gradients_5/AddN_6AddNDoptimizer/gradients_5/policy_1/mul_3_grad/tuple/control_dependency_1Doptimizer/gradients_5/policy_1/mul_1_grad/tuple/control_dependency_1+optimizer/gradients_5/policy_1/Exp_grad/mul*
N*
T0*B
_class8
64loc:@optimizer/gradients_5/policy_1/mul_3_grad/Mul_1
e
7optimizer/gradients_5/policy_1/clip_by_value_grad/ShapeConst*
dtype0*
valueB:
b
9optimizer/gradients_5/policy_1/clip_by_value_grad/Shape_1Const*
dtype0*
valueB 
g
9optimizer/gradients_5/policy_1/clip_by_value_grad/Shape_2Const*
dtype0*
valueB:
j
=optimizer/gradients_5/policy_1/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
7optimizer/gradients_5/policy_1/clip_by_value_grad/zerosFill9optimizer/gradients_5/policy_1/clip_by_value_grad/Shape_2=optimizer/gradients_5/policy_1/clip_by_value_grad/zeros/Const*
T0*

index_type0
�
>optimizer/gradients_5/policy_1/clip_by_value_grad/GreaterEqualGreaterEqualpolicy_1/clip_by_value/Minimumpolicy_1/clip_by_value/y*
T0
�
Goptimizer/gradients_5/policy_1/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs7optimizer/gradients_5/policy_1/clip_by_value_grad/Shape9optimizer/gradients_5/policy_1/clip_by_value_grad/Shape_1*
T0
�
:optimizer/gradients_5/policy_1/clip_by_value_grad/SelectV2SelectV2>optimizer/gradients_5/policy_1/clip_by_value_grad/GreaterEqualoptimizer/gradients_5/AddN_67optimizer/gradients_5/policy_1/clip_by_value_grad/zeros*
T0
�
5optimizer/gradients_5/policy_1/clip_by_value_grad/SumSum:optimizer/gradients_5/policy_1/clip_by_value_grad/SelectV2Goptimizer/gradients_5/policy_1/clip_by_value_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
9optimizer/gradients_5/policy_1/clip_by_value_grad/ReshapeReshape5optimizer/gradients_5/policy_1/clip_by_value_grad/Sum7optimizer/gradients_5/policy_1/clip_by_value_grad/Shape*
T0*
Tshape0
�
<optimizer/gradients_5/policy_1/clip_by_value_grad/SelectV2_1SelectV2>optimizer/gradients_5/policy_1/clip_by_value_grad/GreaterEqual7optimizer/gradients_5/policy_1/clip_by_value_grad/zerosoptimizer/gradients_5/AddN_6*
T0
�
7optimizer/gradients_5/policy_1/clip_by_value_grad/Sum_1Sum<optimizer/gradients_5/policy_1/clip_by_value_grad/SelectV2_1Ioptimizer/gradients_5/policy_1/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
;optimizer/gradients_5/policy_1/clip_by_value_grad/Reshape_1Reshape7optimizer/gradients_5/policy_1/clip_by_value_grad/Sum_19optimizer/gradients_5/policy_1/clip_by_value_grad/Shape_1*
T0*
Tshape0
�
Boptimizer/gradients_5/policy_1/clip_by_value_grad/tuple/group_depsNoOp:^optimizer/gradients_5/policy_1/clip_by_value_grad/Reshape<^optimizer/gradients_5/policy_1/clip_by_value_grad/Reshape_1
�
Joptimizer/gradients_5/policy_1/clip_by_value_grad/tuple/control_dependencyIdentity9optimizer/gradients_5/policy_1/clip_by_value_grad/ReshapeC^optimizer/gradients_5/policy_1/clip_by_value_grad/tuple/group_deps*
T0*L
_classB
@>loc:@optimizer/gradients_5/policy_1/clip_by_value_grad/Reshape
�
Loptimizer/gradients_5/policy_1/clip_by_value_grad/tuple/control_dependency_1Identity;optimizer/gradients_5/policy_1/clip_by_value_grad/Reshape_1C^optimizer/gradients_5/policy_1/clip_by_value_grad/tuple/group_deps*
T0*N
_classD
B@loc:@optimizer/gradients_5/policy_1/clip_by_value_grad/Reshape_1
�
optimizer/gradients_5/AddN_7AddNWoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyNoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
Noptimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_5/AddN_7*
T0*
data_formatNHWC
�
Soptimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_5/AddN_7O^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
[optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/AddN_7T^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*Y
_classO
MKloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_0/Mul_grad/Reshape
�
]optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityNoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradT^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*a
_classW
USloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Koptimizer/gradients_5/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_1/SigmoidVoptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
m
?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/ShapeConst*
dtype0*
valueB:
j
Aoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB 
o
Aoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Shape_2Const*
dtype0*
valueB:
r
Eoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    
�
?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/zerosFillAoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Shape_2Eoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/zeros/Const*
T0*

index_type0
�
Coptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/LessEqual	LessEqualpolicy/log_std/read policy_1/clip_by_value/Minimum/y*
T0
�
Ooptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/ShapeAoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0
�
Boptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/SelectV2SelectV2Coptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/LessEqualJoptimizer/gradients_5/policy_1/clip_by_value_grad/tuple/control_dependency?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/zeros*
T0
�
=optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/SumSumBoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/SelectV2Ooptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Aoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/ReshapeReshape=optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Sum?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Shape*
T0*
Tshape0
�
Doptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/SelectV2_1SelectV2Coptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/LessEqual?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/zerosJoptimizer/gradients_5/policy_1/clip_by_value_grad/tuple/control_dependency*
T0
�
?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Sum_1SumDoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/SelectV2_1Qoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Reshape_1Reshape?optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Sum_1Aoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Shape_1*
T0*
Tshape0
�
Joptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/tuple/group_depsNoOpB^optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/ReshapeD^optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
Roptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/tuple/control_dependencyIdentityAoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/ReshapeK^optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*T
_classJ
HFloc:@optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Reshape
�
Toptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency_1IdentityCoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Reshape_1K^optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/Reshape_1
�
Hoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulMatMul[optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency,optimizer//main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Joptimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_state[optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Roptimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpI^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulK^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Zoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityHoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMulS^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*[
_classQ
OMloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul
�
\optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityJoptimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1S^optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*]
_classS
QOloc:@optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
optimizer/gradients_5/AddN_8AddNToptimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyKoptimizer/gradients_5/policy/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Koptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_5/AddN_8*
T0*
data_formatNHWC
�
Poptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_5/AddN_8L^optimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/AddN_8Q^optimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_5/policy/main_graph_0/hidden_1/Mul_grad/Reshape
�
Zoptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulXoptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_1/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMul policy/main_graph_0/hidden_0/MulXoptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMulH^optimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Woptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMulP^optimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMul
�
Yoptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1P^optimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/MatMul_1
�
Aoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/ShapeShape$policy/main_graph_0/hidden_0/BiasAdd*
T0*
out_type0
�
Coptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Shape_1Shape$policy/main_graph_0/hidden_0/Sigmoid*
T0*
out_type0
�
Qoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsAoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/ShapeCoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
�
?optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/MulMulWoptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency$policy/main_graph_0/hidden_0/Sigmoid*
T0
�
?optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/SumSum?optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/MulQoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( 
�
Coptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/ReshapeReshape?optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/SumAoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
�
Aoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Mul$policy/main_graph_0/hidden_0/BiasAddWoptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
�
Aoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Sum_1SumAoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Mul_1Soptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( 
�
Eoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1ReshapeAoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Sum_1Coptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
�
Loptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOpD^optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/ReshapeF^optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Toptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentityCoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/ReshapeM^optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Voptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1IdentityEoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1M^optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Reshape_1
�
Koptimizer/gradients_5/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGrad$policy/main_graph_0/hidden_0/SigmoidVoptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
�
optimizer/gradients_5/AddN_9AddNToptimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyKoptimizer/gradients_5/policy/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
N*
T0*V
_classL
JHloc:@optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Koptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradoptimizer/gradients_5/AddN_9*
T0*
data_formatNHWC
�
Poptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^optimizer/gradients_5/AddN_9L^optimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Xoptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentityoptimizer/gradients_5/AddN_9Q^optimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*V
_classL
JHloc:@optimizer/gradients_5/policy/main_graph_0/hidden_0/Mul_grad/Reshape
�
Zoptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1IdentityKoptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradQ^optimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*^
_classT
RPloc:@optimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
�
Eoptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulXoptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency(policy/main_graph_0/hidden_0/kernel/read*
T0*
transpose_a( *
transpose_b(
�
Goptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateXoptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
T0*
transpose_a(*
transpose_b( 
�
Ooptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOpF^optimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMulH^optimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
Woptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentityEoptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMulP^optimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*X
_classN
LJloc:@optimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMul
�
Yoptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1IdentityGoptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1P^optimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*Z
_classP
NLloc:@optimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/MatMul_1
�
%optimizer/beta1_power_3/initial_valueConst*2
_class(
&$loc:@optimizer//curiosity_value/bias*
dtype0*
valueB
 *fff?
�
optimizer/beta1_power_3
VariableV2*2
_class(
&$loc:@optimizer//curiosity_value/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta1_power_3/AssignAssignoptimizer/beta1_power_3%optimizer/beta1_power_3/initial_value*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
~
optimizer/beta1_power_3/readIdentityoptimizer/beta1_power_3*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias
�
%optimizer/beta2_power_3/initial_valueConst*2
_class(
&$loc:@optimizer//curiosity_value/bias*
dtype0*
valueB
 *w�?
�
optimizer/beta2_power_3
VariableV2*2
_class(
&$loc:@optimizer//curiosity_value/bias*
	container *
dtype0*
shape: *
shared_name 
�
optimizer/beta2_power_3/AssignAssignoptimizer/beta2_power_3%optimizer/beta2_power_3/initial_value*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
~
optimizer/beta2_power_3/readIdentityoptimizer/beta2_power_3*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias
�
Uoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Koptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Eoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zerosFillUoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorKoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*

index_type0
�
3optimizer//policy/main_graph_0/hidden_0/kernel/Adam
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_0/kernel/Adam/AssignAssign3optimizer//policy/main_graph_0/hidden_0/kernel/AdamEoptimizer//policy/main_graph_0/hidden_0/kernel/Adam/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_0/kernel/Adam/readIdentity3optimizer//policy/main_graph_0/hidden_0/kernel/Adam*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Woptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Moptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Goptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zerosFillWoptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorMoptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*

index_type0
�
5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
<optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/AssignAssign5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1Goptimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
:optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/readIdentity5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel
�
Coptimizer//policy/main_graph_0/hidden_0/bias/Adam/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
1optimizer//policy/main_graph_0/hidden_0/bias/Adam
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
8optimizer//policy/main_graph_0/hidden_0/bias/Adam/AssignAssign1optimizer//policy/main_graph_0/hidden_0/bias/AdamCoptimizer//policy/main_graph_0/hidden_0/bias/Adam/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
6optimizer//policy/main_graph_0/hidden_0/bias/Adam/readIdentity1optimizer//policy/main_graph_0/hidden_0/bias/Adam*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Eoptimizer//policy/main_graph_0/hidden_0/bias/Adam_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_0/bias/Adam_1/AssignAssign3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1Eoptimizer//policy/main_graph_0/hidden_0/bias/Adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_0/bias/Adam_1/readIdentity3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias
�
Uoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Koptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Eoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zerosFillUoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorKoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
3optimizer//policy/main_graph_0/hidden_1/kernel/Adam
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_1/kernel/Adam/AssignAssign3optimizer//policy/main_graph_0/hidden_1/kernel/AdamEoptimizer//policy/main_graph_0/hidden_1/kernel/Adam/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_1/kernel/Adam/readIdentity3optimizer//policy/main_graph_0/hidden_1/kernel/Adam*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Woptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Moptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Goptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zerosFillWoptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorMoptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*

index_type0
�
5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1
VariableV2*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
<optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/AssignAssign5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1Goptimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
:optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/readIdentity5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel
�
Coptimizer//policy/main_graph_0/hidden_1/bias/Adam/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
1optimizer//policy/main_graph_0/hidden_1/bias/Adam
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
8optimizer//policy/main_graph_0/hidden_1/bias/Adam/AssignAssign1optimizer//policy/main_graph_0/hidden_1/bias/AdamCoptimizer//policy/main_graph_0/hidden_1/bias/Adam/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
6optimizer//policy/main_graph_0/hidden_1/bias/Adam/readIdentity1optimizer//policy/main_graph_0/hidden_1/bias/Adam*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
Eoptimizer//policy/main_graph_0/hidden_1/bias/Adam_1/Initializer/zerosConst*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1
VariableV2*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
:optimizer//policy/main_graph_0/hidden_1/bias/Adam_1/AssignAssign3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1Eoptimizer//policy/main_graph_0/hidden_1/bias/Adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
8optimizer//policy/main_graph_0/hidden_1/bias/Adam_1/readIdentity3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias
�
Boptimizer//policy/mu/kernel/Adam/Initializer/zeros/shape_as_tensorConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB"      
�
8optimizer//policy/mu/kernel/Adam/Initializer/zeros/ConstConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *    
�
2optimizer//policy/mu/kernel/Adam/Initializer/zerosFillBoptimizer//policy/mu/kernel/Adam/Initializer/zeros/shape_as_tensor8optimizer//policy/mu/kernel/Adam/Initializer/zeros/Const*
T0*#
_class
loc:@policy/mu/kernel*

index_type0
�
 optimizer//policy/mu/kernel/Adam
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
'optimizer//policy/mu/kernel/Adam/AssignAssign optimizer//policy/mu/kernel/Adam2optimizer//policy/mu/kernel/Adam/Initializer/zeros*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
%optimizer//policy/mu/kernel/Adam/readIdentity optimizer//policy/mu/kernel/Adam*
T0*#
_class
loc:@policy/mu/kernel
�
Doptimizer//policy/mu/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB"      
�
:optimizer//policy/mu/kernel/Adam_1/Initializer/zeros/ConstConst*#
_class
loc:@policy/mu/kernel*
dtype0*
valueB
 *    
�
4optimizer//policy/mu/kernel/Adam_1/Initializer/zerosFillDoptimizer//policy/mu/kernel/Adam_1/Initializer/zeros/shape_as_tensor:optimizer//policy/mu/kernel/Adam_1/Initializer/zeros/Const*
T0*#
_class
loc:@policy/mu/kernel*

index_type0
�
"optimizer//policy/mu/kernel/Adam_1
VariableV2*#
_class
loc:@policy/mu/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
)optimizer//policy/mu/kernel/Adam_1/AssignAssign"optimizer//policy/mu/kernel/Adam_14optimizer//policy/mu/kernel/Adam_1/Initializer/zeros*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
'optimizer//policy/mu/kernel/Adam_1/readIdentity"optimizer//policy/mu/kernel/Adam_1*
T0*#
_class
loc:@policy/mu/kernel
�
0optimizer//policy/mu/bias/Adam/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
optimizer//policy/mu/bias/Adam
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
%optimizer//policy/mu/bias/Adam/AssignAssignoptimizer//policy/mu/bias/Adam0optimizer//policy/mu/bias/Adam/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
{
#optimizer//policy/mu/bias/Adam/readIdentityoptimizer//policy/mu/bias/Adam*
T0*!
_class
loc:@policy/mu/bias
�
2optimizer//policy/mu/bias/Adam_1/Initializer/zerosConst*!
_class
loc:@policy/mu/bias*
dtype0*
valueB*    
�
 optimizer//policy/mu/bias/Adam_1
VariableV2*!
_class
loc:@policy/mu/bias*
	container *
dtype0*
shape:*
shared_name 
�
'optimizer//policy/mu/bias/Adam_1/AssignAssign optimizer//policy/mu/bias/Adam_12optimizer//policy/mu/bias/Adam_1/Initializer/zeros*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(

%optimizer//policy/mu/bias/Adam_1/readIdentity optimizer//policy/mu/bias/Adam_1*
T0*!
_class
loc:@policy/mu/bias
�
0optimizer//policy/log_std/Adam/Initializer/zerosConst*!
_class
loc:@policy/log_std*
dtype0*
valueB*    
�
optimizer//policy/log_std/Adam
VariableV2*!
_class
loc:@policy/log_std*
	container *
dtype0*
shape:*
shared_name 
�
%optimizer//policy/log_std/Adam/AssignAssignoptimizer//policy/log_std/Adam0optimizer//policy/log_std/Adam/Initializer/zeros*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
{
#optimizer//policy/log_std/Adam/readIdentityoptimizer//policy/log_std/Adam*
T0*!
_class
loc:@policy/log_std
�
2optimizer//policy/log_std/Adam_1/Initializer/zerosConst*!
_class
loc:@policy/log_std*
dtype0*
valueB*    
�
 optimizer//policy/log_std/Adam_1
VariableV2*!
_class
loc:@policy/log_std*
	container *
dtype0*
shape:*
shared_name 
�
'optimizer//policy/log_std/Adam_1/AssignAssign optimizer//policy/log_std/Adam_12optimizer//policy/log_std/Adam_1/Initializer/zeros*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(

%optimizer//policy/log_std/Adam_1/readIdentity optimizer//policy/log_std/Adam_1*
T0*!
_class
loc:@policy/log_std
�
Yoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Ooptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Ioptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zerosFillYoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorOoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*

index_type0
�
7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/AssignAssign7optimizer//optimizer//main_graph_0/hidden_0/kernel/AdamIoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/readIdentity7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
[optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB"      
�
Qoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
dtype0*
valueB
 *    
�
Koptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zerosFill[optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorQoptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*

index_type0
�
9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
@optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/AssignAssign9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1Koptimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
>optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/readIdentity9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel
�
Goptimizer//optimizer//main_graph_0/hidden_0/bias/Adam/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
5optimizer//optimizer//main_graph_0/hidden_0/bias/Adam
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
<optimizer//optimizer//main_graph_0/hidden_0/bias/Adam/AssignAssign5optimizer//optimizer//main_graph_0/hidden_0/bias/AdamGoptimizer//optimizer//main_graph_0/hidden_0/bias/Adam/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
:optimizer//optimizer//main_graph_0/hidden_0/bias/Adam/readIdentity5optimizer//optimizer//main_graph_0/hidden_0/bias/Adam*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias
�
Ioptimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
dtype0*
valueB�*    
�
7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
	container *
dtype0*
shape:�*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/AssignAssign7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1Ioptimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/readIdentity7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias
�
Yoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Ooptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Ioptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zerosFillYoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorOoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*

index_type0
�
7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/AssignAssign7optimizer//optimizer//main_graph_0/hidden_1/kernel/AdamIoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/readIdentity7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
[optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB"      
�
Qoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
dtype0*
valueB
 *    
�
Koptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zerosFill[optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorQoptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*

index_type0
�
9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1
VariableV2*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
	container *
dtype0*
shape:
��*
shared_name 
�
@optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/AssignAssign9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1Koptimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
>optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/readIdentity9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel
�
Goptimizer//optimizer//main_graph_0/hidden_1/bias/Adam/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
5optimizer//optimizer//main_graph_0/hidden_1/bias/Adam
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
<optimizer//optimizer//main_graph_0/hidden_1/bias/Adam/AssignAssign5optimizer//optimizer//main_graph_0/hidden_1/bias/AdamGoptimizer//optimizer//main_graph_0/hidden_1/bias/Adam/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
:optimizer//optimizer//main_graph_0/hidden_1/bias/Adam/readIdentity5optimizer//optimizer//main_graph_0/hidden_1/bias/Adam*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias
�
Ioptimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/Initializer/zerosConst*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
dtype0*
valueB�*    
�
7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1
VariableV2*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
	container *
dtype0*
shape:�*
shared_name 
�
>optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/AssignAssign7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1Ioptimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/Initializer/zeros*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
<optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/readIdentity7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias
�
Coptimizer//optimizer//extrinsic_value/kernel/Adam/Initializer/zerosConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB	�*    
�
1optimizer//optimizer//extrinsic_value/kernel/Adam
VariableV2*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
8optimizer//optimizer//extrinsic_value/kernel/Adam/AssignAssign1optimizer//optimizer//extrinsic_value/kernel/AdamCoptimizer//optimizer//extrinsic_value/kernel/Adam/Initializer/zeros*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
6optimizer//optimizer//extrinsic_value/kernel/Adam/readIdentity1optimizer//optimizer//extrinsic_value/kernel/Adam*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
Eoptimizer//optimizer//extrinsic_value/kernel/Adam_1/Initializer/zerosConst*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
dtype0*
valueB	�*    
�
3optimizer//optimizer//extrinsic_value/kernel/Adam_1
VariableV2*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
:optimizer//optimizer//extrinsic_value/kernel/Adam_1/AssignAssign3optimizer//optimizer//extrinsic_value/kernel/Adam_1Eoptimizer//optimizer//extrinsic_value/kernel/Adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
8optimizer//optimizer//extrinsic_value/kernel/Adam_1/readIdentity3optimizer//optimizer//extrinsic_value/kernel/Adam_1*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel
�
Aoptimizer//optimizer//extrinsic_value/bias/Adam/Initializer/zerosConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB*    
�
/optimizer//optimizer//extrinsic_value/bias/Adam
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
6optimizer//optimizer//extrinsic_value/bias/Adam/AssignAssign/optimizer//optimizer//extrinsic_value/bias/AdamAoptimizer//optimizer//extrinsic_value/bias/Adam/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
4optimizer//optimizer//extrinsic_value/bias/Adam/readIdentity/optimizer//optimizer//extrinsic_value/bias/Adam*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
Coptimizer//optimizer//extrinsic_value/bias/Adam_1/Initializer/zerosConst*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
dtype0*
valueB*    
�
1optimizer//optimizer//extrinsic_value/bias/Adam_1
VariableV2*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
8optimizer//optimizer//extrinsic_value/bias/Adam_1/AssignAssign1optimizer//optimizer//extrinsic_value/bias/Adam_1Coptimizer//optimizer//extrinsic_value/bias/Adam_1/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
6optimizer//optimizer//extrinsic_value/bias/Adam_1/readIdentity1optimizer//optimizer//extrinsic_value/bias/Adam_1*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias
�
Coptimizer//optimizer//curiosity_value/kernel/Adam/Initializer/zerosConst*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
dtype0*
valueB	�*    
�
1optimizer//optimizer//curiosity_value/kernel/Adam
VariableV2*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
8optimizer//optimizer//curiosity_value/kernel/Adam/AssignAssign1optimizer//optimizer//curiosity_value/kernel/AdamCoptimizer//optimizer//curiosity_value/kernel/Adam/Initializer/zeros*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
use_locking(*
validate_shape(
�
6optimizer//optimizer//curiosity_value/kernel/Adam/readIdentity1optimizer//optimizer//curiosity_value/kernel/Adam*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel
�
Eoptimizer//optimizer//curiosity_value/kernel/Adam_1/Initializer/zerosConst*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
dtype0*
valueB	�*    
�
3optimizer//optimizer//curiosity_value/kernel/Adam_1
VariableV2*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
:optimizer//optimizer//curiosity_value/kernel/Adam_1/AssignAssign3optimizer//optimizer//curiosity_value/kernel/Adam_1Eoptimizer//optimizer//curiosity_value/kernel/Adam_1/Initializer/zeros*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
use_locking(*
validate_shape(
�
8optimizer//optimizer//curiosity_value/kernel/Adam_1/readIdentity3optimizer//optimizer//curiosity_value/kernel/Adam_1*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel
�
Aoptimizer//optimizer//curiosity_value/bias/Adam/Initializer/zerosConst*2
_class(
&$loc:@optimizer//curiosity_value/bias*
dtype0*
valueB*    
�
/optimizer//optimizer//curiosity_value/bias/Adam
VariableV2*2
_class(
&$loc:@optimizer//curiosity_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
6optimizer//optimizer//curiosity_value/bias/Adam/AssignAssign/optimizer//optimizer//curiosity_value/bias/AdamAoptimizer//optimizer//curiosity_value/bias/Adam/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
4optimizer//optimizer//curiosity_value/bias/Adam/readIdentity/optimizer//optimizer//curiosity_value/bias/Adam*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias
�
Coptimizer//optimizer//curiosity_value/bias/Adam_1/Initializer/zerosConst*2
_class(
&$loc:@optimizer//curiosity_value/bias*
dtype0*
valueB*    
�
1optimizer//optimizer//curiosity_value/bias/Adam_1
VariableV2*2
_class(
&$loc:@optimizer//curiosity_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
8optimizer//optimizer//curiosity_value/bias/Adam_1/AssignAssign1optimizer//optimizer//curiosity_value/bias/Adam_1Coptimizer//optimizer//curiosity_value/bias/Adam_1/Initializer/zeros*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
6optimizer//optimizer//curiosity_value/bias/Adam_1/readIdentity1optimizer//optimizer//curiosity_value/bias/Adam_1*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias
�
>optimizer//optimizer//gail_value/kernel/Adam/Initializer/zerosConst*/
_class%
#!loc:@optimizer//gail_value/kernel*
dtype0*
valueB	�*    
�
,optimizer//optimizer//gail_value/kernel/Adam
VariableV2*/
_class%
#!loc:@optimizer//gail_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
3optimizer//optimizer//gail_value/kernel/Adam/AssignAssign,optimizer//optimizer//gail_value/kernel/Adam>optimizer//optimizer//gail_value/kernel/Adam/Initializer/zeros*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
use_locking(*
validate_shape(
�
1optimizer//optimizer//gail_value/kernel/Adam/readIdentity,optimizer//optimizer//gail_value/kernel/Adam*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel
�
@optimizer//optimizer//gail_value/kernel/Adam_1/Initializer/zerosConst*/
_class%
#!loc:@optimizer//gail_value/kernel*
dtype0*
valueB	�*    
�
.optimizer//optimizer//gail_value/kernel/Adam_1
VariableV2*/
_class%
#!loc:@optimizer//gail_value/kernel*
	container *
dtype0*
shape:	�*
shared_name 
�
5optimizer//optimizer//gail_value/kernel/Adam_1/AssignAssign.optimizer//optimizer//gail_value/kernel/Adam_1@optimizer//optimizer//gail_value/kernel/Adam_1/Initializer/zeros*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
use_locking(*
validate_shape(
�
3optimizer//optimizer//gail_value/kernel/Adam_1/readIdentity.optimizer//optimizer//gail_value/kernel/Adam_1*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel
�
<optimizer//optimizer//gail_value/bias/Adam/Initializer/zerosConst*-
_class#
!loc:@optimizer//gail_value/bias*
dtype0*
valueB*    
�
*optimizer//optimizer//gail_value/bias/Adam
VariableV2*-
_class#
!loc:@optimizer//gail_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
1optimizer//optimizer//gail_value/bias/Adam/AssignAssign*optimizer//optimizer//gail_value/bias/Adam<optimizer//optimizer//gail_value/bias/Adam/Initializer/zeros*
T0*-
_class#
!loc:@optimizer//gail_value/bias*
use_locking(*
validate_shape(
�
/optimizer//optimizer//gail_value/bias/Adam/readIdentity*optimizer//optimizer//gail_value/bias/Adam*
T0*-
_class#
!loc:@optimizer//gail_value/bias
�
>optimizer//optimizer//gail_value/bias/Adam_1/Initializer/zerosConst*-
_class#
!loc:@optimizer//gail_value/bias*
dtype0*
valueB*    
�
,optimizer//optimizer//gail_value/bias/Adam_1
VariableV2*-
_class#
!loc:@optimizer//gail_value/bias*
	container *
dtype0*
shape:*
shared_name 
�
3optimizer//optimizer//gail_value/bias/Adam_1/AssignAssign,optimizer//optimizer//gail_value/bias/Adam_1>optimizer//optimizer//gail_value/bias/Adam_1/Initializer/zeros*
T0*-
_class#
!loc:@optimizer//gail_value/bias*
use_locking(*
validate_shape(
�
1optimizer//optimizer//gail_value/bias/Adam_1/readIdentity,optimizer//optimizer//gail_value/bias/Adam_1*
T0*-
_class#
!loc:@optimizer//gail_value/bias
C
optimizer/Adam_2/beta1Const*
dtype0*
valueB
 *fff?
C
optimizer/Adam_2/beta2Const*
dtype0*
valueB
 *w�?
E
optimizer/Adam_2/epsilonConst*
dtype0*
valueB
 *w�+2
�
Eoptimizer/Adam_2/update_policy/main_graph_0/hidden_0/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_0/kernel3optimizer//policy/main_graph_0/hidden_0/kernel/Adam5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonYoptimizer/gradients_5/policy/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Coptimizer/Adam_2/update_policy/main_graph_0/hidden_0/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_0/bias1optimizer//policy/main_graph_0/hidden_0/bias/Adam3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonZoptimizer/gradients_5/policy/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Eoptimizer/Adam_2/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam	ApplyAdam#policy/main_graph_0/hidden_1/kernel3optimizer//policy/main_graph_0/hidden_1/kernel/Adam5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonYoptimizer/gradients_5/policy/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Coptimizer/Adam_2/update_policy/main_graph_0/hidden_1/bias/ApplyAdam	ApplyAdam!policy/main_graph_0/hidden_1/bias1optimizer//policy/main_graph_0/hidden_1/bias/Adam3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonZoptimizer/gradients_5/policy/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking( *
use_nesterov( 
�
2optimizer/Adam_2/update_policy/mu/kernel/ApplyAdam	ApplyAdampolicy/mu/kernel optimizer//policy/mu/kernel/Adam"optimizer//policy/mu/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonHoptimizer/gradients_5/policy_1/mu/MatMul_grad/tuple/control_dependency_1*
T0*#
_class
loc:@policy/mu/kernel*
use_locking( *
use_nesterov( 
�
0optimizer/Adam_2/update_policy/mu/bias/ApplyAdam	ApplyAdampolicy/mu/biasoptimizer//policy/mu/bias/Adam optimizer//policy/mu/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonIoptimizer/gradients_5/policy_1/mu/BiasAdd_grad/tuple/control_dependency_1*
T0*!
_class
loc:@policy/mu/bias*
use_locking( *
use_nesterov( 
�
0optimizer/Adam_2/update_policy/log_std/ApplyAdam	ApplyAdampolicy/log_stdoptimizer//policy/log_std/Adam optimizer//policy/log_std/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonRoptimizer/gradients_5/policy_1/clip_by_value/Minimum_grad/tuple/control_dependency*
T0*!
_class
loc:@policy/log_std*
use_locking( *
use_nesterov( 
�
Ioptimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdam	ApplyAdam'optimizer//main_graph_0/hidden_0/kernel7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilon\optimizer/gradients_5/optimizer/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking( *
use_nesterov( 
�
Goptimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdam	ApplyAdam%optimizer//main_graph_0/hidden_0/bias5optimizer//optimizer//main_graph_0/hidden_0/bias/Adam7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilon]optimizer/gradients_5/optimizer/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking( *
use_nesterov( 
�
Ioptimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam	ApplyAdam'optimizer//main_graph_0/hidden_1/kernel7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilon\optimizer/gradients_5/optimizer/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking( *
use_nesterov( 
�
Goptimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdam	ApplyAdam%optimizer//main_graph_0/hidden_1/bias5optimizer//optimizer//main_graph_0/hidden_1/bias/Adam7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilon]optimizer/gradients_5/optimizer/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking( *
use_nesterov( 
�
Coptimizer/Adam_2/update_optimizer//extrinsic_value/kernel/ApplyAdam	ApplyAdam!optimizer//extrinsic_value/kernel1optimizer//optimizer//extrinsic_value/kernel/Adam3optimizer//optimizer//extrinsic_value/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonVoptimizer/gradients_5/optimizer/extrinsic_value/MatMul_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking( *
use_nesterov( 
�
Aoptimizer/Adam_2/update_optimizer//extrinsic_value/bias/ApplyAdam	ApplyAdamoptimizer//extrinsic_value/bias/optimizer//optimizer//extrinsic_value/bias/Adam1optimizer//optimizer//extrinsic_value/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonWoptimizer/gradients_5/optimizer/extrinsic_value/BiasAdd_grad/tuple/control_dependency_1*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking( *
use_nesterov( 
�
Coptimizer/Adam_2/update_optimizer//curiosity_value/kernel/ApplyAdam	ApplyAdam!optimizer//curiosity_value/kernel1optimizer//optimizer//curiosity_value/kernel/Adam3optimizer//optimizer//curiosity_value/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonVoptimizer/gradients_5/optimizer/curiosity_value/MatMul_grad/tuple/control_dependency_1*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
use_locking( *
use_nesterov( 
�
Aoptimizer/Adam_2/update_optimizer//curiosity_value/bias/ApplyAdam	ApplyAdamoptimizer//curiosity_value/bias/optimizer//optimizer//curiosity_value/bias/Adam1optimizer//optimizer//curiosity_value/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonWoptimizer/gradients_5/optimizer/curiosity_value/BiasAdd_grad/tuple/control_dependency_1*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking( *
use_nesterov( 
�
>optimizer/Adam_2/update_optimizer//gail_value/kernel/ApplyAdam	ApplyAdamoptimizer//gail_value/kernel,optimizer//optimizer//gail_value/kernel/Adam.optimizer//optimizer//gail_value/kernel/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonQoptimizer/gradients_5/optimizer/gail_value/MatMul_grad/tuple/control_dependency_1*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
use_locking( *
use_nesterov( 
�
<optimizer/Adam_2/update_optimizer//gail_value/bias/ApplyAdam	ApplyAdamoptimizer//gail_value/bias*optimizer//optimizer//gail_value/bias/Adam,optimizer//optimizer//gail_value/bias/Adam_1optimizer/beta1_power_3/readoptimizer/beta2_power_3/readoptimizer/PolynomialDecay_1optimizer/Adam_2/beta1optimizer/Adam_2/beta2optimizer/Adam_2/epsilonRoptimizer/gradients_5/optimizer/gail_value/BiasAdd_grad/tuple/control_dependency_1*
T0*-
_class#
!loc:@optimizer//gail_value/bias*
use_locking( *
use_nesterov( 
�

optimizer/Adam_2/mulMuloptimizer/beta1_power_3/readoptimizer/Adam_2/beta1B^optimizer/Adam_2/update_optimizer//curiosity_value/bias/ApplyAdamD^optimizer/Adam_2/update_optimizer//curiosity_value/kernel/ApplyAdamB^optimizer/Adam_2/update_optimizer//extrinsic_value/bias/ApplyAdamD^optimizer/Adam_2/update_optimizer//extrinsic_value/kernel/ApplyAdam=^optimizer/Adam_2/update_optimizer//gail_value/bias/ApplyAdam?^optimizer/Adam_2/update_optimizer//gail_value/kernel/ApplyAdamH^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdamJ^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdamH^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdamJ^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam1^optimizer/Adam_2/update_policy/log_std/ApplyAdamD^optimizer/Adam_2/update_policy/main_graph_0/hidden_0/bias/ApplyAdamF^optimizer/Adam_2/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamD^optimizer/Adam_2/update_policy/main_graph_0/hidden_1/bias/ApplyAdamF^optimizer/Adam_2/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam1^optimizer/Adam_2/update_policy/mu/bias/ApplyAdam3^optimizer/Adam_2/update_policy/mu/kernel/ApplyAdam*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias
�
optimizer/Adam_2/AssignAssignoptimizer/beta1_power_3optimizer/Adam_2/mul*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking( *
validate_shape(
�

optimizer/Adam_2/mul_1Muloptimizer/beta2_power_3/readoptimizer/Adam_2/beta2B^optimizer/Adam_2/update_optimizer//curiosity_value/bias/ApplyAdamD^optimizer/Adam_2/update_optimizer//curiosity_value/kernel/ApplyAdamB^optimizer/Adam_2/update_optimizer//extrinsic_value/bias/ApplyAdamD^optimizer/Adam_2/update_optimizer//extrinsic_value/kernel/ApplyAdam=^optimizer/Adam_2/update_optimizer//gail_value/bias/ApplyAdam?^optimizer/Adam_2/update_optimizer//gail_value/kernel/ApplyAdamH^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdamJ^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdamH^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdamJ^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam1^optimizer/Adam_2/update_policy/log_std/ApplyAdamD^optimizer/Adam_2/update_policy/main_graph_0/hidden_0/bias/ApplyAdamF^optimizer/Adam_2/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamD^optimizer/Adam_2/update_policy/main_graph_0/hidden_1/bias/ApplyAdamF^optimizer/Adam_2/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam1^optimizer/Adam_2/update_policy/mu/bias/ApplyAdam3^optimizer/Adam_2/update_policy/mu/kernel/ApplyAdam*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias
�
optimizer/Adam_2/Assign_1Assignoptimizer/beta2_power_3optimizer/Adam_2/mul_1*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking( *
validate_shape(
�	
optimizer/Adam_2NoOp^optimizer/Adam_2/Assign^optimizer/Adam_2/Assign_1B^optimizer/Adam_2/update_optimizer//curiosity_value/bias/ApplyAdamD^optimizer/Adam_2/update_optimizer//curiosity_value/kernel/ApplyAdamB^optimizer/Adam_2/update_optimizer//extrinsic_value/bias/ApplyAdamD^optimizer/Adam_2/update_optimizer//extrinsic_value/kernel/ApplyAdam=^optimizer/Adam_2/update_optimizer//gail_value/bias/ApplyAdam?^optimizer/Adam_2/update_optimizer//gail_value/kernel/ApplyAdamH^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/bias/ApplyAdamJ^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_0/kernel/ApplyAdamH^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/bias/ApplyAdamJ^optimizer/Adam_2/update_optimizer//main_graph_0/hidden_1/kernel/ApplyAdam1^optimizer/Adam_2/update_policy/log_std/ApplyAdamD^optimizer/Adam_2/update_policy/main_graph_0/hidden_0/bias/ApplyAdamF^optimizer/Adam_2/update_policy/main_graph_0/hidden_0/kernel/ApplyAdamD^optimizer/Adam_2/update_policy/main_graph_0/hidden_1/bias/ApplyAdamF^optimizer/Adam_2/update_policy/main_graph_0/hidden_1/kernel/ApplyAdam1^optimizer/Adam_2/update_policy/mu/bias/ApplyAdam3^optimizer/Adam_2/update_policy/mu/kernel/ApplyAdam
C
save_1/filename/inputConst*
dtype0*
valueB Bmodel
Z
save_1/filenamePlaceholderWithDefaultsave_1/filename/input*
dtype0*
shape: 
Q
save_1/ConstPlaceholderWithDefaultsave_1/filename*
dtype0*
shape: 
�/
save_1/SaveV2/tensor_namesConst*
dtype0*�/
value�.B�.�Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsB*optimizer//GAIL_model/gail_d_estimate/biasB,optimizer//GAIL_model/gail_d_estimate/kernelB*optimizer//GAIL_model/gail_d_hidden_1/biasB,optimizer//GAIL_model/gail_d_hidden_1/kernelB*optimizer//GAIL_model/gail_d_hidden_2/biasB,optimizer//GAIL_model/gail_d_hidden_2/kernelBoptimizer//curiosity_value/biasB!optimizer//curiosity_value/kernelB5optimizer//curiosity_vector_obs_encoder/hidden_0/biasB7optimizer//curiosity_vector_obs_encoder/hidden_0/kernelB5optimizer//curiosity_vector_obs_encoder/hidden_1/biasB7optimizer//curiosity_vector_obs_encoder/hidden_1/kernelBoptimizer//dense/biasBoptimizer//dense/kernelBoptimizer//dense_1/biasBoptimizer//dense_1/kernelBoptimizer//dense_2/biasBoptimizer//dense_2/kernelBoptimizer//dense_3/biasBoptimizer//dense_3/kernelBoptimizer//extrinsic_value/biasB!optimizer//extrinsic_value/kernelBoptimizer//gail_value/biasBoptimizer//gail_value/kernelB%optimizer//main_graph_0/hidden_0/biasB'optimizer//main_graph_0/hidden_0/kernelB%optimizer//main_graph_0/hidden_1/biasB'optimizer//main_graph_0/hidden_1/kernelB:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/AdamB<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1B<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/AdamB>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1B:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/AdamB<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1B<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/AdamB>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1B:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/AdamB<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1B<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/AdamB>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1B/optimizer//optimizer//curiosity_value/bias/AdamB1optimizer//optimizer//curiosity_value/bias/Adam_1B1optimizer//optimizer//curiosity_value/kernel/AdamB3optimizer//optimizer//curiosity_value/kernel/Adam_1BEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/AdamBGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1BGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/AdamBIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1BEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/AdamBGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1BGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/AdamBIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1B%optimizer//optimizer//dense/bias/AdamB'optimizer//optimizer//dense/bias/Adam_1B'optimizer//optimizer//dense/kernel/AdamB)optimizer//optimizer//dense/kernel/Adam_1B'optimizer//optimizer//dense_1/bias/AdamB)optimizer//optimizer//dense_1/bias/Adam_1B)optimizer//optimizer//dense_1/kernel/AdamB+optimizer//optimizer//dense_1/kernel/Adam_1B'optimizer//optimizer//dense_2/bias/AdamB)optimizer//optimizer//dense_2/bias/Adam_1B)optimizer//optimizer//dense_2/kernel/AdamB+optimizer//optimizer//dense_2/kernel/Adam_1B'optimizer//optimizer//dense_3/bias/AdamB)optimizer//optimizer//dense_3/bias/Adam_1B)optimizer//optimizer//dense_3/kernel/AdamB+optimizer//optimizer//dense_3/kernel/Adam_1B/optimizer//optimizer//extrinsic_value/bias/AdamB1optimizer//optimizer//extrinsic_value/bias/Adam_1B1optimizer//optimizer//extrinsic_value/kernel/AdamB3optimizer//optimizer//extrinsic_value/kernel/Adam_1B*optimizer//optimizer//gail_value/bias/AdamB,optimizer//optimizer//gail_value/bias/Adam_1B,optimizer//optimizer//gail_value/kernel/AdamB.optimizer//optimizer//gail_value/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_0/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_0/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_1/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_1/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1Boptimizer//policy/log_std/AdamB optimizer//policy/log_std/Adam_1B!optimizer//policy/log_std/bc_adamB#optimizer//policy/log_std/bc_adam_1B1optimizer//policy/main_graph_0/hidden_0/bias/AdamB3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1B4optimizer//policy/main_graph_0/hidden_0/bias/bc_adamB6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1B3optimizer//policy/main_graph_0/hidden_0/kernel/AdamB5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1B6optimizer//policy/main_graph_0/hidden_0/kernel/bc_adamB8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1B1optimizer//policy/main_graph_0/hidden_1/bias/AdamB3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1B4optimizer//policy/main_graph_0/hidden_1/bias/bc_adamB6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1B3optimizer//policy/main_graph_0/hidden_1/kernel/AdamB5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1B6optimizer//policy/main_graph_0/hidden_1/kernel/bc_adamB8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1Boptimizer//policy/mu/bias/AdamB optimizer//policy/mu/bias/Adam_1B!optimizer//policy/mu/bias/bc_adamB#optimizer//policy/mu/bias/bc_adam_1B optimizer//policy/mu/kernel/AdamB"optimizer//policy/mu/kernel/Adam_1B#optimizer//policy/mu/kernel/bc_adamB%optimizer//policy/mu/kernel/bc_adam_1Boptimizer/beta1_powerBoptimizer/beta1_power_1Boptimizer/beta1_power_2Boptimizer/beta1_power_3Boptimizer/beta2_powerBoptimizer/beta2_power_1Boptimizer/beta2_power_2Boptimizer/beta2_power_3Bpolicy/log_stdB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBpolicy/mu/biasBpolicy/mu/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
�
save_1/SaveV2/shape_and_slicesConst*
dtype0*�
value�B��B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B 
�0
save_1/SaveV2SaveV2save_1/Constsave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesaction_output_shapeglobal_stepis_continuous_controlmemory_sizenormalization_steps*optimizer//GAIL_model/gail_d_estimate/bias,optimizer//GAIL_model/gail_d_estimate/kernel*optimizer//GAIL_model/gail_d_hidden_1/bias,optimizer//GAIL_model/gail_d_hidden_1/kernel*optimizer//GAIL_model/gail_d_hidden_2/bias,optimizer//GAIL_model/gail_d_hidden_2/kerneloptimizer//curiosity_value/bias!optimizer//curiosity_value/kernel5optimizer//curiosity_vector_obs_encoder/hidden_0/bias7optimizer//curiosity_vector_obs_encoder/hidden_0/kernel5optimizer//curiosity_vector_obs_encoder/hidden_1/bias7optimizer//curiosity_vector_obs_encoder/hidden_1/kerneloptimizer//dense/biasoptimizer//dense/kerneloptimizer//dense_1/biasoptimizer//dense_1/kerneloptimizer//dense_2/biasoptimizer//dense_2/kerneloptimizer//dense_3/biasoptimizer//dense_3/kerneloptimizer//extrinsic_value/bias!optimizer//extrinsic_value/kerneloptimizer//gail_value/biasoptimizer//gail_value/kernel%optimizer//main_graph_0/hidden_0/bias'optimizer//main_graph_0/hidden_0/kernel%optimizer//main_graph_0/hidden_1/bias'optimizer//main_graph_0/hidden_1/kernel:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/optimizer//optimizer//curiosity_value/bias/Adam1optimizer//optimizer//curiosity_value/bias/Adam_11optimizer//optimizer//curiosity_value/kernel/Adam3optimizer//optimizer//curiosity_value/kernel/Adam_1Eoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/AdamGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1Goptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/AdamIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1Eoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/AdamGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1Goptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/AdamIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1%optimizer//optimizer//dense/bias/Adam'optimizer//optimizer//dense/bias/Adam_1'optimizer//optimizer//dense/kernel/Adam)optimizer//optimizer//dense/kernel/Adam_1'optimizer//optimizer//dense_1/bias/Adam)optimizer//optimizer//dense_1/bias/Adam_1)optimizer//optimizer//dense_1/kernel/Adam+optimizer//optimizer//dense_1/kernel/Adam_1'optimizer//optimizer//dense_2/bias/Adam)optimizer//optimizer//dense_2/bias/Adam_1)optimizer//optimizer//dense_2/kernel/Adam+optimizer//optimizer//dense_2/kernel/Adam_1'optimizer//optimizer//dense_3/bias/Adam)optimizer//optimizer//dense_3/bias/Adam_1)optimizer//optimizer//dense_3/kernel/Adam+optimizer//optimizer//dense_3/kernel/Adam_1/optimizer//optimizer//extrinsic_value/bias/Adam1optimizer//optimizer//extrinsic_value/bias/Adam_11optimizer//optimizer//extrinsic_value/kernel/Adam3optimizer//optimizer//extrinsic_value/kernel/Adam_1*optimizer//optimizer//gail_value/bias/Adam,optimizer//optimizer//gail_value/bias/Adam_1,optimizer//optimizer//gail_value/kernel/Adam.optimizer//optimizer//gail_value/kernel/Adam_15optimizer//optimizer//main_graph_0/hidden_0/bias/Adam7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_17optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_15optimizer//optimizer//main_graph_0/hidden_1/bias/Adam7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_17optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1optimizer//policy/log_std/Adam optimizer//policy/log_std/Adam_1!optimizer//policy/log_std/bc_adam#optimizer//policy/log_std/bc_adam_11optimizer//policy/main_graph_0/hidden_0/bias/Adam3optimizer//policy/main_graph_0/hidden_0/bias/Adam_14optimizer//policy/main_graph_0/hidden_0/bias/bc_adam6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_13optimizer//policy/main_graph_0/hidden_0/kernel/Adam5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_16optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_11optimizer//policy/main_graph_0/hidden_1/bias/Adam3optimizer//policy/main_graph_0/hidden_1/bias/Adam_14optimizer//policy/main_graph_0/hidden_1/bias/bc_adam6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_13optimizer//policy/main_graph_0/hidden_1/kernel/Adam5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_16optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1optimizer//policy/mu/bias/Adam optimizer//policy/mu/bias/Adam_1!optimizer//policy/mu/bias/bc_adam#optimizer//policy/mu/bias/bc_adam_1 optimizer//policy/mu/kernel/Adam"optimizer//policy/mu/kernel/Adam_1#optimizer//policy/mu/kernel/bc_adam%optimizer//policy/mu/kernel/bc_adam_1optimizer/beta1_poweroptimizer/beta1_power_1optimizer/beta1_power_2optimizer/beta1_power_3optimizer/beta2_poweroptimizer/beta2_power_1optimizer/beta2_power_2optimizer/beta2_power_3policy/log_std!policy/main_graph_0/hidden_0/bias#policy/main_graph_0/hidden_0/kernel!policy/main_graph_0/hidden_1/bias#policy/main_graph_0/hidden_1/kernelpolicy/mu/biaspolicy/mu/kernelrunning_meanrunning_variancetrainer_major_versiontrainer_minor_versiontrainer_patch_versionversion_number*�
dtypes�
�2�
m
save_1/control_dependencyIdentitysave_1/Const^save_1/SaveV2*
T0*
_class
loc:@save_1/Const
�/
save_1/RestoreV2/tensor_namesConst"/device:CPU:0*
dtype0*�/
value�.B�.�Baction_output_shapeBglobal_stepBis_continuous_controlBmemory_sizeBnormalization_stepsB*optimizer//GAIL_model/gail_d_estimate/biasB,optimizer//GAIL_model/gail_d_estimate/kernelB*optimizer//GAIL_model/gail_d_hidden_1/biasB,optimizer//GAIL_model/gail_d_hidden_1/kernelB*optimizer//GAIL_model/gail_d_hidden_2/biasB,optimizer//GAIL_model/gail_d_hidden_2/kernelBoptimizer//curiosity_value/biasB!optimizer//curiosity_value/kernelB5optimizer//curiosity_vector_obs_encoder/hidden_0/biasB7optimizer//curiosity_vector_obs_encoder/hidden_0/kernelB5optimizer//curiosity_vector_obs_encoder/hidden_1/biasB7optimizer//curiosity_vector_obs_encoder/hidden_1/kernelBoptimizer//dense/biasBoptimizer//dense/kernelBoptimizer//dense_1/biasBoptimizer//dense_1/kernelBoptimizer//dense_2/biasBoptimizer//dense_2/kernelBoptimizer//dense_3/biasBoptimizer//dense_3/kernelBoptimizer//extrinsic_value/biasB!optimizer//extrinsic_value/kernelBoptimizer//gail_value/biasBoptimizer//gail_value/kernelB%optimizer//main_graph_0/hidden_0/biasB'optimizer//main_graph_0/hidden_0/kernelB%optimizer//main_graph_0/hidden_1/biasB'optimizer//main_graph_0/hidden_1/kernelB:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/AdamB<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1B<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/AdamB>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1B:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/AdamB<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1B<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/AdamB>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1B:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/AdamB<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1B<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/AdamB>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1B/optimizer//optimizer//curiosity_value/bias/AdamB1optimizer//optimizer//curiosity_value/bias/Adam_1B1optimizer//optimizer//curiosity_value/kernel/AdamB3optimizer//optimizer//curiosity_value/kernel/Adam_1BEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/AdamBGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1BGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/AdamBIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1BEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/AdamBGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1BGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/AdamBIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1B%optimizer//optimizer//dense/bias/AdamB'optimizer//optimizer//dense/bias/Adam_1B'optimizer//optimizer//dense/kernel/AdamB)optimizer//optimizer//dense/kernel/Adam_1B'optimizer//optimizer//dense_1/bias/AdamB)optimizer//optimizer//dense_1/bias/Adam_1B)optimizer//optimizer//dense_1/kernel/AdamB+optimizer//optimizer//dense_1/kernel/Adam_1B'optimizer//optimizer//dense_2/bias/AdamB)optimizer//optimizer//dense_2/bias/Adam_1B)optimizer//optimizer//dense_2/kernel/AdamB+optimizer//optimizer//dense_2/kernel/Adam_1B'optimizer//optimizer//dense_3/bias/AdamB)optimizer//optimizer//dense_3/bias/Adam_1B)optimizer//optimizer//dense_3/kernel/AdamB+optimizer//optimizer//dense_3/kernel/Adam_1B/optimizer//optimizer//extrinsic_value/bias/AdamB1optimizer//optimizer//extrinsic_value/bias/Adam_1B1optimizer//optimizer//extrinsic_value/kernel/AdamB3optimizer//optimizer//extrinsic_value/kernel/Adam_1B*optimizer//optimizer//gail_value/bias/AdamB,optimizer//optimizer//gail_value/bias/Adam_1B,optimizer//optimizer//gail_value/kernel/AdamB.optimizer//optimizer//gail_value/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_0/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_0/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1B5optimizer//optimizer//main_graph_0/hidden_1/bias/AdamB7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1B7optimizer//optimizer//main_graph_0/hidden_1/kernel/AdamB9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1Boptimizer//policy/log_std/AdamB optimizer//policy/log_std/Adam_1B!optimizer//policy/log_std/bc_adamB#optimizer//policy/log_std/bc_adam_1B1optimizer//policy/main_graph_0/hidden_0/bias/AdamB3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1B4optimizer//policy/main_graph_0/hidden_0/bias/bc_adamB6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1B3optimizer//policy/main_graph_0/hidden_0/kernel/AdamB5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1B6optimizer//policy/main_graph_0/hidden_0/kernel/bc_adamB8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1B1optimizer//policy/main_graph_0/hidden_1/bias/AdamB3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1B4optimizer//policy/main_graph_0/hidden_1/bias/bc_adamB6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1B3optimizer//policy/main_graph_0/hidden_1/kernel/AdamB5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1B6optimizer//policy/main_graph_0/hidden_1/kernel/bc_adamB8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1Boptimizer//policy/mu/bias/AdamB optimizer//policy/mu/bias/Adam_1B!optimizer//policy/mu/bias/bc_adamB#optimizer//policy/mu/bias/bc_adam_1B optimizer//policy/mu/kernel/AdamB"optimizer//policy/mu/kernel/Adam_1B#optimizer//policy/mu/kernel/bc_adamB%optimizer//policy/mu/kernel/bc_adam_1Boptimizer/beta1_powerBoptimizer/beta1_power_1Boptimizer/beta1_power_2Boptimizer/beta1_power_3Boptimizer/beta2_powerBoptimizer/beta2_power_1Boptimizer/beta2_power_2Boptimizer/beta2_power_3Bpolicy/log_stdB!policy/main_graph_0/hidden_0/biasB#policy/main_graph_0/hidden_0/kernelB!policy/main_graph_0/hidden_1/biasB#policy/main_graph_0/hidden_1/kernelBpolicy/mu/biasBpolicy/mu/kernelBrunning_meanBrunning_varianceBtrainer_major_versionBtrainer_minor_versionBtrainer_patch_versionBversion_number
�
!save_1/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*�
value�B��B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B 
�
save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices"/device:CPU:0*�
dtypes�
�2�
�
save_1/AssignAssignaction_output_shapesave_1/RestoreV2*
T0*&
_class
loc:@action_output_shape*
use_locking(*
validate_shape(
�
save_1/Assign_1Assignglobal_stepsave_1/RestoreV2:1*
T0*
_class
loc:@global_step*
use_locking(*
validate_shape(
�
save_1/Assign_2Assignis_continuous_controlsave_1/RestoreV2:2*
T0*(
_class
loc:@is_continuous_control*
use_locking(*
validate_shape(
�
save_1/Assign_3Assignmemory_sizesave_1/RestoreV2:3*
T0*
_class
loc:@memory_size*
use_locking(*
validate_shape(
�
save_1/Assign_4Assignnormalization_stepssave_1/RestoreV2:4*
T0*&
_class
loc:@normalization_steps*
use_locking(*
validate_shape(
�
save_1/Assign_5Assign*optimizer//GAIL_model/gail_d_estimate/biassave_1/RestoreV2:5*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
save_1/Assign_6Assign,optimizer//GAIL_model/gail_d_estimate/kernelsave_1/RestoreV2:6*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_7Assign*optimizer//GAIL_model/gail_d_hidden_1/biassave_1/RestoreV2:7*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_8Assign,optimizer//GAIL_model/gail_d_hidden_1/kernelsave_1/RestoreV2:8*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_9Assign*optimizer//GAIL_model/gail_d_hidden_2/biassave_1/RestoreV2:9*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
use_locking(*
validate_shape(
�
save_1/Assign_10Assign,optimizer//GAIL_model/gail_d_hidden_2/kernelsave_1/RestoreV2:10*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_11Assignoptimizer//curiosity_value/biassave_1/RestoreV2:11*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_12Assign!optimizer//curiosity_value/kernelsave_1/RestoreV2:12*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_13Assign5optimizer//curiosity_vector_obs_encoder/hidden_0/biassave_1/RestoreV2:13*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_14Assign7optimizer//curiosity_vector_obs_encoder/hidden_0/kernelsave_1/RestoreV2:14*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_15Assign5optimizer//curiosity_vector_obs_encoder/hidden_1/biassave_1/RestoreV2:15*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_16Assign7optimizer//curiosity_vector_obs_encoder/hidden_1/kernelsave_1/RestoreV2:16*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_17Assignoptimizer//dense/biassave_1/RestoreV2:17*
T0*(
_class
loc:@optimizer//dense/bias*
use_locking(*
validate_shape(
�
save_1/Assign_18Assignoptimizer//dense/kernelsave_1/RestoreV2:18*
T0**
_class 
loc:@optimizer//dense/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_19Assignoptimizer//dense_1/biassave_1/RestoreV2:19*
T0**
_class 
loc:@optimizer//dense_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_20Assignoptimizer//dense_1/kernelsave_1/RestoreV2:20*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_21Assignoptimizer//dense_2/biassave_1/RestoreV2:21*
T0**
_class 
loc:@optimizer//dense_2/bias*
use_locking(*
validate_shape(
�
save_1/Assign_22Assignoptimizer//dense_2/kernelsave_1/RestoreV2:22*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_23Assignoptimizer//dense_3/biassave_1/RestoreV2:23*
T0**
_class 
loc:@optimizer//dense_3/bias*
use_locking(*
validate_shape(
�
save_1/Assign_24Assignoptimizer//dense_3/kernelsave_1/RestoreV2:24*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_25Assignoptimizer//extrinsic_value/biassave_1/RestoreV2:25*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_26Assign!optimizer//extrinsic_value/kernelsave_1/RestoreV2:26*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_27Assignoptimizer//gail_value/biassave_1/RestoreV2:27*
T0*-
_class#
!loc:@optimizer//gail_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_28Assignoptimizer//gail_value/kernelsave_1/RestoreV2:28*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_29Assign%optimizer//main_graph_0/hidden_0/biassave_1/RestoreV2:29*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_30Assign'optimizer//main_graph_0/hidden_0/kernelsave_1/RestoreV2:30*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_31Assign%optimizer//main_graph_0/hidden_1/biassave_1/RestoreV2:31*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_32Assign'optimizer//main_graph_0/hidden_1/kernelsave_1/RestoreV2:32*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_33Assign:optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adamsave_1/RestoreV2:33*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
save_1/Assign_34Assign<optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1save_1/RestoreV2:34*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
save_1/Assign_35Assign<optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adamsave_1/RestoreV2:35*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_36Assign>optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1save_1/RestoreV2:36*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_estimate/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_37Assign:optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adamsave_1/RestoreV2:37*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_38Assign<optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1save_1/RestoreV2:38*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_39Assign<optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adamsave_1/RestoreV2:39*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_40Assign>optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1save_1/RestoreV2:40*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_41Assign:optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adamsave_1/RestoreV2:41*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
use_locking(*
validate_shape(
�
save_1/Assign_42Assign<optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1save_1/RestoreV2:42*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_hidden_2/bias*
use_locking(*
validate_shape(
�
save_1/Assign_43Assign<optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adamsave_1/RestoreV2:43*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_44Assign>optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1save_1/RestoreV2:44*
T0*?
_class5
31loc:@optimizer//GAIL_model/gail_d_hidden_2/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_45Assign/optimizer//optimizer//curiosity_value/bias/Adamsave_1/RestoreV2:45*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_46Assign1optimizer//optimizer//curiosity_value/bias/Adam_1save_1/RestoreV2:46*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_47Assign1optimizer//optimizer//curiosity_value/kernel/Adamsave_1/RestoreV2:47*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_48Assign3optimizer//optimizer//curiosity_value/kernel/Adam_1save_1/RestoreV2:48*
T0*4
_class*
(&loc:@optimizer//curiosity_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_49AssignEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adamsave_1/RestoreV2:49*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_50AssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1save_1/RestoreV2:50*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_51AssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adamsave_1/RestoreV2:51*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_52AssignIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1save_1/RestoreV2:52*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_53AssignEoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adamsave_1/RestoreV2:53*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_54AssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1save_1/RestoreV2:54*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_55AssignGoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adamsave_1/RestoreV2:55*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_56AssignIoptimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1save_1/RestoreV2:56*
T0*J
_class@
><loc:@optimizer//curiosity_vector_obs_encoder/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_57Assign%optimizer//optimizer//dense/bias/Adamsave_1/RestoreV2:57*
T0*(
_class
loc:@optimizer//dense/bias*
use_locking(*
validate_shape(
�
save_1/Assign_58Assign'optimizer//optimizer//dense/bias/Adam_1save_1/RestoreV2:58*
T0*(
_class
loc:@optimizer//dense/bias*
use_locking(*
validate_shape(
�
save_1/Assign_59Assign'optimizer//optimizer//dense/kernel/Adamsave_1/RestoreV2:59*
T0**
_class 
loc:@optimizer//dense/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_60Assign)optimizer//optimizer//dense/kernel/Adam_1save_1/RestoreV2:60*
T0**
_class 
loc:@optimizer//dense/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_61Assign'optimizer//optimizer//dense_1/bias/Adamsave_1/RestoreV2:61*
T0**
_class 
loc:@optimizer//dense_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_62Assign)optimizer//optimizer//dense_1/bias/Adam_1save_1/RestoreV2:62*
T0**
_class 
loc:@optimizer//dense_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_63Assign)optimizer//optimizer//dense_1/kernel/Adamsave_1/RestoreV2:63*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_64Assign+optimizer//optimizer//dense_1/kernel/Adam_1save_1/RestoreV2:64*
T0*,
_class"
 loc:@optimizer//dense_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_65Assign'optimizer//optimizer//dense_2/bias/Adamsave_1/RestoreV2:65*
T0**
_class 
loc:@optimizer//dense_2/bias*
use_locking(*
validate_shape(
�
save_1/Assign_66Assign)optimizer//optimizer//dense_2/bias/Adam_1save_1/RestoreV2:66*
T0**
_class 
loc:@optimizer//dense_2/bias*
use_locking(*
validate_shape(
�
save_1/Assign_67Assign)optimizer//optimizer//dense_2/kernel/Adamsave_1/RestoreV2:67*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_68Assign+optimizer//optimizer//dense_2/kernel/Adam_1save_1/RestoreV2:68*
T0*,
_class"
 loc:@optimizer//dense_2/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_69Assign'optimizer//optimizer//dense_3/bias/Adamsave_1/RestoreV2:69*
T0**
_class 
loc:@optimizer//dense_3/bias*
use_locking(*
validate_shape(
�
save_1/Assign_70Assign)optimizer//optimizer//dense_3/bias/Adam_1save_1/RestoreV2:70*
T0**
_class 
loc:@optimizer//dense_3/bias*
use_locking(*
validate_shape(
�
save_1/Assign_71Assign)optimizer//optimizer//dense_3/kernel/Adamsave_1/RestoreV2:71*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_72Assign+optimizer//optimizer//dense_3/kernel/Adam_1save_1/RestoreV2:72*
T0*,
_class"
 loc:@optimizer//dense_3/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_73Assign/optimizer//optimizer//extrinsic_value/bias/Adamsave_1/RestoreV2:73*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_74Assign1optimizer//optimizer//extrinsic_value/bias/Adam_1save_1/RestoreV2:74*
T0*2
_class(
&$loc:@optimizer//extrinsic_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_75Assign1optimizer//optimizer//extrinsic_value/kernel/Adamsave_1/RestoreV2:75*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_76Assign3optimizer//optimizer//extrinsic_value/kernel/Adam_1save_1/RestoreV2:76*
T0*4
_class*
(&loc:@optimizer//extrinsic_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_77Assign*optimizer//optimizer//gail_value/bias/Adamsave_1/RestoreV2:77*
T0*-
_class#
!loc:@optimizer//gail_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_78Assign,optimizer//optimizer//gail_value/bias/Adam_1save_1/RestoreV2:78*
T0*-
_class#
!loc:@optimizer//gail_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_79Assign,optimizer//optimizer//gail_value/kernel/Adamsave_1/RestoreV2:79*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_80Assign.optimizer//optimizer//gail_value/kernel/Adam_1save_1/RestoreV2:80*
T0*/
_class%
#!loc:@optimizer//gail_value/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_81Assign5optimizer//optimizer//main_graph_0/hidden_0/bias/Adamsave_1/RestoreV2:81*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_82Assign7optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1save_1/RestoreV2:82*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_83Assign7optimizer//optimizer//main_graph_0/hidden_0/kernel/Adamsave_1/RestoreV2:83*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_84Assign9optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1save_1/RestoreV2:84*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_85Assign5optimizer//optimizer//main_graph_0/hidden_1/bias/Adamsave_1/RestoreV2:85*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_86Assign7optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1save_1/RestoreV2:86*
T0*8
_class.
,*loc:@optimizer//main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_87Assign7optimizer//optimizer//main_graph_0/hidden_1/kernel/Adamsave_1/RestoreV2:87*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_88Assign9optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1save_1/RestoreV2:88*
T0*:
_class0
.,loc:@optimizer//main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_89Assignoptimizer//policy/log_std/Adamsave_1/RestoreV2:89*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save_1/Assign_90Assign optimizer//policy/log_std/Adam_1save_1/RestoreV2:90*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save_1/Assign_91Assign!optimizer//policy/log_std/bc_adamsave_1/RestoreV2:91*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save_1/Assign_92Assign#optimizer//policy/log_std/bc_adam_1save_1/RestoreV2:92*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save_1/Assign_93Assign1optimizer//policy/main_graph_0/hidden_0/bias/Adamsave_1/RestoreV2:93*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_94Assign3optimizer//policy/main_graph_0/hidden_0/bias/Adam_1save_1/RestoreV2:94*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_95Assign4optimizer//policy/main_graph_0/hidden_0/bias/bc_adamsave_1/RestoreV2:95*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_96Assign6optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1save_1/RestoreV2:96*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_97Assign3optimizer//policy/main_graph_0/hidden_0/kernel/Adamsave_1/RestoreV2:97*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_98Assign5optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1save_1/RestoreV2:98*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_99Assign6optimizer//policy/main_graph_0/hidden_0/kernel/bc_adamsave_1/RestoreV2:99*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_100Assign8optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1save_1/RestoreV2:100*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_101Assign1optimizer//policy/main_graph_0/hidden_1/bias/Adamsave_1/RestoreV2:101*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_102Assign3optimizer//policy/main_graph_0/hidden_1/bias/Adam_1save_1/RestoreV2:102*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_103Assign4optimizer//policy/main_graph_0/hidden_1/bias/bc_adamsave_1/RestoreV2:103*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_104Assign6optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1save_1/RestoreV2:104*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_105Assign3optimizer//policy/main_graph_0/hidden_1/kernel/Adamsave_1/RestoreV2:105*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_106Assign5optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1save_1/RestoreV2:106*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_107Assign6optimizer//policy/main_graph_0/hidden_1/kernel/bc_adamsave_1/RestoreV2:107*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_108Assign8optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1save_1/RestoreV2:108*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_109Assignoptimizer//policy/mu/bias/Adamsave_1/RestoreV2:109*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save_1/Assign_110Assign optimizer//policy/mu/bias/Adam_1save_1/RestoreV2:110*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save_1/Assign_111Assign!optimizer//policy/mu/bias/bc_adamsave_1/RestoreV2:111*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save_1/Assign_112Assign#optimizer//policy/mu/bias/bc_adam_1save_1/RestoreV2:112*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save_1/Assign_113Assign optimizer//policy/mu/kernel/Adamsave_1/RestoreV2:113*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_114Assign"optimizer//policy/mu/kernel/Adam_1save_1/RestoreV2:114*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_115Assign#optimizer//policy/mu/kernel/bc_adamsave_1/RestoreV2:115*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_116Assign%optimizer//policy/mu/kernel/bc_adam_1save_1/RestoreV2:116*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_117Assignoptimizer/beta1_powersave_1/RestoreV2:117*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_118Assignoptimizer/beta1_power_1save_1/RestoreV2:118*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
save_1/Assign_119Assignoptimizer/beta1_power_2save_1/RestoreV2:119*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save_1/Assign_120Assignoptimizer/beta1_power_3save_1/RestoreV2:120*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_121Assignoptimizer/beta2_powersave_1/RestoreV2:121*
T0*H
_class>
<:loc:@optimizer//curiosity_vector_obs_encoder/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_122Assignoptimizer/beta2_power_1save_1/RestoreV2:122*
T0*=
_class3
1/loc:@optimizer//GAIL_model/gail_d_estimate/bias*
use_locking(*
validate_shape(
�
save_1/Assign_123Assignoptimizer/beta2_power_2save_1/RestoreV2:123*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save_1/Assign_124Assignoptimizer/beta2_power_3save_1/RestoreV2:124*
T0*2
_class(
&$loc:@optimizer//curiosity_value/bias*
use_locking(*
validate_shape(
�
save_1/Assign_125Assignpolicy/log_stdsave_1/RestoreV2:125*
T0*!
_class
loc:@policy/log_std*
use_locking(*
validate_shape(
�
save_1/Assign_126Assign!policy/main_graph_0/hidden_0/biassave_1/RestoreV2:126*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_0/bias*
use_locking(*
validate_shape(
�
save_1/Assign_127Assign#policy/main_graph_0/hidden_0/kernelsave_1/RestoreV2:127*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_0/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_128Assign!policy/main_graph_0/hidden_1/biassave_1/RestoreV2:128*
T0*4
_class*
(&loc:@policy/main_graph_0/hidden_1/bias*
use_locking(*
validate_shape(
�
save_1/Assign_129Assign#policy/main_graph_0/hidden_1/kernelsave_1/RestoreV2:129*
T0*6
_class,
*(loc:@policy/main_graph_0/hidden_1/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_130Assignpolicy/mu/biassave_1/RestoreV2:130*
T0*!
_class
loc:@policy/mu/bias*
use_locking(*
validate_shape(
�
save_1/Assign_131Assignpolicy/mu/kernelsave_1/RestoreV2:131*
T0*#
_class
loc:@policy/mu/kernel*
use_locking(*
validate_shape(
�
save_1/Assign_132Assignrunning_meansave_1/RestoreV2:132*
T0*
_class
loc:@running_mean*
use_locking(*
validate_shape(
�
save_1/Assign_133Assignrunning_variancesave_1/RestoreV2:133*
T0*#
_class
loc:@running_variance*
use_locking(*
validate_shape(
�
save_1/Assign_134Assigntrainer_major_versionsave_1/RestoreV2:134*
T0*(
_class
loc:@trainer_major_version*
use_locking(*
validate_shape(
�
save_1/Assign_135Assigntrainer_minor_versionsave_1/RestoreV2:135*
T0*(
_class
loc:@trainer_minor_version*
use_locking(*
validate_shape(
�
save_1/Assign_136Assigntrainer_patch_versionsave_1/RestoreV2:136*
T0*(
_class
loc:@trainer_patch_version*
use_locking(*
validate_shape(
�
save_1/Assign_137Assignversion_numbersave_1/RestoreV2:137*
T0*!
_class
loc:@version_number*
use_locking(*
validate_shape(
�
save_1/restore_allNoOp^save_1/Assign^save_1/Assign_1^save_1/Assign_10^save_1/Assign_100^save_1/Assign_101^save_1/Assign_102^save_1/Assign_103^save_1/Assign_104^save_1/Assign_105^save_1/Assign_106^save_1/Assign_107^save_1/Assign_108^save_1/Assign_109^save_1/Assign_11^save_1/Assign_110^save_1/Assign_111^save_1/Assign_112^save_1/Assign_113^save_1/Assign_114^save_1/Assign_115^save_1/Assign_116^save_1/Assign_117^save_1/Assign_118^save_1/Assign_119^save_1/Assign_12^save_1/Assign_120^save_1/Assign_121^save_1/Assign_122^save_1/Assign_123^save_1/Assign_124^save_1/Assign_125^save_1/Assign_126^save_1/Assign_127^save_1/Assign_128^save_1/Assign_129^save_1/Assign_13^save_1/Assign_130^save_1/Assign_131^save_1/Assign_132^save_1/Assign_133^save_1/Assign_134^save_1/Assign_135^save_1/Assign_136^save_1/Assign_137^save_1/Assign_14^save_1/Assign_15^save_1/Assign_16^save_1/Assign_17^save_1/Assign_18^save_1/Assign_19^save_1/Assign_2^save_1/Assign_20^save_1/Assign_21^save_1/Assign_22^save_1/Assign_23^save_1/Assign_24^save_1/Assign_25^save_1/Assign_26^save_1/Assign_27^save_1/Assign_28^save_1/Assign_29^save_1/Assign_3^save_1/Assign_30^save_1/Assign_31^save_1/Assign_32^save_1/Assign_33^save_1/Assign_34^save_1/Assign_35^save_1/Assign_36^save_1/Assign_37^save_1/Assign_38^save_1/Assign_39^save_1/Assign_4^save_1/Assign_40^save_1/Assign_41^save_1/Assign_42^save_1/Assign_43^save_1/Assign_44^save_1/Assign_45^save_1/Assign_46^save_1/Assign_47^save_1/Assign_48^save_1/Assign_49^save_1/Assign_5^save_1/Assign_50^save_1/Assign_51^save_1/Assign_52^save_1/Assign_53^save_1/Assign_54^save_1/Assign_55^save_1/Assign_56^save_1/Assign_57^save_1/Assign_58^save_1/Assign_59^save_1/Assign_6^save_1/Assign_60^save_1/Assign_61^save_1/Assign_62^save_1/Assign_63^save_1/Assign_64^save_1/Assign_65^save_1/Assign_66^save_1/Assign_67^save_1/Assign_68^save_1/Assign_69^save_1/Assign_7^save_1/Assign_70^save_1/Assign_71^save_1/Assign_72^save_1/Assign_73^save_1/Assign_74^save_1/Assign_75^save_1/Assign_76^save_1/Assign_77^save_1/Assign_78^save_1/Assign_79^save_1/Assign_8^save_1/Assign_80^save_1/Assign_81^save_1/Assign_82^save_1/Assign_83^save_1/Assign_84^save_1/Assign_85^save_1/Assign_86^save_1/Assign_87^save_1/Assign_88^save_1/Assign_89^save_1/Assign_9^save_1/Assign_90^save_1/Assign_91^save_1/Assign_92^save_1/Assign_93^save_1/Assign_94^save_1/Assign_95^save_1/Assign_96^save_1/Assign_97^save_1/Assign_98^save_1/Assign_99
�7
init_1NoOp^action_output_shape/Assign^global_step/Assign^is_continuous_control/Assign^memory_size/Assign^normalization_steps/Assign2^optimizer//GAIL_model/gail_d_estimate/bias/Assign4^optimizer//GAIL_model/gail_d_estimate/kernel/Assign2^optimizer//GAIL_model/gail_d_hidden_1/bias/Assign4^optimizer//GAIL_model/gail_d_hidden_1/kernel/Assign2^optimizer//GAIL_model/gail_d_hidden_2/bias/Assign4^optimizer//GAIL_model/gail_d_hidden_2/kernel/Assign'^optimizer//curiosity_value/bias/Assign)^optimizer//curiosity_value/kernel/Assign=^optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Assign?^optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Assign=^optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Assign?^optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Assign^optimizer//dense/bias/Assign^optimizer//dense/kernel/Assign^optimizer//dense_1/bias/Assign!^optimizer//dense_1/kernel/Assign^optimizer//dense_2/bias/Assign!^optimizer//dense_2/kernel/Assign^optimizer//dense_3/bias/Assign!^optimizer//dense_3/kernel/Assign'^optimizer//extrinsic_value/bias/Assign)^optimizer//extrinsic_value/kernel/Assign"^optimizer//gail_value/bias/Assign$^optimizer//gail_value/kernel/Assign-^optimizer//main_graph_0/hidden_0/bias/Assign/^optimizer//main_graph_0/hidden_0/kernel/Assign-^optimizer//main_graph_0/hidden_1/bias/Assign/^optimizer//main_graph_0/hidden_1/kernel/AssignB^optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam/AssignD^optimizer//optimizer//GAIL_model/gail_d_estimate/bias/Adam_1/AssignD^optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam/AssignF^optimizer//optimizer//GAIL_model/gail_d_estimate/kernel/Adam_1/AssignB^optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam/AssignD^optimizer//optimizer//GAIL_model/gail_d_hidden_1/bias/Adam_1/AssignD^optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam/AssignF^optimizer//optimizer//GAIL_model/gail_d_hidden_1/kernel/Adam_1/AssignB^optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam/AssignD^optimizer//optimizer//GAIL_model/gail_d_hidden_2/bias/Adam_1/AssignD^optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam/AssignF^optimizer//optimizer//GAIL_model/gail_d_hidden_2/kernel/Adam_1/Assign7^optimizer//optimizer//curiosity_value/bias/Adam/Assign9^optimizer//optimizer//curiosity_value/bias/Adam_1/Assign9^optimizer//optimizer//curiosity_value/kernel/Adam/Assign;^optimizer//optimizer//curiosity_value/kernel/Adam_1/AssignM^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam/AssignO^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/bias/Adam_1/AssignO^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam/AssignQ^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_0/kernel/Adam_1/AssignM^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam/AssignO^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/bias/Adam_1/AssignO^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam/AssignQ^optimizer//optimizer//curiosity_vector_obs_encoder/hidden_1/kernel/Adam_1/Assign-^optimizer//optimizer//dense/bias/Adam/Assign/^optimizer//optimizer//dense/bias/Adam_1/Assign/^optimizer//optimizer//dense/kernel/Adam/Assign1^optimizer//optimizer//dense/kernel/Adam_1/Assign/^optimizer//optimizer//dense_1/bias/Adam/Assign1^optimizer//optimizer//dense_1/bias/Adam_1/Assign1^optimizer//optimizer//dense_1/kernel/Adam/Assign3^optimizer//optimizer//dense_1/kernel/Adam_1/Assign/^optimizer//optimizer//dense_2/bias/Adam/Assign1^optimizer//optimizer//dense_2/bias/Adam_1/Assign1^optimizer//optimizer//dense_2/kernel/Adam/Assign3^optimizer//optimizer//dense_2/kernel/Adam_1/Assign/^optimizer//optimizer//dense_3/bias/Adam/Assign1^optimizer//optimizer//dense_3/bias/Adam_1/Assign1^optimizer//optimizer//dense_3/kernel/Adam/Assign3^optimizer//optimizer//dense_3/kernel/Adam_1/Assign7^optimizer//optimizer//extrinsic_value/bias/Adam/Assign9^optimizer//optimizer//extrinsic_value/bias/Adam_1/Assign9^optimizer//optimizer//extrinsic_value/kernel/Adam/Assign;^optimizer//optimizer//extrinsic_value/kernel/Adam_1/Assign2^optimizer//optimizer//gail_value/bias/Adam/Assign4^optimizer//optimizer//gail_value/bias/Adam_1/Assign4^optimizer//optimizer//gail_value/kernel/Adam/Assign6^optimizer//optimizer//gail_value/kernel/Adam_1/Assign=^optimizer//optimizer//main_graph_0/hidden_0/bias/Adam/Assign?^optimizer//optimizer//main_graph_0/hidden_0/bias/Adam_1/Assign?^optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam/AssignA^optimizer//optimizer//main_graph_0/hidden_0/kernel/Adam_1/Assign=^optimizer//optimizer//main_graph_0/hidden_1/bias/Adam/Assign?^optimizer//optimizer//main_graph_0/hidden_1/bias/Adam_1/Assign?^optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam/AssignA^optimizer//optimizer//main_graph_0/hidden_1/kernel/Adam_1/Assign&^optimizer//policy/log_std/Adam/Assign(^optimizer//policy/log_std/Adam_1/Assign)^optimizer//policy/log_std/bc_adam/Assign+^optimizer//policy/log_std/bc_adam_1/Assign9^optimizer//policy/main_graph_0/hidden_0/bias/Adam/Assign;^optimizer//policy/main_graph_0/hidden_0/bias/Adam_1/Assign<^optimizer//policy/main_graph_0/hidden_0/bias/bc_adam/Assign>^optimizer//policy/main_graph_0/hidden_0/bias/bc_adam_1/Assign;^optimizer//policy/main_graph_0/hidden_0/kernel/Adam/Assign=^optimizer//policy/main_graph_0/hidden_0/kernel/Adam_1/Assign>^optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam/Assign@^optimizer//policy/main_graph_0/hidden_0/kernel/bc_adam_1/Assign9^optimizer//policy/main_graph_0/hidden_1/bias/Adam/Assign;^optimizer//policy/main_graph_0/hidden_1/bias/Adam_1/Assign<^optimizer//policy/main_graph_0/hidden_1/bias/bc_adam/Assign>^optimizer//policy/main_graph_0/hidden_1/bias/bc_adam_1/Assign;^optimizer//policy/main_graph_0/hidden_1/kernel/Adam/Assign=^optimizer//policy/main_graph_0/hidden_1/kernel/Adam_1/Assign>^optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam/Assign@^optimizer//policy/main_graph_0/hidden_1/kernel/bc_adam_1/Assign&^optimizer//policy/mu/bias/Adam/Assign(^optimizer//policy/mu/bias/Adam_1/Assign)^optimizer//policy/mu/bias/bc_adam/Assign+^optimizer//policy/mu/bias/bc_adam_1/Assign(^optimizer//policy/mu/kernel/Adam/Assign*^optimizer//policy/mu/kernel/Adam_1/Assign+^optimizer//policy/mu/kernel/bc_adam/Assign-^optimizer//policy/mu/kernel/bc_adam_1/Assign^optimizer/beta1_power/Assign^optimizer/beta1_power_1/Assign^optimizer/beta1_power_2/Assign^optimizer/beta1_power_3/Assign^optimizer/beta2_power/Assign^optimizer/beta2_power_1/Assign^optimizer/beta2_power_2/Assign^optimizer/beta2_power_3/Assign^policy/log_std/Assign)^policy/main_graph_0/hidden_0/bias/Assign+^policy/main_graph_0/hidden_0/kernel/Assign)^policy/main_graph_0/hidden_1/bias/Assign+^policy/main_graph_0/hidden_1/kernel/Assign^policy/mu/bias/Assign^policy/mu/kernel/Assign^running_mean/Assign^running_variance/Assign^trainer_major_version/Assign^trainer_minor_version/Assign^trainer_patch_version/Assign^version_number/Assign"�