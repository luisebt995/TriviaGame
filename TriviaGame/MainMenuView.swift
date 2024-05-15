//
//  MainMenuView.swift
//  TriviaGame
//
//  Created by Luis on 13/5/24.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Setting")
                Text("Name")
                Text("Ranking ")
            }
            Spacer()
            HStack {
                Spacer()
                Text("-")
                Text("0")
                Text("+")
                Spacer()
            }
            Text("Jugar")
            Text("Leaderboard")
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
