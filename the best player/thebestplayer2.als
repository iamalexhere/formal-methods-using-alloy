-- Mr. Scott, his sister, his son, and his daughter are tennis players.
abstract sig TennisPlayer{age : one Age, twin : lone TennisPlayer}
one sig mrScott, mrScottSister, mrScottSon, mrScottDaughter extends TennisPlayer{}

-- dua gender: male dan female, setiap gender terdiri atas beberapa TennisPlayer
abstract sig Gender{}
one sig male, female extends Gender{person: set TennisPlayer}
-- Mr Scott and his Son are male, his sister and his daughter are female
fact{#male.person= 2 && mrScott in male.person && mrScottSon in male.person}
fact{#female.person = 2 && mrScottSister in female.person && mrScottDaughter in female.person}

-- empat kelompok umur
-- ada empat orang, jika semua umurnya berbeda, maka maksimal hanya 4 kelompok umur
abstract sig Age{}
sig a1, a2, a3, a4 extends Age{}
-- Umur Mr Scott tidak sama dengan umur anak-anaknya
fact {mrScott.age != mrScottSon.age && mrScott.age != mrScottDaughter.age}

-- satu pemain terbaik, satu pemain terburuk
one sig BestPlayer{person: one TennisPlayer}
one sig WorstPlayer{person: one TennisPlayer}
-- pemain terbaik tidak sama dengan pemain terburuk
fact{all x,y : TennisPlayer |  x in BestPlayer.person && y in WorstPlayer.person => x != y}
-- pemain terbaik punya saudara kembar
fact{all x : TennisPlayer | x in BestPlayer.person => #x.twin = 1}

-- jika x saudara kembar y, maka y saudara kembar x
fact{all x,y : TennisPlayer | x.twin = y <=> y.twin = x}
--  setiap pemain bukan saudara kembar dengan dirinya sendiri
fact{all x : TennisPlayer | x != x.twin}
-- saudara kembar mempunyai usia yang sama
fact{all x,y : TennisPlayer | x.twin = y => x.age = y.age}

-- mr Scott bukan saudara kembar dari anak-anaknya
fact{mrScottSon.twin != mrScott && mrScottSon.twin != mrScottSister}
-- saudara perempuan mr Scott bukan saudara kembar dari anak-anaknya
fact{mrScottDaughter.twin != mrScott && mrScottDaughter.twin != mrScottSister}

-- The best player’s twin and the worst player are of opposite sex.
fact{all x,y,z: TennisPlayer | x in BestPlayer.person && y = x.twin && z in WorstPlayer.person => y in male.person && z in female.person or y in female.person && z in male.person}
-- The best player and the worst player are the same age.
fact{all x,y: TennisPlayer | x in BestPlayer.person && y in WorstPlayer.person =>x.age = y.age}

pred show{}
run show 
