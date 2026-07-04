//
//  CodeBreakerView.swift
//  DummyProjectiOS
//
//  Created by ashutosh ojha on 25/05/26.
//

import SwiftUI

struct CodeBreakerView: View {
    //MARK: Data owned by me
    @State  var game = CodeBreaker(pegChocies: [.brown,.yellow,.orange,.black])

    //MARK: -Body
    
    var body: some View {
        
        VStack {
        
            view(for: game.masterCode)
            ScrollView{
                view(for: game.guess)
                ForEach(game.attempts.reversed().indices,id:\.self){index in
                    view(for: game.attempts[index])
                    
                        }
            }
        }.padding()
        
    }
    
    var guessButton: some View {
        Button("Guess"){
            withAnimation{
                game.attemptGuess()
            }
            
        }.font(.system(size:80))
            .minimumScaleFactor(0.1)
    }
    
    
    func view(for code:Code) -> some View {
            HStack{
                ForEach(code.pegs.indices,id:\.self){index in
               
                  PegView(peg: code.pegs[index])
                        .onTapGesture {
                        if code.kind ==  .guess{
                            game.changeGuessPeg(at : index)
                        }
                    }
            }
                Rectangle().foregroundStyle(Color.clear).aspectRatio(1,contentMode:.fit).overlay{
                    if let matches = code.matches{
                        MatchMarkers(matches: matches)
                    }else{
                        if code.kind == .guess{
                            guessButton
                        }
                    }
                }
            
               
              
          
        }
    }
}





#Preview {
    CodeBreakerView()
}
