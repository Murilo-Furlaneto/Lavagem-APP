import 'package:flutter/material.dart';
import 'package:lavagem_app/data/helper/validation/user_validation.dart';
import 'package:lavagem_app/viewmodel/user_viewmodel.dart';
import 'package:lavagem_app/view/pages/auth/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.userViewModel});

  @override
  State<LoginPage> createState() => _LoginPageState();

  final UserViewModel userViewModel;
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: Image.asset(
                        'assets/images/honda.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O campo precisa ser preenchido';
                      } else if (value.length < 5) {
                        return 'O campo email precisa conter mais que 5 caracteres';
                      } else if (!value.contains('.com') ||
                          !value.contains('@')) {
                        return 'O campo email deve conter o @ e ".com"';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      hintText: 'Senha',
                    ),
                    obscureText: isObscure,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                      ),
                      onPressed: () async {
                        try {
                          final emailValidate = UserValidation.validarEmail(
                              _emailController.text);
                          final passwordValidate =
                              UserValidation.validarSenha(
                                  _senhaController.text);
                          if (emailValidate != null || passwordValidate != null) {
                            await widget.userViewModel
                                .login(emailValidate!, passwordValidate!);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                      onPressed: () async {
                        try {
                          await widget.userViewModel
                              .resetarSenha(_emailController.text);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      child: const Text('Esqueceu a senha?',
                          style: TextStyle(color: Colors.red, fontSize: 15))),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                            (route) => false);
                      },
                      child: const Text('Não tem uma conta? Cadastre-se',
                          style: TextStyle(color: Colors.black, fontSize: 15)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
