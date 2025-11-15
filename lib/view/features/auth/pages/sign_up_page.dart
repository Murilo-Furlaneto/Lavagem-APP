import 'package:flutter/material.dart';
import 'package:lavagem_app/data/enum/enum_role.dart';
import 'package:lavagem_app/data/helper/validation/user_validation.dart';
import 'package:lavagem_app/di/init_getit.dart';
import 'package:lavagem_app/domain/models/user_model.dart';
import 'package:lavagem_app/view/features/auth/view_model/user_viewmodel.dart';
import 'package:lavagem_app/view/features/auth/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _userViewModel = getIt<UserViewModel>();
  bool isObscure = true;
  bool isConsultor = false;

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
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Center(
                      child: Image.asset(
                        'assets/images/honda.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _nomeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        hintText: 'Nome completo',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'O campo precisa ser preenchido';
                        } else if (value.length < 4) {
                          return 'O campo senha precisa conter mais que 4 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
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
                        return 'O campo senha precisa conter mais que 5 caracteres';
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<bool>(
                        value: isConsultor,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isConsultor = newValue!;
                          });
                        },
                        items: const <DropdownMenuItem<bool>>[
                          DropdownMenuItem(
                            value: false,
                            child: Text('Lavador'),
                          ),
                          DropdownMenuItem(
                            value: true,
                            child: Text('Consultor'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                      ),
                      onPressed: () {
                        final usuario = UserModel(
                            nome: _nomeController.text,
                            email: _emailController.text,
                            senha: _senhaController.text,
                            funcao: isConsultor
                                ? UserRole.consultor
                                : UserRole.lavador);

                        final validationError = UserValidation.validar(usuario);

                        if (validationError == null) {
                          _userViewModel.cadastrarUsuario(usuario);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(validationError),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  LoginPage(userViewModel: _userViewModel,)),
                            (route) => false);
                      },
                      child: const Text('Já possui cadastro? Faça login',
                          style: TextStyle(color: Colors.black)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
