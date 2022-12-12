// AsyncOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Асинхронная операция
class AsyncOperation: Operation {
    // MARK: - Constants

    enum Constants {
        static let prefix = "is"
    }

    // MARK: - Types

    enum State: String {
        case ready, executing, finished

        fileprivate var keyPath: String {
            Constants.prefix + rawValue.capitalized
        }
    }

    // MARK: - Public Properties

    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }

    override var isAsynchronous: Bool {
        true
    }

    override var isReady: Bool {
        super.isReady && state == .ready
    }

    override var isExecuting: Bool {
        state == .executing
    }

    override var isFinished: Bool {
        state == .finished
    }

    // MARK: Public Methods

    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }

    override func cancel() {
        super.cancel()
        state = .finished
    }
}
