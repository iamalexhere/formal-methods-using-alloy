// Define the men
abstract sig Man {}
one sig Alec, Bill, Carl, Dave extends Man {}

// Define the traits
abstract sig Trait {}
one sig Tall, Dark, Handsome extends Trait {}

// Define which men have which traits
sig HasTrait {
  man: Man,
  trait: Trait
}

// Constraints from the puzzle
fact Constraints {
  // Only one man has all three traits
  one m: Man | all t: Trait | some ht: HasTrait | ht.man = m and ht.trait = t
  
  // Only three men are tall
  #{m: Man | some ht: HasTrait | ht.man = m and ht.trait = Tall} = 3
  
  // Only two men are dark
  #{m: Man | some ht: HasTrait | ht.man = m and ht.trait = Dark} = 2
  
  // Only one man is handsome
  #{m: Man | some ht: HasTrait | ht.man = m and ht.trait = Handsome} = 1
  
  // Each man has at least one trait
  all m: Man | some ht: HasTrait | ht.man = m
  
  // Alec and Bill have the same complexion (both dark or both not dark)
  (some ht1, ht2: HasTrait | ht1.man = Alec and ht2.man = Bill and 
                             ht1.trait = Dark and ht2.trait = Dark) or
  (no ht1, ht2: HasTrait | ht1.man = Alec and ht2.man = Bill and 
                           (ht1.trait = Dark or ht2.trait = Dark))
  
  // Bill and Carl are the same height (both tall or both not tall)
  (some ht1, ht2: HasTrait | ht1.man = Bill and ht2.man = Carl and 
                             ht1.trait = Tall and ht2.trait = Tall) or
  (no ht1, ht2: HasTrait | ht1.man = Bill and ht2.man = Carl and 
                           (ht1.trait = Tall or ht2.trait = Tall))
  
  // Carl and Dave are not both tall
  not (some ht1, ht2: HasTrait | ht1.man = Carl and ht2.man = Dave and 
                                 ht1.trait = Tall and ht2.trait = Tall)
}

// Define what makes an ideal man - having all three traits
pred isIdealMan[m: Man] {
  all t: Trait | some ht: HasTrait | ht.man = m and ht.trait = t
}

// Run the model to find a solution
run {
  some m: Man | isIdealMan[m]
} for 4 Man, 3 Trait, 9 HasTrait
