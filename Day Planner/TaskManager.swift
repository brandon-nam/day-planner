//
//  TaskManager.swift
//  Day Planner
//
//  Created by Nam Do Hyun on 2024/03/09.
//

import Foundation

class TaskManager: ObservableObject {
    private var date: String
    private var fileName: String
    @Published var tasks: [Task] = []
    
    init(date: String) {
        self.date = date
        self.fileName = self.date + ".json"
        self.tasks = loadJson(filename: self.date + ".json")
    }
    
    func addTask(task: Task) {
        DispatchQueue.main.async {  // Update on main thread
            self.tasks.append(task)
            self.saveData()
            self.tasks = self.loadJson(filename: self.fileName)
        }
    }
    
    func deleteTask(index: Int) -> Task {
        let removedTask = tasks.remove(at: index)
        saveData()
        tasks = loadJson(filename: self.fileName)
        return removedTask
    }
    
    func updateTask(index: Int, newName: String) {
        let newTask = Task(id: UUID(), name: newName)
        tasks[index] = newTask
        saveData()
        tasks = loadJson(filename: "tasks.json")
        
    }
    
    func saveData() {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(tasks)
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(self.fileName)
            try jsonData.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func loadData(filename: String) {
        tasks = loadJson(filename: self.fileName)
    }
    
    func loadJson(filename: String) -> [Task] {
        guard let url = URL(string: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename).absoluteString) else {
            return []
        }

      do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            try tasks = decoder.decode([Task].self, from: data)
            return tasks
      } catch {
            print("Error loading data: \(error)")
            return []
      }
    }
}

