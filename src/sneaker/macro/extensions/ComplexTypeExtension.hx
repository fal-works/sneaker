package sneaker.macro.extensions;

#if macro
import haxe.macro.Expr;
import sneaker.types.Result;

class ComplexTypeExtension {
	/**
		@return Return type of `complexType` if it is a function. otherwise `Failed`.
	**/
	public static function getReturnType(complexType: ComplexType): Result<ComplexType, String> {
		return switch complexType {
			case TFunction(_, returnType): Ok(returnType);
			default: Failed('Not a function');
		}
	}
}
#end
