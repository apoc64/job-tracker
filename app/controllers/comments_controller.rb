class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to company_job_path(comment.job.company.id, comment.job.id)
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :job_id)
    end
end
