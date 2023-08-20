import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_eyedefender/constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:q_eyedefender/helpers/imagepicker.dart';
import 'package:q_eyedefender/screens/uploadscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
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
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 24.24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "in JPEG, PNG and JPG",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.file_upload_outlined,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                XFile image = getimage() as XFile;
                Navigator.push(
                  context,
                  PageTransition(
                      child: UploadScreen(),
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
              label: const Text(
                "Upload Pictures",
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
