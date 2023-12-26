import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search/bloc/user_search_bloc.dart';
import 'package:github_search/bloc/user_search_event.dart';
import 'package:github_search/bloc/user_search_state.dart';
import 'package:github_search/services/github_service.dart';
import 'package:github_search/user_details.dart';

void main() {
  final Dio dio = Dio();
  final GitHubService gitHubService = GitHubService(dio);
  runApp(MyApp(gitHubService: gitHubService));
}

class MyApp extends StatelessWidget {
  final GitHubService gitHubService;

  MyApp({required this.gitHubService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub User Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => UserSearchBloc(gitHubService),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub User Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                BlocProvider.of<UserSearchBloc>(context).add(SearchUser(query));
              },
              decoration: InputDecoration(
                labelText: 'Enter GitHub username',
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<UserSearchBloc, UserSearchState>(
              builder: (context, state) {
                if (state is UserSearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is UserSearchSuccess) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsPage(user: user),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatarUrl),
                        ),
                        title: Text(user.login),
                      );
                    },
                  );
                } else if (state is UserSearchError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
