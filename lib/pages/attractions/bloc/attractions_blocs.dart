import 'package:flutter_bloc/flutter_bloc.dart';
import 'attractions_events.dart';
import 'attractions_states.dart';

class AttractionsBlocs extends Bloc<AttractionsEvents, AttractionsStates>{

  AttractionsBlocs():super(const AttractionsStates()){
    on<RatingChangedEvent>((event, emit){
      emit(state.copyWith(rating: event.rating));
    });
    on<CommentEvent>((event, emit){
      emit(state.copyWith(comment: event.comment));
    });
    on<ReviewsResultEvent>((event, emit){
      emit(state.copyWith(reviewsResult: event.reviewsResult));
    });
    on<AverageRatingEvent>((event, emit){
      emit(state.copyWith(averageRating: event.averageRating));
    });
    on<IsFavoriteEvent>((event, emit){
      emit(state.copyWith(isFavorite: event.isFavorite));
    });
  }

}