-- solution from lecturer
abstract sig Box {value: Int}
one sig B11, B12, B13, B21, B22, B23, B31, B32, B33 extends Box {}

fact {all b:Box | b.value >=-1 && b.value <= 7}
fact {all b1, b2:Box |b1.value = b2.value => b1 = b2} 
fact {B11.value + B12.value + B13.value - 2 = 7}
fact {B21.value + B22.value + B23.value - 2 = 7}
fact {B31.value + B32.value + B33.value - 2 = 7}
fact {B11.value + B21.value + B31.value - 2 = 7}
fact {B12.value + B22.value + B32.value - 2 = 7}
fact {B13.value + B23.value + B33.value - 2 = 7}
fact {B11.value + B22.value + B33.value - 2 = 7}
fact {B31.value + B22.value + B31.value - 2 = 7}

pred Show{}
run Show

