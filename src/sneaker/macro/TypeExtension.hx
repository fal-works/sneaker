package sneaker.macro;

#if macro
import haxe.macro.Type;

class TypeExtension {
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
