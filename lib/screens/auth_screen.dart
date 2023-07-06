import 'package:bookstore/provider/auth_service.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  static const routeName = '/auth-screen';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  var _isLogin = true;
  var _view = false;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _viewPassword() {
    setState(() {
      _view = !_view;
    });
  }

  void signUpUser() {
    authService.userSignUp(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authService.userLogin(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _isLogin ? _signInFormKey : _signUpFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: _isLogin
                                ? null
                                : TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                    ),
                                    keyboardType: TextInputType.name,
                                    autocorrect: false,
                                    controller: _nameController,
                                    validator: (value) => null,
                                  ),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            controller: _emailController,
                            validator: (value) => null,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: GestureDetector(
                                    onTap: _viewPassword,
                                    child: Icon(_view
                                        ? Icons.visibility_off
                                        : Icons.visibility))),
                            obscureText: _view ? false : true,
                            controller: _passwordController,
                            validator: (value) => null,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _isLogin
                                ? () {
                                    if (_signInFormKey.currentState!
                                        .validate()) {
                                      signInUser();
                                      const CircularProgressIndicator();
                                    }
                                  }
                                : () {
                                    if (_signUpFormKey.currentState!
                                        .validate()) {
                                      signUpUser();
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: Text(
                                                  'User signed up, try to log in')));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I already have an account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
