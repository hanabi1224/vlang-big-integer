module biginteger

import math.bits

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
	cmp_result := cmp(a_pos, b_pos)
	if cmp_result < 0 {
		return zero, a_pos
	} else if cmp_result == 0 {
		return one, zero
	} else {
		return div_mod_inner_core(a_pos, b_pos)
	}
}

[inline]
fn div_mod_inner_core(a_pos BigInteger, b_pos BigInteger) (BigInteger, BigInteger) {
	mut quotient := zero
	leading_zeros_b := b_pos.leading_zeros()

	mut remainder_bits := a_pos.bits.clone()
	mut remainder_sign := BigIntegerSign.positive
	divider_bits := b_pos.bits
	mut cmp_bits_result := 1
	for cmp_bits_result > 0 {
		q_shift := u64(remainder_bits.len - divider_bits.len)
		mut q_shift_bits := (32 * q_shift) + leading_zeros_b - u64(bits.leading_zeros_32(remainder_bits.last()))
		if q_shift_bits < 2 {
			break
		}
		q_shift_bits = q_shift_bits - 1
		quotient = quotient + one.lshift(q_shift_bits)
		to_minus := b_pos.lshift(q_shift_bits)
		remainder_sign = sub_mut_a_b_length_desc(mut remainder_bits, to_minus.bits, false)
		if remainder_sign == BigIntegerSign.zero {
			return quotient, zero
		}

		cmp_bits_result = cmp_bits(remainder_bits, divider_bits)
	}

	for cmp_bits_result >= 0 {
		_ = sub_mut_a_b_length_desc(mut remainder_bits, divider_bits, false)
		quotient = quotient + one
		cmp_bits_result = cmp_bits(remainder_bits, divider_bits)
	}

	return quotient, from_bits(remainder_bits)
}
