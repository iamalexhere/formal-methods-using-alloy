abstract sig Symbol {}
one sig Ladybug, Bee, Snail, Butterfly extends Symbol {}

abstract sig Row {}
one sig R1, R2, R3, R4 extends Row {}

abstract sig Col {}
one sig C1, C2, C3, C4 extends Col {}

sig Cell {
    row: one Row,
    col: one Col,
    symbol: one Symbol
}

pred validSudoku() {
    -- Satu cell untuk setiap kombinasi (row, col)
    all r: Row, c: Col |
        one cell: Cell | cell.row = r and cell.col = c

    -- Simbol unik di setiap baris
    all r: Row, s: Symbol |
        lone cell: Cell | cell.row = r and cell.symbol = s

    -- Simbol unik di setiap kolom
    all c: Col, s: Symbol |
        lone cell: Cell | cell.col = c and cell.symbol = s
}

pred clues() {
    some cell: Cell | cell.row = R1 and cell.col = C2 and cell.symbol = Ladybug
    some cell: Cell | cell.row = R1 and cell.col = C3 and cell.symbol = Bee
    some cell: Cell | cell.row = R2 and cell.col = C1 and cell.symbol = Ladybug
    some cell: Cell | cell.row = R2 and cell.col = C2 and cell.symbol = Snail
    some cell: Cell | cell.row = R2 and cell.col = C3 and cell.symbol = Butterfly
    some cell: Cell | cell.row = R3 and cell.col = C1 and cell.symbol = Butterfly
    some cell: Cell | cell.row = R4 and cell.col = C1 and cell.symbol = Bee
    some cell: Cell | cell.row = R4 and cell.col = C3 and cell.symbol = Snail
}

run { validSudoku[] and clues[] } for 16 Cell
