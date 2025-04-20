import Foundation

class MainViewModel: ObservableObject {
    @Published var counter = 0

    func increment() {
        counter += 1
    }

    func decrement() {
        counter -= 1
    }
}
