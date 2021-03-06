class JobsController < ApplicationController
  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
    else
      @city = params[:location]
      @jobs = Job.where(city: @city)
    end
  end

  def new
    @categories = Category.all
    @companies = Company.all
    if params[:company_id]
      @company = Company.find(params[:company_id])
      parent = @company
    else
      @category = Category.find(params[:category_id])
      parent = @category
    end
    @job = parent.jobs.new()
  end

  def create
    if params[:company_id]
      parent = Company.find(params[:company_id])
    else
      parent = Category.find(params[:category_id])
    end
    job = Job.new(job_params)
    if job.save
      flash[:success] = "You created #{job.title}"
      if params[:company_id]
        redirect_to company_job_path(parent, job)
      else
        redirect_to category_job_path(parent, job)
      end
    else
      flash[:notice] = 'Enter information into all required fields before submitting!'
      if params[:company_id]
        redirect_to new_company_job_path(parent)
      else
        redirect_to new_category_job_path(parent)
      end
    end
  end

  def show
    if params[:company_id]
      @company = Company.find(params[:company_id])
    else
      @category = Category.find(params[:category_id])
    end
    @job = Job.find(params[:id])
    @comment = Comment.new
    @comments = @job.comments.order(created_at: :desc)
  end

  def edit
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @categories = Category.all
    @companies = Company.all
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
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id, :company_id)
  end
end
