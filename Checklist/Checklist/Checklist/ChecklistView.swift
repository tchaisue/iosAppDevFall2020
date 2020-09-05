//
//  ContentView.swift
//  View for the Checklist
//
//  Created by Tanarut Chaisuesomboon on 9/2/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import SwiftUI


struct ChecklistView: View {
    //properties
    @ObservedObject var checklist = Checklist()
    @State var newChecklistItemViewIsVisible = false;
    
    var body: some View {
        NavigationView{
            List{
                ForEach(checklist.items){index in
                    RowView(checklistItem: self.$checklist.items[index])
                }
                .onDelete(perform: checklist.deleteListItem)
                .onMove(perform: checklist.moveListItem)
            }
        
            .navigationBarTitle("Checklist", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.newChecklistItemViewIsVisible = true
                }){
                    HStack{
                        Image(systemName: "plus.circle.fill")
                        Text("Add item")
                    }
                },
                trailing: EditButton())
            .onAppear(){
                self.checklist.saveListItems()
                self.checklist.printChecklistContents()
            }
        }.sheet(isPresented: $newChecklistItemViewIsVisible){
            NewChecklistItemView(checklist: self.checklist)
        }
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
