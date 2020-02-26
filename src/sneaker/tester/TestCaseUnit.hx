package sneaker.tester;

@:structInit
class TestCaseUnit {
	public static final empty = new TestCaseUnit("dummy", ()->{}, Empty);

	public final description:String;
	public final run:()->Void;
	public final type:TestCaseType;

	public function new(description:String, run:()->Void, type:TestCaseType) {
		this.description = description;
		this.run = run;
		this.type = type;
	}
}
