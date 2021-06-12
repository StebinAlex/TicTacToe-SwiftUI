//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by LTS on 06/06/21.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    var changingIndex: Int = -1
    
    func processPlayerMove(for position: Int) {
        if isSquareOccupied(in: moves, index: position) { return }
        changingIndex = position
        
        moves[position] = Move(player: .human, boardIndex: position)
        
        if checkWinCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameboardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  { [self] in
            let computerMovePosition = determineComputerMovePosition(in: moves)
            changingIndex = computerMovePosition
            
            moves[computerMovePosition] = Move(player: .computer, boardIndex: computerMovePosition)
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
            
            isGameboardDisabled = false
        }
    }
    
    func isSquareOccupied(in moves: [Move?], index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index } )
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, index: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, index: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        let centerSquare = 4
        if !isSquareOccupied(in: moves, index: centerSquare) {
            return centerSquare
        }
        
        
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, index: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap {$0}.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameboardDisabled = false
    }
}
