//
//  PegChooser.swift
//  DummyProjectiOS
//
//  Created by ashutosh ojha on 05/07/26.
//

import SwiftUI

struct PegChooser: View {
    //MARK: Data in
    let choices: [Peg]
    
    //MARK: Data out func
    let onChoose: ((Peg)->Void)?
    
   //MARK: -Body

    var body: some View {
        
            HStack{
                ForEach(choices, id: \.self){peg in
                    Button{
                        onChoose?(peg)
    
                        
                    } label: {
                        PegView(peg: peg)
                    }
                }
            
        }
    }
}

//#Preview {
//    PegChooser()
//}
