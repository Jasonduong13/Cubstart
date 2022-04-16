import Foundation
import Combine

class CardListViewModel: ObservableObject {
  @Published var cardRepository = CardRepository()

  func add(_ card: Card) {
    cardRepository.add(card)
  }
    @Published var cardViewModels: [CardViewModel] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
      cardRepository.$cards.map { cards in
        cards.map(CardViewModel.init)
      }
      .assign(to: \.cardViewModels, on: self)
      .store(in: &cancellables)
    }
}
