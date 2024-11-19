import 'package:final_exam/helper/db_helper.dart';
import 'package:final_exam/modal/contact_modal.dart';
import 'package:final_exam/services/conatcct_services.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier {
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSign = TextEditingController();
  var txtPass = TextEditingController();
  var txtSearch = TextEditingController();
  int id = 0;
  List contactList = [];
  List searchList = [];
  String search = '';
  List searchName = [];

  Future<void> initData() async {
    await DbHelper.dbHelper.initData();
  }

  Future<void> datacloudToLocally() async {
    final details =
        await ContactService.contactService.readContactInStore().first;
    final contactDetails = details.docs.map(
      (e) {
        final data = e.data();
        return ContactModal(
            id: data['id'],
            name: data['name'],
            phoneNo: data['phoneNo'],
            email: data['email']);
      },
    ).toList();

    for (var con in contactDetails) {
      final sysn = await DbHelper.dbHelper.dataLocallySave(id);
      if (sysn) {
        await updateData(
          id: con.id,
          name: con.name,
          phoneNo: con.phoneNo,
          email: con.email,
        );
      } else {
        await insertData(
          id: con.id,
          name: con.name,
          phoneNo: con.phoneNo,
          email: con.email,
        );
      }
    }
  }

  Future<void> insertData(
      {required int id,
      required String name,
      required String phoneNo,
      required String email}) async {
    await DbHelper.dbHelper.insertDataInDatabase(
        id: id, name: name, phoneNo: phoneNo, email: email);
  }

  Future<void> updateData(
      {required int id,
      required String name,
      required String phoneNo,
      required String email}) async {
    await DbHelper.dbHelper
        .updateData(id: id, name: name, phoneNo: phoneNo, email: email);
  }

  Future<void> deleteData({required int id}) async {
    await DbHelper.dbHelper.deleteData(id: id);
  }

  Future<List> readData() async {
    contactList = await DbHelper.dbHelper.readData();
    notifyListeners();
    return contactList;
  }

  Future<void> contactAddInStore(
      {required int id,
      required String name,
      required String phoneNo,
      required String email}) async {
    await ContactService.contactService.addContactInFireStore(
        id: id, name: name, phoneNo: phoneNo, email: email);
  }

  void searchByName(String value)
  {
    search = value;
    getName();
    notifyListeners();
  }

  Future<List<Map<String, Object?>>> getName()
  async {
    return searchList = await DbHelper.dbHelper.searchName(search);
  }

  void clearAll() {
    txtName.clear();
    txtPhone.clear();
    txtEmail.clear();
    notifyListeners();
  }

  ContactProvider() {
    initData();
  }
}
