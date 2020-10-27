import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app_assignment/widgets/Custom_button.dart';
import 'package:music_app_assignment/widgets/sizedbox.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Duration _duration = Duration();
  Duration _position = Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";
  CarouselSlider carouselSlider;
  int _current = 1;
  List imgList = [
    Color(0xFFCAE7F0).toString(),
    Color(0xFFCAE7F0).toString(),
    Color(0xFFCAE7F0).toString(),
  ];

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });
    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget slider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 3.0,
      ),
      child: Slider(
          value: _position.inSeconds.toDouble(),
          min: 0.0,
          activeColor: Colors.grey[600],
          inactiveColor: Colors.grey[400],
          max: _duration.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              seekToSecond(value.toInt());
              value = value;
            });
          }),
    );
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  Widget indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(imgList, (index, url) {
        return Container(
          width: 14.0,
          height: 14.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index ? Colors.grey[700] : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget carouselImage() {
    return CarouselSlider(
      height: 254.25,
      initialPage: 1,
      enlargeCenterPage: true,
      reverse: false,
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      items: imgList.map((imgUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  color: Color(0xFFCAE7F0),
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Stack(
                children: [
                  Positioned(
                    top: 31.29,
                    left: 29.08,
                    child: Container(child: Image.asset("assets/Cloud.png")),
                  ),
                  Positioned(
                    top: 107.57,
                    left: 154.34,
                    child: Container(child: Image.asset("assets/Cloud.png")),
                  ),
                  Positioned(
                    top: 46.0,
                    left: 62.63,
                    child:
                        Container(child: Image.asset("assets/Vector 10.png")),
                  ),
                  Positioned(
                    top: 74.0,
                    left: 65.56,
                    child:
                        Container(child: Image.asset("assets/Ellipse 5.png")),
                  ),
                  Positioned(
                    top: 142.0,
                    left: 74.43,
                    child: Container(child: Image.asset("assets/Line 3.png")),
                  ),
                  Positioned(
                    top: 184.0,
                    left: 120.08,
                    child: Container(child: Image.asset("assets/Line 23.png")),
                  ),
                  Positioned(
                    top: 120.0,
                    left: 110.0,
                    child: Container(child: Image.asset("assets/Line 27.png")),
                  ),
                  Positioned(
                    top: 116.0,
                    left: 136.0,
                    child: Container(child: Image.asset("assets/Line 30.png")),
                  ),
                  Positioned(
                    top: 140.76,
                    left: 140.31,
                    child:
                        Container(child: Image.asset("assets/Vector 11.png")),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget localAsset({bool isActive = true}) {
    return Column(
      children: [
        Text(
          'Cheap Thrill',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        CustomSizedBox(height: 10),
        Text('Sia', style: TextStyle(fontSize: 16)),
        CustomSizedBox(height: 40),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomRaisedButton(
                  iconData: Icons.arrow_back_ios,
                  onPressed: () => audioCache.play(
                      'Cheap Thrills Sia Mp3 English Song Filmysongs.co.mp3'),
                  size: 16,
                  height: 40,
                  width: 40),
              CustomRaisedButton(
                  iconData: isPlaying ? Icons.pause : Icons.play_arrow,
                  onPressed: () {
                    if (isPlaying) {
                      advancedPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      advancedPlayer.resume();
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  size: 30,
                  height: 60,
                  width: 60),
              CustomRaisedButton(
                  iconData: Icons.arrow_forward_ios,
                  onPressed: () => advancedPlayer.resume(),
                  size: 16,
                  height: 40,
                  width: 40),
            ],
          ),
        ),
        CustomSizedBox(height: 40),
        slider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentTime,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                completeTime,
                style: TextStyle(fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget view() {
    return Container(
      margin: EdgeInsets.only(top: 80),
      child: Column(
        children: <Widget>[
          indicator(),
          CustomSizedBox(height: 20),
          carouselImage(),
          CustomSizedBox(height: 60),
          localAsset()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view(),
    );
  }
}
