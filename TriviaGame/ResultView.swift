//
//  ResultView.swift
//  TriviaGame
//
//  Created by Luis on 13/5/24.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Results")
            HStack {
                Text("# corrects")
                Text("/")
                Text("# questions")
            }
            Text("Corrects!")
            Spacer()
            HStack {
                Text("Repeat")
                Spacer()
                Text("Continue")
            }
        }
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
