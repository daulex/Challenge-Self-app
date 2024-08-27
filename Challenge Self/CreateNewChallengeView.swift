//
//  CreateNewChallengeView.swift
//  Challenge Self
//
//  Created by Kirills Galenko on 26/08/2024.
//

import SwiftUI
import CoreData

struct CreateNewChallengeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \GoalEntity.order, ascending: true)]
    ) var goals: FetchedResults<GoalEntity>
    
    @State private var newGoalTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // TextField and Add Button for new goals
                HStack {
                    TextField("Enter new goal", text: $newGoalTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        if !newGoalTitle.isEmpty {
                            addGoal(title: newGoalTitle)
                            newGoalTitle = ""
                        }
                    }) {
                        Text("Add")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                // List of goals with drag-and-drop reordering and delete functionality
                List {
                    ForEach(goals, id: \.objectID) { goal in
                        if let goalTitle = goal.title {
                            Text(goalTitle)
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                
                // Edit button at the bottom to enable moving and deleting items
                HStack {
                    Spacer()
                    EditButton()
                        .padding()
                }
            }
            .navigationTitle("Goals")
        }
    }
    
    // Add a new goal to the list
    func addGoal(title: String, complete: Bool = false) {
        let newGoal = GoalEntity(context: managedObjectContext)
        newGoal.title = title
        newGoal.complete = complete
        newGoal.order = Int16(goals.count)
        
        do {
            try managedObjectContext.save()
            print("Saved new goal: \(title)")
        } catch {
            print("Failed to save goal: \(error.localizedDescription)")
        }
    }
    
    // Delete a goal from the list
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let goal = goals[index]
            managedObjectContext.delete(goal)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to delete goal: \(error.localizedDescription)")
        }
    }
    
    // Move (reorder) goals in the list
    func move(from source: IndexSet, to destination: Int) {
        var revisedItems: [GoalEntity] = goals.map { $0 }
        revisedItems.move(fromOffsets: source, toOffset: destination)
        
        // Update the order after moving items
        for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1) {
            revisedItems[reverseIndex].order = Int16(reverseIndex)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to reorder goals: \(error.localizedDescription)")
        }
    }
}

struct CreateNewChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewChallengeView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
