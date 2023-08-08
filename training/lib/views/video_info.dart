import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';

import 'home_page.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {

  List info=[];
  bool _playArea = false;
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _disosed = false;
  int _isPlayingIndex = -1;


  var _onUpdateControllerTime;
   Duration? _duration;
   Duration? _position;
  var _progress = 0.0;

  _initData()async{
   await DefaultAssetBundle.of(context).loadString("json/video_info.json").then((value){
     setState(() {
       info = jsonDecode(value);
     });
    });
  }

  @override
  void initState(){
    super.initState();
    _initData();
  }

  @override
  void dispose(){
    _disosed=true;
    _controller.pause();
    _controller.dispose();
    //_controller=null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea==false?BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.9),
              Colors.white,
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight
          )
        ):const BoxDecoration(color: Color(0xFF6985e8)),
        child: Column(
          children: [
            _playArea==false?Container(
              padding: const EdgeInsets.only(top: 70,left: 30,right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap:(){
                          Get.back();
                        },
                          child: const Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)
                      ),
                      Expanded(child: Container()),
                      const Icon(Icons.info_outline,size: 20,color: Colors.white,)
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text('Leg Toning',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),
                  const SizedBox(height: 5,),
                  const Text('and Glutes Workout',style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors:[
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.3),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight
                          )
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer,size: 20,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text("8 min",style: TextStyle(
                              fontSize: 14,
                              color: Colors.white
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 230,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors:[
                                  Colors.white.withOpacity(0.1),
                                  Colors.white.withOpacity(0.3),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight
                            )
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.handyman_outlined,size: 20,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text("Resistent band, kettebell",style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ):Container(
             child: Column(
               children: [
                 Container(
                   height: 100,
                   padding: EdgeInsets.only(left: 30,right: 30),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       InkWell(
                         onTap: (){
                            Get.back();
                         },
                         child: const Icon(Icons.arrow_back_ios, size: 20, color: Color(0xFFb7bce8),),
                       ),
                       Icon(Icons.info_outline,size: 20,color: Color(0xFFb7bce8),)
                     ],
                   ),
                 ),
                 _playView(context),
                 _controllView(context),
               ],
             ),
            ),
            Expanded(child: Container(
              padding: const EdgeInsets.only(left: 30,right: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70)
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Circuit 1: Legs Toning",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6985e8)
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.loop,size: 25,color: Color(0xFF6985e8),),
                          SizedBox(width: 10,),
                          Text("3 sets",style: TextStyle(
                            fontSize: 15,color: Color(0xFF6985e8),
                            fontWeight: FontWeight.w500
                          ),)
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                      child: _listView()
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  String convertTwo(int value){
    return value < 10 ? "0$value" : "0$value";
  }

  Widget _controllView(BuildContext context){

    _duration = _controller.value.duration;
    final noMute = (_controller.value.volume??0)>0;
    final duration = _duration?.inSeconds??0;
    final head = _position?.inSeconds??0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.red[700],
                inactiveTrackColor: Colors.red[100],
                trackShape: const RoundedRectSliderTrackShape(),
                trackHeight: 2.0,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
                thumbColor: Colors.redAccent,
                //overlayColor: Colors.red.withOpacity(32),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 2.0),
                tickMarkShape: const RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.red[700],
                inactiveTickMarkColor: Colors.red[100],
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.redAccent,
                valueIndicatorTextStyle: const TextStyle(
                  color: Colors.white,
                )
            ),
            child: Slider(
              value: max(0, min(_progress*100,100)),
              min: 0,
              max: 100,
              divisions: 100,
              label: _position.toString().split(".")[0],
              onChanged: (value){
                setState(() {
                  _progress = value * 0.01;
                });
              },
              onChangeStart: (value){
                _controller.pause();
              },
              onChangeEnd: (value){
                final duration = _controller.value.duration;
                if(duration != null){
                  var newValue = max(0, min(value,99))*0.01;
                  var millis = (duration.inMilliseconds*newValue).toInt();
                  _controller.seekTo(Duration(milliseconds: millis));
                  _controller.play();
                }
              },
            )
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top:8,bottom: 8,left: 25,right: 30),
          color: const Color(0xFF6985e8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  if(noMute){
                    _controller.setVolume(0);
                  }else{
                    _controller.setVolume(1.0);
                  }
                  setState(() {

                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0,0.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(50,0,0,0),
                        )
                      ]
                    ),
                    child: Icon(noMute?Icons.volume_up:Icons.volume_off,color: Colors.white,),
                  ),
                ),
              ),
              FloatingActionButton(
                  onPressed: (){
                    final index = _isPlayingIndex-1;
                    if(index>=0 && info.length>= 0){
                      _initializeVideo(index);
                    }else{
                      Get.snackbar('Video', "",
                          snackPosition: SnackPosition.BOTTOM,
                          icon: Icon(Icons.face,size: 30,color: Colors.white,),
                          backgroundColor: Colors.blue.withOpacity(0.8),
                          colorText: Colors.white,
                          messageText: Text('No videos ahead!',style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),));
                    }
                  },
                child: Icon(Icons.fast_rewind,size: 36, color: Colors.white,),
              ),
              FloatingActionButton(
                onPressed: (){
                  if(_isPlaying){
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller.pause();
                  }else{
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller.play();
                  }
                },
                child: Icon(_isPlaying?Icons.pause:Icons.play_arrow,size: 36, color: Colors.white,),
              ),
              FloatingActionButton(
                onPressed: (){
                  final index = _isPlayingIndex+1;
                  if(index<=info.length-1){
                    _initializeVideo(index);
                  }else{
                    Get.snackbar('video List', '',
                    snackPosition: SnackPosition.BOTTOM,
                      icon: Icon(Icons.face,size: 30,color: Colors.white,),
                      backgroundColor: Colors.blue.withOpacity(0.8),
                      colorText: Colors.white,
                      messageText: Text('You nave finished watching all the videos. Congrats !',style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),)
                    );
                  }
                },
                child: Icon(Icons.fast_forward,size: 36, color: Colors.white,),
              ),
              Text(
                "$mins:$secs",
                style: const TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0,1.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(150, 0, 0, 0)
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _playView(BuildContext context){
      final controller = _controller;
      if(controller!=null && controller.value.isInitialized){
        return AspectRatio(
          aspectRatio: 16/9,
          child: VideoPlayer(controller),
        );
      }else{
        return const AspectRatio(
            aspectRatio: 16/9,
            child: Center(child: Text('Preparing....',style: TextStyle(
              fontSize: 20,
              color: Colors.white60
            ),)));
      }
  }

  void _onControllerUpdate()async{
    if(_disosed){
      return ;
    }
    _onUpdateControllerTime=0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if(_onUpdateControllerTime>now){
      return;
    }
    _onUpdateControllerTime=now+500;
    final controller = _controller;

    if(controller == null){
      debugPrint('controller is null');
      return;
    }
    if(!controller.value.isInitialized){
      debugPrint('controller can not be initialize');
      return;
    }
    if(_duration == null){
      _duration = _controller.value.duration;
    }
    var duration = _duration;
    if(duration == null) return;
    var position = await controller.position;
    _position = position!;
    final playing = controller.value.isPlaying;
    if(playing){
      if(_disosed)return;
      setState(() {
        _progress = position.inMilliseconds.ceilToDouble()/duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying=playing;
  }

  _initializeVideo(int index){
    final controller = VideoPlayerController.network(info[index]['videoUrl']);
    final old = _controller;
    _controller = controller;
    if(old!=null){
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
    ..initialize().then((_){
      old.dispose();
      _isPlayingIndex=index;
      controller.addListener(_onControllerUpdate);
          controller.play();
      setState(() {});
    });
  }

  _onTapVideo(int index){
    final controller = VideoPlayerController.network(info[index]['videoUrl']);
    _controller = controller;
    setState(() {});
    controller..initialize().then((_){
      _controller.play();
      setState(() {});
    });
  }

  _listView(){
    return ListView.builder(
        itemCount: info.length,
        itemBuilder: (context, i){
          return GestureDetector(
            onTap: (){
              _onTapVideo(i);
              debugPrint(i.toString());
              setState(() {
                if(_playArea == false){
                  _playArea=true;
                }
              });
            },
            child: _buildCard(i),
          );
        }
    );
  }

  _buildCard(int i){
      return Container(
        height: 100,
        //color: Colors.redAccent,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(info[i]['thumbnail']),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(info[i]['title'],style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      color: Color(0xFF6985e8)
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(info[i]['time'],style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF839fed),
                          fontWeight: FontWeight.w500
                      ),),
                    ),

                  ],
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFeaeefc),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('15s rest', style: TextStyle(
                        color: Color(0xFF839fed)
                    ),),
                  ),
                ),
                Row(
                  children: [
                    for(int i=0; i<70; i++)
                      i.isEven?Container(
                        width: 3,
                        height: 1,
                        decoration: BoxDecoration(
                            color: const Color(0xFF839fed),
                            borderRadius: BorderRadius.circular(2)
                        ),
                      ):Container(
                        width: 3,
                        height: 1,
                        color: Colors.white,)
                  ],
                )
              ],
            )
          ],
        ),
      );
  }
}
