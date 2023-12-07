import Foundation

protocol FastingViewModelProtocol {
    var fasts: [Fast] { get }
    var hasFasts: Bool { get }

    func createFast(_ fast: Fast)
    func deleteFast(_ fast: Fast)
}

class FastingViewModel: FastingViewModelProtocol {
    private(set) var fasts: [Fast] = []

    var hasFasts: Bool {
        fasts.count > 0
    }

    func createFast(_ fast: Fast) {
        fasts.append(fast)
    }

    func deleteFast(_ fast: Fast) {
        guard let fastIndex = fasts.firstIndex(where: { $0 == fast }) else { return }
        fasts.remove(at: fastIndex)
    }
}
