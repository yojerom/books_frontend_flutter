import 'dart:convert';

import 'package:books_frontend_flutter/book_details.dart';
import 'package:books_frontend_flutter/book_model.dart';
import 'package:books_frontend_flutter/colors.dart';
import 'package:books_frontend_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future updateBook(BookModel updatedDetails) async {
  final response = await http.put(
      Uri.parse('https://hd19484vif.execute-api.us-east-1.amazonaws.com/books'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'SecretTokenUsers',
      },
      body: jsonEncode(<String, String>{
        'id': updatedDetails.id,
        'published': updatedDetails.published,
        'publisher': updatedDetails.publisher,
        'category': updatedDetails.category,
        'name': updatedDetails.name,
        'price': updatedDetails.price,
        'language': updatedDetails.language
      }));

  if (response.statusCode == 200) {
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class UpdateBook extends StatefulWidget {
  final BookModel bookDetails;

  const UpdateBook({Key? key, required this.bookDetails}) : super(key: key);

  @override
  _UpdateBookState createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  final _updateFormKey = GlobalKey<FormState>();

  BookModel updatedBook = new BookModel(
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
                      "Edit Book Details",
                      style: GoogleFonts.abrilFatface(
                          fontWeight: FontWeight.w900, fontSize: 28),
                    ),
                  ),
                ),
                Form(
                    key: _updateFormKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        initialValue: widget.bookDetails.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the book title here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          updatedBook.name = value!;
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
                        initialValue: widget.bookDetails.publisher,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the publisher here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          updatedBook.publisher = value!;
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
                        initialValue: widget.bookDetails.published,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the published date here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          updatedBook.published = value!;
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
                        initialValue: widget.bookDetails.price,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the price here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          updatedBook.price = value!;
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
                        initialValue: widget.bookDetails.language,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the language here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          updatedBook.language = value!;
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
                        initialValue: widget.bookDetails.category,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the category here';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          updatedBook.category = value!;
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
                                  if (_updateFormKey.currentState!.validate()) {
                                    updatedBook.id = widget.bookDetails.id;
                                    _updateFormKey.currentState!.save();
                                    updateBook(updatedBook);
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
                                  'Update',
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
