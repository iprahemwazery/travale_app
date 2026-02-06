import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travale_app/auth/createAccont/create_user.dart';
import 'package:travale_app/auth/login/cubit/login_cubit.dart';
import 'package:travale_app/auth/login/cubit/login_state.dart';
import 'package:travale_app/auth/widget/app_text_field.dart';
import 'package:travale_app/core/network/api_service.dart';
import 'package:travale_app/root.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<ApiService>()),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginError) _showSnack(state.message);
                  if (state is LoginSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Root()),
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.lock_outline, size: 80),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Login to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 32),

                    /// Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.06),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppTextField(
                              controller: _usernameController,
                              label: 'Email',
                              hint: 'Enter your Email',
                              icon: Icons.person_outline,
                              validator:
                                  (v) => v!.isEmpty ? 'Enter username' : null,
                            ),
                            const SizedBox(height: 16),
                            AppTextField(
                              controller: _passwordController,
                              label: 'Password',
                              hint: '********',
                              icon: Icons.lock_outline,
                              isPassword: true,
                              validator:
                                  (v) => v!.isEmpty ? 'Enter password' : null,
                            ),

                            const SizedBox(height: 24),
                            BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed:
                                        state is LoginLoading
                                            ? null
                                            : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<LoginCubit>()
                                                    .login(
                                                      username:
                                                          _usernameController
                                                              .text
                                                              .trim(),
                                                      password:
                                                          _passwordController
                                                              .text
                                                              .trim(),
                                                    );
                                              }
                                            },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child:
                                        state is LoginLoading
                                            ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                            : const Text('Login'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreateEmailPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
