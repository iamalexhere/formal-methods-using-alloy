// Define Family Members
abstract sig Person {
    skill: one Skill,
    gender: one Gender,
    age: one Age,
    twin: lone Person
}

sig MrScott, Sister, Son, Daughter extends Person {}

// Define Tingkat Skill Best to Worst
abstract sig Skill {}
one sig Best, SecondBest, ThirdBest, Worst extends Skill {}

// Define Gender
abstract sig Gender {}
one sig Male, Female extends Gender {}

// Define Age
abstract sig Age {}
one sig Adult, Child extends Age {}

// Facts tentang family structure
fact FamilyStructure {
    // Exactly one untuk masing masing family member
    #MrScott = 1
    #Sister = 1
    #Son = 1
    #Daughter = 1

    // Gender
    all m: MrScott | m.gender = Male
    all s: Sister | s.gender = Female
    all son: Son | son.gender = Male
    all d: Daughter | d.gender = Female

    // Age
    // Asumsi bahwa
    // Age MrScott dan Sister sama
    all m: MrScott | m.age = Adult
    all s: Sister | s.age = Adult
    // dan Age Son dan Daughter sama
    all son: Son | son.age = Child
    all d: Daughter | d.age = Child

    // Masing masing tingkat skill untuk masing masing person
    all s: Skill | one p: Person | p.skill = s
    
    // Relasi twin simetris
    all p1, p2: Person | p1.twin = p2 implies p2.twin = p1
    
    // A person hanya boleh punya 1 twin
    all p: Person | lone p.twin
    
    // Twins harus memiliki umur yang sama
    all p1, p2: Person | p1.twin = p2 implies p1.age = p2.age
}

// Constraints dari problem
fact TennisConstraints {
    // 1. The best player's twin and the worst player are of opposite sex
    all p: Person | p.skill = Best implies 
        (some p.twin and p.twin.gender != (Person & skill.Worst).gender)
    
    // 2. The best player and the worst player are the same age
    all p1, p2: Person | p1.skill = Best and p2.skill = Worst implies p1.age = p2.age
}

run {
    // Additional constraint untuk solusi yang valid
    some p: Person | p.skill = Best
    
    // Memastikan ada setidaknya satu pasangan twin
    some p1, p2: Person | p1 != p2 and p1.twin = p2
} for 4 Person, 4 Skill, 2 Gender, 2 Age
