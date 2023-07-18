local module = {
	prefixes = {';', ':'}, -- * Prefixes can have multiple non-blank characters, so for example "cmd!" or "//" are both valid prefixes. Default: {";", ":"}
	argumentSeparator = ' ', -- ! This CANNOT have multiple characters. For example, "||" is an invalid argument separator. Default: " "
	stringEncloser = '"' -- ! This CANNOT have multiple characters. For example, '""' is an invalid encloser. Default: '"'
}

return module
