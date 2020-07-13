import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/api.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
          stream: BlocProvider.of<FavoriteBloc>(context).outFav,
          initialData: {},
          builder: (context, snapshot){
            return ListView(
              children: snapshot.data.values.map((v){
                return InkWell(
                  child: Row(
                    children: <Widget>[
                      Container(height: 100, width: 50, child: Image.network(v.thumb)),
                      Expanded(child: Text(v.title, style: TextStyle(color: Colors.white70), maxLines: 2))
                    ],
                  ),
                  onTap: (){ FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: v.id); },
                  onLongPress: (){ BlocProvider.of<FavoriteBloc>(context).toogleFavorite(v); },
                );
              }).toList(),
            );
          }
      ),
    );
  }
}
