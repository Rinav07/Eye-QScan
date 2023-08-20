import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:q_eyedefender/helpers/imagepicker.dart';
import 'package:q_eyedefender/screens/resultscreen.dart';
import 'dart:math';
import 'dart:io';

import '../constant.dart';

class ImageList {
  late File image;
  late String size;

  ImageList(this.image, this.size);
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);
  // UploadScreen(
  //     this.image, {super.key}
  //     );
  // XFile? image;
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  //String name = image.name;
  bool flag = false;
  List<ImageList> imagelist = [];

  TextEditingController namecnt = TextEditingController();
  TextEditingController agecnt = TextEditingController();
  TextEditingController typecnt = TextEditingController();


  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  // Future<int> getSize(int i) async{
  //   int length = await imagelist[i].length();
  //   return length;
  // }

  void addimage() async {
    File image = await getimage();
    String size = getFileSizeString(bytes: await image.length());
    ImageList img = ImageList(image, size);
    imagelist.add(img);
    // int bytes = await image.length();
    // imagesize.add(bytes.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [pblue, sblue],
      )),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.08,
          bottom: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/eyeimage.png",
                    height: 90,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    "Upload 5 Pictures",
                    style: TextStyle(
                      //fontFamily: 'Manrope-VariableFont_wght',
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 24.24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "in JPEG, PNG and JPG",
                    style: TextStyle(
                      //fontFamily: 'Manrope-VariableFont_wght',
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.85,
                child: imagelist.isEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                      color: Colors.white70),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: TextField(
                                      controller: namecnt,
                                      keyboardType: TextInputType.name,
                                      cursorColor: pyellow,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        hintText: 'PATIENT NAME',
                                        hintStyle: const TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        border: InputBorder.none,
                                        prefixIcon: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        // Icon(
                                        //   Icons.mail_outline_rounded,
                                        //   color: Color(0x9f292D32),
                                        // ),
                                        //prefixIconColor: Color(0xff292D32),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: pyellow,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                      color: Colors.white70),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: TextField(
                                      controller: agecnt,
                                      keyboardType: TextInputType.number,
                                      cursorColor: pyellow,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        hintText: 'PATIENT AGE',
                                        hintStyle: const TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        border: InputBorder.none,
                                        prefixIcon: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: const Icon(
                                            Icons.calendar_month_sharp,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        // Icon(
                                        //   Icons.mail_outline_rounded,
                                        //   color: Color(0x9f292D32),
                                        // ),
                                        //prefixIconColor: Color(0xff292D32),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: pyellow,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                      color: Colors.white70),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: TextField(
                                      controller: typecnt,
                                      keyboardType: TextInputType.text,
                                      cursorColor: pyellow,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        hintText: 'TYPE OF DIABETES',
                                        hintStyle: const TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        border: InputBorder.none,
                                        prefixIcon: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: const Icon(
                                            Icons.health_and_safety,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        // Icon(
                                        //   Icons.mail_outline_rounded,
                                        //   color: Color(0x9f292D32),
                                        // ),
                                        //prefixIconColor: Color(0xff292D32),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: pyellow,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: imagelist.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.1),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.15),
                                          ),
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.image_outlined,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Text(
                                            imagelist[i]
                                                .image
                                                .path
                                                .split('/')
                                                .last,
                                            style: const TextStyle(
                                              //fontFamily: 'Manrope-VariableFont_wght',
                                              decoration: TextDecoration.none,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          imagelist[i].size,
                                          //"900kb",
                                          style: const TextStyle(
                                            //fontFamily: 'Manrope-VariableFont_wght',
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.file_upload_outlined,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                imagelist.isEmpty
                    ? setState(() {
                      name = namecnt.text;
                      age = agecnt.text;
                      type = typecnt.text;
                      addimage();

                      })
                    : Navigator.push(
                        context,
                        PageTransition(
                            child: ResultScreen(imagelist),
                            inheritTheme: true,
                            ctx: context,
                            type: PageTransitionType.bottomToTop),
                      );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.white,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.85,
                    MediaQuery.of(context).size.height * 0.075),
              ),
              label: Text(
                imagelist.isEmpty ? "Upload Image" : "Continue",
                style: const TextStyle(
                  //fontFamily: 'Manrope-VariableFont_wght',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // style:
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(icon),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
