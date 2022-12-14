//
//  ContentView.swift
//  MultipleImagesDummy
//
//  Created by sonusingh on 14/12/22.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .pink, .green, .purple]
    @State var offset: CGFloat = 0
    
    var body: some View {
        ScrollView(.init()){
            TabView{
                ForEach(colors.indices,id: \.self){ index in
                    if index == 0{
                        ImageView()
                            .overlay(
                                GeometryReader{proxy -> Color in
                                    
                                    let minX = proxy.frame(in: .global).minX
//                                    print("Next is Index")
//                                    print(index)
                                    print("Next is minX")
                                    print(minX)
                                    DispatchQueue.main.async {
                                        withAnimation(.default){
                                            self.offset = -minX
                                        }
                                    }
                                    
                                    return Color.clear
                                }
                                    .frame(width: 0, height: 0)
                                ,alignment: .leading
                            )
                    }
                    else{
                        EmptyView()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(
                
                //Indicators
                HStack(spacing: 15){
                    ForEach(colors.indices,id: \.self){ index in
                        Capsule()
                            .fill(Color.white)
                            .frame(width: getIndex() == index ? 20 : 7, height: 7)
                    }
                }
                //                //Smooth sliding effect
                //                    .overlay(
                //                        Capsule()
                //                            .fill(Color.white)
                //                            .frame(width: 20, height: 7)
                //                            .offset(x: getOffset())
                //                    )
                    .padding(.bottom, 10)
                
                ,alignment: .bottom
            )
        }
        .ignoresSafeArea()
        .frame(height: 220)
    }
    
    func getIndex() -> Int {
        let index = Int(round(Double(offset / getWidth())))
        print("getIndexFunction")
        print(index)
        return index
    }
    
    // Get offset for Capsule
    func getOffset() -> CGFloat {
        // spacing = 15
        // Circle width = 7
        // so total = 15+7 = 22
        
        let progress = offset / getWidth()
        
        return 22 * progress
    }
}

extension View {
    func getWidth() -> CGFloat {
        //print(UIScreen.main.bounds.width)
        //393
        return UIScreen.main.bounds.width
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
