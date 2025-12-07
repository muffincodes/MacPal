import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    @State private var currentStepIndex = 0
    @State private var showingHelp = false

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
            VStack(alignment: .trailing, spacing: 16) {
                Text(currentStep.instruction)
                    .font(.title3)
                    .lineSpacing(6)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Help button
                if currentStep.helpVideoURL != nil || currentStep.helpImageName != nil {
                    Button(action: { showingHelp.toggle() }) {
                        ZStack(alignment: .bottomTrailing) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 36, height: 36)

                            Text("?")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundStyle(.blue)
                                .frame(width: 36, height: 36)

                            Circle()
                                .fill(Color.orange)
                                .frame(width: 10, height: 10)
                                .offset(x: 3, y: 3)
                        }
                    }
                    .buttonStyle(.plain)
                    .help("Click for visual help")
                }
            }
            .padding(30)
            .frame(maxHeight: .infinity)

            // Help panel (shown when ? is clicked)
            if showingHelp {
                VStack(spacing: 12) {
                    if let videoURL = currentStep.helpVideoURL {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .foregroundStyle(.blue)
                            Link("Watch a short video showing this step", destination: URL(string: videoURL)!)
                                .font(.callout)
                        }
                    }

                    if let imageName = currentStep.helpImageName {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 150)
                            .cornerRadius(8)
                    }

                    Button("Close help") {
                        showingHelp = false
                    }
                    .font(.caption)
                }
                .padding()
                .background(Color.blue.opacity(0.05))
                .cornerRadius(12)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }

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

                Button(action: { /* TODO: Show stuck help */ }) {
                    Text("I'm stuck")
                        .frame(width: 100)
                }
                .controlSize(.large)

                Button(action: goToNextStep) {
                    Text(isLastStep ? "Finish" : "I did it")
                        .frame(width: 100)
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
            }
            .padding(30)
        }
    }

    private func goToNextStep() {
        showingHelp = false
        if currentStepIndex < lesson.steps.count - 1 {
            currentStepIndex += 1
        }
    }

    private func goToPreviousStep() {
        showingHelp = false
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }
}

#Preview {
    LessonView(lesson: openingClosingWindowLesson)
        .frame(width: 500, height: 600)
}
