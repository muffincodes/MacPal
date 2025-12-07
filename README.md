# MacPal

A macOS app to help onboard new users to macOS through guided, step-by-step lessons.

## About

MacPal is designed to help people who are unfamiliar with computers learn how to use a Mac. Whether you're teaching a parent, a senior, or someone who's never used a computer before, MacPal provides hands-on lessons that guide users through essential macOS skills.

The app works alongside the user's actual Mac environment - they follow instructions in the app window while practicing on their real desktop, Finder, and system.

## Screenshots

<!-- Add screenshots here -->
<!-- Suggested: Home screen, Lesson view, Device selection, "I'm stuck" help sheet -->

## Features

- **Step-by-step guided lessons** - Clear instructions broken into manageable steps
- **Device selection** - Choose between Mouse or Trackpad for relevant lessons
- **"I'm stuck" button** - Visual help images when users need assistance
- **Progress tracking** - Automatically saves progress and completed lessons
- **Full onboarding mode** - Go through all lessons in sequence
- **Resume capability** - Continue where you left off

## Current Lessons

1. **Using the Mouse/Trackpad** - Learn cursor movement, clicking, double-clicking, right-clicking, scrolling, and dragging
2. **Opening and Closing a Window** - Practice window management with Finder

## Requirements

- macOS 13.0+ (Ventura or later)
- Xcode 15.0+ (for building)

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/MacPal.git
   ```

2. Open the project in Xcode:
   ```bash
   cd MacPal
   open MacPal.xcodeproj
   ```

3. Select your Mac as the run destination

4. Build and run (`Cmd + R`)

## Project Structure

```
MacPal/
├── MacPalApp.swift       # App entry point
├── ContentView.swift     # Main navigation controller
├── HomeView.swift        # Lesson selection screen
├── LessonView.swift      # Core lesson display with steps
├── LessonData.swift      # Lesson content and data models
├── ProgressManager.swift # Progress persistence (UserDefaults)
├── GIFImage.swift        # Animated image support
└── Assets.xcassets/      # Images and help visuals
```

## Adding New Lessons

To add a new lesson, edit `LessonData.swift`:

1. Create a new `Lesson` instance with steps:
   ```swift
   let myNewLesson = Lesson(
       id: "my-lesson",
       title: "My New Lesson",
       description: "Learn something new",
       steps: [
           LessonStep(instruction: "Step 1 instructions", helpImage: "HelpImage1"),
           LessonStep(instruction: "Step 2 instructions", helpImage: "HelpImage2"),
       ]
   )
   ```

2. Add your lesson to the `allLessons` array

3. Add any help images to `Assets.xcassets`

## Roadmap

- [ ] More lessons (Spotlight search, System Preferences, Dock usage, Files and Folders)
- [ ] GIF animation support for help images
- [ ] Accessibility improvements (VoiceOver support)
- [ ] Localization for multiple languages

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
