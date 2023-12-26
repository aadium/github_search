import 'package:bloc/bloc.dart';
import 'package:github_search/models/user.dart';
import 'package:github_search/services/github_service.dart';
import 'user_search_event.dart';
import 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final GitHubService gitHubService;

  UserSearchBloc(this.gitHubService) : super(UserSearchInitial()) {
    on<SearchUser>(_onSearchUser);
  }

  void _onSearchUser(SearchUser event, Emitter<UserSearchState> emit) async {
    emit(UserSearchLoading());

    try {
      final List<User> users = await gitHubService.searchUsers(event.query);
      emit(UserSearchSuccess(users));
    } catch (e) {
      emit(UserSearchError('Failed to fetch users. Please try again.'));
    }
  }
  
  UserSearchState fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson(UserSearchState state) {
    throw UnimplementedError();
  }
}
