import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intheloopapp/ui/themes.dart';
import 'package:intheloopapp/ui/views/send_badge/send_badge_cubit.dart';

class BadgeImageInput extends StatelessWidget {
  const BadgeImageInput({Key? key}) : super(key: key);

  Widget imagePicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pick a image",
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(width: 25.0),
        GestureDetector(
          onTap: () => context.read<SendBadgeCubit>().handleImageFromGallery(),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                color: itlAccent,
                width: 2,
              ),
            ),
            child: Icon(
              FontAwesomeIcons.fileImage,
              size: 40,
              color: itlAccent,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendBadgeCubit, SendBadgeState>(
      builder: (context, state) {
        return state.badgeImage == null
            ? imagePicker(context)
            : Image.file(state.badgeImage!);
      },
    );
  }
}