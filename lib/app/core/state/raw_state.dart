abstract class RawState {
  const RawState();
}

class IdleState extends RawState {
  const IdleState();
}

class SuccessState<Output> extends RawState {
  final Output output;

  const SuccessState({required this.output});
}

class ErrorState extends RawState {
  final String message;

  const ErrorState({required this.message});
}

class LoadingState extends RawState {
  const LoadingState();
}