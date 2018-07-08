import Foundation

class Variable<E> {
	
	typealias Observer = (E) -> Void
	
	/// Empty initializer
	private init() {
	}
	
	/// Initializes Variable with a value of type E
	///
	/// - Parameter value: Value to store.
	init(value: E) {
		self._value = value
	}
	
	deinit {
		print("\(self) dealloc")
	}
	
	// MARK: - Properties
	private var _value: E!
	private var observers = [Observer]()
	
	func value() throws -> E {
		if let val = _value {
			return val
		} else {
			throw Error(value: "No value!")
		}
	}
	
	/// Sets new value and notified all observers
	///
	/// - Parameter newValue: New value to set.
	func setValue(_ newValue: E) {
		self._value = newValue
		for obs in observers {
			obs(newValue)
		}
	}
	
	/// Subscribes an observer.
	///
	/// - Parameter obs: Observer to subscribe for updates.
	func subscribe(_ obs: @escaping Observer) {
		observers.append(obs)
	}
	
	struct Error: LocalizedError {
		let value: String
		var localizedDescription: String {
			return value
		}
	}
}

extension Variable {
	/// Transforms elements of original sequence and projects them to another sequence
	///
	/// - Parameter transform: Transform closure to be applied to elements
	func map<T>(_ transform: @escaping (E) -> T) -> Variable<T> {
		let newInstance = Variable<T>()
		subscribe { value in
			newInstance.setValue(transform(value))
		}
		return newInstance
	}
}
