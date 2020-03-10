package sneaker.macro;

#if macro
import haxe.macro.Type;

class TypeExtension {
	/**
		@return `true` if `type` is a class instance.
	**/
	public static function isClass(type: Type): Bool {
		return switch type {
			case TInst(typeRef, params):
				true;
			default:
				false;
		}
	}

	/**
		@return `true` if `type` is a class instance
		and its `String` representation is `name`.
	**/
	public static function isClassWithName(type: Type, name: String): Bool {
		return switch type {
			case TInst(typeRef, params):
				typeRef.toString() == name;
			default:
				false;
		}
	}
}
#end
