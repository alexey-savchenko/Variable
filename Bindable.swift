import UIKit

protocol Bindable {
	associatedtype T
	func bind(_ value: T)
}

extension UILabel: Bindable {
	typealias T = String
	func bind(_ value: String) {
		text = value
	}
}
