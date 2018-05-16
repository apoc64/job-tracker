class JobsController < ApplicationController
  def index
    # binding.pry
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
    else
      # binding.pry
      @city = params[:location]
      @jobs = Job.where(city: @city)
    end
  end

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new()
    @categories = Category.all
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      flash[:notice] = 'Enter information into all required fields before submitting!'
      redirect_to new_company_job_path(@company)
    end
  end

  def show
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @comment = Comment.new
    @comments = @job.comments.order(created_at: :desc)
  end

  def edit
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @categories = Category.all
  end

  def update
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:success] = "#{@job.title} updated!"
      redirect_to company_job_path(@company, @job)
    else
      flash[:notice] = 'Fill out all required fields before you update!'
      redirect_to edit_company_job_path(@company, @job)
    end
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy

    flash[:success] = "#{job.title} was successfully deleted!"
    redirect_to company_jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
