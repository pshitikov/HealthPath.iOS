
import SwiftUI

@Observable
open class StateMachine<State, Event>: NSObject, StateMachineProtocol where State: Equatable {
    
    // MARK: - Properties
    
    public private(set) var state: State {
        willSet { leaveState(state) }
        
        didSet {
            enterState(state)
            handleStateUpdate(oldValue, new: state)
        }
    }
    
    // MARK: - Initialization
    
    public init(_ initialState: State) { state = initialState }
    
    // MARK: - Open functions
    
    open func handleEvent(_ event: Event) -> State? { fatalError("Override handleEvent(_:)") }
    
    open func handleStateUpdate(_ oldState: State, new newState: State) {} // swiftlint:disable:this no_empty_block
    
    open func send(event: Event) {
        guard let state = handleEvent(event) else { return }
        
        self.state = state
    }
    
    open func leaveState(_ state: State) {} // swiftlint:disable:this no_empty_block
    open func enterState(_ state: State) {} // swiftlint:disable:this no_empty_block
}
