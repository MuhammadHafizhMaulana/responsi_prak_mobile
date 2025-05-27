import 'package:responsi/model/movie_model.dart';
import 'package:responsi/network/base_network.dart';

abstract class MovieView{
  void showLoading();
  void hideLoading();
  void showMovieList(List<Movie> movieList);
  void showErorr(String message);
}

class MoviePresenter {
  final MovieView view;
  MoviePresenter(this.view);

  Future<void> loadMovieData(String endpoint) async {
    view.hideLoading();
    try {
      final List<dynamic> data = await BaseNetwork.getData(endpoint);
      final movieList = data.map((json)=> Movie.fromJson(json)).toList();
      view.showMovieList(movieList);
    } catch (e) {
      view.showErorr(e.toString());
    } finally{
      view.hideLoading();
    }
  }
}