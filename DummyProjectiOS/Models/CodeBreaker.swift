//
//  CodeBreaker.swift
//  DummyProjectiOS
//
//  Created by ashutosh ojha on 10/06/26.
//

import SwiftUICore

typealias Peg = Color


struct  CodeBreaker{
    var masterCode : Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegChocies :[Peg]
    init(pegChocies:[Peg]=[.red,.green,.blue,.orange]){
        self.pegChocies = pegChocies
        masterCode.randomize(from: pegChocies)
        print(masterCode)
    }
    
    var isOver:Bool{
        attempts.last?.pegs == masterCode.pegs
    }
    
   mutating func attemptGuess(){
        var attempt = guess
       attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
       guess.reset()
       
       if isOver {
           masterCode.kind = .master(isHidden: false)
       }
    }
    
    mutating func setGuessPeg(_ peg:Peg, at index :Int){
        guard guess.pegs.indices.contains(index) else {return}
        guess.pegs[index] = peg
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



