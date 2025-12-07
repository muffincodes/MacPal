import SwiftUI

struct HomeView: View {
    @ObservedObject var progressManager: ProgressManager
    let onSelectLesson: (Lesson) -> Void
    let onStartOnboarding: () -> Void

    private var hasStartedOnboarding: Bool {
        progressManager.isInOnboardingMode && progressManager.currentOnboardingIndex < allLessons.count
    }

    private var nextLesson: Lesson? {
        guard hasStartedOnboarding else { return nil }
        return allLessons[progressManager.currentOnboardingIndex]
    }

    private var completedCount: Int {
        progressManager.completedLessons.count
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                Text("MacPal")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Your friendly Mac guide")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 40)
            .padding(.bottom, 30)

            Divider()

            ScrollView {
                VStack(spacing: 24) {
                    // Continue or Start Onboarding button
                    if hasStartedOnboarding, let lesson = nextLesson {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Continue where you left off")
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            Button(action: { onSelectLesson(lesson) }) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Continue: \(lesson.title)")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        Text("Lesson \(progressManager.currentOnboardingIndex + 1) of \(allLessons.count)")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "arrow.right.circle.fill")
                                        .font(.title)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(12)
                            }
                            .buttonStyle(.plain)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("New to Mac?")
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            Button(action: onStartOnboarding) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Start Full Onboarding")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        Text("Learn the basics step by step")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "play.circle.fill")
                                        .font(.title)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(12)
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    Divider()

                    // Individual lessons
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("All Lessons")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(completedCount)/\(allLessons.count) completed")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        ForEach(allLessons) { lesson in
                            LessonRow(
                                lesson: lesson,
                                isCompleted: progressManager.isCompleted(lessonId: lesson.id),
                                onSelect: { onSelectLesson(lesson) }
                            )
                        }
                    }
                }
                .padding(30)
            }
        }
    }
}

struct LessonRow: View {
    let lesson: Lesson
    let isCompleted: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isCompleted ? .green : .secondary)

                VStack(alignment: .leading, spacing: 2) {
                    Text(lesson.title)
                        .font(.body)
                        .fontWeight(.medium)
                    Text(lesson.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView(
        progressManager: ProgressManager(),
        onSelectLesson: { _ in },
        onStartOnboarding: {}
    )
    .frame(width: 500, height: 600)
}
