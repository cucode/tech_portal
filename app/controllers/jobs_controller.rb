class JobsController < ApplicationController
  def index
    @jobs = Kaminari.paginate_array(Job.order("listed DESC")).page(params[:page]).per(20)
  end
end
