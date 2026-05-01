import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_dicoding_app/common/constants.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv.dart';
import 'package:movie_dicoding_app/modules/tvs/domain/entities/tv_detail.dart';
import 'package:movie_dicoding_app/modules/tvs/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_dicoding_app/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvs';

  final int id;

  const TvDetailPage({super.key, required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchTvDetail(widget.id));
      context.read<TvDetailBloc>().add(LoadTvWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvDetailBloc, TvDetailState>(
        listenWhen: (previous, current) =>
            previous.watchlistMessage != current.watchlistMessage &&
            current.watchlistMessage.isNotEmpty,
        listener: (context, state) {
          final message = state.watchlistMessage;
          if (message == TvDetailBloc.watchlistAddSuccessMessage ||
              message == TvDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(content: Text(message));
              },
            );
          }
        },
        builder: (context, state) {
          if (state.tvState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.tvState == RequestState.Loaded && state.tv != null) {
            final tv = state.tv!;
            return SafeArea(
              child: DetailContent(
                tv,
                state.tvRecommendations,
                state.recommendationState,
                state.message,
                state.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(state.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;
  final List<Tv> recommendations;
  final RequestState recommendationState;
  final String message;
  final bool isAddedWatchlist;

  const DetailContent(
    this.tv,
    this.recommendations,
    this.recommendationState,
    this.message,
    this.isAddedWatchlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tv.name ?? '-', style: kHeading5),
                            FilledButton(
                              onPressed: () async {
                                final bloc = context.read<TvDetailBloc>();
                                if (!isAddedWatchlist) {
                                  bloc.add(AddTvToWatchlist(tv));
                                } else {
                                  bloc.add(RemoveTvFromWatchlist(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(tv.genres ?? [])),
                            _buildSeasons(tv.seasons ?? []),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (tv.voteAverage ?? 0) / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      Icon(Icons.star, color: kMikadoYellow),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage ?? 0}'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(tv.overview ?? '-'),
                            SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            _buildRecommendationSection(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(color: Colors.white, height: 4, width: 48),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationSection() {
    if (recommendationState == RequestState.Loading) {
      return Center(child: CircularProgressIndicator());
    } else if (recommendationState == RequestState.Error) {
      return Text(message);
    } else if (recommendationState == RequestState.Loaded) {
      return Container(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tvRecomendations = recommendations[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    TvDetailPage.ROUTE_NAME,
                    arguments: tvRecomendations.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${tvRecomendations.posterPath}',
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: recommendations.length,
        ),
      );
    }

    return Container();
  }

  String _showGenres(List<TvGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  Widget _buildSeasons(List<TvSeason> seasons) {
    if (seasons.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seasons', style: kHeading6),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: seasons.length,
            itemBuilder: (context, index) {
              final season = seasons[index];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 8),
                child: Card(
                  color: kDavysGrey,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      season.posterPath != null
                          ? CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w200${season.posterPath}',
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            )
                          : Container(
                              height: 100,
                              color: Colors.grey[800],
                              child: const Icon(Icons.tv, color: Colors.white),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              season.name ?? '-',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'S${season.seasonNumber ?? '-'}  •  ${season.episodeCount ?? '-'} eps',
                              style: const TextStyle(fontSize: 10, color: Colors.white70),
                            ),
                            if (season.voteAverage != null)
                              Text(
                                '★ ${season.voteAverage!.toStringAsFixed(1)}',
                                style: const TextStyle(fontSize: 10, color: kMikadoYellow),
                              ),
                            if (season.airDate != null)
                              Text(
                                '${season.airDate!.year}',
                                style: const TextStyle(fontSize: 10, color: Colors.white54),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
