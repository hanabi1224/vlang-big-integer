module biginteger

pub fn (big BigInteger) lshift(d u64) BigInteger {
	d_q := d / 32
	d_r := d % 32
	mut result_bits := big.bits.clone()
	for _ in 0 .. d_q {
		result_bits.prepend(0)
	}
	if d_r > 0 {
		tmp_next := lshift_unsafe(mut result_bits, d_q, d_r)
		if tmp_next > 0 {
			result_bits << tmp_next
		}
	}

	return {
		sign: big.sign
		bits: result_bits
	}
}

[direct_array_access]
fn lshift_unsafe(mut result_bits []u32, q u64, r u64) u32 {
	mut tmp_next := u32(0)
	for i := q; i < result_bits.len; i++ {
		current := u64(result_bits[i])
		tmp_current := (current << r) | tmp_next
		tmp_next = u32(tmp_current >> 32)
		result_bits[i] = u32(tmp_current)
	}

	return tmp_next
}

pub fn (big BigInteger) rshift(d u64) BigInteger {
	d_q := d / 32
	d_r := d % 32
	bits_len_shift := if d_r == 0 { d_q } else { d_q + 1 }
	if big.bits.len <= bits_len_shift {
		return zero
	}

	mut result_bits := big.bits[d_q..].clone()
	if d_r > 0 {
		rshift_unsafe(mut result_bits, d_q, d_r)
	}

	trim_msb_zeros(mut result_bits)

	return {
		sign: big.sign
		bits: result_bits
	}
}

[direct_array_access]
fn rshift_unsafe(mut result_bits []u32, q u64, r u64) {
	mut tmp_next := u32(0)
	for i := result_bits.len - 1; i >= 0; i-- {
		current := result_bits[i]
		tmp_current := (current >> r) | tmp_next
		if i > 0 {
			tmp_next = u32(current << (32 - r))
		}

		result_bits[i] = u32(tmp_current)
	}
}
