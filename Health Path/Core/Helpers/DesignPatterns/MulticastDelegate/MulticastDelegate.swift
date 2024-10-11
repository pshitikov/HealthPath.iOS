
import SwiftUI

public final class MulticastDelegate<T> {
    
    // MARK: - Delegates
    
    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    // MARK: - Internal functions
    
    public func add(_ delegate: T) { delegates.add(delegate as AnyObject) }
    
    public func remove(_ delegateToRemove: T) {
        for delegate in delegates.allObjects.reversed() where delegate === delegateToRemove as AnyObject {
            delegates.remove(delegate)
        }
    }
    
    public func invoke(_ invocation: (T) -> Void) {
        for delegate in delegates.allObjects.reversed() {
            guard let delegate = delegate as? T else { return }
            
            invocation(delegate)
        }
    }
    
    public func removeAllDelegates() { delegates.removeAllObjects() }
}
