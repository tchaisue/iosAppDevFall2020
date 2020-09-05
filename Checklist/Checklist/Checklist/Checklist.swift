//
//  Checklist.swift
//  Checklist
//
//  Methods that provide the functionality for the View (ChecklistView, RowView)
//
//  Created by Tanarut Chaisuesomboon on 9/2/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import Foundation

class Checklist: ObservableObject{
    
    @Published var items: [ChecklistItem] = []
    
        //Methods
    
    init(){
        print("Data documents directory is: \(documentsDirectory())")
        print("Data file path is: \(dataFilePath())")
        loadListItems()
    }
    
    //debug the items in the checklist
    func printChecklistContents(){
        for item in items{
            print(item)
        }
    }
    
    //saves the checklist data to a local file
    func saveListItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(items)
            
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)
        }catch{
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    //reads the checklist data from a local file
    func loadListItems(){
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do{
                items = try decoder.decode([ChecklistItem].self,
                                           from: data)
            }catch{
                print("Error dewcoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    //delete checklist item
    func deleteListItem(whichElement: IndexSet){
        items.remove(atOffsets: whichElement)
        printChecklistContents()
        saveListItems()
    }
    
    //moves checklist items
    func moveListItem(whichElement: IndexSet, destination: Int){
        items.move(fromOffsets: whichElement, toOffset: destination)
        printChecklistContents()
        saveListItems()
    }
    
    //gets document directory for this app
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    //creates a data file path for the checklist item data
    func dataFilePath() -> URL {
        return
            documentsDirectory().appendingPathComponent("Checklist.plist")
    }
}

