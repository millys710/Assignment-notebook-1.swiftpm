import SwiftUI

struct ContentView: View {
    var body: some View {
       Home()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .preferredColorScheme(.light)
    }
}
#Preview{
    ContentView()
}
