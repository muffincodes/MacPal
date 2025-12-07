import SwiftUI

struct ContentView: View {
    @StateObject private var progressManager = ProgressManager()
    @State private var currentLesson: Lesson? = nil
    @State private var isInOnboardingFlow = false

    var body: some View {
        if let lesson = currentLesson {
            LessonView(
                lesson: lesson,
                onComplete: {
                    handleLessonComplete(lesson: lesson)
                },
                onExit: {
                    currentLesson = nil
                    isInOnboardingFlow = false
                }
            )
        } else {
            HomeView(
                progressManager: progressManager,
                onSelectLesson: { lesson in
                    currentLesson = lesson
                },
                onStartOnboarding: {
                    progressManager.startOnboarding()
                    isInOnboardingFlow = true
                    if let firstLesson = allLessons.first {
                        currentLesson = firstLesson
                    }
                }
            )
        }
    }

    private func handleLessonComplete(lesson: Lesson) {
        progressManager.markCompleted(lessonId: lesson.id)

        if isInOnboardingFlow || progressManager.isInOnboardingMode {
            progressManager.advanceOnboarding()

            // Check if there's a next lesson
            if progressManager.currentOnboardingIndex < allLessons.count {
                currentLesson = allLessons[progressManager.currentOnboardingIndex]
            } else {
                // Onboarding complete
                progressManager.exitOnboarding()
                currentLesson = nil
                isInOnboardingFlow = false
            }
        } else {
            // Single lesson mode - go back to home
            currentLesson = nil
        }
    }
}

#Preview {
    ContentView()
        .frame(width: 500, height: 600)
}
