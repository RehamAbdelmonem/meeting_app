import 'package:flutter/material.dart';
import 'package:jitsi_meet_v1/jitsi_meet.dart';
import 'package:zoom_app/resources/auth_methods.dart';
import 'package:zoom_app/utils/colors.dart';
import 'package:zoom_app/widgets/custom_button.dart';
import 'package:zoom_app/widgets/meeting_option.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TextField(
            controller: nameController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: 'Name',
              contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MeetingOption(
          text: 'Mute Audio',
          isMute: isAudioMuted,
          onChange: onAudioMuted,
        ),
        MeetingOption(
          text: 'Turn off My Video',
          isMute: isVideoMuted,
          onChange: onVideoMuted,
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
            text: 'Log Out',
            btncolor: Colors.red,
            onPressed: () => AuthMethods().signOut())
      ],
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
