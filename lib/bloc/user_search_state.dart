import 'package:equatable/equatable.dart';
import 'package:github_search/models/user.dart';

abstract class UserSearchState extends Equatable {
  const UserSearchState();
}

class UserSearchInitial extends UserSearchState {
  @override
  List<Object> get props => [];
}

class UserSearchLoading extends UserSearchState {
  @override
  List<Object> get props => [];
}

class UserSearchSuccess extends UserSearchState {
  final List<User> users;

  UserSearchSuccess(this.users);

  @override
  List<Object?> get props => [users];
}

class UserSearchError extends UserSearchState {
  final String message;

  UserSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
