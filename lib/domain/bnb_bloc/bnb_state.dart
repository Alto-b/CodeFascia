part of 'bnb_bloc.dart';

sealed class BnbState extends Equatable {
  const BnbState(this.tabIndex);
  
  @override
  List<Object> get props => [];
  final int tabIndex;

  
}

final class BnbInitial extends BnbState {
 const BnbInitial(super.tabIndex);
}
