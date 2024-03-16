import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks/domain/post_model.dart';
import 'package:code_geeks/infrastructure/post_repo.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepo postRepo = PostRepo();
  PostBloc(this.postRepo) : super(PostInitial()) {
    on<FeedsLoadEvent>(loadFeeds);
  }

  FutureOr<void> loadFeeds(FeedsLoadEvent event, Emitter<PostState> emit)async{
    emit(PostInitial());
    Future.delayed(Duration(seconds: 6));
    final feed = await postRepo.getFeeds();
    emit(FeedLoadedState(postList:feed ));
  }
}
