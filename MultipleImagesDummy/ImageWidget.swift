//
//  ImageWidget.swift
//  MultipleImagesDummy
//
//  Created by sonusingh on 14/12/22.
//

import SwiftUI

struct ImageView: View {
    @State var offset: CGSize = .zero
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            let imageSize = size.width * 0.7
            VStack{
                Image("Mac")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize)
            }
        }
        .rotation3DEffect(offset2Angle(true), axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(offset2Angle(), axis: (x: 0, y: 1, z: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .gesture(
        DragGesture()
            .onChanged({ value in
                offset = value.translation
            })
                .onEnded({ _ in
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.32, blendDuration:  0.32)){
                        offset = .zero
                    }
                })
        )
    }
    
    func offset2Angle(_ isVertical: Bool = false) -> Angle{
        return .init(degrees: 0)
    }
}
