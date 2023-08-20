import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:q_eyedefender/helpers/pdfcreator.dart';
import '../constant.dart';
import '../helpers/imagepost.dart';
import 'package:q_eyedefender/screens/uploadscreen.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';

class ResultScreen extends StatefulWidget {
  //const ResultScreen({Key? key}) : super(key: key);
  final List<ImageList> imagelist;
  const ResultScreen(this.imagelist, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int index = 0;
  var percno = 97.60;
  bool flag = false;
  String str = "";
  //int str =0;
  //List<int> indexlist = [0, 0, 0, 0, 0];
  String api = 'https://predictv3.azurewebsites.net/post/';

  Future<void> getdata(File image) async {
    //print("in getdata");
    //print(image);
    // var request = http.MultipartRequest('POST', Uri.parse(api));
    // request.fields['file'] = ;
    // var tp = http.MultipartFile.fromBytes('picture', File(image!.path).readAsBytesSync(),filename: image!.path);
    // request.files.add(tp);
    // http.Response response = await http.post(
    //     Uri.parse(api),
    //     body: jsonEncode(<String,File>{
    //       'file' : image,
    //     })
    // );
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });
    String cnd = "";
    Dio dio = new Dio();
    dio.post(api, data: formData).then((response){
      // print(response);
      var jsonresponse = jsonDecode(response.toString());
      cnd = jsonresponse['class'];
      print(cnd);
      print(getint(cnd));
      // indexlist[getint(cnd)]++;
      // int index = indexlist.indexOf(indexlist.reduce(max));
      // print(index);
      setState(() {
        str=cnd;
      });
      //return cnd;
    });
    // response = await dio.post("/info", data: formData)
    //print(cnd);
    //var response = await request.send();
    //print(response);

    // if (response.statusCode == 200) {
    //   // var body = jsonDecode(response.body);
    //   // cnd = body[0]["class"];
    // }
    //return cnd;
  }

  int getint(String str) {
    int index=0;
    if(str == "No_DR") {
      index = 0;
    } else if (str == "Mild") {
      index = 1;
    }else if (str == "Moderate"){
      index = 2;
    }else if (str == "Severe"){
      index = 3;
    }else if (str == "Proliferate_DR"){
      index = 4;
    }
    return index;
  }

  void getindex() async {
    List<ImageList> imglist = widget.imagelist;
    //print(imglist.length);
    String res;
    await getdata(imglist[0].image);
    //print(res);
    // setState(() {
    //   str=res;
    // });

    // for (int i = 0; i < imglist.length; i++) {
    //   res = await getdata(imglist[i].image);
    //   setState(() {
    //     str=res;
    //   });
    //
    //   // setState(() async {
    //   //
    //   //   flag = true;
    //   // });
    //
    // }
    // setState(() {
    //   flag = true;
    // });
  }

  // void getscreen()  {
  //   getindex().whenComplete((){
  //     setState(() {
  //       flag = true;
  //     });
  //   });
  //
  //   //return await getindex();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getindex();
    // setState(() {
    //   flag =true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    String perc = percno.toStringAsFixed(2);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [pblue, sblue],
      )),
      child: str.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(pyellow),
                  ),
                )
              ],
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/eyeimage.png",
                          height: 90,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            "The Condition is ",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              str,
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "\t\tWe are $perc % certain",
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Expanded(
                    child: SizedBox(
                        //height: double.infinity,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        CreatePDF(str);
                        // Fluttertoast.showToast(
                        //     msg: "Downloaded Report PDF",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     backgroundColor: Colors.red,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.white,
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.85,
                            MediaQuery.of(context).size.height * 0.075),
                      ),
                      child: const Text(
                        "Download Report",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // style:
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              child: const UploadScreen(),
                              inheritTheme: true,
                              ctx: context,
                              type: PageTransitionType.bottomToTop),
                          (Route route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.85,
                          MediaQuery.of(context).size.height * 0.075),
                    ),
                    child: const Text(
                      "Start Over",
                      style: TextStyle(
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

//
// Padding(
// padding: const EdgeInsets.symmetric(
// vertical: 8.0, horizontal: 8.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 2.0),
// child: Expanded(
// child: Container(
// height:
// MediaQuery.of(context).size.height *
// 0.035,
// //width: double.infinity,
// decoration: BoxDecoration(
// color: index == 0
// ? Colors.yellow
//     : Colors.transparent,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 5.0),
// child: Text(
// "No-DR",
// style: TextStyle(
// decoration: TextDecoration.none,
// color: Colors.black,
// fontSize: 14,
// fontWeight: index == 0
// ? FontWeight.bold
//     : FontWeight.normal,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 2.0),
// child: Expanded(
// child: Container(
// height:
// MediaQuery.of(context).size.height *
// 0.035,
// //width: double.infinity,
// decoration: BoxDecoration(
// color: index == 1
// ? Colors.yellow
//     : Colors.transparent,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 5.0),
// child: Text(
// "Mild",
// style: TextStyle(
// decoration: TextDecoration.none,
// color: Colors.black,
// fontSize: 14,
// fontWeight: index == 1
// ? FontWeight.bold
//     : FontWeight.normal,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 2.0),
// child: Expanded(
// child: Container(
// height:
// MediaQuery.of(context).size.height *
// 0.035,
// //width: double.infinity,
// decoration: BoxDecoration(
// color: index == 2
// ? Colors.yellow
//     : Colors.transparent,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 5.0),
// child: Text(
// "Moderate",
// style: TextStyle(
// decoration: TextDecoration.none,
// color: Colors.black,
// fontSize: 14,
// fontWeight: index == 2
// ? FontWeight.bold
//     : FontWeight.normal,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 2.0),
// child: Expanded(
// child: Container(
// height:
// MediaQuery.of(context).size.height *
// 0.035,
// //width: double.infinity,
// decoration: BoxDecoration(
// color: index == 3
// ? Colors.yellow
//     : Colors.transparent,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 5.0),
// child: Text(
// "Severe",
// style: TextStyle(
// decoration: TextDecoration.none,
// color: Colors.black,
// fontSize: 14,
// fontWeight: index == 3
// ? FontWeight.bold
//     : FontWeight.normal,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 2.0),
// child: Expanded(
// child: Container(
// height:
// MediaQuery.of(context).size.height *
// 0.035,
// //width: double.infinity,
// decoration: BoxDecoration(
// color: index == 4
// ? Colors.yellow
//     : Colors.transparent,
// borderRadius: BorderRadius.circular(10),
// ),
// child: Center(
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 5.0),
// child: Text(
// "Proliferate",
// style: TextStyle(
// decoration: TextDecoration.none,
// color: Colors.black,
// fontSize: 14,
// fontWeight: index == 4
// ? FontWeight.bold
//     : FontWeight.normal,
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// )
