import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    let onComplete: () -> Void
    let onExit: () -> Void

    @State private var currentStepIndex = 0
    @State private var showingStuckHelp = false
    @State private var showingCompletion = false
    @State private var selectedDevice: DeviceType? = nil

    private var currentStep: LessonStep {
        lesson.steps[currentStepIndex]
    }

    private var isLastStep: Bool {
        currentStepIndex == lesson.steps.count - 1
    }

    private var needsDeviceSelection: Bool {
        lesson.requiresDeviceSelection && selectedDevice == nil
    }

    var body: some View {
        if needsDeviceSelection {
            DeviceSelectionView(
                onSelect: { device in
                    selectedDevice = device
                },
                onExit: onExit
            )
        } else {
            lessonContent
        }
    }

    private var lessonContent: some View {
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

                // Show selected device if applicable
                if let device = selectedDevice {
                    Text(device.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
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
            Text(currentStep.instruction(for: selectedDevice))
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
                .disabled(currentStep.helpImage(for: selectedDevice) == nil)

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
            StuckHelpSheet(imageName: currentStep.helpImage(for: selectedDevice))
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
            showingCompletion = true
        }
    }

    private func goToPreviousStep() {
        if currentStepIndex > 0 {
            currentStepIndex -= 1
        }
    }
}

// MARK: - Device Selection View

struct DeviceSelectionView: View {
    let onSelect: (DeviceType) -> Void
    let onExit: () -> Void

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

            Spacer()

            VStack(spacing: 30) {
                Text("What are you using?")
                    .font(.title)
                    .fontWeight(.semibold)

                Text("We'll show you instructions for your device")
                    .font(.body)
                    .foregroundStyle(.secondary)

                HStack(spacing: 30) {
                    DeviceButton(
                        icon: "computermouse.fill",
                        title: "Mouse",
                        onTap: { onSelect(.mouse) }
                    )

                    DeviceButton(
                        icon: "hand.draw.fill",
                        title: "Trackpad",
                        onTap: { onSelect(.trackpad) }
                    )
                }
                .padding(.top, 20)
            }

            Spacer()
        }
    }
}

struct DeviceButton: View {
    let icon: String
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 50))

                Text(title)
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .frame(width: 140, height: 140)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(20)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Stuck Help Sheet

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
                    .frame(width: 350, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
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

// MARK: - Lesson Complete Sheet

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

// MARK: - Previews

#Preview("Lesson View") {
    LessonView(
        lesson: openingClosingWindowLesson,
        onComplete: {},
        onExit: {}
    )
    .frame(width: 500, height: 600)
}

#Preview("Device Selection") {
    DeviceSelectionView(
        onSelect: { _ in },
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
