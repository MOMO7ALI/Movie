import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/model/browse_genre_response.dart';

// Define the possible states for the Cubit
@immutable
abstract class BrowseState {}

// Initial state when the Cubit is first created
class BrowseInitial extends BrowseState {}

// State when a genre is selected
class BrowseGenreSelected extends BrowseState {
  final Genres? genre;

  BrowseGenreSelected(this.genre);
}

// State when navigating back to categories (reset genre)
class BrowseBackToCategories extends BrowseState {}

// Define the Cubit that manages browse state
class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseInitial());

  // Method to set the selected genre and update the state
  void setSelectedGenre(Genres? genre) {
    emit(BrowseGenreSelected(genre));
  }

  // Method to navigate back to categories (reset genre)
  void navigateBackToCategories() {
    emit(BrowseBackToCategories());
  }
}
