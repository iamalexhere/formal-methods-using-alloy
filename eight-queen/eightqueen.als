// Define the chessboard dengan integers untuk posisi
open util/integer

// Define a Queen ditaruh di board di posisi spesifik (menggunakan integers 0-7)
sig Queen {
  row: one Int,
  col: one Int
}

// Memastikan semua posisi valid (0-7)
fact ValidPositions {
  all q: Queen | 
    q.row >= 0 and q.row <= 7 and
    q.col >= 0 and q.col <= 7
}

// Exactly 8 queens di board
fact EightQueens {
  #Queen = 8
}

// Tidak ada 2 queens yang ada di baris yang sama
fact NoSharedRows {
  all disj q1, q2: Queen | q1.row != q2.row
}

// Tidak ada 2 queens yang ada di kolom yang sama
fact NoSharedColumns {
  all disj q1, q2: Queen | q1.col != q2.col
}

// Tidak ada 2 queens yang ada di diagonal yang sama
fact NoDiagonalThreats {
  all disj q1, q2: Queen | 
    // 2 queens dikatakan memiliki diagonal yang sama jika absolute difference
    // antara baris dan kolom setara n
    // Karena Alloy tidak punya fungsi abs(), perlu di cek untuk kedua kasus:
    // Either (r1-r2) = (c1-c2) or (r1-r2) = -(c1-c2)
    q1.row.minus[q2.row] != q1.col.minus[q2.col] and
    q1.row.minus[q2.row] != q2.col.minus[q1.col]
}

run {} for 8 Queen, 8 Int
