import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelguide/common/widgets/toast.dart';
import 'package:travelguide/pages/profile/bloc/profile_blocs.dart';
import 'package:travelguide/pages/profile/bloc/profile_events.dart';

class ProfileController {
  final BuildContext context;

  const ProfileController({required this.context});

  Future<void> uploadImage(File uploadFile, String userId, String userName) async {
    if (uploadFile.existsSync()) {
      final Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$userId/$userName.jpg');
      try {
        final UploadTask uploadTask = storageRef.putFile(uploadFile);
        await uploadTask.whenComplete(() => null);

        final String downloadUrl = await storageRef.getDownloadURL();
        context.read<ProfileBlocs>().add(ImageUrlEvent(downloadUrl));
      } catch (e) {
        toastInfo(msg: 'Error loading profile image: $e');
      }
    } else {
      toastInfo(msg: 'File does not exist.');
    }
  }

  Future<void> loadProfileImage(String userId, String userName) async {
    final Reference storageRef =
    FirebaseStorage.instance.ref().child('profile_images/$userId/$userName.jpg');

    try {
      final url = await storageRef.getDownloadURL();
      context.read<ProfileBlocs>().add(ImageUrlEvent(url));
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        context.read<ProfileBlocs>().add(ImageUrlEvent(""));
      } else {
        toastInfo(msg: 'Error loading profile image: $e');
      }
    }
  }
}
