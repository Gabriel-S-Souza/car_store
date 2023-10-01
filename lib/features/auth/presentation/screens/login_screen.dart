import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_controller.dart';
import '../../../../setups/app_routes/app_routes.dart';
import '../../../../setups/di/service_locator.dart';
import '../../../../shared/presentation/widgets/elevate_button_widget.dart';
import '../../../../shared/presentation/widgets/outlined_button_widget.dart';
import '../../../../shared/presentation/widgets/text_field_widget.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _loginCubit = ServiceLocator.I.get<LoginBloc>();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: BlocProvider<LoginBloc>(
            create: (context) => _loginCubit,
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) => Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text(
                        'Car Store',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFieldWidget(
                        controller: _emailController,
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Senha',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFieldWidget(
                        controller: _passwordController,
                        obscureText: state.hidePassword,
                        validator: validatePassword,
                        textInputAction: TextInputAction.done,
                        suffix: IconButton(
                          onPressed: () => _loginCubit.showPassword(!state.hidePassword),
                          icon: Icon(
                            state.hidePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButtonWidget(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _loginCubit.login(
                                _emailController.text, _passwordController.text);

                            if (_loginCubit.state.user != null && mounted) {
                              AppController.I.setRole(_loginCubit.state.user!.roles);
                              AppController.I.setNavBarIndex(0);
                              context.goNamed(RouteName.vehicles.name);
                            }
                          }
                        },
                        child: state.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButtonWidget(
                        onPressed: () => context.goNamed(RouteName.signup.name),
                        text: 'Não tem uma conta? Cadastre-se',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O email é obrigatório';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Email inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória';
    } else if (value.length <= 8 ||
        !value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
        !value.contains(RegExp(r'[0-9]'))) {
      return 'Senha inválida';
    }

    return null;
  }
}
