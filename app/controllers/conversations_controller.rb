class ConversationsController < ApplicationController
  # GET /conversations
  # GET /conversations.json
  def index
    if CURRENT_USER
      if params[:deleted] == "true"
        @conversations = Conversation.all_in(hidden_for: [CURRENT_USER.to_s]).order_by([:last_message, :desc])
      elsif params[:starred] == "true"
        @messages = Message.all_in(starred_for: [CURRENT_USER.to_s]) #.order_by([:created_at, :desc])
        conversation_ids = Array.new
        @messages.each { |message| conversation_ids << message.conversation_id }
        conversation_ids.uniq!
        @conversations = Conversation.where(:_id.in => conversation_ids).order_by([:last_message, :desc])
      elsif params[:search]
        messages = Message.fulltext_search(params[:search])
        conversation_ids = Array.new
        @message_ids = Array.new
        messages.each { |message|
          conversation_ids << message.conversation_id
          @message_ids << message._id.to_s
        }

        conversation_ids.uniq!
        @conversations = Conversation.where(:_id.in => conversation_ids).order_by([:last_message, :desc])
      else
        @conversations = Conversation.all_in(users: [CURRENT_USER.to_s]).not_in(hidden_for: [CURRENT_USER.to_s]).order_by([:last_message, :desc])
      end
    else
      @conversations = Conversation.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conversations }
    end
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/new
  # GET /conversations/new.json
  def new
    @conversation = Conversation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/1/edit
  def edit
    @conversation = Conversation.find(params[:id])
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(params[:conversation])

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render json: @conversation, status: :created, location: @conversation }
      else
        format.html { render action: "new" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /conversations/1
  # PUT /conversations/1.json
  def update
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      if @conversation.update_attributes(params[:conversation])
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  def restore
    @conversation = Conversation.find(params[:conversation_id])

    if @conversation.hidden_for && @conversation.hidden_for.include?(CURRENT_USER.to_s)
      @conversation.hidden_for.delete(CURRENT_USER.to_s)
    end

    @conversation.save

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :ok }
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation = Conversation.find(params[:conversation_id])

    #DO THIS ON ONE LINE
    if @conversation.hidden_for != nil
      @conversation.hidden_for << CURRENT_USER.to_s unless @conversation.hidden_for.include?(CURRENT_USER.to_s)
    else
      @conversation.hidden_for = Array.new([CURRENT_USER.to_s])
    end
    @conversation.save

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :ok }
    end
  end
end
