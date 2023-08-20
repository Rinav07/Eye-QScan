import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:q_eyedefender/screens/resultscreen.dart' show _ResultScreenState;

String api = 'https://predictv3.azurewebsites.net/post/';
//List<int> indexlist = [0, 0, 0, 0, 0];


Future<String> getdata(File image) async {
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
    return cnd;
  });
  // response = await dio.post("/info", data: formData)
  //print(cnd);
  //var response = await request.send();
  //print(response);

  // if (response.statusCode == 200) {
  //   // var body = jsonDecode(response.body);
  //   // cnd = body[0]["class"];
  // }
  return cnd;
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
