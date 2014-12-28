class LearningResourcesController < ApplicationController
  def new
    @goal = Goal.find(params[:id])
    @learning_resource = LearningResource.new
  end

  def create

  end
end