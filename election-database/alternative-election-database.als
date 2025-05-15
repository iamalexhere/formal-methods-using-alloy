// answer from lecturer
/*
The database must provide the following functions:
register : registers a person in the database.
check : checks whether a person has been registered in the database.
number : returns the number of the people currently registered in the database.
*/

sig Database {voter: set Person}
sig Person{}


one sig p1,p2,p3 extends Person{}

pred init{
     p1 in Database.voter && p2 in Database.voter && not p3 in Database.voter
}
run init for 1

fun number : Int {
    #Database.voter
}

fun isReg (p:Person) : Int{
     #(Database.voter & p)
}

pred register(d, d':Database, p:Person){
    all p1:Person | p1 == p && not p1 in d.voter => d'.voter = d.voter+p
}

pred showRegister(d, d':Database){
     #d.voter = 2
     p1 in d.voter && p2 in d.voter && not p3 in d.voter
     register[d, d',p3]
}
run showRegister  for 1 but 2 Database

pred Show(){}
run Show for 1
