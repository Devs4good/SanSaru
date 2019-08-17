class ProfilesController < ApplicationController
  before_action :set_profile, only: [:destroy]
  before_action :require_login

  def index
    # Los usuarios que van a aparecer en el listado tienen que cumplir:
    #   1) Están postulados (tienen un perfil creado).
    #   2) No son el usuario actual (para evitar que una persona se seleccione a si misma).
    #   3) No fueron seleccionados aún y todavía hay cupo para el rol que pusieron en su perfil.
    #   4) Fueron seleccionados para participar de la hackaton.

    @postulados = User.
      joins(:profile).
      joins('LEFT JOIN invitations ON invitations.user_id = users.id').
      where.not(profile_id: nil).
      where.not(users: { id: current_user.id }).
      where(
        '(invitations.id IS NULL AND profiles.role IN (:available_roles)) OR invitations.id IS NOT NULL',
        available_roles: Role.with_available_invitations,
      ).
      order('organizer DESC, created_at ASC').
      paginate(page: params[:page], per_page: 10)
  end

  def favorites
    @postulados = current_user.favorites.paginate(page: params[:page], per_page: 10)
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(
      :residence, :first_time, :expectancy, :hobbies, :bring, :proposal,
      :bio, :gender_id, :size_id, :linkedin, :heard_or_see_d4g, :tech_stack,
      :owned_projects,
    )
  end
end
