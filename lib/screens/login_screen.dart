import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import '../widgets/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLogin});
  final VoidCallback onLogin;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = GlobalKey<FormState>();
  bool visible = false;
  @override
  Widget build(BuildContext context) => AppBackground(
    child: LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: (constraints.maxHeight - 64).clamp(0, double.infinity),
          ),
          child: Form(
            key: form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Mixtapp',
                  style: TextStyle(
                    fontSize: 52,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.pink,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '¿Quieres conocer música nueva?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.muted),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  key: const Key('email'),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    hintText: 'Ingresa tu correo',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  validator: (value) =>
                      value == null ||
                          !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                              .hasMatch(value.trim())
                      ? 'Escribe un correo válido.'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('password'),
                  obscureText: !visible,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Ingresa tu contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      tooltip: visible
                          ? 'Ocultar contraseña'
                          : 'Mostrar contraseña',
                      onPressed: () => setState(() => visible = !visible),
                      icon: Icon(
                        visible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (value) => value == null || value.length < 6
                      ? 'Usa al menos 6 caracteres.'
                      : null,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (form.currentState!.validate()) widget.onLogin();
                    },
                    child: const Text('Ingresar'),
                  ),
                ),
                const SizedBox(height: 22),
                TextButton(
                  onPressed: () => showFeedback(
                    context,
                    'Usa cualquier correo válido y una contraseña de 6 caracteres para probar la demostración.',
                  ),
                  child: const Text('¿No tienes cuenta? Crear cuenta'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
