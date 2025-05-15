/* Magic Square Model with enumerated valid combinations */
// Define the numbers we can use
abstract sig Number {}
one sig N1, N2, N3, N4, N5, N6, N7, N8, N9 extends Number {}

// Define grid positions
sig Position {}
one sig P11, P12, P13, P21, P22, P23, P31, P32, P33 extends Position {}

// Define a relation mapping positions to numbers
one sig Grid {
  cells: Position -> one Number
}

// Center is 5
fact CenterIsFive {
  Grid.cells[P22] = N5
}

// Uniqueness constraint: each number appears exactly once
fact UniqueNumbers {
  // Each number is used once
  all n: Number | one p: Position | p -> n in Grid.cells
}

// Magic square property by enumerating valid combinations
fact ValidSums {
  // Row 1 valid combinations (sum to 15)
  (Grid.cells[P11] = N8 and Grid.cells[P12] = N1 and Grid.cells[P13] = N6) or
  (Grid.cells[P11] = N6 and Grid.cells[P12] = N1 and Grid.cells[P13] = N8) or
  (Grid.cells[P11] = N8 and Grid.cells[P12] = N3 and Grid.cells[P13] = N4) or
  (Grid.cells[P11] = N4 and Grid.cells[P12] = N3 and Grid.cells[P13] = N8) or
  (Grid.cells[P11] = N2 and Grid.cells[P12] = N7 and Grid.cells[P13] = N6) or
  (Grid.cells[P11] = N6 and Grid.cells[P12] = N7 and Grid.cells[P13] = N2) or
  (Grid.cells[P11] = N2 and Grid.cells[P12] = N9 and Grid.cells[P13] = N4) or
  (Grid.cells[P11] = N4 and Grid.cells[P12] = N9 and Grid.cells[P13] = N2)

  // Row 2 valid combinations (sum to 15)
  and ((Grid.cells[P21] = N3 and Grid.cells[P22] = N5 and Grid.cells[P23] = N7) or
  (Grid.cells[P21] = N7 and Grid.cells[P22] = N5 and Grid.cells[P23] = N3) or
  (Grid.cells[P21] = N1 and Grid.cells[P22] = N5 and Grid.cells[P23] = N9) or
  (Grid.cells[P21] = N9 and Grid.cells[P22] = N5 and Grid.cells[P23] = N1))

  // Row 3 valid combinations (sum to 15)
  and ((Grid.cells[P31] = N4 and Grid.cells[P32] = N9 and Grid.cells[P33] = N2) or
  (Grid.cells[P31] = N2 and Grid.cells[P32] = N9 and Grid.cells[P33] = N4) or
  (Grid.cells[P31] = N6 and Grid.cells[P32] = N7 and Grid.cells[P33] = N2) or
  (Grid.cells[P31] = N2 and Grid.cells[P32] = N7 and Grid.cells[P33] = N6) or
  (Grid.cells[P31] = N8 and Grid.cells[P32] = N3 and Grid.cells[P33] = N4) or
  (Grid.cells[P31] = N4 and Grid.cells[P32] = N3 and Grid.cells[P33] = N8) or
  (Grid.cells[P31] = N8 and Grid.cells[P32] = N1 and Grid.cells[P33] = N6) or
  (Grid.cells[P31] = N6 and Grid.cells[P32] = N1 and Grid.cells[P33] = N8))

  // Column 1 valid combinations (sum to 15)
  and ((Grid.cells[P11] = N8 and Grid.cells[P21] = N3 and Grid.cells[P31] = N4) or
  (Grid.cells[P11] = N8 and Grid.cells[P21] = N1 and Grid.cells[P31] = N6) or
  (Grid.cells[P11] = N4 and Grid.cells[P21] = N3 and Grid.cells[P31] = N8) or
  (Grid.cells[P11] = N6 and Grid.cells[P21] = N1 and Grid.cells[P31] = N8) or
  (Grid.cells[P11] = N6 and Grid.cells[P21] = N7 and Grid.cells[P31] = N2) or
  (Grid.cells[P11] = N2 and Grid.cells[P21] = N7 and Grid.cells[P31] = N6) or
  (Grid.cells[P11] = N2 and Grid.cells[P21] = N9 and Grid.cells[P31] = N4) or
  (Grid.cells[P11] = N4 and Grid.cells[P21] = N9 and Grid.cells[P31] = N2))

  // Column 2 valid combinations (sum to 15)
  and ((Grid.cells[P12] = N1 and Grid.cells[P22] = N5 and Grid.cells[P32] = N9) or
  (Grid.cells[P12] = N9 and Grid.cells[P22] = N5 and Grid.cells[P32] = N1) or
  (Grid.cells[P12] = N3 and Grid.cells[P22] = N5 and Grid.cells[P32] = N7) or
  (Grid.cells[P12] = N7 and Grid.cells[P22] = N5 and Grid.cells[P32] = N3))

  // Column 3 valid combinations (sum to 15)
  and ((Grid.cells[P13] = N6 and Grid.cells[P23] = N7 and Grid.cells[P33] = N2) or
  (Grid.cells[P13] = N2 and Grid.cells[P23] = N7 and Grid.cells[P33] = N6) or
  (Grid.cells[P13] = N8 and Grid.cells[P23] = N3 and Grid.cells[P33] = N4) or
  (Grid.cells[P13] = N4 and Grid.cells[P23] = N3 and Grid.cells[P33] = N8) or
  (Grid.cells[P13] = N8 and Grid.cells[P23] = N1 and Grid.cells[P33] = N6) or
  (Grid.cells[P13] = N6 and Grid.cells[P23] = N1 and Grid.cells[P33] = N8) or
  (Grid.cells[P13] = N4 and Grid.cells[P23] = N9 and Grid.cells[P33] = N2) or
  (Grid.cells[P13] = N2 and Grid.cells[P23] = N9 and Grid.cells[P33] = N4))

  // Diagonal 1 (top-left to bottom-right) valid combinations (sum to 15)
  and ((Grid.cells[P11] = N8 and Grid.cells[P22] = N5 and Grid.cells[P33] = N2) or
  (Grid.cells[P11] = N2 and Grid.cells[P22] = N5 and Grid.cells[P33] = N8) or
  (Grid.cells[P11] = N4 and Grid.cells[P22] = N5 and Grid.cells[P33] = N6) or
  (Grid.cells[P11] = N6 and Grid.cells[P22] = N5 and Grid.cells[P33] = N4))

  // Diagonal 2 (top-right to bottom-left) valid combinations (sum to 15)
  and ((Grid.cells[P13] = N6 and Grid.cells[P22] = N5 and Grid.cells[P31] = N4) or
  (Grid.cells[P13] = N4 and Grid.cells[P22] = N5 and Grid.cells[P31] = N6) or
  (Grid.cells[P13] = N8 and Grid.cells[P22] = N5 and Grid.cells[P31] = N2) or
  (Grid.cells[P13] = N2 and Grid.cells[P22] = N5 and Grid.cells[P31] = N8))
}

run {} for 10 Int, 1 Grid, 9 Position, 9 Number
