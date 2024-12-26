
import 'package:fetchingdata/models/game.dart';
import 'package:fetchingdata/sources/game_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'live_game_event.dart';
part 'live_game_state.dart';

class LiveGameBloc extends Bloc<LiveGameEvent, LiveGameState> {
  LiveGameBloc() : super(LiveGameInitial()) {
    
    //Function Menampilkan Data
    FetchData();

    //Function Menyimpan Game
    SaveGame();
    
    //Function Menghapus Simpanan Game
    RemoveGame();
  }

  void RemoveGame() {
    return on<OnRemoveGame>((event, emit) {
    final games = (state as LiveGameLoaded).games;
    Game newGame = event.game.copyWith(isSaved: false);
    int index = games.indexWhere((e) => e.id==newGame.id);
    games[index] = newGame;
    emit(LiveGameLoaded(games));
  });
  }

  void SaveGame() {
    return on<OnSaveGame>((event, emit) {
    final games = (state as LiveGameLoaded).games;
    Game newGame = event.game.copyWith(isSaved: true);
    int index = games.indexWhere((e) => e.id==newGame.id);
    games[index] = newGame;
    emit(LiveGameLoaded(games));
  });
  }

  void FetchData() {
    return on<OnFetchLiveGame>((event, emit) async {
    emit(LiveGameLoading());
    List<Game>? result = await GameSource.getLiveGame();

    if (result==null){
      emit(LiveGameFailure('Terjadi Kesalahan'));
    } else{
      emit(LiveGameLoaded(result));
    }
    
  });
  }
}
