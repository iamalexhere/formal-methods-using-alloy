-- Solution from lecturer
-- Trait = karakteristik yang diinginkan Mary
abstract sig Trait {}
one sig Tall, Dark, Handsome extends Trait {}

-- Empat pria yang dikenali Mary
abstract sig Man {
    traits: set Trait
}
one sig Alec, Bill, Carl, Dave extends Man {}

-- Hanya satu pria yang memiliki semua sifat: tall, dark, dan handsome
pred onlyOneIdealMan() {
    one m: Man | 
        Tall in m.traits and
        Dark in m.traits and
        Handsome in m.traits
}

-- Jumlah pria yang tall = 3, dark = 2, handsome = 1
pred traitCounts() {
    #({m: Man | Tall in m.traits}) = 3
    #({m: Man | Dark in m.traits}) = 2
    #({m: Man | Handsome in m.traits}) = 1
}

-- Setiap pria memiliki setidaknya satu dari ketiga sifat
pred everyManHasOneTrait() {
    all m: Man | some m.traits
}

-- Alec dan Bill memiliki complexion (dark/light) yang sama
pred alecBillSameComplexion() {
    (Dark in Alec.traits) iff (Dark in Bill.traits)
}

-- Bill dan Carl memiliki tinggi yang sama
pred billCarlSameHeight() {
    (Tall in Bill.traits) iff (Tall in Carl.traits)
}

-- Carl dan Dave tidak boleh dua-duanya tall
pred carlDaveNotBothTall() {
    not (Tall in Carl.traits and Tall in Dave.traits)
}

-- Gabungan semua constraint
pred allConstraints() {
    onlyOneIdealMan[]
    traitCounts[]
    everyManHasOneTrait[]
    alecBillSameComplexion[]
    billCarlSameHeight[]
    carlDaveNotBothTall[]
}

-- Eksekusi model
run allConstraints for 4
