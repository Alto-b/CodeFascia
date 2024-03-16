part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryLoadEvent extends HistoryEvent{
  String uid;
  HistoryLoadEvent({
    required this.uid
  }); 
}
