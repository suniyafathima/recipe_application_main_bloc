import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/favorite_screen/viewmodel/bloc/favorite_bloc.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final FavoriteBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = FavoriteBloc();
    _bloc.add(LoadFavorites());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text("My favourites", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is FavoriteLoaded) {
              final items = state.items;

              if (items.isEmpty) {
                return Center(child: Text("No favorites yet"));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: Image.asset(item.imagePath, width: 60, height: 60, fit: BoxFit.cover),
                    title: Text(item.name),
                    subtitle: Text(item.time),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: ColorConstants.red),
                      onPressed: () {
                        context.read<FavoriteBloc>().add(RemoveFavorite(index));
                      },
                    ),
                  );
                },
              );
            }

            if (state is FavoriteError) {
              return Center(child: Text(state.message));
            }

            return Container();
          },
        ),
      ),
    );
  }
}
