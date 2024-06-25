import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../view_model/music_model.dart';
import '../view_model/set_up_data.dart';

class PCHomePage extends StatefulWidget {
  const PCHomePage({super.key});
  @override
  State<PCHomePage> createState() => _PCHomePageState();
}

class _PCHomePageState extends State<PCHomePage> {

  // 通过单例获取
  final musicList = MusicManager.instance.musicList;

  //audio
  bool isPlaying = false;
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  void musicPlayerInit() {
    List<Audio> audios = [];
    for (MusicModel model in musicList) {
      audios.add(Audio(model.songUrl));
    }
    assetsAudioPlayer.open(
        Playlist(
            audios: audios
        ),
        loopMode: LoopMode.playlist //loop the full playlist
    );
  }

  void songOperator(int num){
    //0 :pause or play
    //1 :pre song
    //2 :next song
    if(assetsAudioPlayer.playlist == null){
      musicPlayerInit();
      debugPrint("init");
    }else{
      switch (num){
        case 0:{assetsAudioPlayer.playOrPause();}
        break;
        case 1:{assetsAudioPlayer.previous();}
        break;
        case 2:{assetsAudioPlayer.next();}
        break;
        default : break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Directory"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              assetsAudioPlayer.playlistPlayAtIndex(index);
              setState(() {
                isPlaying = true;
              });
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/music_default.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.skip_previous),
              color: Colors.white,
              onPressed: () {
                songOperator(1);
                setState(() {
                  isPlaying = true;
                });
              },
            ),
            IconButton(
              icon: Icon(isPlaying?Icons.pause_circle:Icons.play_arrow),
              color: Colors.white,
              onPressed: () {
                songOperator(0);
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              color: Colors.white,
              onPressed: () {
                songOperator(2);
                setState(() {
                  isPlaying = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
