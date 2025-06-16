import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tera/features/auth/register_screen.dart';

import '../../core/contants/app_color.dart';
import '../../core/utils/navigation.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_login_buttons.dart';
import 'auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              AuthTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Email is required'),
                  EmailValidator(errorText: 'Enter a valid email'),
                ]),
              ),
              AuthTextField(
                controller: _passwordController,
                label: 'Password',
                hintText: 'Enter your password',
                obscureText: authViewModel.obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.grey,
                  ),
                  onPressed: authViewModel.togglePasswordVisibility,
                ),
                validator: RequiredValidator(errorText: 'Password is required'),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password functionality
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AuthButton(
                text: 'Sign In',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authViewModel.login(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      context: context,
                    );
                  }
                },
                isLoading: authViewModel.isLoading,
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Or sign in with',
                  style: TextStyle(color: AppColors.grey),
                ),
              ),
              const SizedBox(height: 20),
              SocialLoginButtons(
                onGooglePressed: () {
                  // Google sign in implementation
                },
                onFacebookPressed: () {
                  // Facebook sign in implementation
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigation.push(context, const RegisterScreen());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}