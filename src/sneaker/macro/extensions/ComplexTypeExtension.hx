package sneaker.macro.extensions;

#if macro
using sneaker.macro.TypeMapper;

import haxe.macro.Expr;
import sneaker.types.Result;

class ComplexTypeExtension {
	/**
		@return The return type of `complexType` if it is a function. otherwise `Failed`.
	**/
	public static function getReturnType(
		complexType: ComplexType
	): Result<ComplexType, String> {
		return switch complexType {
			case TFunction(_, returnType): Ok(returnType);
			default: Failed('Not a function');
		}
	}

	/**
		Reveals the underlying type if `TNamed` (recursively).
	**/
	public static function unwrapNamed(complexType: ComplexType): ComplexType
		return complexType.mapTypes(unwrapNamedShallow);

	/**
		Reveals the underlying type if `TNamed` (not recursively).
	**/
	public static function unwrapNamedShallow(complexType: ComplexType): ComplexType {
		return switch complexType {
			case TNamed(_, underlyingType): underlyingType;
			default: complexType;
		}
	}
}
#end
