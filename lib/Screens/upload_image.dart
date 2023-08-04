import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpiner = false;

  //! Getting the image
  Future getImage() async {
    final pickerFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickerFile != null) {
      image = File(pickerFile.path);
      setState(() {});
    } else {
      print('No image selected');
    }
  }

  //! Uploading the image
  Future<void> uploadImage() async {
    setState(() {
      showSpiner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = http.MultipartRequest('POST', uri);

    request.fields['title'] = 'Static title';

    var multiport = http.MultipartFile(
      'image',
      stream,
      length,
    );

    request.files.add(multiport);


    var response = await request.send();
    print(response.stream.toString());

    if (response.statusCode == 200) {
      setState(() {
        showSpiner = false;
      });
      print('Image Uploaded');
    } else {
       setState(() {
        showSpiner = false;
      });
      print('Filed to upload');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UploadImage'),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: image == null
                    ? Center(
                        child: ElevatedButton(
                          onPressed: () {
                            getImage();
                          },
                          child: const Text('PickImage'),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  uploadImage();
                },
                child: Container(
                  color: Colors.black,
                  height: 30,
                  width: double.infinity,
                  child: const Center(child: Text('Upload', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
