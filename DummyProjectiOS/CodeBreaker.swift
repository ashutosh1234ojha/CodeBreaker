//
//  CodeBreaker.swift
//  DummyProjectiOS
//
//  Created by ashutosh ojha on 10/06/26.
//

import SwiftUICore

typealias Peg = Color


struct  CodeBreaker{
    var masterCode : Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegChocies :[Peg]
    init(pegChocies:[Peg]=[.red,.green,.blue,.orange]){
        self.pegChocies = pegChocies
        masterCode.randomize(from: pegChocies)
        print(masterCode)
    }
    
   mutating func attemptGuess(){
        var attempt = guess
       attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
    }
    
  mutating  func  changeGuessPeg(at index: Int){
        let exisitingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChocies.firstIndex(of : exisitingPeg){
            let newPeg = pegChocies[ (indexOfExistingPegInPegChoices+1) % pegChocies.count]
            guess.pegs[index] = newPeg
        }else{
            guess.pegs[index] = pegChocies.first ?? Code.missingPeg
        }
        
    }
}

extension Peg{
    static let missingPeg = Color.clear
}

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Peg.missingPeg, count: 4)
    
    static let missingPeg: Peg = .clear
    
    enum Kind: Equatable{
        case master
        case guess
        case attempt([Match])
        case unknown
    }
    
   mutating func randomize(from pegChoices:[Peg]){
        for index in pegChoices.indices{
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
    }
    
    var matches :[Match]?{
        switch kind{
        case .attempt(let matches) : return matches
        default: return nil
        }
    }
    
    func match(against otherCode:Code)->[Match]{
        var pegsToMatch = otherCode.pegs
        
        let backwardExactMatches = pegs.indices.reversed().map{index in
            if pegsToMatch.count>index, pegsToMatch[index]==pegs[index]{
                pegsToMatch.remove(at: index)
                return Match.exact
                
            }else{
                return .nomatch
            }
        }
        let exactMatches = Array(backwardExactMatches.reversed())
        return pegs.indices.map{index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]){
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            }else{
                return exactMatches[index]
            }
        }

        
    }
    
}

