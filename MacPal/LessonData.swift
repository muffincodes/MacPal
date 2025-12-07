import Foundation

enum DeviceType: String, CaseIterable {
    case mouse = "Mouse"
    case trackpad = "Trackpad"
}

struct LessonStep: Identifiable {
    let id = UUID()
    let instruction: String
    let mouseInstruction: String?
    let trackpadInstruction: String?
    let helpImage: String?
    let mouseHelpImage: String?
    let trackpadHelpImage: String?

    // Convenience initializer for simple steps (no device variants)
    init(instruction: String, helpImage: String?) {
        self.instruction = instruction
        self.mouseInstruction = nil
        self.trackpadInstruction = nil
        self.helpImage = helpImage
        self.mouseHelpImage = nil
        self.trackpadHelpImage = nil
    }

    // Full initializer for device-specific steps
    init(
        instruction: String = "",
        mouseInstruction: String?,
        trackpadInstruction: String?,
        helpImage: String? = nil,
        mouseHelpImage: String?,
        trackpadHelpImage: String?
    ) {
        self.instruction = instruction
        self.mouseInstruction = mouseInstruction
        self.trackpadInstruction = trackpadInstruction
        self.helpImage = helpImage
        self.mouseHelpImage = mouseHelpImage
        self.trackpadHelpImage = trackpadHelpImage
    }

    func instruction(for device: DeviceType?) -> String {
        guard let device = device else { return instruction }
        switch device {
        case .mouse:
            return mouseInstruction ?? instruction
        case .trackpad:
            return trackpadInstruction ?? instruction
        }
    }

    func helpImage(for device: DeviceType?) -> String? {
        guard let device = device else { return helpImage }
        switch device {
        case .mouse:
            return mouseHelpImage ?? helpImage
        case .trackpad:
            return trackpadHelpImage ?? helpImage
        }
    }
}

struct Lesson: Identifiable {
    let id: String
    let title: String
    let description: String
    let steps: [LessonStep]
    let requiresDeviceSelection: Bool

    init(id: String, title: String, description: String, steps: [LessonStep], requiresDeviceSelection: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.steps = steps
        self.requiresDeviceSelection = requiresDeviceSelection
    }
}

// MARK: - Lesson 1: Using the Mouse/Trackpad

let mouseTrackpadLesson = Lesson(
    id: "mouse-trackpad",
    title: "Using the Mouse/Trackpad",
    description: "Learn the basics of pointing, clicking, and scrolling",
    steps: [
        LessonStep(
            mouseInstruction: "Place your hand on the mouse and move it around on your desk. Watch how the arrow (called the cursor) moves on the screen. The cursor follows your mouse movements.",
            trackpadInstruction: "Place one finger on the trackpad (the flat rectangular area below your keyboard). Slide your finger around and watch how the arrow (called the cursor) moves on the screen. The cursor follows your finger.",
            mouseHelpImage: "MouseMove",
            trackpadHelpImage: "TrackpadMove"
        ),
        LessonStep(
            mouseInstruction: "Find the left button on your mouse (it's the bigger button on the left side). Press it once and release - this is called a 'click'. You use clicking to select things.",
            trackpadInstruction: "Press down on the trackpad until you feel a click, then release. Or simply tap the trackpad lightly with one finger. This is called a 'click'. You use clicking to select things.",
            mouseHelpImage: "MouseClick",
            trackpadHelpImage: "TrackpadClick"
        ),
        LessonStep(
            mouseInstruction: "Now try clicking the left button twice very quickly - click-click! This is called a 'double-click'. Double-clicking opens things like folders and applications.",
            trackpadInstruction: "Now try tapping the trackpad twice very quickly - tap-tap! This is called a 'double-click'. Double-clicking opens things like folders and applications.",
            mouseHelpImage: "MouseDoubleClick",
            trackpadHelpImage: "TrackpadDoubleClick"
        ),
        LessonStep(
            mouseInstruction: "Find the right button on your mouse (the smaller button on the right side). Press it once - this is called a 'right-click'. A menu with options will appear. Click anywhere else to close the menu.",
            trackpadInstruction: "Tap the trackpad with two fingers at the same time. This is called a 'right-click'. A menu with options will appear. Tap anywhere else to close the menu.",
            mouseHelpImage: "MouseRightClick",
            trackpadHelpImage: "TrackpadRightClick"
        ),
        LessonStep(
            mouseInstruction: "Find the scroll wheel on your mouse (the wheel between the two buttons). Roll it up and down with your finger. This scrolls the page up and down, letting you see more content.",
            trackpadInstruction: "Place two fingers on the trackpad and slide them up or down together. This scrolls the page up and down, letting you see more content.",
            mouseHelpImage: "MouseScroll",
            trackpadHelpImage: "TrackpadScroll"
        ),
        LessonStep(
            mouseInstruction: "Press and hold the left button, then move the mouse while still holding the button. This is called 'dragging'. You can use this to move files or select text. Release the button when done.",
            trackpadInstruction: "Press and hold down on the trackpad, then move your finger while still pressing. This is called 'dragging'. You can use this to move files or select text. Release when done.",
            mouseHelpImage: "MouseDrag",
            trackpadHelpImage: "TrackpadDrag"
        ),
        LessonStep(
            instruction: "Congratulations! You've learned the essential mouse and trackpad skills: moving the cursor, clicking, double-clicking, right-clicking, scrolling, and dragging. These are the building blocks for everything you'll do on your Mac!",
            helpImage: nil
        )
    ],
    requiresDeviceSelection: true
)

// MARK: - Lesson 2: Opening and Closing a Window

let openingClosingWindowLesson = Lesson(
    id: "opening-closing-window",
    title: "Opening and Closing a Window",
    description: "Learn to open and close windows using the colored buttons",
    steps: [
        LessonStep(
            instruction: "Look at the bottom of your screen. You'll see a row of icons - this is called the Dock. Find the icon that looks like a blue and white smiling face. This is called Finder.",
            helpImage: "DockFinder"
        ),
        LessonStep(
            instruction: "Move your cursor over the Finder icon (the blue and white smiling face) and click once. A new window will appear on your screen.",
            helpImage: "DockFinder"
        ),
        LessonStep(
            instruction: "Look at the window that just opened. In the very top-left corner of this window, you'll see three small colored circles next to each other: a red one, a yellow one, and a green one.",
            helpImage: "WindowButtons"
        ),
        LessonStep(
            instruction: "Move your cursor over the red circle (the leftmost one) and click it once. The window will close and disappear from your screen.",
            helpImage: "WindowButtons"
        ),
        LessonStep(
            instruction: "Congratulations! You just opened a Finder window and closed it. You can use these three colored circles on any window: red to close, yellow to minimize, and green to make it bigger.",
            helpImage: nil
        )
    ]
)

// MARK: - All Lessons

let allLessons: [Lesson] = [
    mouseTrackpadLesson,
    openingClosingWindowLesson
]
