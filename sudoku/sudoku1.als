sig Box {row:Int,  col:Int, subb:Int, picture:Picture}
one sig B11, B12, B13, B14, B21, B22, B23, B24, B31, B32, B33, B34, B41, B42, B43, B44 extends Box {}

sig Picture {}
one sig Butterfly, Bee, Snail, Ladybug extends Picture {} 

fact {all b:Box | b.picture = Butterfly || b.picture == Bee || b.picture = Snail || b.picture = Ladybug} 
 
fact{B11.row = 1 && B11.col = 1 && B11.subb = 1}
fact{B12.row = 1 && B12.col = 2 && B12.subb = 1}
fact{B13.row = 1 && B13.col = 3 && B13.subb = 2 && B13.picture = Ladybug}
fact{B14.row = 1 && B14.col = 4 && B14.subb = 2 && B14.picture = Bee}
fact{B21.row = 2 && B21.col = 1 && B21.subb = 1}
fact{B22.row = 2 && B22.col = 2 && B22.subb = 1 && B22.picture = Ladybug}
fact{B23.row = 2 && B23.col = 3 && B23.subb = 2 && B23.picture = Snail}
fact{B24.row = 2 && B24.col = 4 && B24.subb = 2 && B24.picture = Butterfly}

fact{B31.row = 3 && B31.col = 1 && B31.subb = 3}
fact{B32.row = 3 && B32.col = 2 && B32.subb = 3 && B32.picture = Butterfly}
fact{B33.row = 3 && B33.col = 3 && B33.subb = 4}
fact{B34.row = 3 && B34.col = 4 && B34.subb = 4}
fact{B41.row = 4 && B41.col = 1 && B41.subb = 3}
fact{B42.row = 4 && B42.col = 2 && B42.subb = 3 && B42.picture = Bee}
fact{B43.row = 4 && B43.col = 3 && B43.subb = 4}
fact{B44.row = 4 && B44.col = 4 && B44.subb = 4 && B44.picture = Snail}

fact {all b1,b2:Box | b1.row = b2.row => b1.picture = b2.picture => b1 = b2} 
fact {all b1,b2:Box | b1.col = b2.col => b1.picture = b2.picture => b1 = b2} 
fact {all b1,b2:Box | b1.subb = b2.subb => b1.picture = b2.picture => b1 = b2} 

pred Show {}
run Show
