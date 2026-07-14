//
//  CodeView.swift
//  DummyProjectiOS
//
//  Created by ashutosh ojha on 05/07/26.
//
import SwiftUI


struct CodeView<AncillaryView>:View where AncillaryView :View{
    
//MARK: Data  in
    let code: Code
    
    //MARK: Data shared with me
   @Binding  var selection:Int
    
   @ViewBuilder let ancillaryView: ()-> AncillaryView
    
    init(code: Code,
         selection: Binding<Int> = Binding<Int>.constant(-1),
         @ViewBuilder ancillaryView: @escaping () -> AncillaryView = {EmptyView()}){
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    //MARK: -Body
    
    var body: some View {
        
        HStack{
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
            
            Rectangle().foregroundStyle(Color.clear).aspectRatio(1,contentMode:.fit).overlay{
                ancillaryView()
          
            }
            
            
            
        }
    }
        
    
    }
    
  fileprivate  struct Selection{
        static let cornerRadius:CGFloat = 10
        static let color:Color = Color.gray(0.85)
        static let shape = RoundedRectangle(cornerRadius: cornerRadius)

    }


