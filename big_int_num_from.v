module biginteger

pub fn from_i8(i i8) BigInteger {
	return from_i64(i)
}

pub fn from_int(i int) BigInteger {
	return from_i64(i)
}

pub fn from_i64(i i64) BigInteger {
	if i == 0 {
		return from_u64_and_sign(0, BigIntegerSign.zero)
	} else if i < 0 {
		return from_u64_and_sign(u64(-i), BigIntegerSign.negative)
	} else {
		return from_u64_and_sign(u64(i), BigIntegerSign.positive)
	}
}

pub fn from_u32(i u32) BigInteger {
	return from_u64(i)
}

pub fn from_u64(i u64) BigInteger {
	return from_u64_and_sign(i, BigIntegerSign.positive)
}

pub fn from_bits(bits []u32) BigInteger {
	return from_bits_and_sign(bits, .positive)
}

pub fn from_bits_and_sign(bits []u32, sign BigIntegerSign) BigInteger {
	if sign == .zero || bits.len < 1 || (bits.len == 1 && bits[0] == 0) {
		return zero
	}

	return BigInteger{
		sign: sign
		bits: bits
	}
}

fn from_u64_and_sign(i u64, sign BigIntegerSign) BigInteger {
	if i == 0 || sign == .zero {
		return zero
	}

	abs := i
	abs_top := u32(abs >> 32)
	bits := if abs_top == 0 { [u32(abs)] } else { [u32(abs), abs_top] }

	return BigInteger{
		sign: sign
		bits: bits
	}
}
