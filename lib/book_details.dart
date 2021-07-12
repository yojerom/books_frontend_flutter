import 'dart:convert';
import 'dart:io';

import 'package:books_frontend_flutter/book_model.dart';
import 'package:books_frontend_flutter/colors.dart';
import 'package:books_frontend_flutter/home.dart';
import 'package:books_frontend_flutter/update_book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

Future deleteBook(BuildContext context, String id) async {
  final response = await http.delete(
      Uri.parse(
          'https://hd19484vif.execute-api.us-east-1.amazonaws.com/books/$id'),
      headers: {
        'Authorization': 'SecretTokenUsers',
      });

  if (response.statusCode == 200) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}

class BookDetails extends StatefulWidget {
  final BookModel bookDetails;
  const BookDetails({Key? key, required this.bookDetails}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool _isAvailable = false;

  void loadImg(String id) async {
    final response = await http.get(
        Uri.parse('https://imagefilesproject.s3.amazonaws.com/books/$id.jpg'));

    if (response.statusCode == 200) {
      print("200");
      setState(() {
        _isAvailable = true;
      });
    } else {
      print("null");
      _isAvailable = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadImg(widget.bookDetails.id);
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.bookDetails.id;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  child: Text(
                    "Overview",
                    style: GoogleFonts.abrilFatface(
                        fontWeight: FontWeight.w900, fontSize: 28),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 300,
                      color: Colors.white,
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.only(left: 15, top: 15),
                      child: Image.network(_isAvailable == true
                          ? 'https://imagefilesproject.s3.amazonaws.com/books/$id.jpg'
                          : 'https://i.postimg.cc/9Qkrcxcs/placeholder-img.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton.icon(
                            onPressed: () {
                              _showPicker(context, widget.bookDetails.id);
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.cyan[900],
                            ),
                            label: Text(
                              'Add photo',
                              style: TextStyle(color: Colors.cyan[900]),
                            )),
                        SizedBox(height: 25),
                        Text(
                          "Category ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          widget.bookDetails.category,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Language ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          widget.bookDetails.language,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Price ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        Text(
                          widget.bookDetails.price,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.bookDetails.name,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Published by ",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                                Text(
                                  widget.bookDetails.publisher,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "“Description is the pattern of narrative development that aims to make vivid a place, object, character, or group. Description is one of four rhetorical modes, along with exposition, argumentation, and narration. In practice it would be difficult to write literature that drew on just one of the four basic modes“.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          letterSpacing: 0.6,
                          wordSpacing: 0.6,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Published on ",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                            Text(
                              widget.bookDetails.published,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateBook(
                                              bookDetails:
                                                  widget.bookDetails)));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.cyan[900],
                                ),
                                label: Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.cyan[900]),
                                )),
                            OutlinedButton.icon(
                                onPressed: () {
                                  showAlertDialog(
                                      context, widget.bookDetails.id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.cyan[900],
                                ),
                                label: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.cyan[900]),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showPicker(BuildContext context, String id) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery(context, id);
                      Navigator.of(context).pop();
                    }),
                /*ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),*/
              ],
            ),
          ),
        );
      });
}

_imgFromGallery(BuildContext context, String id) async {
  final imgPicker = ImagePicker();
  PickedFile? pickedImage = await imgPicker.getImage(
    source: ImageSource.gallery, /*imageQuality: 50*/
  );
  if (pickedImage != null) {
    File imageFile = File(pickedImage.path);
    imageAlertDialog(context, imageFile, id);
  }
}

Future uploadImage(BuildContext context, File imageFile, String id) async {
  final imageUri = Uri.parse(
      'https://hd19484vif.execute-api.us-east-1.amazonaws.com/books/image/$id');
  final response = await http.post(
    imageUri,
    body: imageFile.readAsBytesSync(),
    headers: {
      'Authorization': 'SecretTokenUsers',
      'Content-Type': 'application/octet-stream'
    },
  );

  if (response.statusCode == 200) print("Uploaded!");
}

imageAlertDialog(BuildContext context, File imageFile, String id) {
  Widget yesButton = OutlinedButton(
    child: Text("Yes"),
    onPressed: () {
      uploadImage(context, imageFile, id);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    },
    style: OutlinedButton.styleFrom(primary: Colors.cyan[900]),
  );

  Widget noButton = ElevatedButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(primary: Colors.cyan[900]),
  );

  AlertDialog deleteAlert = AlertDialog(
    title: Text("Add Image!"),
    content: Text("Do you want to add this image?"),
    actions: [yesButton, noButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return deleteAlert;
    },
  );
}

showAlertDialog(BuildContext context, String id) {
  Widget yesButton = OutlinedButton(
    child: Text("Yes"),
    onPressed: () {
      deleteBook(context, id);
      //Navigator.of(context).pop(); //need to edit
    },
    style: OutlinedButton.styleFrom(primary: Colors.cyan[900]),
  );

  Widget noButton = ElevatedButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(primary: Colors.cyan[900]),
  );

  AlertDialog deleteAlert = AlertDialog(
    title: Text("Delete Book!"),
    content: Text("Are you sure, You want to delete?"),
    actions: [yesButton, noButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return deleteAlert;
    },
  );
}
