//
//  Command.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

final public class Command {
    private let id: String
    private let file: StaticString
    private let function: StaticString
    private let line: Int
    private let action: () -> Void

    public init(
        id: String = "unnamed",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        action: @escaping () -> Void
    ) {
        self.id = id
        self.action = action
        self.function = function
        self.file = file
        self.line = line
    }

    public func perform() {
        action()
    }

    static public var nop: Command { return Command(id: "nop") {  } }

    @objc
    func debugQuickLookObject() -> AnyObject? {
        return """
            type: \(String(describing: type(of: self)))
            id: \(id)
            file: \(file)
            function: \(function)
            line: \(line)
            """ as NSString
    }
}

final public class CommandWith<T> {
    private let id: String
    private let file: StaticString
    private let function: StaticString
    private let line: Int
    private let action: (T) -> Void

    public init(
        id: String = "unnamed",
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line,
        action: @escaping (T) -> Void
    ) {
        self.id = id
        self.action = action
        self.function = function
        self.file = file
        self.line = line
    }

    public func perform(with value: T) {
        action(value)
    }

    static public var nop: CommandWith { return CommandWith(id: "nop") { _ in } }

    @objc
    func debugQuickLookObject() -> AnyObject? {
        return """
            type: \(String(describing: type(of: self)))
            id: \(id)
            file: \(file)
            function: \(function)
            line: \(line)
            """ as NSString
    }
}


extension CommandWith: Hashable {
    public static func == (left: CommandWith, right: CommandWith) -> Bool {
        return ObjectIdentifier(left) == ObjectIdentifier(right)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
}

public extension CommandWith {
    func dispatched(on queue: DispatchQueue) -> CommandWith {
        CommandWith { value in
            Environment.timeline.schedule(on: queue) {
                self.action(value)
            }
        }
    }
}
