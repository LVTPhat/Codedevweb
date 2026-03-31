import 'dart:typed_data';

import 'package:calendar_view/calendar_view.dart';
import 'package:codedevweb/app/modules/weddinginfor/views/components/animationimage.dart';
import 'package:codedevweb/app/modules/weddinginfor/views/components/network_image_custom.dart';
import 'package:codedevweb/app/modules/weddinginfor/views/components/slideanimationcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controllers/weddinginfor_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class WeddinginforView extends GetView<WeddinginforController> {
  static MapController mapController = MapController();
  const WeddinginforView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final commonWidth = screenWidth * 0.9;
    final controller = Get.put(WeddinginforController());
    final imageScale = 90 / 60;
    final infor2Style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return CalendarControllerProvider(
        controller: EventController(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('WeddinginforView'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.onSaveWeddingInfor,
            child: Icon(Icons.check_circle),
          ),
          body: Obx(
            () => controller.isLoading
                ? Text("Loading")
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth,
                          height: screenWidth * imageScale,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: screenWidth,
                                height: screenWidth * imageScale,
                                child: NetworkImageCustom(
                                  imageMemo: controller.listImage[0],
                                  imageUrl:
                                      controller.weddingInfor.image1 ?? "",
                                  isChooseImage:
                                      controller.listChooseImage[0].value,
                                  dowloadImage: controller.listDowloadImage[0],
                                  onGetImage: () {
                                    controller.onTapPickImage(0);
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  VisibilityDetector(
                                      key: Key("name-animation-key"),
                                      child: Obx(() => AnimatedScale(
                                            scale: controller.nameScale,
                                            curve: Curves.linear,
                                            duration: Duration(seconds: 1),
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 30, 0, 0),
                                                child: RotationTransition(
                                                  turns:
                                                      new AlwaysStoppedAnimation(
                                                          -5 / 360),
                                                  child: new Text(
                                                    "Tứ Thiên - Như Ý",
                                                    style:
                                                        TextStyle(fontSize: 40),
                                                  ),
                                                )),
                                          )),
                                      onVisibilityChanged:
                                          (VisibilityInfo info) {
                                        final height =
                                            info.visibleBounds.height;
                                        final currentIsShow = height > 0;
                                        if (controller.nameScale == 0.5 &&
                                            currentIsShow) {
                                          controller.nameScale = 1;
                                        }

                                        if (!currentIsShow) {
                                          controller.nameScale = 0.5;
                                        }
                                        // print(info.visibleBounds.height);
                                      }),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, screenHeight * 0.2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.6,
                                            child: Column(
                                              children: [
                                                SlideAnimationCard(
                                                  animationKey:
                                                      Key("thu-moi-1"),
                                                  width: screenWidth * 0.6,
                                                  height: 35,
                                                  offset: Offset(0, 1),
                                                  child: Center(
                                                    child: Text(
                                                      "THƯ MỜI TỆC CƯỚI",
                                                      style: TextStyle(
                                                          fontSize: 22),
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.black87,
                                                  thickness: 3,
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                SlideAnimationCard(
                                                  animationKey:
                                                      Key("thu-moi-2"),
                                                  width: screenWidth * 0.6,
                                                  height: 40,
                                                  offset: Offset(0, 1),
                                                  child: Center(
                                                    child: Text(
                                                      "THỨ 7 - 9h00",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                SlideAnimationCard(
                                                  animationKey:
                                                      Key("thu-moi-3"),
                                                  width: screenWidth * 0.6,
                                                  height: 40,
                                                  offset: Offset(0, 1),
                                                  child: Center(
                                                    child: Text(
                                                      "24 . 5 . 2025",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.black87,
                                                  thickness: 3,
                                                  indent: 10,
                                                  endIndent: 10,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hôn nhân là chuyện cả đời,",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Yêu người vừa ý cưới người mình thương",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 250,
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "NHÀ TRAI",
                                          style: infor2Style,
                                        ),
                                        Text(
                                          "BÀ PHẠM THỊ CHỌN",
                                          style: infor2Style,
                                        ),
                                        Text(
                                          "　",
                                          style: infor2Style,
                                        ),
                                        SizedBox(
                                          height: 100,
                                        ),
                                        Text(
                                          "Chú Rể",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SlideAnimationCard(
                                          animationKey: Key("person-1-name"),
                                          width: screenWidth * 0.5,
                                          height: 46,
                                          offset: Offset(0, 1),
                                          child: Center(
                                            child: Text(
                                              "Võ Tứ Thiên",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "NHÀ GÁI",
                                          style: infor2Style,
                                        ),
                                        Text(
                                          "ÔNG NGUYỄN VĂN CAO",
                                          style: infor2Style,
                                        ),
                                        Text(
                                          "BÀ LÊ THỊ HỪNG",
                                          style: infor2Style,
                                        ),
                                        SizedBox(
                                          height: 100,
                                        ),
                                        Text(
                                          "Cô Dâu",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SlideAnimationCard(
                                          animationKey: Key("person-2-name"),
                                          width: screenWidth * 0.5,
                                          height: 46,
                                          offset: Offset(0, 1),
                                          child: Center(
                                            child: Text(
                                              "Nguyễn Như Ý",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          width: commonWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SlideAnimationCard(
                                animationKey: Key("person-1"),
                                height: commonWidth * 0.48 * imageScale,
                                width: commonWidth * 0.48,
                                offset: Offset(-1, 0),
                                child: Center(
                                  child: Obx(
                                    () => NetworkImageCustom(
                                      imageMemo: controller.listImage[1],
                                      imageUrl:
                                          controller.weddingInfor.image2 ?? "",
                                      isChooseImage:
                                          controller.listChooseImage[1].value,
                                      dowloadImage:
                                          controller.listDowloadImage[1],
                                      onGetImage: () {
                                        controller.onTapPickImage(1);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SlideAnimationCard(
                                animationKey: Key("person-2"),
                                height: commonWidth * 0.48 * imageScale,
                                width: commonWidth * 0.48,
                                offset: Offset(1, 0),
                                child: Obx(
                                  () => Center(
                                    child: NetworkImageCustom(
                                      imageMemo: controller.listImage[2],
                                      imageUrl:
                                          controller.weddingInfor.image3 ?? "",
                                      isChooseImage:
                                          controller.listChooseImage[2].value,
                                      dowloadImage:
                                          controller.listDowloadImage[2],
                                      onGetImage: () {
                                        controller.onTapPickImage(2);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 40,
                          color: Colors.black87,
                          thickness: 3,
                          indent: 10,
                          endIndent: 10,
                        ),
                        VisibilityDetector(
                            key: Key("thu-moi-4"),
                            child: Obx(() => AnimatedScale(
                                  scale: controller.inviteScale,
                                  curve: Curves.linear,
                                  duration: Duration(seconds: 1),
                                  child: Text("Thư mời",
                                      style: TextStyle(fontSize: 38)),
                                )),
                            onVisibilityChanged: (VisibilityInfo info) {
                              final height = info.visibleBounds.height;
                              final currentIsShow = height > 0;
                              if (controller.inviteScale == 0.5 &&
                                  currentIsShow) {
                                controller.inviteScale = 1;
                              }

                              if (!currentIsShow) {
                                controller.inviteScale = 0.5;
                              }
                              // print(info.visibleBounds.height);
                            }),
                        SlideAnimationCard(
                          animationKey: Key("thu-moi-6"),
                          width: screenWidth,
                          height: 46,
                          offset: Offset(0, 1),
                          child: Center(
                            child: Text(
                              "THAM DỰ LỄ CƯỚI CỦA THIÊN & Ý",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        CarouselSlider(
                            options: CarouselOptions(
                              height: 400,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 0.5,
                              enlargeCenterPage: true,
                            ),
                            items: (controller.isChooseListSlider
                                    ? controller.listSliderImage
                                    : controller.listSliderImageDownload)
                                .map((image) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                      onTap: controller.onTapPickImageMulti,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Image.memory(
                                            image ?? new Uint8List(0)),
                                      ));
                                },
                              );
                            }).toList()),
                        SizedBox(
                          height: 60,
                          child: Center(
                            child: Text("TIỆC MỪNG LỄ VU QUY",
                                style: TextStyle(fontSize: 25)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Vào Lúc ", style: TextStyle(fontSize: 16)),
                            Text("9h00 | THỨ 7",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                color: Colors
                                    .black87, //                   <--- border color
                                width: 2,
                              ))),
                              child: SlideAnimationCard(
                                  animationKey: Key("month-view"),
                                  height: 50,
                                  width: 160,
                                  offset: Offset(-1, 0),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      child: Text(
                                        "Tháng 5",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  )),
                            ),
                            VisibilityDetector(
                                key: Key("wedding-date"),
                                child: Obx(() => AnimatedScale(
                                      scale: controller.dateScale,
                                      curve: Curves.linear,
                                      duration: Duration(seconds: 1),
                                      child: Text("25",
                                          style: TextStyle(fontSize: 60)),
                                    )),
                                onVisibilityChanged: (VisibilityInfo info) {
                                  final height = info.visibleBounds.height;
                                  final currentIsShow = height > 0;
                                  if (controller.dateScale == 0.5 &&
                                      currentIsShow) {
                                    controller.dateScale = 1;
                                  }

                                  if (!currentIsShow) {
                                    controller.dateScale = 0.5;
                                  }
                                  // print(info.visibleBounds.height);
                                }),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                color: Colors
                                    .black87, //                   <--- border color
                                width: 2,
                              ))),
                              child: SlideAnimationCard(
                                  animationKey: Key("year-view"),
                                  height: 50,
                                  width: 160,
                                  offset: Offset(1, 0),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      child: Text(
                                        "2025",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        )),
                        Center(
                          child: Text(
                            "(Tức Ngày 27 Tháng 4 Năm Ất Tỵ)",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: commonWidth + 90,
                          width: commonWidth,
                          child: Scaffold(
                              body: Container(
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(20),
                            //   color: Colors.white,
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Colors.grey.withValues(alpha: 0.5),
                            //       spreadRadius: 5,
                            //       blurRadius: 7,
                            //       offset: Offset(0, 3), // changes position of shadow
                            //     ),
                            //   ],
                            // ),

                            child: MonthView(
                              minMonth: DateTime(2025, 5, 1),
                              maxMonth: DateTime(2025, 5, 31),
                              initialMonth: DateTime(2025, 5),
                              cellAspectRatio: 1,
                              headerBuilder: (date) {
                                return Container(
                                  child: SizedBox(
                                    height: 130,
                                    width: commonWidth,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Tháng 5",
                                          style: TextStyle(
                                              fontSize: 40,
                                              // fontWeight: FontWeight.w900,
                                              fontFamily: "MothFont"),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "2025",
                                          style: TextStyle(
                                              fontSize: 90,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "YearFont"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              weekDayBuilder: (dayOfWeek) {
                                return Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black87),
                                  child: Text(
                                    controller.listDayOfWeek[dayOfWeek],
                                    // dayOfWeek.toString(),
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 16),
                                  ),
                                );
                              },
                              cellBuilder: (
                                date,
                                events,
                                isToday,
                                isInMonth,
                                hideDaysNotInMonth,
                              ) {
                                final intDay = date.day;
                                return Container(
                                    child: Center(
                                  child: intDay != 24 && intDay != 25
                                      ? Text(intDay.toString())
                                      : Stack(
                                          children: [
                                            Animationimage(
                                                width: 70,
                                                height: 70,
                                                path:
                                                    "assets/animations/hearticonincalendar.json"),
                                            Center(
                                              child: Text(intDay.toString()),
                                            )
                                          ],
                                        ),
                                ));
                              },
                            ),
                          )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        VisibilityDetector(
                            key: Key("wedding-location-animation-key"),
                            child: Obx(() => AnimatedScale(
                                  scale: controller.locationScale,
                                  curve: Curves.linear,
                                  duration: Duration(seconds: 1),
                                  child: Text("Địa điểm tổ chức",
                                      style: TextStyle(fontSize: 25)),
                                )),
                            onVisibilityChanged: (VisibilityInfo info) {
                              final height = info.visibleBounds.height;
                              final currentIsShow = height > 0;
                              if (controller.locationScale == 0.5 &&
                                  currentIsShow) {
                                controller.locationScale = 1;
                              }

                              if (!currentIsShow) {
                                controller.locationScale = 0.5;
                              }
                              // print(info.visibleBounds.height);
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: commonWidth + 100,
                            width: commonWidth,
                            child: Stack(
                              children: [
                                Container(
                                  height: commonWidth + 100,
                                  width: commonWidth,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "TỔ CHỨC TẠI GIA",
                                          style: TextStyle(
                                            fontSize: 28,
                                          ),
                                        ),
                                        Text(
                                          "Ấp An Bình, Ba Chúc, Tri Tôn, An Giang",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        )
                                      ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
                                  child: Container(
                                    height: commonWidth - 20,
                                    width: commonWidth - 20,
                                    child: FlutterMap(
                                      mapController: mapController,
                                      options: MapOptions(
                                          initialZoom: 12,
                                          initialCenter:
                                              LatLng(10.470228, 104.896273)),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.weddinginfor.app',
                                        ),
                                        MarkerLayer(markers: [
                                          Marker(
                                              point:
                                                  LatLng(10.470228, 104.896273),
                                              child: Icon(
                                                Icons.location_on_rounded,
                                                color: Colors.red,
                                                size: 50,
                                              )),
                                        ])
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: commonWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SlideAnimationCard(
                                animationKey: Key("image-view-1"),
                                height: commonWidth * 0.48 * imageScale,
                                width: commonWidth * 0.48,
                                offset: Offset(-1, 0),
                                child: Center(
                                  child: Obx(
                                    () => NetworkImageCustom(
                                      imageMemo: controller.listImage[3],
                                      imageUrl:
                                          controller.weddingInfor.image4 ?? "",
                                      isChooseImage:
                                          controller.listChooseImage[3].value,
                                      dowloadImage:
                                          controller.listDowloadImage[3],
                                      onGetImage: () {
                                        controller.onTapPickImage(3);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SlideAnimationCard(
                                animationKey: Key("image-view-2"),
                                height: commonWidth * 0.48 * imageScale,
                                width: commonWidth * 0.48,
                                offset: Offset(1, 0),
                                child: Center(
                                  child: Obx(
                                    () => NetworkImageCustom(
                                      imageMemo: controller.listImage[4],
                                      imageUrl:
                                          controller.weddingInfor.image5 ?? "",
                                      isChooseImage:
                                          controller.listChooseImage[4].value,
                                      dowloadImage:
                                          controller.listDowloadImage[4],
                                      onGetImage: () {
                                        controller.onTapPickImage(4);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: commonWidth * 0.04,
                        ),
                        SlideAnimationCard(
                          animationKey: Key("image-view-3"),
                          height: commonWidth * 1.5,
                          width: commonWidth,
                          offset: Offset(-1, 0),
                          child: Center(
                            child: Obx(
                              () => NetworkImageCustom(
                                imageMemo: controller.listImage[5],
                                imageUrl: controller.weddingInfor.image6 ?? "",
                                isChooseImage:
                                    controller.listChooseImage[5].value,
                                dowloadImage: controller.listDowloadImage[5],
                                onGetImage: () {
                                  controller.onTapPickImage(5);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: commonWidth * 0.04,
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
