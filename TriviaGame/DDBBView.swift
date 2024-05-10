//
//  DDBBView.swift
//  TriviaGame
//
//  Created by Luis on 9/5/24.
//

import SwiftUI

struct DDBBView: View {
    
    @ObservedObject private var ddbbViewModel = DDBBViewModel()
    
    //@Environment(\.dismiss) var dismiss
    
    @State var corrects = 0
    @State var incorrects = 0
    @State var ratio = 0.0
    
    //Playground view to test DDBB connection
    var body: some View {
        NavigationView {
            List {
                TextField("corrects", value: $corrects, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("incorrects", value: $incorrects, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("ratio", value: $ratio, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Text("corrects \(corrects)")
                Text("incorrects \(incorrects)")
                Text("ratio \(ratio)")
                ForEach(ddbbViewModel.userData, id:\.id) { Data in
                    VStack(alignment: .leading) {
                        if let x = Data.corrects {
                            Text(String(x))
                                .font(.system(size: 22, weight: .regular))
                        }
                        if let x = Data.incorrects {
                            Text(String(x))
                                .font(.system(size: 22, weight: .regular))
                        }
                        if let x = Data.ratio {
                            Text(String(x))
                                .font(.system(size: 22, weight: .regular))
                        }
                    }.frame(maxHeight: 200)
                        .onTapGesture {ddbbViewModel.selectedData = Data}
                }.onDelete { (indexSet) in
                    self.ddbbViewModel.deleteData(at: indexSet)
                    //rViewModel.restaurants.remove(atOffsets: indexSet)
                }
                Button(action: {
                    self.ddbbViewModel.addData(corrects: corrects, incorrects: incorrects, ratio: ratio)
                    //dismiss()
                    
                })
                {
                    Text("Save now")
                }
                
                Button(action: {
                    self.ddbbViewModel.updateData()
                    //dismiss()
                    
                })
                {
                    Text("Save now")
                }
                //.disabled(self.corrects > 0 && self.incorrects > 0 && self.ratio > 0.0)
                .foregroundColor(.yellow)
            }.onAppear(perform: self.ddbbViewModel.fetchData)
                .navigationTitle("Publish")
                .toolbar {
                    ToolbarItemGroup(placement:.destructiveAction) {
                        Button("Cancel") {
                            //dismiss()
                        }
                    }
                }
        }
    }
}

struct DDBBView_Previews: PreviewProvider {
    static var previews: some View {
        DDBBView()
    }
}
