import 'dart:convert';

import 'package:books_frontend_flutter/book_model.dart';
import 'package:books_frontend_flutter/colors.dart';
import 'package:books_frontend_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// class PostResponseModel {
//   String id;
//   String status;
//   String message;

//   PostResponseModel(
//       {required this.id, required this.status, required this.message});
// }

Future addNewBook(BookModel newBookDetails) async {
  final response = await http.post(
      Uri.parse('https://hd19484vif.execute-api.us-east-1.amazonaws.com/books'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'SecretTokenUsers',
      },
      body: jsonEncode(<String, String>{
        'published': newBookDetails.published,
        'publisher': newBookDetails.publisher,
        'category': newBookDetails.category,
        'name': newBookDetails.name,
        'price': newBookDetails.price,
        'language': newBookDetails.language
      }));

  if (response.statusCode == 200) {
    /*PostResponseModel postResponseModel =
        new PostResponseModel(id: '', status: '', message: '');

    var responseData = jsonDecode(response.body);
    postResponseModel.id = responseData['id'].toString();*/

    //print(postResponseModel.id.toString());
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _addFormKey = GlobalKey<FormState>();

  BookModel newBookDetails = new BookModel(
      id: '',
      published: '',
      publisher: '',
      category: '',
      name: '',
      price: '',
      language: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Wrap(
              runSpacing: 20,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      "Add New Book",
                      style: GoogleFonts.abrilFatface(
                          fontWeight: FontWeight.w900, fontSize: 28),
                    ),
                  ),
                ),
                Form(
                    key: _addFormKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the book title here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          newBookDetails.name = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Title',
                          labelText: 'Title',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the publisher here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          newBookDetails.publisher = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Published by',
                          labelText: 'Published by',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the published date here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          newBookDetails.published = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Published on',
                          labelText: 'Published on',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the price here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          newBookDetails.price = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Price',
                          labelText: 'Price',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the language here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          newBookDetails.language = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Language',
                          labelText: 'Language',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the category here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          newBookDetails.category = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Category',
                          labelText: 'Category',
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    minimumSize: Size(100, 50)),
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    addNewBook(newBookDetails);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                  }
                                },
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.cyan[900],
                                ),
                                label: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.cyan[900]),
                                )),
                            SizedBox(width: 20),
                            OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    minimumSize: Size(100, 50)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.cyan[900],
                                ),
                                label: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.cyan[900]),
                                )),
                          ],
                        ),
                      ),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
