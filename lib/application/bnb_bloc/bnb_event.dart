part of 'bnb_bloc.dart';

sealed class BnbEvent extends Equatable {
  const BnbEvent();

  @override
  List<Object> get props => [];
}

class TabChangeEvent extends BnbEvent{
  final int tabIndex;

  const TabChangeEvent({required this.tabIndex});
}
