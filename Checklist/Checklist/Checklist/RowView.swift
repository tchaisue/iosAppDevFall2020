//
//  RowView.swift
//  View for an individual row 
//
//  Created by Tanarut Chaisuesomboon on 9/2/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import SwiftUI

struct RowView: View {
    @Binding var checklistItem: ChecklistItem
    var body: some View {
        NavigationLink(destination: EditChecklistItemView(checklistItem: $checklistItem)){
            HStack{
                Text(checklistItem.name)
                Spacer()
                Text(checklistItem.isChecked ? "✅" : "🔲")
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(checklistItem: .constant(ChecklistItem(name: "Sample item")))
    }
}
