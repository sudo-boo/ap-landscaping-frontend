import 'package:ap_landscaping/pages/provider/provider_signup/provider_qualifications_page.dart';
import 'package:flutter/material.dart';
import 'package:ap_landscaping/models/providerinfo.dart';

class ProviderSignUp extends StatefulWidget {
  const ProviderSignUp({super.key});
  @override
  State<ProviderSignUp> createState() => _ProviderSignUpState();
}

class _ProviderSignUpState extends State<ProviderSignUp> {
  final _formKey = GlobalKey<FormState>();
  providerInfo provider_info = providerInfo();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured1 = true;
  bool _isObscured2 = true;
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFFBBE1C5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/providersignin'),
        ),
      ),
      body: Container(
        color: const Color(0xFFBBE1C5),
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/signupPage1.png'),
                ),
                const Text(
                  'Hello There!',
                  style: TextStyle(
                    color: Color(0xFF3E363F),
                    fontSize: 50,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.02,
                    letterSpacing: -0.30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) => provider_info.username = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a username' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) => provider_info.email = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an email' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscured1,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured1 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured1 = !_isObscured1;
                      });
                    },
                  ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    onSaved: (value) => provider_info.password = value ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a password' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
                  child: TextFormField(
                    obscureText: _isObscured2,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured2 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured2 = !_isObscured2;
                      });
                    },
                  ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                    ),
                    validator: (value) => value != _passwordController.text
                        ? 'Password does not match'
                        : null,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QualificationsPage(
                                provider_info: provider_info)),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity, // Takes the width of the parent
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E363F), // Background color
                        borderRadius: BorderRadius.circular(
                            5), // Adjust the radius as needed
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Adjust the font size as needed
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
