import SwiftUI

struct CardView: View {
  var cardViewModel: CardViewModel
  @State var showContent: Bool = false
  @State var viewState = CGSize.zero
  @State var showAlert = false

  var body: some View {
    ZStack(alignment: .center) {
      backView.opacity(showContent ? 1 : 0)
      frontView.opacity(showContent ? 0 : 1)
    }
    .frame(width: 250, height: 400)
    .background(Color.red)
    .cornerRadius(20)
    .shadow(color: Color(.blue).opacity(0.3), radius: 5, x: 10, y: 10)
    .rotation3DEffect(.degrees(showContent ? 180.0 : 0.0), axis: (x: 0, y: -1, z: 0))
    .offset(x: viewState.width, y: viewState.height)
    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
    .onTapGesture {
      withAnimation {
        showContent.toggle()
      }
    }
    .gesture(
      DragGesture()
        .onChanged { value in
          viewState = value.translation
        }
      .onEnded { value in
        if value.location.y < value.startLocation.y - 40.0 {
          showAlert.toggle()
        }
        viewState = .zero
      }
    )
      .alert(isPresented: $showAlert) {
        Alert(
          title: Text("Remove Card"),
          message: Text("Are you sure you want to remove this card?"),
          primaryButton: .destructive(Text("Remove")) {
            cardViewModel.remove()
          },
          secondaryButton: .cancel())
      }
  }

  var frontView: some View {
    VStack(alignment: .center) {
      Spacer()
      Text(cardViewModel.card.question)
        .foregroundColor(.white)
        .font(.system(size: 20))
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
        .padding(20.0)
      Spacer()
      if !cardViewModel.card.successful {
        Text("You answered this one incorrectly before")
          .foregroundColor(.white)
          .font(.system(size: 11.0))
          .fontWeight(.bold)
          .padding()
      }
    }
  }

  var backView: some View {
    VStack {
      // 1
      Spacer()
      Text(cardViewModel.card.answer)
        .foregroundColor(.white)
        .font(.body)
        .padding(20.0)
        .multilineTextAlignment(.center)
        .animation(.easeInOut)
      Spacer()
      // 2
      HStack(spacing: 40) {
        Button(action: markCardAsSuccesful) {
          Image(systemName: "hand.thumbsup.fill")
            .padding()
            .background(Color.green)
            .font(.title)
            .foregroundColor(.white)
            .clipShape(Circle())
        }
        Button(action: markCardAsUnsuccesful) {
          Image(systemName: "hand.thumbsdown.fill")
            .padding()
            .background(Color.blue)
            .font(.title)
            .foregroundColor(.white)
            .clipShape(Circle())
        }
      }
      .padding()
    }
    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
  }

  private func markCardAsUnsuccesful() {
    var updatedCard = cardViewModel.card
    updatedCard.successful = false
    update(card: updatedCard)
  }

  private func markCardAsSuccesful() {
    var updatedCard = cardViewModel.card
    updatedCard.successful = true
    update(card: updatedCard)
  }

  func update(card: Card) {
    cardViewModel.update(card: card)
    showContent.toggle()
  }
}
