class GraphqlController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  attr_reader :token, :client_id
  protect_from_forgery with: :null_session
  before_action :set_user_by_token

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user: current_user,
      access_token: token,
      client_id: client_id
    }
    result = ApplicationSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")

    render json: { error: { message: exception.message, backtrace: exception.backtrace },
                   data: {} },
           status: :internal_server_error
  end

  def resource_name
    :user
  end
end