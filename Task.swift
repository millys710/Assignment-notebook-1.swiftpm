import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID 
    var taskTitle: String
    var creationData: Date 
    var isCompleted: Bool 
    var tint: String
    
    init(id: UUID = .init(), taskTitle: String, creationData: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationData = creationData
        self.isCompleted = isCompleted
        self.tint = tint
    }
    var tintColor: Color {
        switch tint {
        case "Red" : return .red
        case "Blue" : return .blue
        case "Yellow" : return .yellow
        case "Purple" : return .purple
        case "Mint" : return .mint
        default : return .black
        }
    }
}


//var sampleTasks: [Task] = [
//    .init(taskTitle: "Record Video", creationData: .updateHour(-5), isCompleted: true, tint: .red),
//    .init(taskTitle: "Redsign Website", creationData: .updateHour(-3), tint: .yellow),
//    .init(taskTitle: "Go for a Walk", creationData: .updateHour(-4), tint: .blue),
//    .init(taskTitle: "Edit Video", creationData: .updateHour(0), isCompleted: true, tint: .purple),
//    .init(taskTitle: "Publish Video", creationData: .updateHour(2), isCompleted: true, tint: .red),
//    .init(taskTitle: "Post on Instagram", creationData: .updateHour(1), isCompleted: true, tint: .mint)
//]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calander = Calendar.current
        return calander.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }  

}

