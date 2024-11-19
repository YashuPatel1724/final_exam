import 'package:final_exam/services/auth_services.dart';
import 'package:final_exam/views/componets/text_Field.dart';
import 'package:final_exam/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<ContactProvider>(context);
    var providerFalse = Provider.of<ContactProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Sign In Page',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            MyField(controller: providerTrue.txtEmail, label: 'Email'),
            SizedBox(
              height: 10,
            ),
            MyField(controller: providerTrue.txtPass, label: 'Password'),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                await AuthServices.authServices.signInWithGoogle();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              },
              child: Container(
                height: 40,
                width: 40,
                child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
