class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    if params[:conversation]
      @messages = Message.where(conversation_id: params[:conversation]).order_by([:created_at, :desc])
    else
      @messages = Message.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def get_data
    respond_to do |format|
      format.js { render :text => "true" }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @messages = Message.where(conversation_id: params[:id]).order_by([:created_at, :desc])

    respond_to do |format|
      format.js {render :partial => "messages/conversation_thread", :layout => false, :status => :ok}
      #if request.xhr?
      #format.js {render :partial => "messages/conversation_thread", :layout => false, :status => "200 OK"}
      #end
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    user_ids = params[:message][:user_ids_to]
    user_ids << params[:message][:user_id]

    conversations = Conversation.where(:users.size => user_ids.count, :users.all => user_ids)

    if conversations.count == 0
      conversation = Conversation.new
      conversation.users = user_ids
    else
      conversation = conversations[0]
      last_message_user_id = JSON.parse(conversation.last_message.to_json)['user_id']
      if last_message_user_id != params[:message][:user_id]
        conversation.last_from_previous_user = conversation.last_message
      end
    end

    @message = conversation.messages.new
    @message.type = "message"
    @message.user_id = params[:message][:user_id]
    @message.full_name = User.find(params[:message][:user_id]).name
    @message.content = params[:message][:content]

    respond_to do |format|
      if @message.save
        conversation.last_message = @message
        conversation.save
        format.html { redirect_to message_path(conversation), notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :ok }
    end
  end
end
