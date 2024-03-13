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
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // Use currency style
        formatter.maximumFractionDigits = 2 // Maximum of 2 decimal places
        return formatter
      }()
    
    @EnvironmentObject var taskManager: TaskManager
    @State private var value = 0
    @State private var text: String = ""
    @State var isEditing: Bool
    @State var isFinished: Bool = false
    @FocusState private var isNameFocused: Bool
    
    
    @State private var hours: Int = 0
      @State private var minutes: Int = 0
    
    var body: some View {
        HStack {
            Toggle(isOn: $isFinished) {
                
            }
            .toggleStyle(.checkbox)
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
    
    private var formattedTime: String {
      get {
        "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes))"
      }
      set {
        // Handle potential invalid input during initialization (optional)
      }
    }
}

