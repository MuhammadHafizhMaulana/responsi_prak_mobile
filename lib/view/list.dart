import 'package:flutter/material.dart';
import 'package:responsi/model/movie_model.dart';
import 'package:responsi/presenter/movie_presenter.dart';
import 'package:responsi/view/movie_detail.dart';


class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreen();
}

class _MovieListScreen extends State<MovieListScreen> 
implements MovieView{
  late MoviePresenter _presenter;
  bool _isLoading = false;
  List<Movie> _movieList = [];
  String? _errorMessage;
  String _currentEndpoint = 'movie';

  @override
  void initState(){
    super.initState();
    _presenter = MoviePresenter(this);
    _presenter.loadMovieData(_currentEndpoint);
  }

  void _fetchData(String endpoint){
    setState(() {
      _currentEndpoint = endpoint;
      _presenter.loadMovieData(endpoint);
    });
  }
  
  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  void showMovieList(List<Movie> movieList) {
    setState(() {
      _movieList = movieList;
    });
  }
  
  @override
  void showErorr(String message) {
    setState(() {
      _errorMessage = message;
    });
  }
  
  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Movie List"),
      backgroundColor: Colors.deepPurple, // Menggunakan warna ungu agar lebih menarik
    ),
    body: Column(
      children: [
        
        // Menambahkan expanded dan desain ListView
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _errorMessage != null
                  ? Center(child: Text("Error ${_errorMessage}"))
                  : ListView.builder(
                      itemCount: _movieList.length,
                      itemBuilder: (context, index) {
                        final movie = _movieList[index];
                        return Card(
                          elevation: 5, // Tambahkan bayangan untuk memberi efek
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: (movie.imgUrl.isNotEmpty)
                                ? Image.network(
                                  movie.imgUrl,
                                  width: 40,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                                : Image.network('https://placehold.co/600x400'),
                            title: Text(
                              movie.title,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Genre: ${movie.genre}",
                              style: TextStyle(color: Colors.grey),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          id: movie.id, endpoint: _currentEndpoint)));
                            },
                          ),
                        );
                      },
                    ),
        ),
      ],
    ),
  );
}


}