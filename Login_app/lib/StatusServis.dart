import 'Status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusServis{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStatus(String status, String image) async {
    var ref = _firestore.collection("kullanicilar");

    image = 'image boş';

    var documentRef = await ref.add({
      'status': status, 'image': image
    });

    return Status(id: documentRef.id, status: status, image: image);
  }
}