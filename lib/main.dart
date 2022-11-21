import 'dart:convert'; 
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 
 
void main() => runApp(const MyApp()); 
 
class MyApp extends StatelessWidget { 
  const MyApp({super.key}); 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Cinema Star', 
      home: Scaffold( 
        appBar: AppBar( 
            title: const Text('Cinema Star'), 
            // ignore: prefer_const_constructors 
            backgroundColor: Color.fromARGB(255, 116, 5, 97)), 
        body: const HomePage( 
          title: '', 
        ), 
      ), 
    ); 
  } 
} 
 
class HomePage extends StatefulWidget { 
  const HomePage({super.key, required this.title}); 
  final String title; 
  @override 
  State<HomePage> createState() => _HomePageState(); 
} 
 
class _HomePageState extends State<HomePage> { 
  var desc = ""; 
  String chooseMovie = ""; 
  TextEditingController textEditingController = TextEditingController(); 
  @override 
  Widget build(BuildContext context) { 
    return Center( 
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.start, 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [ 
          const Text("Type Your Movie Title:", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), 
          TextField( 
            controller: textEditingController, 
            // ignore: prefer_const_constructors 
            decoration: InputDecoration( 
              // ignore: prefer_const_constructors 
              border: OutlineInputBorder(), 
              labelText: 'Search movie', 
              hintText: 'Type here', 
            ), 
            onChanged: (text) { 
              setState(() { 
                chooseMovie = text; 
              }); 
            }, 
          ), 
          ElevatedButton(onPressed: _getMovie, child: const Text("Search")), 
          Text(desc, 
              style: 
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
        ], 
      ), 
    ); 
  } 
 
  Future<void> _getMovie() async { 
    var apiid = "67bbd071"; 
    var url = Uri.parse('http://www.omdbapi.com/?t=$chooseMovie&apikey=$apiid'); 
    var response = await http.get(url); 
    var rescode = response.statusCode; 
    if (rescode == 200) { 
      var jsonData = response.body; 
      var parsedJson = json.decode(jsonData); 
      setState(() { 
        var title = parsedJson['Title']; 
        var year = parsedJson['Year']; 
        var rated = parsedJson['Rated']; 
        var released = parsedJson['Released']; 
        var runtime = parsedJson['Runtime']; 
        var genre = parsedJson['Genre']; 
        var director = parsedJson['Director']; 
        var actors = parsedJson['Actors']; 
        var language = parsedJson['Language']; 
        var country = parsedJson['Country']; 
 
        desc = 
            "Title: $title. \nYear: $year. \nRated: $rated. \nReleased: $released. \nRuntime: $runtime. \nGenre: $genre. \nDirector: $director. \nActors: $actors. \nLanguage: $language. \nCountry: $country. "; 
      }); 
    } else { 
      setState(() { 
        desc = "No Record"; 
      }); 
    } 
  } 
}