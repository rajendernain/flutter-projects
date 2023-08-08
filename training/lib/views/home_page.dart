import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:training/views/video_info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List info=[];
  _initData(){
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value){
      info = jsonDecode(value);
    });
  }

  @override
  void initState(){
      super.initState();
      _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Training",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                ),),
                Expanded(child: Container()),
                const Icon(Icons.arrow_back_ios,size: 20,color: Colors.grey,),
                const Icon(Icons.calendar_today_outlined,size: 20,color: Colors.grey,),
                const Icon(Icons.arrow_forward_ios,size: 20,color: Colors.grey,)
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                const Text("Your Program",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),),
                Expanded(child: Container()),
                const Text("Details",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700
                  ),),
                SizedBox(width: 5,),
                InkWell(
                  onTap: (){
                    Get.to(()=>VideoInfo());
                  },
                  child: Icon(Icons.arrow_forward,size: 20,color: Colors.grey,)
                )
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Colors.blueAccent,
                  Colors.grey,
                ],
                begin: Alignment.bottomLeft,
                  end: Alignment.centerRight
                ),
                color: Colors.red,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(80)
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 10),
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.2),
                  )
                ]
              ),
              child:
              Container(
                padding: const EdgeInsets.only(top: 25,left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Next workout',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    const Text('Leg Toning',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white
                      ),),
                    const SizedBox(height: 5,),
                    const Text('and Glutes Workout',style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),),
                    Row(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.timer,size: 20,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text('60 min',style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(4,8)
                              )
                            ]
                          ),
                            child: const Icon(Icons.play_circle_fill,size: 60,color: Colors.white,)
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 0,),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 30),
                    height: 98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/card.png"),
                        fit:BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(1,3),
                          color: Colors.blue.withOpacity(0.3)
                        ),
                        BoxShadow(
                            blurRadius: 5,
                            offset: const Offset(1,5),
                            color: Colors.blue.withOpacity(0.3)
                        )
                      ]
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right: 200,top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage("assets/girl.png"),
                          //fit:BoxFit.fill,
                        ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 100,
                    margin: const EdgeInsets.only(left: 140, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("You are doing great",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),
                        const SizedBox(height: 10,),
                        RichText(text: const TextSpan(
                          text: "Keep it up\n",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14
                          ),
                          children: [
                            TextSpan(
                              text: "Stick to your plan"
                            )
                          ]
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Text("Area of foucs",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey
                ),),
              ),
            ),
            Expanded(child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                itemCount: (info.length.toDouble()/2).toInt(),
                  itemBuilder: (context, i){
                    int a = 2*i;
                    int b = 2*i+1;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5, top: 20),
                          width: (MediaQuery.of(context).size.width-90)/2,
                          height: 150,
                          margin: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            // image: DecorationImage(
                            //   image: AssetImage(
                            //     info[a]['img']
                            //   )
                            // ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: const Offset(5,8),
                                color: Colors.lightBlueAccent.withOpacity(0.1)
                              ),
                              BoxShadow(
                                  blurRadius: 3,
                                  offset: const Offset(1,5),
                                  color: Colors.lightBlueAccent.withOpacity(0.1)
                              ),
                            ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(info[a]['img']),
                                ),
                              ),
                              Text(info[a]['title'],style: const TextStyle(fontSize: 20,
                              color: Colors.grey),),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5, top: 20),
                          width: (MediaQuery.of(context).size.width-90)/2,
                          height: 150,
                          margin: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // image: DecorationImage(
                              //     image: AssetImage(
                              //         info[b]['img']
                              //     )
                              // ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: const Offset(-5,8),
                                    color: Colors.lightBlueAccent.withOpacity(0.1)
                                ),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: const Offset(1,5),
                                    color: Colors.lightBlueAccent.withOpacity(0.1)
                                ),
                              ]
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(info[b]['img']),
                                ),
                              ),
                              Text(info[b]['title'],style: TextStyle(fontSize: 20,
                                  color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    );
                  }
              ),
            ))
          ],
        ),
      ),
    );
  }
}
