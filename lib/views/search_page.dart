import 'package:final_exam/modal/contact_modal.dart';
import 'package:final_exam/views/componets/text_Field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ContactProvider>(context);
    var providerFalse = Provider.of<ContactProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyField(
                    onChanged: (value) {
                      providerFalse.searchByName(value);
                    },
                      icon: Icons.search,
                      controller: providerTrue.txtSearch,
                      label: 'Search Name'),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: providerFalse.getName(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
               providerTrue.searchName = providerTrue.searchList
                    .map(
                      (e) => ContactModal.fromMap(e),
                    )
                    .toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: providerTrue.searchName.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Text(providerTrue.searchName[index].id.toString()),
                      title: Text(providerTrue.searchName[index].name.toString()),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(providerTrue.searchName[index].email),
                          Text(providerTrue.searchName[index].phoneNo)
                        ],
                      ),
                    )
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
    );
  }
}
