//
//  TriviaButtonStyle.swift
//  TriviaGame
//
//  Created by Luis on 14/5/24.
//

import SwiftUI


//ButtonStyle for avatar selection Button
struct AvatarButtonStyle : ButtonStyle {
    var imageName : String
    @Binding var selection : String
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(55)
            //.foregroundColor(.white)
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

//ButtonStyle for answers Button
struct AnswerButtonStyle : ButtonStyle {
    //Defines answer: true = correct, false = incorrect
    @State var typeAnswer : Bool
    @State var answerNum : Int
    
    //Control flow variable
    @Binding var answerControl : Int
    @Binding var flowControl : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            //.padding(.horizontal, 280)
            //.padding(.vertical, 25)
            .frame(width: 290, height: 30,alignment: .center)
            .background(
                ZStack {
                    Rectangle()
                        .frame(width: 290, height: 30)
                        .foregroundColor(typeAnswer ? .green : .red)
                        .opacity((flowControl && typeAnswer) || (flowControl && (answerNum == answerControl) ) ? 1 : 0)
                        .cornerRadius(10)
                }
                    /*.onTapGesture {
                        flowControl = true
                    }*/
            )
    }
}

//ButtonStyle for next and finish selection Button
struct NextButtonStyle : ButtonStyle {
    /*Animation variable
    @State private var animation = false*/
    
    //Control flow variable
    @Binding var flowControl : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 70)
            .padding(.vertical, 10)
            .background(
                ZStack {
                    Text("Next")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .zIndex(2)
                    Rectangle()
                        .frame(width: 100, height: 35)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .zIndex(1)
                    Rectangle()
                        .frame(width: 105, height: 40)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                }
                    .opacity(flowControl ? 1 : 0)
                    /*.onTapGesture {
                        flowControl = false
                    }*/
                    /*.scaleEffect(animation ? 0.8 : 1.0)
                    .onTapGesture {
                       withAnimation(Animation.spring()) {
                            self.animation.toggle()
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.animation.toggle()
                        }
                    }*/
            )
    }
}
