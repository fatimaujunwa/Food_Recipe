import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_recipe_review/app_colors.dart';
import 'package:food_recipe_review/text_dimensions.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

  //https://img.bslmeiyu.com/uploads/20170706/The%20Bananas%20Song%20%20Counting%20Bananas%20%20Super%20Simple%20Songs.mp4
//https://www.youtube.com/watch?v=4aZr5hZXP_s
  // https://www.youtube.com/watch?v=KpP73uE1688&list=RDKpP73uE1688&start_radio=1
  onTapVideo(int i){
    final controller =VideoPlayerController.network("https://www.youtube.com/watch?v=4aZr5hZXP_s");
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
  late YoutubePlayerController controller;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
 final videoID=YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=BBAyRBTfsOU");
 controller=YoutubePlayerController(initialVideoId: videoID!,
   flags:  const YoutubePlayerFlags(autoPlay: false)
 );
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
    return Scaffold(
      body: Column(children: [
        YoutubePlayer(controller: controller,
          showVideoProgressIndicator: true,
          onReady: ()=>debugPrint("ready"),
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.white
              ),
            ),
            PlaybackSpeedButton()

          ],


        )

      ],),
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
class YouTubePlayer extends StatefulWidget {
  const YouTubePlayer({Key? key}) : super(key: key);

  @override
  State<YouTubePlayer> createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const url="https://www.youtube.com/watch?v=BBAyRBTfsOU";
    controller=YoutubePlayerController(initialVideoId: url!,
        flags:  const YoutubePlayerFlags(autoPlay: false)
    );
  }
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(player: YoutubePlayer(controller: controller,),


        builder: (context,player){
          return Scaffold(
            body: Column(children: [
              YoutubePlayer(controller: controller,
                showVideoProgressIndicator: true,
                onReady: ()=>debugPrint("ready"),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.white
                    ),
                  ),
                  PlaybackSpeedButton()

                ],


              ),
              ElevatedButton(onPressed: (){
                const url="https://www.youtube.com/watch?v=BBAyRBTfsOU";
controller.toggleFullScreenMode();
if(controller.value.isPlaying){
  controller.pause();
}
else{
  controller.play();
}
              }, child: Text('Play'))

            ],),
          );
        });
  }
}

