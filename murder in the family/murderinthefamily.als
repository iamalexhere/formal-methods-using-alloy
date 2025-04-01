// Define family members
abstract sig Person {
    role: one Role,
    gender: one Gender,
    age: one Age
}

sig Father, Mother, Son, Daughter extends Person {}

// Define roles
abstract sig Role {}
one sig Killer, Victim, Witness, Accessory extends Role {}

// Define gender
abstract sig Gender {}
one sig Male, Female extends Gender {}

// Define age ordering
abstract sig Age {}
one sig Oldest, SecondOldest, ThirdOldest, Youngest extends Age {}

// Facts tentang family structure
fact FamilyStructure {
    // Exactly one untuk masing masing family member
    #Father = 1
    #Mother = 1
    #Son = 1
    #Daughter = 1

    // Gender
    all f: Father | f.gender = Male
    all m: Mother | m.gender = Female
    all s: Son | s.gender = Male
    all d: Daughter | d.gender = Female

    // Clue 5
    // Father is the oldest
    all f: Father | f.age = Oldest
    
    // Masing masing person punya unique age
    #Oldest = 1
    #SecondOldest = 1
    #ThirdOldest = 1
    #Youngest = 1
    
    // Maisng masing role dimiliki exactly one person
    all r: Role | one p: Person | p.role = r
}

// Constraints
fact CrimeConstraints {
    // 1. The accessory and the witness were of opposite sex
    (all p: Person | p.role = Accessory implies 
        (all w: Person | w.role = Witness implies p.gender != w.gender))
    
    // 2. The oldest member and the witness were of opposite sex
    (all p: Person | p.age = Oldest implies 
        (all w: Person | w.role = Witness implies p.gender != w.gender))
    
    // 3. The youngest member and the victim were of opposite sex
    (all p: Person | p.age = Youngest implies 
        (all v: Person | v.role = Victim implies p.gender != v.gender))
    
    // 4. The accessory was older than the victim
    (all a: Person | a.role = Accessory implies 
        (all v: Person | v.role = Victim implies olderThan[a.age, v.age]))
    
    // 5. The father was the oldest member (already defined in FamilyStructure)
    
    // 6. The killer was not the youngest member
    no p: Person | p.role = Killer and p.age = Youngest
}

// Helper predicate to define age ordering
pred olderThan[a1, a2: Age] {
    (a1 = Oldest and (a2 = SecondOldest or a2 = ThirdOldest or a2 = Youngest)) or
    (a1 = SecondOldest and (a2 = ThirdOldest or a2 = Youngest)) or
    (a1 = ThirdOldest and a2 = Youngest)
}

run {
    // Additional constraint to ensure we have a valid solution
    some p: Person | p.role = Killer
} for 4 Person, 4 Role, 2 Gender, 4 Age
