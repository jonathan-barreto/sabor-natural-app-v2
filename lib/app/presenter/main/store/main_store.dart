import 'package:flutter/material.dart';
import 'package:natural_app/app/core/state/raw_state.dart';
import 'package:natural_app/app/data/repositories/main_repository.dart';
import 'package:natural_app/app/presenter/main/state/main_state.dart';

class MainStore extends ValueNotifier<RawState> {
  final MainRepository repository;

  MainStore({required this.repository}) : super(const IdleState());

  Future<void> initial() async {
    final int quantity = await repository.getTotalProductsInCart();

    value = SuccessState<MainState>(
      output: MainState.initial(
        quantity: quantity,
      ),
    );
  }

  Future<void> updateCart() async {
    final int quantity = await repository.getTotalProductsInCart();

    value = SuccessState<MainState>(
      output: MainState.initial(
        quantity: quantity,
      ),
    );
  }

  void selectIndex({required int index}) {
    if (value is SuccessState<MainState>) {
      value = SuccessState(
        output: MainState.selectIndex(
          index: index,
        ),
      );
    }
  }
}
