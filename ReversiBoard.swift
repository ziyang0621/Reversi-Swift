//
//  ReversiBoard.swift
//  SwiftReversi
//
//  Created by Ziyang Tan on 3/20/15.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation

class ReversiBoard: Board {
    private (set) var blackScore = 0, whiteScore = 0
    private (set) var nextMove = BoardCellState.White
    private (set) var gameHasFinished = false
    private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
    
    override init() {
        super.init()
    }
    
    init(board: ReversiBoard) {
        super.init(board: board)
        nextMove = board.nextMove
        blackScore = board.blackScore
        whiteScore = board.whiteScore
    }
    
    func isValidMove(location: BoardLocation) -> Bool {
        return isValidMove(location, toState: nextMove)
    }
    
    private func isValidMove(location: BoardLocation, toState: BoardCellState) -> Bool {
        if self[location] != BoardCellState.Empty {
            return false
        }
        
        for direction in MoveDirection.directions {
            if moveSurroundsSounters(location, direction: direction, toState: toState) {
                return true
            }
        }
        return false
    }
    
    private func flipOpponentsCounter(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) {
        if !moveSurroundsSounters(location, direction: direction, toState: toState) {
            return
        }
        
        let opponentsState = toState.invert()
        var currentState = BoardCellState.Empty
        var currentLocation = location
        
        do {
            currentLocation = direction.move(currentLocation)
            currentState = self[currentLocation]
            self[currentLocation] = toState
        } while (isWithinBounds(currentLocation) && currentState == opponentsState)
    }
    
    private func checkIfGameHasFinished() -> Bool {
        return !canPlayerMakeMove(BoardCellState.Black) && !canPlayerMakeMove(BoardCellState.White)
    }
    
    private func canPlayerMakeMove(toState: BoardCellState) -> Bool {
        return anyCellsMatchCondition{ self.isValidMove($0, toState: toState) }
    }
    
    func makeMove(location: BoardLocation) {
        self[location] = nextMove
        
        for direction in MoveDirection.directions {
            flipOpponentsCounter(location, direction: direction, toState: nextMove)
        }
        
        switchTurns()
        
        gameHasFinished = checkIfGameHasFinished()
        
        whiteScore = countMatches{ self[$0] == BoardCellState.White }
        blackScore = countMatches{ self[$0] == BoardCellState.Black }
        
        reversiBoardDelegates.invokeDelegates{ $0.boardStateChanged() }
    }
    
    func switchTurns() {
        var intendedNextMove = nextMove.invert()
        
        if canPlayerMakeMove(intendedNextMove) {
            nextMove = intendedNextMove
        }
    }

    
    func setInitialState() {
        clearBoard()
        
        super[3, 3] = .White
        super[4, 4] = .White
        super[3, 4] = .Black
        super[4, 3] = .Black
        
        blackScore = 2
        whiteScore = 2
    }
    
    func moveSurroundsSounters(location:BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool {
        var index = 1
        var currentLocation = direction.move(location)
        
        while isWithinBounds(currentLocation) {
            let currentState = self[currentLocation]
            if index == 1 {
                if currentState != toState.invert() {
                    return false
                }
            } else {
                if currentState == toState {
                    return true
                }
            
                if currentState == BoardCellState.Empty {
                    return false
                }
            }
            
            index++
            
            currentLocation = direction.move(currentLocation)
        }
        return false
    }
    
    
    func addDelegate(delegate: ReversiBoardDelegate) {
        reversiBoardDelegates.addDelegate(delegate)
    }
}