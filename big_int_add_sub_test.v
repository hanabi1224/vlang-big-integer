module biginteger

fn test_add_1() {
	a := from_str('8337839423') or { panic('') }
	b := from_str('9683495887') or { panic('') }

	assert '${b + a}' == '18021335310'
}

fn test_add_2() {
	a := from_str('-8337839423') or { panic('') }
	b := from_str('9683495887') or { panic('') }

	assert '${b + a}' == '1345656464'
}

fn test_add_3() {
	a := from_str('8337839423') or { panic('') }
	b := from_str('-9683495887') or { panic('') }

	assert '${b + a}' == '-1345656464'
}

fn test_add_4() {
	a := from_str('-8337839423') or { panic('') }
	b := from_str('-9683495887') or { panic('') }

	assert '${b + a}' == '-18021335310'
}

fn test_add_5() {
	a := from_str('-8337839423') or { panic('') }
	b := from_str('8337839423') or { panic('') }

	assert '${b + a}' == '0'
}

fn test_add_6() {
	a := from_str('8337839423') or { panic('') }
	b := from_str('-8337839423') or { panic('') }

	assert '${b + a}' == '0'
}

fn test_sub_1() {
	a := from_str('8337839423') or { panic('') }
	b := from_str('9683495887') or { panic('') }

	assert '${b - a}' == '1345656464'
	assert '${a - b}' == '-1345656464'
}

fn test_sub_2() {
	a := from_str('-8337839423') or { panic('') }
	b := from_str('-9683495887') or { panic('') }

	assert '${b - a}' == '-1345656464'
	assert '${a - b}' == '1345656464'
}

fn test_sub_3() {
	a := from_str('-8337839423') or { panic('') }
	b := from_str('9683495887') or { panic('') }

	assert '${b - a}' == '18021335310'
	assert '${a - b}' == '-18021335310'
}

fn test_sub_4() {
	a := from_str('-8337839423') or { panic('') }
	b := from_str('-8337839423') or { panic('') }

	assert '${b - a}' == '0'
	assert '${a - b}' == '0'
}

fn test_sub_5() {
	a := from_str('8337839423') or { panic('') }
	b := from_str('8337839423') or { panic('') }

	assert '${b - a}' == '0'
	assert '${a - b}' == '0'
}
