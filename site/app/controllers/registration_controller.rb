class RegistrationController < Devise::RegistrationsController
  private
 
  def sign_up_params
    params.require(:user).permit(:nome, :morada, :localidade, :codigo, :nif, :moeda, :email, :password, :password_confirmation, :current_password, :telef, :distrito_id, :concelho_id, :habilitacoes, :profissao,:formacao)
  end
 
  def account_update_params
    params.require(:user).permit(:nome, :morada, :localidade, :codigo, :nif, :moeda, :email, :password, :password_confirmation, :current_password, :telef, :distrito_id, :concelho_id, :habilitacoes, :profissao,:formacao)
  end
 
end