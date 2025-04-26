abstract class Login {}

class loginsatat extends Login {}

class loginmainstat extends Login {}

class loginscreen extends Login {}

class loginError extends Login {
  final String error;
  loginError(this.error);
}
