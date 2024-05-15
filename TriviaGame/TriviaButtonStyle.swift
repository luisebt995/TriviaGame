//
//  TriviaButtonStyle.swift
//  TriviaGame
//
//  Created by Luis on 14/5/24.
//

import SwiftUI


//ButtonStyle for avatar selection Button
struct AvatarButtonStyle: ButtonStyle {
    var imageName : String
    @Binding var selection : String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(55)
            .foregroundColor(.white)
            .background(
                ZStack {
                    Image(imageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(30)
                        .zIndex(2)
                    Circle()
                        .fill(.white)
                        .frame(width: 70 , height: 70)
                        .zIndex(1)
                    Circle()
                        .fill(.blue)
                        .frame(width: selection == imageName ? 80 : 70 , height: selection == imageName ? 80 : 70)
                }
                    .onTapGesture {
                        selection = imageName
                    }
            )
    }
}
