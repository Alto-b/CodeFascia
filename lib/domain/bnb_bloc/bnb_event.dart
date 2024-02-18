part of 'bnb_bloc.dart';

sealed class BnbEvent extends Equatable {
  const BnbEvent();

  @override
  List<Object> get props => [];
}

class TabChangeEvent extends BnbEvent{
  final int tabIndex;

  TabChangeEvent({required this.tabIndex});
}
