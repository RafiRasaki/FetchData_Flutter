import 'package:extended_image/extended_image.dart';
import 'package:fetchingdata/bloc/live_game_bloc.dart';
import 'package:fetchingdata/cubit/genre_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/game.dart';
import '../widget/item_game.dart';

class LiveGamePage extends StatefulWidget {
  const LiveGamePage({super.key});

  @override
  State<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends State<LiveGamePage> {
  List<String> genres = ['Shooter', 'MMOARPG', 'ARPG','Strategy','Fighting'];

  @override
  void initState() {
    context.read<LiveGameBloc>().add(OnFetchLiveGame());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Games'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<GenreCubit, String>(
            builder: (context,state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 3),
                  child: Row(
                    children: genres.map((genre) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: (){
                            context.read<GenreCubit>().onSelected(genre);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black87,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              //TernaryOperator
                              color: genre==state
                              ? Theme.of(context).primaryColor 
                              : Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9, 
                              vertical: 3,
                            ),
                            child: Text(
                              genre, 
                              style: TextStyle(
                                color: genre==state
                              ? Colors.white
                              : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    ),
                ),
                );
            }
          ),

          
          Expanded(
            child: BlocBuilder<LiveGameBloc, LiveGameState>(
              builder: (context, state) {
                if(state is LiveGameLoading){
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                }
                if(state is LiveGameFailure){
                  return Center(
                    child: Text(state.message)
                  );
                }
                 if(state is LiveGameLoaded){
                  List<Game> games = state.games; 
                  if (games.isEmpty){
                     return const Center(child:Text('Empty')); 
                  }
                  return BlocBuilder<GenreCubit, String>(
                    builder: (context,genreState) {
                       List<Game> list = games.where((element) => 
                       element.genre==genreState).toList();
                      return GridView.builder(
                        itemCount: list.length,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.all(2),
                        gridDelegate: 
                         const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2
                          ), 
                        itemBuilder: (context, index){
                          Game game = list[index];
                          return ItemGame(
                            game: game,
                            onSaveClick: (){
                              if(game.isSaved){
                                context.read<LiveGameBloc>().add(OnRemoveGame(game));
                              }else{
                                context.read<LiveGameBloc>().add(OnSaveGame(game));
                              }
                            },
                          );
                        }
                        );
                    }
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

