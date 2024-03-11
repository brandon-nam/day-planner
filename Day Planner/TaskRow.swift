//
//  TaskRow.swift
//  Day Planner
//
//  Created by Nam Do Hyun on 2024/03/08.
//

import SwiftUI

struct TaskRow: View {
    var task: Task
    var index: Int
    
    @EnvironmentObject var taskManager: TaskManager
    
    @State private var text: String = ""
    @State var isEditing: Bool
    @FocusState private var isNameFocused: Bool
    
    var body: some View {
        HStack {
            if !isEditing {
                Text(task.name)
                    .font(.title)
            } else {
                TextField(task.name, text: $text)
                          .onSubmit {
                              taskManager.updateTask(index: index, newName: text)
                              isEditing = false // Hide TextField on submit
                          }
                          .focused($isNameFocused)
            }
            Button(isEditing ? "Save" : "Edit") {
                if isEditing {
                    isEditing = false
                    isNameFocused = false
                } else {
                    text = task.name
                    isEditing = true
                    isNameFocused = true
                }
            }
            if !isEditing {
                Button("Delete") {
                    taskManager.deleteTask(index: index)
                }
            }
        }
    }
}

