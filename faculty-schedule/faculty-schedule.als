/*
 * Model untuk sistem penjadwalan mata kuliah fakultas
 * Mencakup dosen, mata kuliah, slot waktu, dan ruang kelas
 * dengan batasan untuk menghindari konflik penjadwalan
 */

// Signature Dosen
sig Dosen {}

// Signature MataKuliah dengan relasi ke dosen
sig MataKuliah {
    diampuOleh: one Dosen,  // Setiap mata kuliah diampu oleh satu dosen
    jadwal: one Waktu,      // Setiap mata kuliah dijadwalkan pada satu slot waktu
    kelas: one Ruang        // Setiap mata kuliah ditugaskan ke satu ruang kelas
}

// Signature Waktu (slot waktu)
sig Waktu {}

// Signature Ruang (kelas)
sig Ruang {}

// Facts untuk membatasi model

// Setiap mata kuliah hanya dapat dijadwalkan sekali per minggu
// (Ini secara implisit ditangani oleh multiplisitas one dalam relasi)

// Tidak ada konflik penjadwalan
fact NoConflicts {
    // Tidak boleh ada dua mata kuliah yang menempati ruang yang sama pada waktu yang sama
    all disj mk1, mk2: MataKuliah |
        (mk1.jadwal = mk2.jadwal and mk1.kelas = mk2.kelas) implies mk1 = mk2

    // Seorang dosen tidak dapat mengajar dua mata kuliah pada waktu yang sama
    all disj mk1, mk2: MataKuliah |
        (mk1.jadwal = mk2.jadwal and mk1.diampuOleh = mk2.diampuOleh) implies mk1 = mk2
}

// Setiap dosen dapat mengajar maksimal 2 mata kuliah
fact MaxCoursesPerProfessor {
    all d: Dosen | #{mk: MataKuliah | mk.diampuOleh = d} <= 2
}

// Predicate untuk menghasilkan jadwal yang valid
pred jadwalValid {
    // Minimal ada satu MataKuliah
    some MataKuliah

    // Minimal ada satu Dosen
    some Dosen

    // Minimal ada satu Waktu (slot waktu)
    some Waktu

    // Minimal ada satu Ruang (kelas)
    some Ruang
}

// Assertions untuk memverifikasi model

// Asumsikan bahwa tidak ada konflik dosen
assert noConflictDosen {
    no disj mk1, mk2: MataKuliah |
        mk1.jadwal = mk2.jadwal and mk1.diampuOleh = mk2.diampuOleh
}

// Asumsikan bahwa tidak ada konflik ruang kelas
assert noConflictRuang {
    no disj mk1, mk2: MataKuliah |
        mk1.jadwal = mk2.jadwal and mk1.kelas = mk2.kelas
}

// Run model untuk menemukan jadwal yang valid
run jadwalValid for 4 but exactly 3 Dosen, exactly 5 MataKuliah, exactly 4 Waktu, exactly 3 Ruang

// Check assertions
check noConflictDosen for 4
check noConflictRuang for 4
