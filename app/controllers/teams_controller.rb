class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[show edit update destroy, transfer]
  before_action :forbid_edit_team, only: %i[edit update]

  def index
    @teams = Team.all
  end

  def show
    @working_team = @team
    change_keep_team(current_user, @team)
  end

  def new
    @team = Team.new
  end

  def edit; end

  def create
    @team = Team.new(team_params)
    @team.owner = current_user
    if @team.save
      @team.invite_member(@team.owner)
      redirect_to @team, notice: I18n.t('views.messages.create_team')
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_team')
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: I18n.t('views.messages.update_team')
    else
      flash.now[:error] = I18n.t('views.messages.failed_to_save_team')
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: I18n.t('views.messages.delete_team')
  end

  def transfer
    new_leader = User.find_by(id: params[:new_leader_id])
    if current_user == @team.owner && @team.owner_id != new_leader.id
      @team.owner_id = new_leader.id
      @team.update(team_params)
      TeamMailer.team_mail(@team.name, new_leader.email).deliver
      redirect_to team_path(@team.id),
      notice: 'リーダー権限を移動しました'
    else
      render :show
    end
  end

  def dashboard
    @team = current_user.keep_team_id ? Team.find(current_user.keep_team_id) : current_user.teams.first
  end

  private

  def set_team
    @team = Team.friendly.find(params[:id])
  end

  def team_params
    params.fetch(:team, {}).permit %i[name icon icon_cache owner_id keep_team_id]
  end

  def forbid_edit_team
    redirect_to team_url(@team), notice: I18n.t('views.messages.cannot_edit_the_team') unless @team.owner == current_user
  end

end
