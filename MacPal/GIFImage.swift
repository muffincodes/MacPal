import SwiftUI
import AppKit

/// A view that displays images from the asset catalog or bundle.
/// Supports both static images (PNG, JPG) and animated GIFs.
/// Note: GIFs must be added directly to the bundle (not asset catalog) to animate.
struct AnimatedImage: NSViewRepresentable {
    let name: String

    func makeNSView(context: Context) -> NSView {
        let containerView = NSView()
        let imageView = NSImageView()
        imageView.canDrawSubviewsIntoLayer = true
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.animates = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        return containerView
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        guard let imageView = nsView.subviews.first as? NSImageView else { return }

        // Try loading GIF from bundle first (preserves animation)
        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let image = NSImage(contentsOf: url) {
            imageView.image = image
            return
        }

        // Try loading PNG from bundle
        if let url = Bundle.main.url(forResource: name, withExtension: "png"),
           let image = NSImage(contentsOf: url) {
            imageView.image = image
            return
        }

        // Fall back to asset catalog (works for PNGs, GIFs won't animate)
        if let image = NSImage(named: name) {
            imageView.image = image
        }
    }
}

#Preview {
    VStack {
        AnimatedImage(name: "DockFinder")
            .frame(width: 200, height: 150)
    }
    .padding()
}
