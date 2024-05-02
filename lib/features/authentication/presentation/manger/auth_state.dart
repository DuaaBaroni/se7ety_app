class AuthState{}

class AuthInitial extends AuthState{}
// login
class LoginLoadingState extends AuthState{}

class LoginSuccessState extends AuthState{}

class LoginErrorState extends AuthState{
  final String error;

  LoginErrorState(this.error);
}

// register 
class RegisterLoadingState extends AuthState{}

class RegisterSuccessState extends AuthState{}

class RegisterErrorState extends AuthState{
   final String error ;
   RegisterErrorState(this.error);
}

// upload doctor 

class UploadLoadingState extends AuthState{}

class UploadSuccessState extends AuthState{}

class UploadErrorState extends AuthState{
  final String error;
  UploadErrorState(this.error);

}

