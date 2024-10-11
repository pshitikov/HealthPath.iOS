
import SwiftUI

public protocol StateMachineProtocol {
    
    // MARK: - Associated Types
    
    associatedtype State: Equatable
    associatedtype Event
    
    // MARK: - Properties
    
    var state: State { get }
    
    // MARK: - Functions
    
    func handleStateUpdate(_ oldState: State, new newState: State)
    func handleEvent(_ event: Event) -> State?
    func send(event: Event)
    func leaveState(_ state: State)
    func enterState(_ state: State)
}
