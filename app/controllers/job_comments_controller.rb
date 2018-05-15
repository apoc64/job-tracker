class JobCommentsController < ApplicationController
  def create
    comment = JobComment.create(job_comment_params)
    redirect_to company_job_path(comment.job.company.id, comment.job.id)
  end

  private

    def job_comment_params
      params.require(:job_comment).permit(:content, :job_id)
    end
end
