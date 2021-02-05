module biginteger

import os

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
			// a_pos >= b_pos
			// Within u64 range
			if a_pos.bits.len <= 2 {
				a_u64 := a_pos.u64()
				b_u64 := b_pos.u64()

				quotient = from_u64(a_u64 / b_u64)
				remainder = from_u64(a_u64 % b_u64)
			} else {
				remainder = a_pos
				quotient = one.clone()
				mut to_minus := b_pos.clone()
				for step in biginteger.shift_steps {
					for {
						mut is_in_place_shift_safe := false
						// mut is_in_place_shift_safe_path := 0
						remainder_len := remainder.bits.len
						to_minus_len := to_minus.bits.len
						if remainder_len > to_minus_len + 1 {
							is_in_place_shift_safe = true
							// is_in_place_shift_safe_path = 1
						} else if step < 32 {
							if remainder_len == to_minus_len + 1 {
								if (remainder.bits.last() >> step) > 0 {
									is_in_place_shift_safe = true
									// is_in_place_shift_safe_path = 2
								} else {
									remainer_msb := u64(remainder.bits[remainder_len - 2]) >> step
									to_minus_msb := u64(to_minus.bits.last())
									if remainer_msb > to_minus_msb {
										is_in_place_shift_safe = true
										// is_in_place_shift_safe_path = 3
									} else if remainer_msb < to_minus_msb {
										break
									}
								}
							} else if remainder_len == to_minus_len {
								remainer_msb := u64(remainder.bits.last()) >> step
								to_minus_msb := u64(to_minus.bits.last())
								if remainer_msb > to_minus_msb {
									is_in_place_shift_safe = true
									// is_in_place_shift_safe_path = 4
								} else if remainer_msb < to_minus_msb {
									break
								}
							} else {
								break
							}
						} else if step == 32 {
							if remainder_len == to_minus_len + 1 {
								remainer_msb := u64(remainder.bits[remainder_len - 1])
								to_minus_msb := u64(to_minus.bits.last())
								if remainer_msb > to_minus_msb {
									is_in_place_shift_safe = true
									// is_in_place_shift_safe_path = 5
								} else if remainer_msb < to_minus_msb {
									break
								}
							} else {
								break
							}
						}

						if is_in_place_shift_safe {
							// println('1:to_minus:$to_minus,$to_minus.bits,step:$step')
							// to_minus_str := to_minus.str()
							// to_minus_bits_str := to_minus.bits.str()
							to_minus.lshift_inner_in_place(step)
							// os.input('2:to_minus:$to_minus,$to_minus.bits,step:$step')
							// if to_minus > remainder {
							// 	os.input('\n3:\nto_minus:$to_minus_str,$to_minus_bits_str\nto_minus:$to_minus,$to_minus.bits\nremainder:$remainder,$remainder.bits\nstep:$step,path:$is_in_place_shift_safe_path')
							// }
						} else {
							to_minus_tmp := to_minus.lshift(step)
							if to_minus_tmp > remainder {
								break
							}
							to_minus = to_minus_tmp
						}

						quotient.lshift_inner_in_place(step)
					}
				}

				remainder = remainder - to_minus
				for cmp(remainder, b_pos) >= 0 {
					remainder = remainder - b_pos
					quotient = quotient + one
				}
			}
		}

		if negative {
			remainder = remainder.negative()
		}
		if quotient == zero && remainder == zero {
			os.input('7: q:$quotient, r:$remainder')
		}
		return quotient, remainder
	}
}
