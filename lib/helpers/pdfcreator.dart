import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:q_eyedefender/constant.dart';
import 'dart:io';

Future<void> CreatePDF(String str) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child:
            pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("PATIENT REPORT",style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                )),
                pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10.0)),
                pw.Row(children: [
                  pw.Text("Name: "),
                  pw.Text(name),
                ]),
                pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10.0)),
                pw.Row(children: [
                  pw.Text("Age: "),
                  pw.Text(age),
                ]),
                pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10.0)),
                pw.Row(children: [
                  pw.Text("Type of Diabetes: "),
                  pw.Text(type),
                ]),
                pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 10.0)),
                pw.Row(children: [
                  pw.Text("Condition: "),
                  pw.Text(str),
                ]),
        ],),
      ),
    ),
  );

  Directory generalDownloadDir = Directory('/storage/emulated/0/Download'); //! THIS WORKS for android only !!!!!!

  //qr image file saved to general downloads folder
  File qrJpg = await File('${generalDownloadDir.path}/Report_$name.pdf').create();
  await qrJpg.writeAsBytes(await pdf.save());

  Fluttertoast.showToast(msg: ' $name _Report Downloaded', gravity: ToastGravity.BOTTOM);


  //final directory = (await getExternalStorageDirectories(type: StorageDirectory.downloads)).first!;
  // final file = File('Report_$name.pdf');
  // await file.writeAsBytes(await pdf.save());
  // saveInStorage("Report_$name", file);
}

Future saveInStorage(String fileName, File file) async {

final Directory? downloadsDir = await getDownloadsDirectory();
String filePath =
    "${downloadsDir!.path}/${fileName.trim()}";

File fileDef = File(filePath);
await fileDef.create(recursive: true);
Uint8List bytes = await file.readAsBytes();
await fileDef.writeAsBytes(bytes);
}