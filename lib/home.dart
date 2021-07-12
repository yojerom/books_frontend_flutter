import 'dart:convert';

import 'package:books_frontend_flutter/add_book.dart';
import 'package:books_frontend_flutter/book_details.dart';
import 'package:books_frontend_flutter/colors.dart';
import 'package:flutter/material.dart';
import 'package:books_frontend_flutter/book_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map mapResponse = {};
  List listOfItems = [];

  Future fetchBooks() async {
    final response = await http.get(
      Uri.parse('https://hd19484vif.execute-api.us-east-1.amazonaws.com/books'),
      headers: {
        'Authorization': 'SecretTokenUsers',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        listOfItems = mapResponse['Items'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xffF2F5F9),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "The Little Books",
                    style: GoogleFonts.abrilFatface(
                        fontWeight: FontWeight.w900, fontSize: 28),
                  ),
                ),
                Image.asset(
                  "assets/banner.png",
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('All Books',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddBook()));
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.cyan[900],
                          ),
                          label: Text(
                            'Add new',
                            style: TextStyle(color: Colors.cyan[900]),
                          ))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    //color: Colors.amber,
                    alignment: Alignment.topCenter,
                    height: 445,
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 0.0),
                        itemCount: listOfItems.length,
                        itemBuilder: (context, index) {
                          BookModel bookDetails = new BookModel(
                              id: '',
                              published: '',
                              publisher: '',
                              category: '',
                              name: '',
                              price: '',
                              language: '');
                          bookDetails.id = listOfItems[index]['id'].toString();
                          bookDetails.published =
                              listOfItems[index]['published'].toString();
                          bookDetails.publisher =
                              listOfItems[index]['publisher'].toString();
                          bookDetails.category =
                              listOfItems[index]['category'].toString();
                          bookDetails.name =
                              listOfItems[index]['name'].toString();
                          bookDetails.price =
                              listOfItems[index]['price'].toString();
                          bookDetails.language =
                              listOfItems[index]['language'].toString();

                          return BooksTile(bookDetails: bookDetails);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BooksTile extends StatelessWidget {
  final BookModel bookDetails;

  BooksTile({required this.bookDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(bookDetails: bookDetails)));
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Stack(
          children: <Widget>[
            Container(
              //color: Colors.blue,
              height: 100,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.only(top: 0.0),
              alignment: Alignment.bottomLeft,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  width: double.infinity,
                  height: 75,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 60,
                      ),
                      /*Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/book_avatar.png'),
                          radius: 30,
                        ),
                      ),*/
                      Container(
                        width: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              bookDetails.name,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              bookDetails.category,
                              style: TextStyle(
                                color: darkGreen,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              height: 70,
              width: 60,
              margin: EdgeInsets.only(
                left: 28,
                top: 10,
              ),
              child: Image.asset(
                'assets/book_avatar.png',
                height: 60,
                width: 40,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
