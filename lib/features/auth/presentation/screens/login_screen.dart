import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_controller.dart';
import '../../../../setups/app_routes/app_routes.dart';
import '../../../../setups/di/service_locator.dart';
import '../../../../shared/presentation/widgets/elevate_button_widget.dart';
import '../../../../shared/presentation/widgets/outlined_button_widget.dart';
import '../../../../shared/presentation/widgets/responsive_padding_widget.dart';
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ResponsivePadding(
          isScreenWrapper: true,
          child: Scaffold(
            body: BlocProvider<LoginBloc>(
              create: (context) => _loginCubit,
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) => Center(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 55),
                        TextFieldWidget(
                          label: 'Email',
                          hint: 'example@email.com',
                          controller: _emailController,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 22),
                        TextFieldWidget(
                          label: 'Senha',
                          controller: _passwordController,
                          obscureText: state.hidePassword,
                          validator: validatePassword,
                          textInputAction: TextInputAction.done,
                          suffix: IconButton(
                            onPressed: () => _loginCubit.hidePassword(!state.hidePassword),
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
                                AppController.I.setUser(_loginCubit.state.user!);
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
                                    fontSize: 16,
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
    } else if (value.length < 8 ||
        !value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
        !value.contains(RegExp(r'[0-9]'))) {
      return 'Senha inválida';
    }

    return null;
  }
}
