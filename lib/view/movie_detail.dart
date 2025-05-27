import 'package:flutter/material.dart';
import 'package:responsi/network/base_network.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String endpoint;

  const DetailScreen( {
      super.key,
      required this.id,
      required this.endpoint
    }

  );

  @override State <DetailScreen>createState()=>_DetailScreenState();
}

class _DetailScreenState extends State <DetailScreen> {
  bool _isLoading=true;
  Map<String,
  dynamic>? _detailData;
  String? _errorMessage;

  @override void initState() {
    super.initState();
    _fetchDetailData();
  }

  Future<void>_fetchDetailData() async {
    try {
      final data=await BaseNetwork.getDetailData(widget.endpoint, widget.id);

      setState(() {
          _detailData=data;
          _isLoading=false;
        }

      );
    }

    catch (e) {
      setState(() {
          _errorMessage=e.toString();
          _isLoading=false;
        }

      );
    }
  }

  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Detail", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : _errorMessage !=null ? Center(child: Text("Error: $_errorMessage", style: TextStyle(color: Colors.red, fontSize: 18))) : _detailData !=null ? Padding(padding: const EdgeInsets.all(16.0), // Padding around the body
        child: Center(child: SingleChildScrollView( // Ensure the content can scroll if it's large
            child: Card(elevation: 12, // Add shadow effect 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: const Color.fromARGB(255, 180, 175, 181),
              child: Padding(padding: const EdgeInsets.all(16.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ ClipRRect(borderRadius: BorderRadius.horizontal(), // Circular image
                    child: Image.network(_detailData !['imgUrl'] ?? 'https://placehold.co/600x400',
                      width: 150, // Size of the image
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20), // Space between image and text

                  Text("Title: ${_detailData!['title']}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 10),
                  SelectableText("Release Date: ${_detailData!['Release_date']?? '-'}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text("Rating: ${_detailData!['rating'] ?? '-'}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text("Genre: ${_detailData!['genre'] is List ? (_detailData!['genre'] as List).join (', ') : (_detailData!['genre'] ?? '-')}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text("Description: ${_detailData!['description'] ?? '-'}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text("Director: ${_detailData!['director'] ?? '-'}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text("Cast: ${_detailData!['cast'] is List ? (_detailData!['cast'] as List).join (', ') : (_detailData!['cast'] ?? '-')}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text("Language: ${_detailData!['language'] ?? '-'}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text("Duration: ${_detailData!['duration'] ?? '-'}",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ) : Center(child: Text("Data not available", style: TextStyle(fontSize: 18))),
    );
  }
}