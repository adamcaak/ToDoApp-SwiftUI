//
//  ContentView.swift
//  ToDoApp
//
//  Created by Łukasz Adamczak on 29/04/2025.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var isDone: Bool
}

struct ContentView: View {
    @State private var tasks: [Task] = [
        Task(title: "Nauka SwiftUI", isDone: false),
        Task(title: "Kupić mleko", isDone: true)
    ]
    @State private var newTask: String = ""
    
    private func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: {$0.id == task.id}) {
            tasks[index].isDone.toggle()
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Wpisz nowe zadanie:", text: $newTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Dodaj") {
                    if !newTask.isEmpty {
                        tasks.append(Task(title: newTask, isDone: false))
                        newTask = ""
                    }
                }
            }
            .padding()
            
            List {
                ForEach(tasks) { task in
                    HStack {
                        Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isDone ? .green : .gray)
                        Text(task.title)
                            .strikethrough(task.isDone)
                    }
                    .onTapGesture {
                        toggleTask(task)
                    }
                }
                .onDelete(perform: deleteTask)
            }
        }
    }
}

#Preview {
    ContentView()
}
