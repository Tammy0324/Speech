import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../search/dictionary_provider.dart';
import '../search/status_provider.dart';
import '../search/word_with_icons.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void createSnackBar(String message) {
      final snackBar = SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer(
      builder: (context, watch, child) {
        var queryListener = watch(queryProvider);
        var response = watch(getQueryResponse(queryListener.query));
        FloatingSearchBarController controller = FloatingSearchBarController();
        print("From consumer");
        print(StatusProvider().status);
        return Scaffold(
          backgroundColor: Colors.blueAccent,
          appBar: AppBar(
            title: Text(
              "單字查詢",
            ),
            backgroundColor: Colors.blueAccent,
            elevation: 0,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            child: FloatingSearchBar(
              controller: controller,
              borderRadius: BorderRadius.circular(15),
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 100),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              axisAlignment: isPortrait ? 0.0 : -1.0,
              openAxisAlignment: 0.0,
              width: isPortrait ? 600 : 500,
              debounceDelay: const Duration(milliseconds: 100),
              clearQueryOnClose: false,
              transition: CircularFloatingSearchBarTransition(),
              onSubmitted: (val) {
                if (val == "") {
                  print(val);
                  controller.close();
                  createSnackBar("Please enter keyword to find meaning ");
                  queryListener.listenFlag = true;
                  return;
                } else {
                  queryListener.query = val.toString();
                  queryListener.listenFlag = true;
                  watch(getQueryResponse(queryListener.query));
                  watch(getErrorResponse(queryListener.query));
                  controller.close();
                  // createSnackBar(
                  //     "${response.data.value.length} results for you");
                }
              },
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(
                      Icons.search_rounded,
                    ),
                    onPressed: () {
                      queryListener.listenFlag = true;
                      watch(getQueryResponse(queryListener.query));
                      watch(getErrorResponse(queryListener.query));
                      controller.close();
                    },
                  ),
                ),
                FloatingSearchBarAction.searchToClear(
                  showIfClosed: false,
                ),
              ],
              builder: (context, transition) {},
              body: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: queryListener.listenFlag
                    ? Consumer(
                        builder: (context, watch, child) {
                          return Container(
                            child: response.map(
                              data: (res) {
                                AssetsAudioPlayer assetAudioPlayer =
                                    AssetsAudioPlayer();
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: res.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 15.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            wordWithIcons(res, index, context,
                                                assetAudioPlayer),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Container(
                                              child: Text(
                                                '${res.value[index].meanings.isEmpty ? "" : res.value[index].meanings.first.partOfSpeech}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Container(
                                              child: Text(
                                                '${res.value[index].meanings.isEmpty ? "" : res.value[index].meanings.first.definitions.first.definition}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              loading: (_) => SizedBox(
                                child: Center(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                              error: (_) {
                                return Text(
                                  _.error.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Please enter word to see meaning',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
