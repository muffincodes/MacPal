import Foundation

class ProgressManager: ObservableObject {
    @Published var completedLessons: Set<String> = []
    @Published var currentOnboardingIndex: Int = 0
    @Published var isInOnboardingMode: Bool = false

    private let completedLessonsKey = "completedLessons"
    private let currentIndexKey = "currentOnboardingIndex"
    private let onboardingModeKey = "isInOnboardingMode"

    init() {
        loadProgress()
    }

    func markCompleted(lessonId: String) {
        completedLessons.insert(lessonId)
        saveProgress()
    }

    func isCompleted(lessonId: String) -> Bool {
        completedLessons.contains(lessonId)
    }

    func startOnboarding() {
        isInOnboardingMode = true
        currentOnboardingIndex = 0
        saveProgress()
    }

    func advanceOnboarding() {
        currentOnboardingIndex += 1
        saveProgress()
    }

    func exitOnboarding() {
        isInOnboardingMode = false
        saveProgress()
    }

    func resetProgress() {
        completedLessons.removeAll()
        currentOnboardingIndex = 0
        isInOnboardingMode = false
        saveProgress()
    }

    private func saveProgress() {
        UserDefaults.standard.set(Array(completedLessons), forKey: completedLessonsKey)
        UserDefaults.standard.set(currentOnboardingIndex, forKey: currentIndexKey)
        UserDefaults.standard.set(isInOnboardingMode, forKey: onboardingModeKey)
    }

    private func loadProgress() {
        if let saved = UserDefaults.standard.array(forKey: completedLessonsKey) as? [String] {
            completedLessons = Set(saved)
        }
        currentOnboardingIndex = UserDefaults.standard.integer(forKey: currentIndexKey)
        isInOnboardingMode = UserDefaults.standard.bool(forKey: onboardingModeKey)
    }
}
