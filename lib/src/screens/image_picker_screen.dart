import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../repository/model/post_model.dart';
import '../service/api_service.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  /// Variables
  File? imageFile;

  double progressUpload = 0;

  String? imageUrl;
  String? content;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future uploadFile() async {
    if (imageFile == null) return;
    final _fileName = DateTime.now().millisecondsSinceEpoch;
    // print(destination);
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('files')
          .child('$_fileName/');

      ref.putFile(imageFile!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            final progress =
                100.0 * (event.bytesTransferred / event.totalBytes);
            setState(() {
              progressUpload = progress;
            });
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            // Handle successful uploads on complete
            // ...
            imageUrl = await event.ref.getDownloadURL();
            print("url : $imageUrl");
            break;
        }
      });

      // final link = await ref.getDownloadURL();
    } catch (e) {
      print('error occured');
    }

    // Future<void> createPost() async {
    //   final client =
    //       RestClient(Dio(BaseOptions(contentType: "application/json")));
    //   Post newPost = Post(
    //       id: null,
    //       name: "Tên",
    //       avatar: null,
    //       image: imageUrl,
    //       content: content);
    //   await client.createPost(newPost);
    // }
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: const Text("PICK FROM GALLERY"),
                        ),
                        Container(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _getFromCamera();
                          },
                          child: const Text("PICK FROM CAMERA"),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        // Stack(
                        //   children: [

                        //   ],
                        // ),
                        Image.file(
                          imageFile!,
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        const SizedBox(height: 3),
                        LinearProgressIndicator(
                          value: progressUpload,
                        ),
                        // IconButton(
                        //     onPressed: () => {
                        //           // print("object")
                        //           uploadFile()
                        //         },
                        //     icon: const Icon(Icons.upload_file)),
                        const SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Nhập nội dung',
                          ),
                          onChanged: (value) {
                            content = value;
                          },
                        ),
                        ElevatedButton(
                            onPressed: createPost,
                            child: const Text("Đăng bài"))
                      ],
                    ),
                  )));
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        uploadFile();
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.camera));
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        uploadFile();
      });
    }
  }

  void createPost() async {
    final client =
        RestClient(Dio(BaseOptions(contentType: "application/json")));
    Post newPost = Post(
        id: null, name: "Tên", avatar: null, image: imageUrl, content: content);
    await client.createPost(newPost);
  }
}
