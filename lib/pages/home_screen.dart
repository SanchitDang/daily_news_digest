import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:daily_news_digest/pages/registration/login.dart';
import 'package:daily_news_digest/pages/registration/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/article_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final color = const Color(0xffFE0000);

  String myApi = 'f89a0a23e2e4410b98f9b4a18447128e';

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Article> _articles = [];
  List<Article> _filteredArticles = [];

  bool intConnection = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }


  Future<void> fetchArticles() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check for internet connectivity
    final bool isConnected = await Connectivity().checkConnectivity() != ConnectivityResult.none;
    setState(() {
      intConnection = isConnected;
    });

    // Check if the data is already saved in local storage
    final String? savedData = prefs.getString('articles');

    if (savedData != null && !isConnected) {
      setState(() {
        _articles = (jsonDecode(savedData) as List)
            .map((item) => Article.fromJson(item))
            .toList();
        _filteredArticles = _articles;
      });
      return;
    }

    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$myApi'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Save the data in local storage
      await prefs.setString('articles', jsonEncode(data['articles']));

      List<Article> fetchedArticles = [];

      for (var article in data['articles']) {
        fetchedArticles.add(Article.fromJson(article));
      }

      setState(() {
        _articles = fetchedArticles;
        _filteredArticles = fetchedArticles;
      });

    } else {
      throw Exception('Failed to load articles');
    }
  }

  void _filterArticles(String query) {
    setState(() {
      _searchQuery = query;
        // Filter the list of articles based on the search query
        setState(() {
          _filteredArticles = _articles.where((article) =>
          article.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              article.description.toLowerCase().contains(_searchQuery.toLowerCase())
          ).toList();
        });

    });
  }

  String getDateStatus(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    int diff = now.difference(date).inDays;

    if (diff == 0) {
      return "Today";
    } else if (diff == 1) {
      return "Yesterday";
    } else {
      return "More than 2 days ago";
    }
  }



  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      intConnection ? const SizedBox() :
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No Internet Connection!'),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {
              // Perform an action when the "OK" button is pressed
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
          duration: const Duration(seconds: 20),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueGrey,
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color,
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // Navigate back to sign in screen
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
              },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search in feed',
              prefixIcon: Icon(Icons.search, color: color,),
            ),
            onChanged: (value) {
              _filterArticles(value);
            },
          ),

          const SizedBox(height: 10,),

          Expanded(
          child: ListView.builder(
            //itemCount: _articles.length,
            itemCount: _filteredArticles.length,
            itemBuilder: (context, index) {
              //final article = _articles[index];
              final article = _filteredArticles[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  getDateStatus(article.publishedAt)
                                 // DateFormat('MM-dd-yyyy').format(DateTime.parse(article.publishedAt))
                                ,
                                ),
                                const SizedBox(width: 4,),
                                Text(
                                  article.source,
                                  style: const TextStyle(
                                    color: Colors.blueGrey
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              article.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                 Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(article.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),]
      ),
    );
  }
}