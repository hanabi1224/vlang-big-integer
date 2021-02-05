module biginteger

pub fn (big BigInteger) int() int {
	if big.sign == .zero {
		return 0
	}

	int_val := int(big.bits[0])
	return if big.sign == .positive {
		int_val
	} else {
		-int_val
	}
}
