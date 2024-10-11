
import Foundation

extension Array where Element: Equatable {

    /// Удаление существующего элемента из массива.
    /// - Parameter element: Элемент, реализующий протокол Equtable.
    /// - Returns: Возвращает удаленный элемент из массива в случае, если он находился в нем.
    /// Если элемент не был найден в массиве, то возвращает nil.
    @discardableResult
    mutating func remove(element: Element) -> Element? {
        guard let removedIndex = firstIndex(where: { $0 == element }) else { return nil }
        
        return remove(at: removedIndex)
    }
    
    /// Замена/добавление элемента в массив.
    /// - Parameter element: Элемент, реализующий протокол Equtable.
    mutating func put(element: Element) {
        if let replacedIndex = firstIndex(where: { $0 == element }) {
            self[replacedIndex] = element
        } else {
            append(element)
        }
    }
}
