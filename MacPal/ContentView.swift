import SwiftUI

struct ContentView: View {
    var body: some View {
        LessonView(lesson: openingClosingWindowLesson)
    }
}

#Preview {
    ContentView()
        .frame(width: 500, height: 600)
}
