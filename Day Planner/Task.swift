//
//  SwiftUIView.swift
//  Day Planner
//
//  Created by Nam Do Hyun on 2024/03/07.
//

import SwiftUI

struct Task: Hashable, Identifiable, Codable {
    var id: UUID
    var name: String
    
}
