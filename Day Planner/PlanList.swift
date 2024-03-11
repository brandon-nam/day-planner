//
//  PlanList.swift
//  Day Planner
//
//  Created by Nam Do Hyun on 2024/03/07.
//

import SwiftUI

struct PlanList: View {
    @State var dates: [String] = loadDates()
    var body: some View {
        NavigationView {
            VStack {
                List(dates, id:\.self) { date in
                    NavigationLink(destination: PlanView(date: date)) {
                        Text(date)
                    }
                }
                Button("Add Day") {
                    let date = Date().formatted(.dateTime.day().month().year())
                    if (!dates.contains(date)) {
                        dates.append(date)
                        saveDates(dates: dates)
                    } else {
                        
                    }
                    
                }.padding()
            }
        }
    }
}

func saveDates(dates: [String]) {
    do {
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(dates)
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("dates.json")
        try jsonData.write(to: url)
    } catch {
        print("Error saving data: \(error)")
    }
}

func loadDates() -> [String] {
    guard let url = URL(string: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("dates.json").absoluteString) else {
        return []
    }

  do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try  decoder.decode([String].self, from: data)
  } catch {
        print("Error loading data: \(error)")
        return []
      
  }
}

struct PlanList_Previews: PreviewProvider {
    static var previews: some View {
        PlanList()
    }
}
