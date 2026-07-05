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
            pegChooser
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
    
    var pegChooser: some View {
        HStack{
            ForEach(game.pegChocies, id: \.self){peg in
                Button{
                    game.setGuessPeg(peg, at: selection)
                    
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
    
    
    func view(for code:Code) -> some View {
            HStack{
                ForEach(code.pegs.indices,id:\.self){index in
               
                  PegView(peg: code.pegs[index])
                        .background{
                            if selection == index, code.kind == .guess{
                                RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.gray(0.85))
                            }
                        }
                        .onTapGesture {
                        if code.kind ==  .guess{
                           selection = index
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



extension Color {
    static func gray (_ brighness: CGFloat )->Color{
        return Color(hue: 148/360, saturation: 0,brightness: brighness)
    }
}



#Preview {
    CodeBreakerView()
}
