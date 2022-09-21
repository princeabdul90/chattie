/*
* Developer: Abubakar Abdullahi
* Date: 11/08/2022
*/
import 'package:chattie/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/user_dao.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = true;

  void printLatestValue() {
     _emailController.text;
    _passwordController.text;
  }

  @override
  void initState() {
    _emailController.addListener(printLatestValue);
    _passwordController.addListener(printLatestValue);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onLoginUser(userDao, bool login) {
    if (_formKey.currentState!.validate()) {

      if(login == true) {
        userDao.login(
          _emailController.text,
          _passwordController.text,
        );

      }else {
        userDao.signup(
          _emailController.text,
          _passwordController.text,
        );
      }


      if (userDao.isLoggedIn() == true ) {
        setState(() {
          _emailController.clear();
          _passwordController.clear();
        });
      }
    } else {
      toast('please fill all fields');
    }
  }


  @override
  Widget build(BuildContext context) {

    final userDao = Provider.of<UserDao>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chattie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Email Address',
                      ),
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      controller: _emailController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Required';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:  InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible ? Icons.visibility_off : Icons.visibility,
                              color: Colors.blue,)
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: passwordVisible,
                      autofocus: false,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      controller: _passwordController,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // userDao.login(
                        //   _emailController.text,
                        //   _passwordController.text,
                        // );
                        onLoginUser(userDao, true);
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // userDao.signup(
                        //   _emailController.text,
                        //   _passwordController.text,
                        // );
                        onLoginUser(userDao, false);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
