import 'package:final_exam/modal/contact_modal.dart';
import 'package:final_exam/provider/contact_provider.dart';
import 'package:final_exam/services/auth_services.dart';
import 'package:final_exam/views/componets/text_Field.dart';
import 'package:final_exam/views/search_page.dart';
import 'package:final_exam/views/signIn_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ContactProvider>(context);
    var providerFalse = Provider.of<ContactProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(onPressed: () {
            providerFalse.datacloudToLocally();
          }, child: Text('Save In Local')),
          TextButton(
              onPressed: () {
                List<ContactModal> cont = [];
                cont = providerTrue.contactList
                    .map(
                      (e) => ContactModal.fromMap(e),
                    )
                    .toList();

                for (int i = 0; i < providerTrue.contactList.length; i++) {
                  providerFalse.contactAddInStore(
                      id: cont[i].id,
                      name: cont[i].name,
                      phoneNo: cont[i].phoneNo,
                      email: cont[i].email);
                }
              },
              child: Text('Back Up')),
          IconButton(onPressed: () async {
            await AuthServices.authServices.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SigninPage(),));
          }, icon: Icon(Icons.login))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage(),));
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Search'),
            ),
          ),
          FutureBuilder(
            future: providerFalse.readData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ContactModal> conatct = [];
                conatct = providerTrue.contactList
                    .map(
                      (e) => ContactModal.fromMap(e),
                    )
                    .toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: conatct.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        providerTrue.id = conatct[index].id;
                        providerTrue.txtName.text = conatct[index].name;
                        providerTrue.txtPhone.text = conatct[index].phoneNo;
                        providerTrue.txtEmail.text = conatct[index].email;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Update Contact'),
                            actions: [
                              MyField(
                                controller: providerTrue.txtName,
                                label: 'Name',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyField(
                                controller: providerTrue.txtEmail,
                                label: 'Email',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyField(
                                controller: providerTrue.txtPhone,
                                label: 'Phone',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      providerFalse.updateData(
                                          id: providerTrue.id,
                                          name: providerTrue.txtName.text,
                                          phoneNo: providerTrue.txtPhone.text,
                                          email: providerTrue.txtEmail.text);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      title: Text(
                        conatct[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(conatct[index].email),
                          Text(conatct[index].phoneNo)
                        ],
                      ),
                      trailing: GestureDetector(
                          onTap: () {
                            providerFalse.deleteData(id: conatct[index].id);
                          },
                          child: Icon(Icons.delete)),
                      leading: Text(conatct[index].id.toString()),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          providerFalse.clearAll();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Contact'),
              actions: [
                MyField(
                  icon: Icons.person,
                  controller: providerTrue.txtName,
                  label: 'Name',
                ),
                SizedBox(
                  height: 10,
                ),
                MyField(
                  icon: Icons.email,
                  controller: providerTrue.txtEmail,
                  label: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                MyField(
                  icon: Icons.phone,
                  controller: providerTrue.txtPhone,
                  label: 'Phone',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        providerTrue.id = providerTrue.contactList.length + 1;
                        providerFalse.insertData(
                            id: providerTrue.id,
                            name: providerTrue.txtName.text,
                            phoneNo: providerTrue.txtPhone.text,
                            email: providerTrue.txtEmail.text);
                        Navigator.pop(context);
                        providerFalse.clearAll();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
