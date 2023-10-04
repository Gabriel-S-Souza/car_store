import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../setups/app_routes/app_routes.dart';
import '../../../../setups/di/service_locator.dart';
import '../../../../shared/presentation/toast/toast_controller.dart';
import '../../../../shared/presentation/widgets/elevate_button_widget.dart';
import '../../../../shared/presentation/widgets/outlined_button_widget.dart';
import '../../../../shared/presentation/widgets/responsive_padding_widget.dart';
import '../../../../shared/presentation/widgets/text_field_widget.dart';
import '../blocs/register/register_use_state.dart';
import '../blocs/register/register_user_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final registerUserBloc = ServiceLocator.I.get<RegisterUserBloc>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    registerUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ResponsivePadding(
          isScreenWrapper: true,
          child: Scaffold(
            body: BlocProvider<RegisterUserBloc>(
              create: (context) => registerUserBloc,
              child: BlocBuilder<RegisterUserBloc, RegisterUserState>(
                builder: (context, state) => Center(
                  child: Form(
                    key: formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Text(
                          'Cadastro',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 55),
                        TextFieldWidget(
                          label: 'Nome',
                          controller: nameController,
                          validator: validateName,
                        ),
                        const SizedBox(height: 16),
                        TextFieldWidget(
                          label: 'Email',
                          controller: emailController,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 16),
                        TextFieldWidget(
                          label: 'Senha',
                          controller: passwordController,
                          obscureText: state.hidePassword,
                          textInputAction: TextInputAction.done,
                          validator: validatePassword,
                          suffix: IconButton(
                            onPressed: () => registerUserBloc.hidePassword(!state.hidePassword),
                            icon: Icon(
                              state.hidePassword ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFieldWidget(
                          label: 'Confirmar senha',
                          controller: confirmPasswordController,
                          obscureText: state.hideConfirmPassword,
                          textInputAction: TextInputAction.done,
                          validator: validateConfirmPassword,
                          suffix: IconButton(
                            onPressed: () =>
                                registerUserBloc.hideConfirmPassword(!state.hideConfirmPassword),
                            icon: Icon(
                              state.hideConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButtonWidget(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await registerUserBloc.register(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                              if (registerUserBloc.state.isSuccess && mounted) {
                                context.goNamed(RouteName.login.name);
                              }
                            }
                          },
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButtonWidget(
                          onPressed: () => context.goNamed(RouteName.login.name),
                          text: 'Já possui uma conta? Entrar',
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome é obrigatório';
    }
    return null;
  }

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
      Toast.show(
        'A senha deve conter pelo menos 8 caracteres e conter pelo menos uma letra maiúscula, uma letra minúscula, um número e um caractere especial',
        duration: const Duration(seconds: 6),
      );
      return 'Senha inválida';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme a senha';
    } else if (value != passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
