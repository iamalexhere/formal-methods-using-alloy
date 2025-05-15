-- Solution from lecturer
sig Man { } 
one sig Alec, Bill, Carl, Dave extends Man {}
sig Chars {}
one sig Tall, Dark, Handsome extends Chars {has : set Man}
one sig Mary {loves: set Man, knows: set Man} 

-- Mary’s ideal man is tall, dark, and handsome.
fact { all m : Man | m in Mary.loves => m in Mary.knows && m in Tall.has && m in Dark.has && m in Handsome.has}

-- Mary knows four man Alec, Bill, Carl, and Dave
fact {Alec in Mary.knows && Bill in Mary.knows && Carl in Mary.knows && Dave in Mary.knows}

-- Only one of the four men has all of the characteristics Mary requires.
fact {#Mary.loves= 1}

--Only three of the men are tall, 
fact {#Tall.has = 3}

--only two are dark, and
fact {#Dark.has = 2}

--only one is handsome.
fact {#Handsome.has =1}

--Each of the four men has at least one of the required traits.
fact {all m:Man | m in Tall.has+Dark.has+Handsome.has}

-- Alec and Bill have the same complexion.
fact {Alec in Dark.has <=> Bill in Dark.has}

--Bill and Carl are the same height.
fact {Carl in Tall.has <=> Bill in Tall.has}

-- Carl and Dave are not both tall. 
fact {not (Carl in Tall.has && Dave in Tall.has)}

pred Show{}
run Show
