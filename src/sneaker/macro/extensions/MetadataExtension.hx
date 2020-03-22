package sneaker.macro.extensions;

#if macro
import haxe.macro.Type;

class MetadataExtension {
	/**
		@return Metadata parameters of all entries with `metadataName`.
	**/
	public static function extractParameters(_this: MetaAccess, metadataName: String) {
		final entries = _this.extract(metadataName);
		return [for (entry in entries) {
			final parameters = entry.params;
			if (parameters == null) continue;
			for (parameter in parameters) parameter;
		}];
	}
}
#end
