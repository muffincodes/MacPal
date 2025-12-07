import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    @State private var currentStepIndex = 0
    @State private var showingStuckHelp = false

    private var currentStep: LessonStep {
        lesson.steps[currentStepIndex]
    }

    private var isLastStep: Bool {
        currentStepIndex == lesson.steps.count - 1
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                Text(lesson.title)
                    .font(.title)
                    .fontWeight(.semibold)

                Text("Step \(currentStepIndex + 1) of \(lesson.steps.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 30)
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
    }

    private func goToNextStep() {
        if currentStepIndex < lesson.steps.count - 1 {
            currentStepIndex += 1
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

#Preview {
    LessonView(lesson: openingClosingWindowLesson)
        .frame(width: 500, height: 600)
}

#Preview("Stuck Help Sheet") {
    StuckHelpSheet(imageName: "DockFinder")
}
