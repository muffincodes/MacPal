import Foundation

struct LessonStep: Identifiable {
    let id = UUID()
    let instruction: String
    let helpImage: String?
}

struct Lesson: Identifiable {
    let id = UUID()
    let title: String
    let steps: [LessonStep]
}

let openingClosingWindowLesson = Lesson(
    title: "Opening and Closing a Window",
    steps: [
        LessonStep(
            instruction: "Look at the bottom of your screen. You'll see a row of icons - this is called the Dock. Find the icon that looks like a blue and white smiling face. This is called Finder.",
            helpImage: "DockFinder"
        ),
        LessonStep(
            instruction: "Move your mouse pointer over the Finder icon (the blue and white smiling face) and click once. A new window will appear on your screen.",
            helpImage: "DockFinder"
        ),
        LessonStep(
            instruction: "Look at the window that just opened. In the very top-left corner of this window, you'll see three small colored circles next to each other: a red one, a yellow one, and a green one.",
            helpImage: "WindowButtons"
        ),
        LessonStep(
            instruction: "Move your mouse pointer over the red circle (the leftmost one) and click it once. The window will close and disappear from your screen.",
            helpImage: "WindowButtons"
        ),
        LessonStep(
            instruction: "Congratulations! You just opened a Finder window and closed it. You can use these three colored circles on any window: red to close, yellow to minimize, and green to make it bigger.",
            helpImage: nil
        )
    ]
)
