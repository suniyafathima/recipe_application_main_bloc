import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:recipe_application_main/features/profile_screen/viewmodel/bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRowItem("Change Email", "suniyafathima@gmail.com", Icons.edit),
                  const SizedBox(height: 12),
                  buildRowItem("Change Name", "Suniya", Icons.edit),
                  const SizedBox(height: 12),

                  // Push Notification Toggle
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Push Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text("Turn on or off the push notifications"),
                        value: state.pushNotifications,
                        onChanged: (val) {
                          bloc.add(TogglePushNotificationEvent(val));
                        },
                        activeColor: Colors.amber,
                      );
                    },
                  ),

                  const SizedBox(height: 12),
                  buildRowItem("Preference", "", Icons.edit, onTap: () {
                    // Navigate to OnboardingScreen
                  }),
                  const SizedBox(height: 12),
                  buildRowItem("Reset Password", "Tap to reset Password", Icons.lock),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRowItem(String title, String subtitle, IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(subtitle),
            ),
          ),
          Icon(icon, color: Colors.grey[700]),
        ],
      ),
    );
  }
}
