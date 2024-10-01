// ignore_for_file: unused_import, empty_statements

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
final FirebaseStorage  _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName,Uint8List file) async {
    Reference ref = _storage.ref().child(childName);;
    UploadTask uploadTask = ref.putData(file, SettableMetadata(contentType: 'image/png'));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
Future<String> uploadVideoToStorage(String childName, Uint8List file) async {
  Reference ref = _storage.ref().child(childName);
  UploadTask uploadTask = ref.putData(file, SettableMetadata(contentType: 'video/mp4')); // Adjust the content type for videos
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}


  Future<String> saveData({
    required Uint8List file
  }) async {
    String resp = " Some Error Occurred";
    try{
      if(file.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('images/profileImage', file);
        await _firestore.collection('userProfile').add({
          'imageLink': imageUrl,
        });

        resp = 'success';
      }
    }
        catch(err){
          resp =err.toString();
        }
        return resp;
  }
}
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class StoreData {
//   Future<String> uploadToStorage(String childName, Uint8List file, String contentType) async {
//     Reference ref = _storage.ref().child(childName);
//     UploadTask uploadTask = ref.putData(file, SettableMetadata(contentType: contentType));
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }

//   Future<String> saveData({
//     required Uint8List file,
//     required String contentType,
//   }) async {
//     String resp = " Some Error Occurred";
//     try {
//       if (file.isNotEmpty) {
//         String mediaUrl = await uploadToStorage('media/profileMedia', file, contentType);

//         // Update this part according to your Firestore data structure
//         await _firestore.collection('mediaCollection').add({
//           'mediaLink': mediaUrl,
//           'contentType': contentType,
//         });

//         resp = 'success';
//       }
//     } catch (err) {
//       resp = err.toString();
//     }
//     return resp;
//   }
// }
