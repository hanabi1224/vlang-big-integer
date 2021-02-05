module biginteger

enum BigIntegerSign {
	negative
	zero
	positive
}

pub struct BigInteger {
	bits []u32
pub:
	sign BigIntegerSign
}

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

pub fn from_i8(i i8) BigInteger {
	return from_i64(i)
}

pub fn from_int(i int) BigInteger {
	return from_i64(i)
}

pub fn from_i64(i i64) BigInteger {
	sign := if i == 0 {
		BigIntegerSign.zero
	} else {
		if i < 0 { BigIntegerSign.negative } else { BigIntegerSign.positive }
	}
	abs := if i < 0 { u64(-i) } else { u64(i) }
	return from_u64_and_sign(abs, sign)
}

pub fn from_u32(i u32) BigInteger {
	return from_u64(i)
}

pub fn from_u64(i u64) BigInteger {
	return from_u64_and_sign(i, BigIntegerSign.positive)
}

fn from_u64_and_sign(i u64, sign BigIntegerSign) BigInteger {
	if i == 0 || sign == .zero {
		return zero
	}

	abs := i
	abs_top := u32(abs >> 32)
	bits := if abs_top == 0 { [u32(abs)] } else { [u32(abs), abs_top] }

	return {
		sign: sign
		bits: bits
	}
}
