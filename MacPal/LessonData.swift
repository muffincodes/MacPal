import Foundation

enum DeviceType: String, CaseIterable {
    case mouse = "Mouse"
    case trackpad = "Trackpad"
}

enum LessonCategory: String, CaseIterable {
    case gettingStarted = "Getting Started"
    case essentialSkills = "Essential Skills"
    case organizingYourMac = "Organizing Your Mac"
}

struct LessonStep: Identifiable {
    let id = UUID()
    let instruction: String
    let mouseInstruction: String?
    let trackpadInstruction: String?
    let helpImage: String?
    let mouseHelpImage: String?
    let trackpadHelpImage: String?
    let helpTip: String?

    // Convenience initializer for simple steps (no device variants)
    init(instruction: String, helpImage: String?, helpTip: String? = nil) {
        self.instruction = instruction
        self.mouseInstruction = nil
        self.trackpadInstruction = nil
        self.helpImage = helpImage
        self.mouseHelpImage = nil
        self.trackpadHelpImage = nil
        self.helpTip = helpTip
    }

    // Full initializer for device-specific steps
    init(
        instruction: String = "",
        mouseInstruction: String?,
        trackpadInstruction: String?,
        helpImage: String? = nil,
        mouseHelpImage: String?,
        trackpadHelpImage: String?,
        helpTip: String? = nil
    ) {
        self.instruction = instruction
        self.mouseInstruction = mouseInstruction
        self.trackpadInstruction = trackpadInstruction
        self.helpImage = helpImage
        self.mouseHelpImage = mouseHelpImage
        self.trackpadHelpImage = trackpadHelpImage
        self.helpTip = helpTip
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
    let icon: String
    let category: LessonCategory
    let steps: [LessonStep]
    let requiresDeviceSelection: Bool

    init(id: String, title: String, description: String, icon: String = "book.fill", category: LessonCategory = .gettingStarted, steps: [LessonStep], requiresDeviceSelection: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.icon = icon
        self.category = category
        self.steps = steps
        self.requiresDeviceSelection = requiresDeviceSelection
    }
}

// MARK: - Lesson 1: Using the Mouse/Trackpad

let mouseTrackpadLesson = Lesson(
    id: "mouse-trackpad",
    title: "Using the Mouse/Trackpad",
    description: "Learn the basics of pointing, clicking, and scrolling",
    icon: "computermouse.fill",
    category: .gettingStarted,
    steps: [
        LessonStep(
            mouseInstruction: "Place your hand on the mouse and move it around on your desk. Watch how the arrow (called the cursor) moves on the screen. The cursor follows your mouse movements.",
            trackpadInstruction: "Place one finger on the trackpad (the flat rectangular area below your keyboard). Slide your finger around and watch how the arrow (called the cursor) moves on the screen. The cursor follows your finger.",
            mouseHelpImage: "MouseMove",
            trackpadHelpImage: "TrackpadMove",
            helpTip: "Look for the small arrow on your screen — that's the cursor. It should move when you move your mouse or slide your finger on the trackpad."
        ),
        LessonStep(
            mouseInstruction: "Find the left button on your mouse (it's the bigger button on the left side). Press it once and release - this is called a 'click'. You use clicking to select things.",
            trackpadInstruction: "Press down on the trackpad until you feel a click, then release. Or simply tap the trackpad lightly with one finger. This is called a 'click'. You use clicking to select things.",
            mouseHelpImage: "MouseClick",
            trackpadHelpImage: "TrackpadClick",
            helpTip: "Press the left mouse button (or press down on the trackpad) once firmly, then let go. You should hear or feel a click."
        ),
        LessonStep(
            mouseInstruction: "Now try clicking the left button twice very quickly - click-click! This is called a 'double-click'. Double-clicking opens things like folders and applications.",
            trackpadInstruction: "Now try tapping the trackpad twice very quickly - tap-tap! This is called a 'double-click'. Double-clicking opens things like folders and applications.",
            mouseHelpImage: "MouseDoubleClick",
            trackpadHelpImage: "TrackpadDoubleClick",
            helpTip: "The key to double-clicking is speed — click twice as fast as you can without moving the cursor. If it's not working, try clicking a little faster."
        ),
        LessonStep(
            mouseInstruction: "Find the right button on your mouse (the smaller button on the right side). Press it once - this is called a 'right-click'. A menu with options will appear. Click anywhere else to close the menu.",
            trackpadInstruction: "Tap the trackpad with two fingers at the same time. This is called a 'right-click'. A menu with options will appear. Tap anywhere else to close the menu.",
            mouseHelpImage: "MouseRightClick",
            trackpadHelpImage: "TrackpadRightClick",
            helpTip: "On a mouse, press the button on the right side. On a trackpad, place two fingers on the surface and tap once. A menu should appear near your cursor."
        ),
        LessonStep(
            mouseInstruction: "Find the scroll wheel on your mouse (the wheel between the two buttons). Roll it up and down with your finger. This scrolls the page up and down, letting you see more content.",
            trackpadInstruction: "Place two fingers on the trackpad and slide them up or down together. This scrolls the page up and down, letting you see more content.",
            mouseHelpImage: "MouseScroll",
            trackpadHelpImage: "TrackpadScroll",
            helpTip: "On a mouse, the scroll wheel is the small wheel between the left and right buttons — roll it with your index finger. On a trackpad, use two fingers sliding up or down."
        ),
        LessonStep(
            mouseInstruction: "Press and hold the left button, then move the mouse while still holding the button. This is called 'dragging'. You can use this to move files or select text. Release the button when done.",
            trackpadInstruction: "Press and hold down on the trackpad, then move your finger while still pressing. This is called 'dragging'. You can use this to move files or select text. Release when done.",
            mouseHelpImage: "MouseDrag",
            trackpadHelpImage: "TrackpadDrag",
            helpTip: "The trick is to keep holding the button (or pressing the trackpad) while you move. Don't let go until you've finished moving to where you want."
        ),
        LessonStep(
            instruction: "Congratulations! You've learned the essential mouse and trackpad skills: moving the cursor, clicking, double-clicking, right-clicking, scrolling, and dragging. These are the building blocks for everything you'll do on your Mac!",
            helpImage: nil,
            helpTip: "You're all done with this lesson! Press \"Finish\" to continue. If you'd like more practice, press \"Back\" to revisit any step."
        )
    ],
    requiresDeviceSelection: true
)

// MARK: - Lesson 2: Opening and Closing a Window

let openingClosingWindowLesson = Lesson(
    id: "opening-closing-window",
    title: "Opening and Closing a Window",
    description: "Learn to open and close windows using the colored buttons",
    icon: "macwindow",
    category: .gettingStarted,
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
            helpImage: nil,
            helpTip: "You're all done with this lesson! Press \"Finish\" to continue. If you'd like more practice, press \"Back\" to revisit any step."
        )
    ]
)

// MARK: - Lesson 3: Using the Dock

let usingTheDockLesson = Lesson(
    id: "using-the-dock",
    title: "Using the Dock",
    description: "Learn to find, launch, and switch between apps using the Dock",
    icon: "dock.rectangle",
    category: .essentialSkills,
    steps: [
        LessonStep(
            instruction: "Look at the very bottom of your screen. You'll see a row of app icons sitting on a translucent bar. This is called the Dock. It's where your favorite and currently running apps live.",
            helpImage: nil,
            helpTip: "The Dock is a bar of icons at the very bottom edge of your screen. If you don't see it, try moving your cursor all the way down to the bottom of the screen and wait a moment — it may be hidden."
        ),
        LessonStep(
            instruction: "Move your cursor slowly over the icons in the Dock. As you hover over each icon, its name appears above it. Try hovering over a few icons to see what apps are available.",
            helpImage: nil,
            helpTip: "Move your cursor slowly over the icons. Don't click — just hover. The name of each app will pop up above its icon after a brief moment."
        ),
        LessonStep(
            instruction: "Find the Safari icon in the Dock — it looks like a blue compass. Click it once to open Safari (Apple's web browser). A new window will appear on your screen.",
            helpImage: nil,
            helpTip: "Safari looks like a blue compass. It's usually in the Dock by default. Scan from left to right through the icons until you spot it, then click once."
        ),
        LessonStep(
            instruction: "Look at the Dock again. You'll notice a small dot below the Safari icon. This dot means the app is currently running. Look for dots under other icons too — those apps are also open.",
            helpImage: nil,
            helpTip: "Look directly beneath each icon in the Dock. Running apps have a small dot below them. It can be subtle, so look closely."
        ),
        LessonStep(
            instruction: "Now find the Finder icon in the Dock — it's the blue and white smiley face, usually the first icon on the left. Click it once. A Finder window will open.",
            helpImage: nil,
            helpTip: "The Finder icon is usually the very first icon on the left side of the Dock. It looks like a two-toned blue and white smiley face."
        ),
        LessonStep(
            instruction: "You now have two apps open: Safari and Finder. Click the Safari icon in the Dock to switch back to Safari. Click the Finder icon to switch back to Finder. The Dock lets you jump between open apps quickly.",
            helpImage: nil,
            helpTip: "Click an app's icon in the Dock to bring its windows to the front. Try clicking back and forth between Safari and Finder to practice switching."
        ),
        LessonStep(
            instruction: "Let's close Safari. Find the Safari icon in the Dock, then right-click it (press the right mouse button, or tap the trackpad with two fingers). A menu will appear. Click \"Quit\" at the bottom of that menu.",
            helpImage: nil,
            helpTip: "To right-click on a mouse, press the right button. On a trackpad, tap with two fingers. A small menu will pop up — look for \"Quit\" at the bottom."
        ),
        LessonStep(
            instruction: "Congratulations! You've learned how to use the Dock: hovering to see app names, clicking to launch apps, spotting running apps by their dots, switching between apps, and quitting apps from the Dock menu.",
            helpImage: nil
        )
    ]
)

// MARK: - Lesson 4: Searching with Spotlight

let searchingWithSpotlightLesson = Lesson(
    id: "searching-with-spotlight",
    title: "Searching with Spotlight",
    description: "Learn to quickly find and open anything on your Mac",
    icon: "magnifyingglass",
    category: .essentialSkills,
    steps: [
        LessonStep(
            instruction: "Look at the very top-right area of your screen. You'll see a row of small icons in the menu bar. Find the magnifying glass icon (🔍) and click it once. A search box will appear in the center of your screen.",
            helpImage: nil,
            helpTip: "Look at the very top-right corner of your screen. The magnifying glass icon is in the menu bar, usually near the Wi-Fi and battery icons."
        ),
        LessonStep(
            instruction: "With the Spotlight search box open, type the word \"Safari\" using your keyboard. As you type, a list of results will appear below the search box. You'll see Safari at or near the top of the list.",
            helpImage: nil,
            helpTip: "After clicking the magnifying glass, a search bar appears in the center of the screen. Just start typing — you don't need to click inside it first."
        ),
        LessonStep(
            instruction: "Press the Return key (also called Enter) on your keyboard. This will open Safari — the first result in the list. Spotlight is a fast way to open any app without searching through folders.",
            helpImage: nil,
            helpTip: "The Return key is the large key on the right side of your keyboard, sometimes labeled \"Enter\". Press it once to open the highlighted result."
        ),
        LessonStep(
            instruction: "Let's try a keyboard shortcut to open Spotlight even faster. First, close the Safari window by clicking the red circle in its top-left corner. Now, hold down the Command key (⌘) and press the Space bar. Spotlight opens again!",
            helpImage: nil,
            helpTip: "The Command key (⌘) is right next to the Space bar at the bottom of your keyboard. Hold it down, then tap the Space bar once."
        ),
        LessonStep(
            instruction: "The Command (⌘) + Space shortcut is the fastest way to open Spotlight. You can use it any time, from any app. Try pressing ⌘ + Space, then press Escape to close it. Practice this a few times.",
            helpImage: nil,
            helpTip: "Hold the ⌘ key (next to the Space bar) and tap Space. When the search box appears, press Escape (top-left corner of keyboard) to close it."
        ),
        LessonStep(
            instruction: "Spotlight can do more than find apps. Open Spotlight (⌘ + Space) and type \"2 + 2\". You'll see the answer appear instantly — Spotlight works as a calculator! Press Escape to close it.",
            helpImage: nil,
            helpTip: "Open Spotlight with ⌘ + Space, then type a math problem like \"2 + 2\". The answer appears instantly in the results — no need to press Return."
        ),
        LessonStep(
            instruction: "Congratulations! You've learned to use Spotlight: opening it from the menu bar or with ⌘ + Space, searching for apps, pressing Return to launch them, and even using it as a calculator. Spotlight is one of the most useful tools on your Mac!",
            helpImage: nil
        )
    ]
)

// MARK: - Lesson 5: Files and Folders

let filesAndFoldersLesson = Lesson(
    id: "files-and-folders",
    title: "Files and Folders",
    description: "Learn to create, rename, and organize files and folders",
    icon: "folder.fill",
    category: .organizingYourMac,
    steps: [
        LessonStep(
            instruction: "Click the Finder icon in the Dock (the blue and white smiley face). A Finder window will open. On the left side of this window, you'll see a sidebar with locations like Desktop, Documents, and Downloads.",
            helpImage: nil,
            helpTip: "The Finder icon is the blue and white smiley face, usually the first icon on the left side of the Dock at the bottom of your screen."
        ),
        LessonStep(
            instruction: "In the Finder sidebar on the left, click the word \"Desktop\". The main area of the window will now show everything that's on your Desktop. This is one way to see your files.",
            helpImage: nil,
            helpTip: "The sidebar is the narrow column on the left side of the Finder window. Look for the word \"Desktop\" and click it."
        ),
        LessonStep(
            instruction: "Let's create a new folder. Go to the menu bar at the very top of the screen and click \"File\". A dropdown menu will appear. Click \"New Folder\" from that menu. A new folder will appear with its name highlighted.",
            helpImage: nil,
            helpTip: "The menu bar is at the very top of your screen. Click the word \"File\" to open a dropdown, then look for \"New Folder\" in that list."
        ),
        LessonStep(
            instruction: "The new folder's name is highlighted and ready to edit. Type a name for your folder — try typing \"My Practice Folder\" — then press the Return key to confirm the name.",
            helpImage: "RenamingFolder",
            helpTip: "The folder's name should already be highlighted in blue. Just start typing your new name. If it's not highlighted, click the folder once, then press Return to make the name editable."
        ),
        LessonStep(
            instruction: "Double-click your new folder (\"My Practice Folder\") to open it. The Finder window will now show the inside of the folder, which is empty since you just created it.",
            helpImage: nil,
            helpTip: "Double-click means clicking twice quickly. Position your cursor over the folder and click-click rapidly. The Finder window will then show the inside of that folder."
        ),
        LessonStep(
            instruction: "Let's go back. Look at the top of the Finder window for a left-pointing arrow (◀). Click it to go back to the Desktop. You can always use this arrow to return to where you were before.",
            helpImage: nil,
            helpTip: "Look at the top-left area of the Finder window, near the window title. You'll see navigation arrows (◀ ▶). Click the left-pointing arrow to go back."
        ),
        LessonStep(
            instruction: "Let's delete the practice folder. Click once on \"My Practice Folder\" to select it (it will become highlighted). Then go to the menu bar, click \"File\", and choose \"Move to Trash\". The folder will be moved to the Trash.",
            helpImage: nil,
            helpTip: "Click the folder once to select it (it gets highlighted). Then go to \"File\" in the menu bar at the top of the screen and choose \"Move to Trash\"."
        ),
        LessonStep(
            instruction: "Congratulations! You've learned the basics of files and folders: navigating with the Finder sidebar, creating new folders, naming them, opening folders with double-click, going back, and moving items to the Trash.",
            helpImage: nil
        )
    ]
)

// MARK: - All Lessons

let allLessons: [Lesson] = [
    mouseTrackpadLesson,
    openingClosingWindowLesson,
    usingTheDockLesson,
    searchingWithSpotlightLesson,
    filesAndFoldersLesson
]
