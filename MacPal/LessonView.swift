import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    let onComplete: () -> Void
    let onExit: () -> Void

    @State private var currentStepIndex = 0
    @State private var showingStuckHelp = false
    @State private var showingCompletion = false

    private var currentStep: LessonStep {
        lesson.steps[currentStepIndex]
    }

    private var isLastStep: Bool {
        currentStepIndex == lesson.steps.count - 1
    }

    var body: some View {
        VStack(spacing: 0) {
            // Top bar with exit button
            HStack {
                Button(action: onExit) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Home")
                    }
                }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)

            // Header
            VStack(spacing: 8) {
                Text(lesson.title)
                    .font(.title)
                    .fontWeight(.semibold)

                Text("Step \(currentStepIndex + 1) of \(lesson.steps.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 15)
            .padding(.bottom, 20)

            Divider()

            // Instruction area
            Text(currentStep.instruction)
                .font(.title3)
                .lineSpacing(6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(30)
                .frame(maxHeight: .infinity)

            Divider()

            // Buttons
            HStack(spacing: 20) {
                if currentStepIndex > 0 {
                    Button(action: goToPreviousStep) {
                        Text("Back")
                            .frame(width: 100)
                    }
                    .controlSize(.large)
                }

                Spacer()

                Button(action: { showingStuckHelp = true }) {
                    Text("I'm stuck")
                        .frame(width: 100)
                }
                .controlSize(.large)
                .disabled(currentStep.helpImage == nil)

                Button(action: goToNextStep) {
                    Text(isLastStep ? "Finish" : "I did it")
                        .frame(width: 100)
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
            }
            .padding(30)
        }
        .sheet(isPresented: $showingStuckHelp) {
            StuckHelpSheet(imageName: currentStep.helpImage)
        }
        .sheet(isPresented: $showingCompletion) {
            LessonCompleteSheet(lessonTitle: lesson.title) {
                onComplete()
            }
        }
    }

    private func goToNextStep() {
        if currentStepIndex < lesson.steps.count - 1 {
            currentStepIndex += 1
        } else {
            // Last step completed
            showingCompletion = true
        }
    }

    private func goToPreviousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }
}

struct StuckHelpSheet: View {
    let imageName: String?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text("Here's what to look for")
                .font(.title2)
                .fontWeight(.semibold)

            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(maxWidth: 400, maxHeight: 300)
            }

            Button("Got it") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(40)
        .frame(minWidth: 450, minHeight: 400)
    }
}

struct LessonCompleteSheet: View {
    let lessonTitle: String
    let onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)

            Text("Lesson Complete!")
                .font(.title)
                .fontWeight(.bold)

            Text("You finished \"\(lessonTitle)\"")
                .font(.title3)
                .foregroundStyle(.secondary)

            Button("Continue") {
                dismiss()
                onContinue()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(40)
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    LessonView(
        lesson: openingClosingWindowLesson,
        onComplete: {},
        onExit: {}
    )
    .frame(width: 500, height: 600)
}

#Preview("Stuck Help Sheet") {
    StuckHelpSheet(imageName: "DockFinder")
}

#Preview("Lesson Complete") {
    LessonCompleteSheet(lessonTitle: "Opening and Closing a Window", onContinue: {})
}
