//
//  BoardLocation.swift
//  SwiftReversi
//
//  Created by Ziyang Tan on 3/20/15.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation

struct BoardLocation: Equatable {
    let row: Int, column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
}

func == (lhs: BoardLocation, rhs: BoardLocation) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}