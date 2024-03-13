//
//  PlanView.swift
//  Day Planner
//
//  Created by Nam Do Hyun on 2024/03/07.
//

import SwiftUI

struct PlanView: View {
    private var date: String
    @State private var time: String = ""
    @State private var task: String = ""
    @StateObject private var taskManager: TaskManager
    
    init(date: String) {
        self.date = date
        _taskManager = StateObject(wrappedValue: TaskManager(date: date))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(taskManager.tasks.indices , id: \.self) { index in
                    TaskRow(task: taskManager.tasks[index], index: index, isEditing: false)
                }
                
            }.environmentObject(taskManager)
            
            Text("Number of tasks: \(taskManager.tasks.count)")
            VStack {
                HStack {
                    TextField("00:00", text: $time)
                        .frame(width: 48.0)
                        .onChange(of: time) { newValue in
                            if !time.isEmpty {
                                time = time.formatTime()
                            }
                        }
                        .multilineTextAlignment(.trailing)
                    
                    TextField("", text: $task)
                        .onSubmit {
                            guard !task.isEmpty else { return }
                            let newTask = Task(id: UUID(), name: task)
                            taskManager.addTask(task: newTask)
                            task = ""
                        }
                }
            }
        }
        .padding()
    }
}


extension String {
    func formatTime() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "XX:XX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        var endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}


struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView(date: Date().description)
    }
}
