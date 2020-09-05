//
//  ContentView.swift
//  Checklist
//
//  Created by Tanarut Chaisuesomboon on 9/2/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import SwiftUI

struct ChecklistItem: Identifiable {
    let id = UUID();
    var name: String
    var isChecked: Bool = false
}
struct ChecklistView: View {
    @State var checklistItems = [
        ChecklistItem(name: "Walk the dog"),
        ChecklistItem(name: "Brush my teeth"),
        ChecklistItem(name: "Learn iOS development", isChecked: true),
        ChecklistItem(name: "Soccer practice"),
        ChecklistItem(name: "Eat ice cream", isChecked: true),
    ]
    var body: some View {
        NavigationView{
            List{
                ForEach(checklistItems){checklistItem in
                    HStack{
                        Text(checklistItem.name)
                        Spacer()
                        if(checklistItem.isChecked){
                            Text("✅")
                        }else{
                            Text("🔲")
                        }
                    }
                    .background(Color.white)
                    .onTapGesture{
                        if let matchingIndex = self.checklistItems.firstIndex(where: {$0.id == checklistItem.id}){
                            self.checklistItems[matchingIndex].isChecked.toggle()
                        }
                        print("checklistitem name: \(checklistItem.name)")
                    }
                }
            .onDelete(perform: deleteListItem)
                .onMove(perform: moveListItem)
            }
        
            .navigationBarTitle("Checklist")
            .navigationBarItems(trailing: EditButton())
            .onAppear(){
                self.printChecklistContents()
            }
        }
    }
    
    func printChecklistContents(){
        for item in checklistItems{
            print(item)
        }
    }
    
    func deleteListItem(whichElement: IndexSet){
        checklistItems.remove(atOffsets: whichElement)
        printChecklistContents()
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int){
        checklistItems.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
