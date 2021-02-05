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
	return compare(a, b) < 0
}

pub fn compare(a BigInteger, b BigInteger) int {
	if b.sign == .positive {
		if a.sign == .positive {
			if a.bits.len < b.bits.len {
				return -1
			} else if a.bits.len > b.bits.len {
				return 1
			} else {
				for i := a.bits.len - 1; i >= 0; i-- {
					digit_a := a.bits[i]
					digit_b := b.bits[i]
					if digit_a < digit_b {
						return -1
					} else if digit_a > digit_b {
						return 1
					}
				}

				return 0
			}
		} else {
			return -1
		}
	} else {
		if a.sign == .zero && b.sign == .zero {
			return 0
		} else if a.sign == .negative {
			return compare(b.negative(), a.negative())
		} else {
			return 1
		}
	}
}
