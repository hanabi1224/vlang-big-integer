module biginteger

fn test_zero() {
	n := from_i64(0)
	assert n.str() == '0'
}

fn test_pos() {
	n := from_i64(8)
	assert n.str() == '8'
}

fn test_neg() {
	n := from_i64(-8)
	assert n.str() == '-8'
}
