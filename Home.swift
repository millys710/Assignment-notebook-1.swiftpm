import SwiftUI

struct Home: View {
    
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 0
//    @State private var tasks: [Task] = sampleTasks.sorted(by: {$1.creationData > $0.creationData})
    @State private var createNewTask: Bool = false

    @Namespace private var animation
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            
            HeaderView()
            
            ScrollView(.vertical){
                VStack{
                    TasksView(currentDate: $currentDate)
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }
            .scrollIndicators(.hidden)
            
        })
        .vSpacing(.top)
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                createNewTask.toggle()  
                
            }, label: {
                Image(systemName: "plus")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 55, height: 55)
                    .background(.blue.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10)), in: .circle)
            })
            .padding(15)
        })
        
        .onAppear(perform: {
            if weekSlider.isEmpty{
                let currentWeek = Date().fetchWeek()
                weekSlider.append(currentWeek)
            }
                
        })
        .sheet(isPresented:$createNewTask, content:{
            NewTaskView()
                .presentationDetents([.height(300)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.white)
        })
    }
    @ViewBuilder
    func HeaderView() -> some View{
        VStack(alignment: .leading, spacing: 6){
            HStack(spacing: 5){
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.indigo)
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())

            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            //week slider
            TabView(selection: $currentWeekIndex){
                ForEach(weekSlider.indices, id: \.self){ index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .tag(index)
                    
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing, content: {Button(action: {},label: {
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(.circle)
        })
    })
        .padding(15)
        .background(.white)
    }
    // Week View
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View{
        HStack(spacing: 0){
            ForEach( week ) { day in
                VStack(spacing: 8){
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                //     .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .frame(width: 35, height: 35)
                        .background(content: {
//                            if isSameDate(day.date, currentDate){
//                                Circle()
//                                    .fill(.Blue)
//                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
//                            }
//                            if day.date.isToday {
//                                Circle()
//                                    .fill(.cyan)
//                                    .frame(width: 5, height: 5)
//                                    .vSpacing(.bottom)
//                                    .offset(y:12)
//                            } 
//                            
                        })
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture{
                    withAnimation(.snappy){
                        currentDate = day.date
                    }
                }
                
            } 
        }
    }
//    //Tasks View
//    @ViewBuilder
//    func TasksView()-> some View{
//        VStack(alignment: .leading, spacing: 35){
//            ForEach($tasks) { $task in
//                TaskRowView(task: $task)
//                    .background(alignment: .leading){
//                        if tasks.last?.id != task.id{
//                            Rectangle()
//                                .frame(width: 1)
//                                .offset(x:8)
//                                .padding(.bottom, -35)
//                        }
//                    }
//            }
//        }
//        .padding([.vertical, .leading], 15)
//        .padding(.top, 15)
 //   }
    
}
#Preview{
    ContentView()
}
//10:33
