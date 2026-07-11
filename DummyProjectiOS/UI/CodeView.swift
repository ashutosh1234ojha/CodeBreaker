//
//  CodeView.swift
//  DummyProjectiOS
//
//  Created by ashutosh ojha on 05/07/26.
//
import SwiftUI


struct CodeView:View{
    
//MARK: Data  in
    let code: Code
    
    //MARK: Data shared with me
   @Binding  var selection:Int 
    
    //MARK: -Body
    
    var body: some View {
        ForEach(code.pegs.indices,id:\.self){index in
       
          PegView(peg: code.pegs[index])
                .background{
                    if selection == index, code.kind == .guess{
                        Selection.shape.foregroundStyle(Selection.color)
                    }
                }
                .overlay(Selection.shape.foregroundStyle(code.isHidden ? Color.gray : .clear))
                .onTapGesture {
                if code.kind ==  .guess{
                   selection = index
                }
            }
    }
    }
    
    struct Selection{
        static let cornerRadius:CGFloat = 10
        static let color:Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)

    }

}
