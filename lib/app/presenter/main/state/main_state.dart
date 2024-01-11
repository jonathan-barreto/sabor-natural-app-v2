class MainState {
  final int? indexSelected;
  final int? quantity;

  MainState({
    this.indexSelected,
    this.quantity,
  });

  factory MainState.initial({required int quantity}) {
    return MainState(
      indexSelected: 0,
      quantity: quantity,
    );
  }

  factory MainState.selectIndex({required int index}) {
    return MainState(
      indexSelected: index,
    );
  }

  factory MainState.updateQuantity({required int quantity}) {
    return MainState(
      quantity: quantity,
    );
  }

  MainState copyWith({int? index, int? quantity}) {
    return MainState(
      indexSelected: index ?? indexSelected,
      quantity: quantity ?? this.quantity,
    );
  }
}
