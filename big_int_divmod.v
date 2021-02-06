module biginteger

pub fn (a BigInteger) / (b BigInteger) BigInteger {
	quotient, _ := div_mod(a, b) or { return zero }
	return quotient
}

pub fn (a BigInteger) % (b BigInteger) BigInteger {
	_, remainder := div_mod(a, b) or { return zero }
	return remainder
}

pub fn div_mod(a BigInteger, b BigInteger) ?(BigInteger, BigInteger) {
	if b.sign == .zero {
		error('Divided by zero')
	} else if a.sign == .zero {
		return zero, zero
	}

	if a.sign != b.sign {
		if a.sign == .negative {
			quotient, remainder := div_mod(a.negative(), b) ?
			return quotient.negative(), remainder.negative()
		} else {
			quotient, remainder := div_mod(a, b.negative()) ?
			return quotient.negative(), remainder
		}
	}

	negative := a.sign == .negative
	a_pos := if negative { a.negative() } else { a }
	b_pos := if negative { b.negative() } else { b }

	mut quotient := zero
	mut remainder := zero

	quotient, remainder = div_mod_inner(a_pos, b_pos)

	if negative {
		remainder = remainder.negative()
	}

	return quotient, remainder
}

fn div_mod_inner(a_pos BigInteger, b_pos BigInteger) (BigInteger, BigInteger) {
	if a_pos == b_pos {
		return one, zero
	} else if a_pos < b_pos {
		return zero, a_pos
	} else {
		return div_mod_inner_core(a_pos, b_pos)
	}
}

[inline]
fn div_mod_inner_core(a_pos BigInteger, b_pos BigInteger) (BigInteger, BigInteger) {
	mut quotient := zero
	mut remainder := zero

	leading_zeros_a := a_pos.leading_zeros()
	leading_zeros_b := b_pos.leading_zeros()

	remainder = a_pos
	mut q_shift := u64(remainder.bits.len - b_pos.bits.len)

	mut q_shift_bits := (32 * q_shift) + leading_zeros_b - leading_zeros_a
	if q_shift_bits > 1 {
		q_shift_bits = q_shift_bits - 1
		remainder = remainder - b_pos.lshift(q_shift_bits)
		quotient = one.lshift(q_shift_bits)
	}

	for cmp(remainder, b_pos) >= 0 {
		remainder = remainder - b_pos
		quotient = quotient + one
	}

	return quotient, remainder
}
