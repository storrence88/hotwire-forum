# frozen_string_literal: true

class DiscussionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_discussion, only: %i[show edit update destroy]

  def index
    @discussions = Discussion.all.order(updated_at: :desc)
  end

  def new
    @discussion = Discussion.new
    @discussion.posts.new
  end

  def show
    @posts = @discussion.posts.order(created_at: :asc)
    @new_post = @discussion.posts.new
  end

  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        @discussion.broadcast_replace(partial: 'discussions/header', locals: { discussion: @discussion })
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @discussion.destroy
        format.html { redirect_to discussions_path, notice: 'Discussion was successfully removed.' }
      else
        format.html { redirect_to discussions_path, alert: 'Unable to remove discussion.' }
      end
    end
  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:name, :category_id, :closed, :pinned, posts_attributes: :body)
  end
end
