import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){ FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id); },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AspectRatio(aspectRatio: 16.0 / 9.0, child: Image.network(video.thumb, fit: BoxFit.cover)),
              Row(children: <Widget>[
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(8, 8, 8, 0), child: Text(video.title, maxLines: 2, style: TextStyle(fontSize: 16, color: Colors.white))),
                  Padding(padding: EdgeInsets.all(8.0), child: Text("${video.channel}", style: TextStyle(fontSize: 14, color: Colors.white)))
                ])),
                StreamBuilder(
                    stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return IconButton(icon: Icon(snapshot.data.containsKey(video.id) ? Icons.star : Icons.star_border), iconSize: 30, color: Colors.white, onPressed: (){BlocProvider.of<FavoriteBloc>(context).toogleFavorite(video);});
                      }else{
                        return CircularProgressIndicator();
                      }
                    })
              ])
            ],
          ),
        ));
  }
}
