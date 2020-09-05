//
//  ChecklistItem.swift
//  Model for the ChecklistItem struct
//
//  Created by Tanarut Chaisuesomboon on 9/2/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import Foundation

struct ChecklistItem: Identifiable, Codable {
    let id = UUID();
    var name: String
    var isChecked: Bool = false
}
