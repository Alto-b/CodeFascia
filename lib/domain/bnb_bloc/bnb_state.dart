part of 'bnb_bloc.dart';

abstract class BnbState extends Equatable {
  const BnbState({required this.tabIndex});
  
  @override
  List<Object> get props => [];
  final int tabIndex;

  
}

final class BnbInitial extends BnbState {
 const BnbInitial({required super.tabIndex});

}
