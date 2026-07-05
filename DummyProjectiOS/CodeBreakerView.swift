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
            
            view(for: game.masterCode)
            ScrollView{
                view(for: game.guess)
                ForEach(game.attempts.reversed().indices,id:\.self){index in
                    view(for: game.attempts[index])
                    
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
            }
            
        }.font(.system(size:GuessButton.maxFontSize))
            .minimumScaleFactor(GuessButton.scaleFactor)
    }
    
  
    
    
    func view(for code:Code) -> some View {
            HStack{
                CodeView(code:code, selection: $selection)
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
