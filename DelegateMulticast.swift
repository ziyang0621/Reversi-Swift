//
//  DelegateMulticast.swift
//  SwiftReversi
//
//  Created by Ziyang Tan on 3/20/15.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation

class DelegateMulticast<T> {
    private var delegates = [T]()
    
    func addDelegate(delegate: T) {
        delegates.append(delegate)
    }
    
    func invokeDelegates(invocation: (T) -> ()) {
        for delegate in delegates {
            invocation(delegate)
        }
    }
}