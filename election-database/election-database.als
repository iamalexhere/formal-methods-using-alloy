// Modul untuk database pemilu
module election/database

// -- Entitas Utama --

// Sig Person merepresentasikan semua orang yang mungkin ada.
sig Person {}

// Sig RegisteredVoters merepresentasikan himpunan orang yang *saat ini* terdaftar.
// Ini adalah subset dari Person ('in Person').
// Ditandai 'var' karena himpunan ini berubah (orang bisa mendaftar).
var sig RegisteredVoters in Person {}


// -- Fakta Inisial (Opsional, tapi bagus untuk asumsi awal) --
// Asumsikan database dimulai kosong.
fact InitialState {
    no RegisteredVoters
}


// -- Operasi / Fungsi Database --

// Predikat untuk mendaftarkan seseorang.
// Mengambil Person 'p' sebagai input.
// Mendeskripsikan perubahan state dari SEKARANG ke BERIKUTNYA (menggunakan prime ').
pred register [p: Person] {
    // State RegisteredVoters BERIKUTNYA adalah state SEKARANG ditambah orang 'p'.
    // Sifat union (+) pada himpunan secara otomatis menangani kasus jika 'p' sudah terdaftar
    // (himpunan tidak akan berubah jika elemen sudah ada).
    RegisteredVoters' = RegisteredVoters + p

    // Implisit: Status orang lain yang tidak sama dengan 'p' tidak berubah
    // (Alloy cenderung mencari model dengan perubahan minimal).
    // Kita bisa membuatnya eksplisit jika perlu, tapi ini biasanya cukup:
    // all other: Person - p | (other in RegisteredVoters iff other in RegisteredVoters')
}

// Predikat untuk memeriksa apakah seseorang terdaftar.
// Mengambil Person 'p' sebagai input.
// Ini adalah operasi read-only, tidak mengubah state.
// Predikat ini BERNILAI BENAR jika 'p' ada di dalam RegisteredVoters.
pred isRegistered [p: Person] {
    p in RegisteredVoters
}

// Fungsi untuk mengembalikan jumlah orang yang terdaftar.
// Tidak mengambil parameter (selain state implisit).
// Mengembalikan nilai Integer (Int).
// Ini adalah operasi read-only.
fun number []: Int {
    // Menggunakan operator kardinalitas '#' untuk menghitung jumlah elemen.
    #RegisteredVoters
}


// -- Commands (Skenario dan Pengecekan) --

// Skenario 1: Daftarkan satu orang (p1) saat database kosong.
run RegisterPerson1 {
    // Kita perlu 'some p1' karena kita tidak tahu siapa orang spesifiknya,
    // Alloy akan mencari contoh orang 'p1'.
    some p1: Person | {
        // Kondisi Awal: Pastikan DB kosong di state 0
        no RegisteredVoters
        // Tindakan: Jalankan operasi 'register' untuk p1
        // Ini akan menyebabkan transisi ke state 1
        register[p1]
    }
} for 3 Person, 2..2 steps // Scope: 3 orang, 2 state (awal & setelah register)


// Skenario 2: Daftarkan dua orang berbeda (p1, p2) secara berurutan.
run RegisterPerson1ThenPerson2 {
    some disj p1, p2: Person | { // 'disj' memastikan p1 dan p2 berbeda
        no RegisteredVoters // Mulai dari kosong (state 0)
        // Langkah 1->2: Daftarkan p1
        register[p1]
        // Langkah 2->3: Daftarkan p2 (setelah p1 didaftarkan)
        // Menggunakan ';' untuk komposisi sekuensial state
        ; // Pemisah state
        register[p2]
    }
} for 3 Person, 3..3 steps // Scope: 3 orang, 3 state (0, 1, 2)


// Pengecekan 1: Setelah mendaftarkan p1 (dari kosong), apakah p1 terdaftar?
check CheckRegisteredAfterRegister1 {
    // Untuk SEMUA kemungkinan orang p1:
    all p1: Person | {
        // JIKA kondisi awal (kosong) DAN kita mendaftarkan p1...
        (no RegisteredVoters and register[p1])
        // MAKA di state BERIKUTNYA, p1 HARUS terdaftar.
        implies (p1 in RegisteredVoters')
   }
} for 3 Person, 2..2 steps


// Pengecekan 2: Setelah mendaftarkan p1 (dari kosong), apakah jumlah pemilih = 1?
check CountIsOneAfterRegister1 {
   all p1: Person | {
        (no RegisteredVoters and register[p1])
        // MAKA di state BERIKUTNYA, jumlah pemilih HARUS 1.
        implies (#RegisteredVoters' = 1)
   }
} for 3 Person, 2..2 steps


// Pengecekan 3: Setelah mendaftarkan p1 lalu p2 (keduanya berbeda, dari kosong),
// apakah jumlah pemilih = 2 di state akhir?
check CountIsTwoAfterRegister2 {
    all disj p1, p2: Person | {
        // JIKA kita mulai kosong, daftarkan p1, LALU daftarkan p2...
        (no RegisteredVoters and register[p1] ; register[p2])
        // MAKA di state SETELAH p2 didaftarkan (state 2, atau RegisteredVoters''),
        // jumlahnya HARUS 2.
        // Untuk merujuk ke state setelah dua langkah:
        // Kita bisa menjalankan trace 3 langkah dan melihat state terakhir,
        // atau menggunakan logika temporal yang lebih canggih.
        // Cara termudah: Alloy check biasanya memeriksa invarian atau konsekuensi langsung.
        // Kita bisa merumuskan ulang: JIKA terjadi register[p1] diikuti register[p2] dari state kosong,
        // maka di state *setelah* register[p2], jumlahnya 2.
        implies (#RegisteredVoters'' = 2) // Perlu cara menangani prime ganda, atau model temporal
   }
} // Scope perlu disesuaikan, dan cara mengecek state ke-2 mungkin perlu pendekatan lain.

// Cara Pengecekan 3 yang lebih praktis dengan state:
// Jalankan `run RegisterPerson1ThenPerson2` dan periksa state terakhir secara visual
// atau buat predikat spesifik untuk state akhir.

// Contoh Predikat untuk State Akhir (setelah 2 registrasi)
pred FinalStateAfterTwoRegs {
    #RegisteredVoters = 2
}

// Cek apakah MUNGKIN mencapai state dimana ada 2 pemilih terdaftar
// setelah menjalankan skenario register 2 orang.
run CheckReachStateTwoVoters {
     some disj p1, p2: Person | {
        no RegisteredVoters
        register[p1] ; register[p2] // Lakukan dua registrasi
        // Sekarang cek apakah kondisi FinalStateAfterTwoRegs terpenuhi di state *ini* (setelah langkah kedua)
        FinalStateAfterTwoRegs // Ini akan merujuk #RegisteredVoters di state *setelah* register[p2]
     }
} for 3 Person, 3..3 steps
