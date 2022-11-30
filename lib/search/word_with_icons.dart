import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dictionay_model.dart';

Column wordWithIcons(AsyncData<List<DictionaryModel>> res, int index,
    BuildContext context, AssetsAudioPlayer assetAudioPlayer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text(
                '${res.value[index].word}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Center(
              child: Text(
                '${res.value[index].phonetics.first.text}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  child: IconButton(
                    tooltip: "Copy to Clipboard",
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: res.value[index].word),
                      ).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Text is copied "),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.copy_rounded,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
                Text(
                  "Copy",
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  child: IconButton(
                    tooltip: "Play pronunciation",
                    onPressed: () {
                      assetAudioPlayer.open(
                        Audio.network(res.value[index].phonetics.first.audio),
                      );
                    },
                    icon: Icon(
                      Icons.volume_up_rounded,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
                Text(
                  "Listen",
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ],
  );
}