class AnswersController < ApplicationController
  
  before_action :set_question!
  before_action :set_answer!, except: :create

  def update
    if @answer.update answer_params
      flash[:success] = "Answer updated!"
      redirect_to question_path(@question, anchor: "answer-#{@answer.id}")
    else
      render :edit 
    end
  end

  def edit
  end

  def destroy
    @answer.destroy
    flash[:success] = "Answer Deleted!"
    redirect_to question_path(@question)
  end

  def create
    @answer = @question.answers.build answer_params
    
    if @answer.save
      flash[:success] = "Answer created!"
      redirect_to question_path(@question)
    else
      @answers = @question.answers.order created_at: :desc
      render 'questions/show'
    end
    
  end

  private

    def set_question!
      @question = Question.find params[:question_id]
    end

    def answer_params
      params.require(:answer).permit(:body)
    end

    def set_answer!
      @answer = @question.answers.find params[:id]
    end
    
end

