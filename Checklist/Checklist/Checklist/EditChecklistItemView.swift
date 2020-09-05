//
//  SwiftUIView.swift
//  Checklist View for Editing Checklist Items
//
//  Created by Tanarut Chaisuesomboon on 9/2/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import SwiftUI

struct EditChecklistItemView: View {
    @Binding var checklistItem: ChecklistItem
    
    var body: some View {
        Form{
            TextField("Name", text: $checklistItem.name)
            Toggle("Completed", isOn: $checklistItem.isChecked)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        EditChecklistItemView(checklistItem: .constant(ChecklistItem(name: "Blah")))
    }
}
