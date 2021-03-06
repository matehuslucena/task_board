class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index 
    respond_to do |format|
      format.html do
        get_tasks_by_board
        get_boards_by_user
        get_status
      end
      format.json do
        @tasks = Task.where(board_id: session[:board])
        render json: @tasks
      end
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    get_boards_by_user
  end

  # GET /tasks/new
  def new
    @task = Task.new
    get_status
    get_boards_by_user
  end

  # GET /tasks/1/edit
  def edit
    set_task
    get_status
    get_boards_by_user
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    unless @task.board_id.nil?
      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_task_path, notice: "Please fil all the fields."
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      format.html { redirect_to @task, notice: 'Task was successfully updated.' }
      format.json { render :show, status: :ok, location: @task }
    else
      format.html { render :edit }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filter
    session[:board] = params[:board_id]
    redirect_to tasks_path
  end

  def update_ajax
    @task = Task.find(params[:task_id])
    @task.status_id = params[:status_id]
    @task.save
    flash[:notice] = 'Successfully checked in'
    redirect_to @task
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :priority, :status_id, :board_id)
    end

    def get_boards_by_user
      @boards = Board.where(user_id: current_user.id)
    end

    def get_tasks_by_board
      @tasks = if params[:board_id]
          Task.find_by_board_id(params[:board_id])
        else
          Task.all.where(user_id: current_user.id)
        end
        p @tasks
    end

    def get_status
      @status = Status.all
    end
end
