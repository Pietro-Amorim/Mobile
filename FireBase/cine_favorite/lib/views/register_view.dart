import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _senhaField = TextEditingController();
  final TextEditingController _confirmarSenhaField = TextEditingController();
  bool _ocultarSenha = true;
  bool _ocultarConfSenha = true;
  bool _isLoading = false;

  void _registrar() async {
    // Validações
    if (_emailField.text.isEmpty || _senhaField.text.isEmpty || _confirmarSenhaField.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos"))
      );
      return;
    }

    if (_senhaField.text != _confirmarSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("As senhas não coincidem"))
      );
      return;
    }

    if (_senhaField.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("A senha deve ter pelo menos 6 caracteres"))
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(), 
        password: _senhaField.text
      );
      
      // Sucesso - usuário criado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário criado com sucesso!"))
      );
      
      // Opcional: Navegar de volta para login
      // Navigator.pop(context);
      
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Erro ao criar usuário";
      
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "Este email já está em uso";
          break;
        case 'invalid-email':
          errorMessage = "Email inválido";
          break;
        case 'operation-not-allowed':
          errorMessage = "Operação não permitida";
          break;
        case 'weak-password':
          errorMessage = "Senha muito fraca";
          break;
        default:
          errorMessage = "Erro: ${e.message}";
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailField,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _ocultarSenha = !_ocultarSenha;
                    });
                  }, 
                  icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off)
                )
              ),
              obscureText: _ocultarSenha,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmarSenhaField, // CORREÇÃO AQUI
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _ocultarConfSenha = !_ocultarConfSenha;
                    });
                  }, 
                  icon: Icon(_ocultarConfSenha ? Icons.visibility : Icons.visibility_off)
                ),
              ),
              obscureText: _ocultarConfSenha,
            ),
            const SizedBox(height: 20),
            _isLoading 
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _registrar, 
                    child: const Text("Registrar")
                  ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Voltar para login
              }, 
              child: const Text("Já tem uma conta? Faça login")
            )
          ],
        ),
      ),
    );
  }
}