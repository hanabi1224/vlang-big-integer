module biginteger

pub fn (a BigInteger) == (b BigInteger) bool {
	if a.sign != b.sign || a.bits.len != b.bits.len {
		return false
	} else {
		for i := 0; i < a.bits.len; i++ {
			if a.bits[i] != b.bits[i] {
				return false
			}
		}
	}

	return true
}

pub fn (a BigInteger) < (b BigInteger) bool {
	return cmp(a, b) < 0
}

pub fn cmp(a BigInteger, b BigInteger) int {
	if b.sign == .positive {
		if a.sign == .positive {
			return cmp_bits(a.bits, b.bits)
		} else {
			return -1
		}
	} else {
		if a.sign == .zero && b.sign == .zero {
			return 0
		} else if a.sign == .negative {
			return cmp(b.negative(), a.negative())
		} else {
			return 1
		}
	}
}

[direct_array_access]
fn cmp_bits(a []u32, b []u32) int {
	if a.len < b.len {
		return -1
	} else if a.len > b.len {
		return 1
	} else {
		for i := a.len - 1; i >= 0; i-- {
			digit_a := a[i]
			digit_b := b[i]
			if digit_a < digit_b {
				return -1
			} else if digit_a > digit_b {
				return 1
			}
		}

		return 0
	}
}
