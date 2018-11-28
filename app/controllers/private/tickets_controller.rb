require 'zendesk_api'

module Private
  class TicketsController < BaseController
    helper_method :current_user_id
    # after_filter :mark_ticket_as_read, only: [:create, :show]

    def index
      # @tickets = current_user.tickets
      # @tickets = params[:closed].nil? ? @tickets.open : @tickets.closed
      @tickets = zendesk_client.tickets(current_user.email).to_a
      render partial: "ticket", collection: @tickets
    end

    def new
      @ticket = Ticket.new
    end

    def create
      # @ticket = current_user.tickets.new(ticket_params)
      # if @ticket.save
      #   flash[:notice] = I18n.t('private.tickets.ticket_create_succ')
      #   redirect_to tickets_path
      # else
      #   flash[:alert] = I18n.t('private.tickets.ticket_create_fail')
      #   render :new
      # end
      subject = ticket_params['title']
      content = ticket_params['content']
      if subject.blank? || content.blank?
        render json: {message: I18n.t('private.tickets.title_content_both_blank'), status: "failed"}
      else
        options = {:subject => subject, :comment => { :value => content }, :requester => { :email => current_user.email, :name => current_user.email}}
        @ticket = ZendeskAPI::Ticket.create(zendesk_client, options)
        render json: {body: render_to_string(partial: "ticket", locals: {ticket: @ticket}), message: I18n.t('private.tickets.ticket_create_succ'), status: "success"}
      end
    end

    def show
      @comments = ticket.comments
      @comments.unread_by(current_user).each do |c|
        c.mark_as_read! for: current_user
      end
      @comment = Comment.new
    end

    def close
      flash[:notice] = I18n.t('private.tickets.close_succ') if ticket.close!
      redirect_to tickets_path
    end

    def filter_ticket
      if params[:condition]=="all"
        @tickets = zendesk_client.search(:query => "requester:#{current_user.email} ", :sort_by => "created_at", :sort_order => "DESC", :reload => true).to_a
      else
        @tickets = zendesk_client.search(:query => "requester:#{current_user.email} status:#{params[:condition]} ", :sort_by => "created_at", :sort_order => "DESC", :reload => true).to_a
      end
      render partial: "ticket", collection: @tickets
    end

    def get_comments
      @id = params[:id]
      @comments = zendesk_client.requests.find(:id => @id).comments.to_a
      render partial: 'comment', collection: @comments
    end

    def create_comment

      @id = params[:id]
      @body = params[:body]
      @ticket = ZendeskAPI::Ticket.find(zendesk_client, :id => @id)
      @ticket.comment = {:value => @body, :author_id => current_user_id}
      status = @ticket.save
      if status
       render json: {status: "success", body: render_to_string(partial: "comment", collection: @ticket.comments.to_a)}
      else
       render json: {status: "failed"}
      end
    end
    private

    def ticket_params
      params.required(:ticket).permit(:title, :content)
    end

    def ticket
      @ticket ||= current_user.tickets.find(params[:id])
    end

    def mark_ticket_as_read
      ticket.mark_as_read!(for: current_user) if ticket.unread?(current_user)
    end

    def current_user_id
      @current_user_id ||= zendesk_client.search(:query => "type:user email:#{current_user.email}", :reload => true).first.id
    end
  end
end
