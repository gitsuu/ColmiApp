import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool showPasswordCriteria = false;
  bool showPassword = false; // Mostrar/ocultar contraseña
  bool showConfirmPassword = false; // Mostrar/ocultar confirmación

  @override
  void initState() {
    super.initState();

    // Listener para controlar el enfoque en el campo de contraseña
    passwordFocusNode.addListener(() {
      setState(() {
        showPasswordCriteria = passwordFocusNode.hasFocus;
      });
    });
  }

  void validatePassword(String password) {
    setState(() {
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasLowercase = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasMinLength = password.length >= 8;
    });
  }

  @override
  void dispose() {
    // Liberar recursos
    passwordFocusNode.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '¡Crea tu cuenta!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de usuario',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: !showPassword,
                    onChanged: validatePassword,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirmar contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: !showConfirmPassword,
                  ),
                  const SizedBox(height: 8),
                  if (showPasswordCriteria)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PasswordCriteriaItem(
                          text: 'Debe contener al menos 1 letra mayúscula',
                          isValid: hasUppercase,
                        ),
                        PasswordCriteriaItem(
                          text: 'Debe contener al menos 2 letra minúscula',
                          isValid: hasLowercase,
                        ),
                        PasswordCriteriaItem(
                          text: 'Debe contener al menos 1 número',
                          isValid: hasNumber,
                        ),
                        PasswordCriteriaItem(
                          text: 'Debe tener al menos 8 caracteres',
                          isValid: hasMinLength,
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      final username = usernameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      final confirmPassword =
                          confirmPasswordController.text.trim();

                      if (username.isEmpty ||
                          email.isEmpty ||
                          password.isEmpty ||
                          confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Todos los campos son obligatorios'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Las contraseñas no coinciden, verifica nuevamente.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (!(hasUppercase &&
                          hasLowercase &&
                          hasNumber &&
                          hasMinLength)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'La contraseña no cumple con los criterios'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      try {
                        // Verificar si el username ya existe
                        final querySnapshot = await FirebaseFirestore.instance
                            .collection('users')
                            .where('username', isEqualTo: username)
                            .get();

                        if (querySnapshot.docs.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('El nombre de usuario ya está en uso'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Crear usuario en Firebase Auth
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        // Guardar el username en Firestore
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userCredential.user!.uid)
                            .set({
                          'username': username,
                          'email': email,
                        });

                        Navigator.of(context).pushReplacementNamed('/login');
                      } on FirebaseAuthException catch (e) {
                        String errorMessage;
                        switch (e.code) {
                          case 'email-already-in-use':
                            errorMessage =
                                'El correo electrónico ya está en uso.';
                            break;
                          case 'invalid-email':
                            errorMessage =
                                'El correo electrónico ingresado no es válido.';
                            break;
                          case 'weak-password':
                            errorMessage =
                                'La contraseña es demasiado débil. Intenta usar una contraseña más segura.';
                            break;
                          case 'operation-not-allowed':
                            errorMessage =
                                'El registro con correo electrónico está deshabilitado.';
                            break;
                          default:
                            errorMessage =
                                'Ocurrió un error inesperado. Por favor, inténtalo nuevamente.';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '¿Ya tienes cuenta? Inicia sesión aquí',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordCriteriaItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const PasswordCriteriaItem({
    required this.text,
    required this.isValid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
