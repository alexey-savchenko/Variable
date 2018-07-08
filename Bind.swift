infix operator <*>
func <*><Value, Binder: Bindable>(lhs: Variable<Value>, rhs: Binder) where Binder.T == Value {
	lhs.subscribe(rhs.bind)
}
