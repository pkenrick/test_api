class Api::TaskController < Api::BaseController

  def user_tasks
    render json: { tasks: current_user.tasks }
  end

end
