import SwiftUI

struct EmptyStateView: View {
    let title: String

    static func makeView(title: String) -> UIView {
        let vc = UIHostingController(rootView: EmptyStateView(title: title))
        return vc.view
    }

    var body: some View {
        Text(title)
    }
}

#Preview {
    EmptyStateView(title: "No Fasts Found")
}
