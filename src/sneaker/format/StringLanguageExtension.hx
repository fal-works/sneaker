package sneaker.format;

class StringLanguageExtension {
	/**
		Adds -s only if plural (`count != 1`).
	**/
	public static inline function formatNounPluralS(noun: String, count: Int): String {
		return if (count == 1) noun else '${noun}s';
	}

	/**
		@return Plural: `'${count} ${noun}s'`, Singular: `'${count} ${noun}'`
	**/
	public static inline function formatNounCountPluralS(
		noun: String,
		count: Int
	): String {
		return '${count} ${formatNounPluralS(noun, count)}';
	}

	/**
		Adds -es only if plural (`count != 1`).
	**/
	public static inline function formatNounPluralEs(noun: String, count: Int): String {
		return if (count == 1) noun else '${noun}es';
	}

	/**
		@return Plural: `'${count} ${noun}es'`, Singular: `'${count} ${noun}'`
	**/
	public static inline function formatNounCountPluralEs(
		noun: String,
		count: Int
	): String {
		return '${count} ${formatNounPluralEs(noun, count)}';
	}

	/**
		Adds -s only if singular (`count == 1`).
	**/
	public static inline function formatVerbSingularS(verb: String, count: Int): String {
		return if (count == 1) '${verb}s' else verb;
	}

	/**
		Adds -es only if singular (`count == 1`).
	**/
	public static inline function formatVerbSingularEs(verb: String, count: Int): String {
		return if (count == 1) '${verb}es' else verb;
	}
}
