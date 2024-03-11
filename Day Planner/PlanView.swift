//
//  PlanView.swift
//  Day Planner
//
//  Created by Nam Do Hyun on 2024/03/07.
//

import SwiftUI

struct PlanView: View {
    private var date: String
    @State private var userInput: String = ""
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
                TextField("Placeholder", text: $userInput)
                    .onSubmit {
                        guard !userInput.isEmpty else { return }
                        let newTask = Task(id: UUID(), name: userInput)
                        taskManager.addTask(task: newTask)
                        userInput = ""
                    }
            }
        }
        .padding()
    }
}


//struct PlanView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanView()
//    }
//}
