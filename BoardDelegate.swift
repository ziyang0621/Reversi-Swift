//
//  BoardDelegate.swift
//  SwiftReversi
//
//  Created by Ziyang Tan on 3/20/15.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation

protocol BoardDelegate {
    func cellStateChanged(location: BoardLocation)
}