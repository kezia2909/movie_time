import 'package:movie_time/src/models/movie_model.dart';
import 'package:movie_time/src/models/trending_model.dart';
import 'package:movie_time/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TrendingTvShowDayBloc {
  final _repository = Repository();
  final _subject = BehaviorSubject<TrendingResponseModel>();

  BehaviorSubject<TrendingResponseModel> get subject => _subject;

  getTrendingList() async {
    TrendingResponseModel response =
        await _repository.getTrendingTvShowDayList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }
}

final trendingTvShowDayBloc = TrendingTvShowDayBloc();
