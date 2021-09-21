import 'dart:io';

import 'package:blog/provider/provider_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  void initState() {
    context.appViewModel.getPost();

    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String title;
  late String author;

  late String content;
  final List<XFile>? imageFileList = <XFile>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (imageFileList!.isEmpty)
              GestureDetector(
                onTap: () {
                  selectImages();
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.network(
                        'https://cdn.iconscout.com/icon/free/png-256/add-image-1438838-1214525.png',
                      ),
                    ),
                    const Text('Add Image')
                  ],
                ),
              )
            else
              GridView.builder(
                  itemCount:
                      imageFileList!.length < 5 ? imageFileList!.length : 4,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    print('Image List  : ${imageFileList![index].path}');

                    return Image.file(
                      File(imageFileList![index].path),
                      fit: BoxFit.cover,
                    );
                  }),
            const SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:  InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          hintText: 'Title',
                          hintStyle: TextStyle(color: Theme.of(context).hintColor),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (String? val) =>
                          val!.isEmpty ? 'Enter Title' : null,
                      onChanged: (String val) {
                        setState(() => title = val);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      minLines: 16,
                      maxLines: 50,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration:  InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Theme.of(context).focusColor,
                                width: .1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                                color: Theme.of(context).focusColor,
                                width: .1),
                          ),
                          hintText: 'Content',
                          hintStyle: TextStyle(color: Theme.of(context).hintColor),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (String? val) =>
                          val!.isEmpty ? 'Add Content' : null,
                      onChanged: (String val) {
                        setState(() => content = val);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: .1),
                          ),
                          hintText: 'Author',
                          hintStyle: TextStyle(color: Theme.of(context).hintColor),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (String? val) =>
                          val!.isEmpty ? 'Enter Author Name' : null,
                      onChanged: (String val) {
                        setState(() => author = val);
                      },
                    ),
                    MaterialButton(
                        minWidth: 150,
                        height: 40,
                        shape: const StadiumBorder(),
                        color: Colors.teal,
                        child: const Text(
                          'Add Post',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.appViewModel
                                .createPost(
                                    title, content, author, imageFileList!)
                                .then((void value) =>
                                    context.navigation.goToHome());
                          }
                        }),
                    const SizedBox(
                      height: 27,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future<void> selectImages() async {
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print('Image List Length : ${selectedImages.length}');
    setState(() {});
  }
}
