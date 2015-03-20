//
//  ReversiBoardView.swift
//  SwiftReversi
//
//  Created by Ziyang Tan on 3/20/15.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation
import UIKit

class ReversiBoardView: UIView {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implementing")
    }
    
    init(frame: CGRect, board: ReversiBoard) {
        super.init(frame: frame)
        
        let rowHeight = frame.size.height / CGFloat(board.boardSize)
        let columnWidth = frame.size.width / CGFloat(board.boardSize)
        
        board.cellVisitor {
            (location: BoardLocation) in
            let left = CGFloat(location.column) * columnWidth
            let top = CGFloat(location.row) * rowHeight
            let squareImage = CGRect(x: left, y: top, width: columnWidth, height: rowHeight)
            let square = BoardSquare(frame: squareImage, location: location, board: board)
            self.addSubview(square)
        }
    }
}