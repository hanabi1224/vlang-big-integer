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

pub fn (big BigInteger) u64() u64 {
	if big.sign == .zero {
		return 0
	}

	mut val := u64(big.bits[0])
	if big.bits.len > 1 {
		val = val | (big.bits[1] << 32)
	}

	return val
}
