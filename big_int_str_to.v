module biginteger

import strings

pub fn (big BigInteger) str() string {
	if big.sign == .zero {
		return '0'
	}
	// TODO: optimize init size
	mut builder := strings.new_builder(1)
	if big.sign == .negative {
		builder.write_string('-')
	}

	base := u32(10)
	mut txt := ''

	mut bits := []u64{}
	for b in big.bits {
		bits << u64(b)
	}

	mut remainder := bits[0]
	for {
		for i := bits.len - 1; i > 0; i-- {
			tmp_bits := bits[i]
			tmp_bits_mod := tmp_bits % base
			tmp_bits_remaider := tmp_bits / base
			if tmp_bits_remaider > 0 {
				bits[i] = tmp_bits_remaider
			} else {
				bits.delete_last()
			}

			if tmp_bits_mod > 0 {
				bits[i - 1] += (tmp_bits_mod << 32)
			}
		}

		d0 := bits[0]
		mod := d0 % base
		remainder = d0 / base

		if mod == 0 && remainder == 0 && bits.len == 1 {
			break
		} else {
			txt = '$mod$txt'
			bits[0] = remainder
		}
	}

	builder.write_string(txt)
	ret := builder.str()
	return ret
}
