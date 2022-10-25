import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_recipe_review/app_colors.dart';
import 'package:food_recipe_review/text_dimensions.dart';
import 'package:video_player/video_player.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool disposed=true;
  List info = [];
  VideoPlayerController? _controller;

  bool isPlaying=false;
  Widget controlView(BuildContext context){

    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      color: Colors.lightBlueAccent.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         InkWell( onTap: ()async{

          }, child: Icon(Icons.fast_rewind, size: 36,color: Colors.white,)),
          InkWell( onTap: ()async{
            if(isPlaying){
              print('pause');
              _controller?.pause();
              setState(() {
                isPlaying=false;
              });
            }else{
              print('play');
              setState(() {
                isPlaying=true;
                onTapVideo(1);
              });
              _controller?.play();
            }
          }, child: Icon( isPlaying?Icons.pause:Icons.play_arrow, size: 36,color: Colors.white,)),
         InkWell( onTap: ()async{

          }, child: Icon(Icons.fast_forward, size: 36,color: Colors.white,)),
        ],
      ),
    );
  }
  Widget playView(BuildContext context){
    final controller= _controller;
    if(controller!=null&&controller.value.isInitialized){
      return AspectRatio(
        aspectRatio: 16/4,
        child: Container(
          height: 300,
          width: 300,
          child: VideoPlayer(controller),
        ),
      );
    }
    else{
      return AspectRatio(aspectRatio: 16/9,
          child: Center(child: Text('please wait')));
    }
  }
  void onControllerUpdate()async{
    if(disposed){
      return;
    }
    final controller=_controller;
    if(controller==null){
      debugPrint('controller is null');
      return;
    }
    if(!controller.value.isInitialized){
      debugPrint("controller can not be initialized");
      return;
    }
    final playing=controller.value.isPlaying;
    isPlaying=playing;

  }
  onTapVideo(int i){
    final controller =VideoPlayerController.network("https://img.bslmeiyu.com/uploads/20170706/The%20Bananas%20Song%20%20Counting%20Bananas%20%20Super%20Simple%20Songs.mp4");
    final old =_controller;
    _controller=controller;
    if(old!=null){
      old.removeListener(() { onControllerUpdate();});
      old.pause();
    }
    setState(() {

    });
    controller
      ..initialize().then((_) {
        old?.dispose();
        controller.addListener(() {
          onControllerUpdate();
        });
        controller.play();
        setState(() {

        });
      });
  }

  bool playArea=false;

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposed=true;
    _controller?.pause();
    _controller?.dispose();
    _controller=null;
  }

  @override
  Widget build(BuildContext context) {
    return
   Scaffold(
      body:

      Container(
        decoration:playArea==false?
        BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueAccent.shade100,
            Colors.lightBlueAccent.shade100
          ], end: Alignment.bottomRight, begin: Alignment.bottomLeft),
        ):BoxDecoration(
            color: Colors.lightBlueAccent.shade100
        ),
        child:
        Column(
          children: [
            SafeArea(
              child:playArea==false? Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onTap: () {
                           Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Legs Toning\nand glutes Workout',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.alarm,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '60 min',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.handyman,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Resistant band, Kettlebell',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ):
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      height: 100,
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(Icons.arrow_back_ios,
                              size: 20,
                              color: Colors.white,),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,size: 20,
                            color: Colors.white,),

                        ],
                      ),
                    ),
                    playView(context),
                    controlView(context),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                    )),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Circuit 1: Legs Toning',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.loop,
                                color: Colors.blue.shade300,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '3 sets',
                                style: TextStyle(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  onTapVideo(i);
                                  if(playArea==false){
                                    playArea=true;
                                  }
                                });

                              }
                              ,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                                height: 135,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            // image: DecorationImage(
                                            //     image: AssetImage(
                                            //         info[i]["thumbnail"]),
                                            //     fit: BoxFit.fill),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'text',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'text',
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.4)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: Color(0xffeaeefc),
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              '15s rest',
                                              style: TextStyle(
                                                  color: Color(0xff8339fed)),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            for(int i=0;i<70;i++)
                                              i.isEven?Container(
                                                height: 1,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffffffff),
                                                    borderRadius: BorderRadius.circular(2)
                                                ),
                                              ):Container(
                                                height: 1,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff839fed),
                                                    borderRadius: BorderRadius.circular(2)
                                                ),
                                              )

                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

//       Scaffold(
//         backgroundColor: Colors.white,
//         body:    Container(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 25, right: 25,bottom: 50),
//                 height: 100,
//                 child: Row(
//                   children: [
//                     InkWell(
//                       child: Icon(Icons.arrow_back_ios,
//                         size: 20,
//                         color: Colors.white,),
//                     ),
//                     Expanded(child: Container()),
//                     Icon(Icons.info_outline,size: 20,
//                       color: Colors.white,),
//
//                   ],
//                 ),
//               ),
//               playView(context),
//               controlView(context),
//             ],
//           ),
//         ),
//
//
//         // CustomScrollView(
//         //   slivers: [
//         //     SliverAppBar(
//         //       title: Row(
//         //         children: [
//         //           Icon(
//         //             Icons.arrow_back_ios,
//         //             color: Colors.black,
//         //           ),
//         //           SizedBox(
//         //             width: 20.w,
//         //           ),
//         //           Text(
//         //             'Spargetti Bolonese',
//         //             style: TextDimensions.style24RajdhaniW600WBlack,
//         //           )
//         //         ],
//         //       ),
//         //       pinned: true,
//         //       expandedHeight: 300,
//         //       backgroundColor: Colors.blue,
//         //       shadowColor: Colors.grey.withOpacity(0.5),
//         //       bottom: PreferredSize(
//         //           preferredSize: Size.fromHeight(20.h),
//         //           child: Container(
//         //             padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
//         //             // height: 816.h,
//         //             width: double.maxFinite,
//         //             decoration: BoxDecoration(
//         //               color: Colors.white,
//         //               borderRadius: BorderRadius.only(
//         //                 topRight: Radius.circular(30.r),
//         //                 topLeft: Radius.circular(30.r),
//         //               ),
//         //             ),
//         //           )),
//         //       flexibleSpace: FlexibleSpaceBar(
//         //         centerTitle: true,
//         //         background:
//         //         Container(
//         //           height: 100,
//         //           color: Colors.blue,
//         //         ),
//         //       ),
//         //     ),
//         //     SliverToBoxAdapter(
//         //         child: Container(
//         //       margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
//         //       child: Column(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         children: [
//         //           Text(
//         //             'Ingredients',
//         //             style: TextDimensions.style20RajdhaniW600Black,
//         //           ),
//         //           SizedBox(
//         //             height: 10.h,
//         //           ),
//         //           for (int index = 0; index < 4; index++)
//         //             Column(
//         //               children: [
//         //                 Container(
//         //                     height: 50.h,
//         //                     width: 375.w,
//         //                     decoration: BoxDecoration(
//         //                         color: AppColors.grey.withOpacity(0.2),
//         //                         borderRadius:BorderRadius.circular(10.r),
//         //                       border: Border.all(color: AppColors.orange)
//         //
//         //                     ),
//         //
//         //                 child: Row(
//         //
//         //                   children: [
//         //                   Icon(FontAwesomeIcons.cutlery),
//         //                   SizedBox(width: 20.w,),
//         //                   Text('A Cup of sugar',style: TextDimensions.style14RajdhaniW400Black,)
//         //                 ],),
//         //                 ),
//         //                 SizedBox(height: 10.h,)
//         //               ],
//         //             )
//         //         ],
//         //       ),
//         //     )),
//         //     SliverToBoxAdapter(
//         //         child: Container(
//         //           margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
//         //           child: Column(
//         //             crossAxisAlignment: CrossAxisAlignment.start,
//         //             children: [
//         //               Text(
//         //                 'Cooking Instructions',
//         //                 style: TextDimensions.style20RajdhaniW600Black,
//         //               ),
//         //               SizedBox(
//         //                 height: 10.h,
//         //               ),
//         //
//         //             ],
//         //           ),
//         //         )),
//         //   ],
//         // )
// //       Stack(
// //         children: [
// //           Container(height: 200,width: 375,
// //             // decoration: BoxDecoration(
// //             //     image: DecorationImage(image:
// //             //     NetworkImage(meals[0].strMealThumb!),
// //             //         fit: BoxFit.cover
// //             //
// //             //     )
// //             // ),
// //
// // color: Colors.pinkAccent,
// //
// //
// //           ),
// //           Container(
// //             margin: EdgeInsets.only(top: 350.h,left: 10.w,right: 10.w),
// //             height: 816.h,
// //
// //
// //           ),
// //           child:
// //           Container(
// //             margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 40.h),
// //             child:
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Icon(Icons.arrow_back_ios,color: AppColors.black,),
// //                 SizedBox(height: 40.h,),
// //                 Text('Watercress Salad',style: TextDimensions.style24RajdhaniW600WBlack,),
// //                 SizedBox(height: 15.h,),
// //                 Text('this recipe is a special one which originated from china',style: TextDimensions.style15RajdhaniW400Grey,),
// //                 Row(
// //
// //                   children: [
// //                     Container(height: 100,width: 120,color: Colors.red,),
// //                     CircleAvatar(radius: 100,backgroundColor: AppColors.orange,)
// //                   ],)
// //               ],
// //             ),
// //           ),
// //           // child: Column(),
// //           ),
// //         ],
// //       ),
//
//         );
  }
}
