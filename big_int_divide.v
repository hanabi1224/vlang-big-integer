module biginteger

const (
	shift_steps = [u64(32), 16, 8, 4, 2, 1]
)

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
	} else {
		negative := a.sign == .negative
		a_pos := if negative { a.negative() } else { a }
		b_pos := if negative { b.negative() } else { b }

		mut quotient := zero
		mut remainder := zero

		if a_pos == b_pos {
			quotient = one
			remainder = zero
		} else if a_pos < b_pos {
			quotient = zero
			remainder = a_pos
		} else {
			remainder = a_pos

			mut to_minus := b_pos
			mut quotient_guess := one

			for step in biginteger.shift_steps {
				for {
					to_minus_tmp := to_minus.lshift(step)
					if to_minus_tmp > remainder {
						break
					}
					to_minus = to_minus_tmp
					quotient_guess = quotient_guess.lshift(step)
				}
			}

			// for {
			// 	to_minus_tmp := to_minus.lshift(1)
			// 	if to_minus_tmp > remainder {
			// 		break
			// 	}
			// 	to_minus = to_minus_tmp
			// 	quotient_guess = quotient_guess.lshift(1)
			// }

			remainder = remainder - to_minus
			quotient = quotient_guess

			for cmp(remainder, b_pos) >= 0 {
				remainder = remainder - b_pos
				quotient = quotient + one
			}
		}

		if negative {
			remainder = remainder.negative()
		}

		return quotient, remainder
	}
}
