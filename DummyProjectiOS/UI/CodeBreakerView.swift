//
//  CodeBreakerView.swift
//  DummyProjectiOS
//
//  Created by ashutosh ojha on 25/05/26.
//

import SwiftUI

struct CodeBreakerView: View {
    //MARK: Data owned by me
    @State  var game = CodeBreaker(pegChocies: [.brown,.yellow,.orange,.black,.green])
    @State private var selection:Int = 0

    //MARK: -Body
    
    var body: some View {
        
        VStack {
            
            CodeView(code: game.masterCode,ancillaryView: {Text("0:03").font(.title)})
            ScrollView{
                if !game.isOver
                {
                    CodeView(code: game.guess,selection: $selection){guessButton}
                }
                    
                ForEach(game.attempts.reversed().indices,id:\.self){index in
                    CodeView(code: game.attempts[index]){
                        if let matches = game.attempts[index].matches{
                            MatchMarkers(matches: matches)
                        }
                    }
                    
                }
            }
            PegChooser(choices: game.pegChocies, onChoose: {peg in
                game.setGuessPeg(peg, at: selection)
                selection =  (selection+1) % game.masterCode.pegs.count
            }).padding()
        }.padding()
        
    }
    
    
    var guessButton: some View {
        Button("Guess"){
            withAnimation{
                game.attemptGuess()
                selection = 0
            }
            
        }.font(.system(size:GuessButton.maxFontSize))
            .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
    
    struct GuessButton{
        static let minFontSize:CGFloat = 8
        static let maxFontSize:CGFloat = 80
        static let scaleFactor:CGFloat = minFontSize/maxFontSize
    }
    
   
}



extension Color {
    static func gray (_ brighness: CGFloat )->Color{
        return Color(hue: 148/360, saturation: 0,brightness: brighness)
    }
}



#Preview {
    CodeBreakerView()
}
