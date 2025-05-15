/*
 * Model untuk pengaturan tempat duduk kafe dan pesanan minuman
 * Tiga teman (Andi, Budi, Citra) masing-masing duduk di posisi yang berbeda (kiri, tengah, kanan)
 * dan memesan minuman yang berbeda (americano, latte, cappuccino)
 */

// Signature Person untuk merepresentasikan ketiga teman
abstract sig Person {
    // Setiap orang duduk di sebuah posisi
    position: one Position,
    // Setiap orang memesan sebuah minuman
    orders: one Drink
}

// Signature ketiga teman (inherits dari Person)
one sig Andi, Budi, Citra extends Person {}

// Signature Position untuk merepresentasikan posisi tempat duduk
abstract sig Position {}
one sig Left, Middle, Right extends Position {}

// Signature Drink untuk merepresentasikan jenis minuman
abstract sig Drink {}
one sig Americano, Latte, Cappuccino extends Drink {}

// Facts untuk membatasi model

// Setiap orang duduk di posisi yang berbeda
fact DifferentPositions {
    all disj p1, p2: Person | p1.position != p2.position
}

// Setiap orang memesan minuman yang berbeda
fact DifferentDrinks {
    all disj p1, p2: Person | p1.orders != p2.orders
}

// Batasan tambahan berdasarkan pernyataan masalah
fact AdditionalConstraints {
    // Andi duduk di sebelah kiri orang yang memesan latte
    Andi.position = Left and (some p: Person | p.orders = Latte and p.position = Middle)
    or
    Andi.position = Middle and (some p: Person | p.orders = Latte and p.position = Right)

    // Budi duduk di kursi tengah
    Budi.position = Middle

    // Orang yang memesan capucino duduk di kursi paling kanan
    some p: Person | p.orders = Cappuccino and p.position = Right
}

// `Run` model untuk menemukan semua kombinasi yang mungkin
run {
    // Tidak ada batasan tambahan yang diperlukan untuk skenario dasar
} for 3
