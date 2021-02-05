module biginteger

fn test_multiply() {
	a := from_str('12345678901234567890') or { panic('') }
	b := from_str('98765432109876543210') or { panic('') }

	assert '${a * b}' == '1219326311370217952237463801111263526900'
}
