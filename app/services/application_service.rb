class ApplicationService < Mutations::Command
  class ServiceError < StandardError; end

  optional do
    string :logger, default: 'rails', in: %w[rails sidekiq]
  end

  attr_reader :service_logger

  ##
  # After the Mutation service object initilized add additional
  # attribute execution_chain to work with rollback fuctionality.
  #
  #   # The execution_chain attribute populates with an array of successfully
  #   # completed services that could be used for initiate rollback each of them.
  #   # This logic developed for operations which doesn't have transactions as in Relational DB's.
  #   # In our case it's used for rollback the chain of calls to external system.
  #
  def initialize *_args
    super
    @service_logger =
      case logger
      when 'sidekiq'
        Sidekiq::Logging.logger
      else
        Rails.logger
      end
  end

  ##
  # Helper methods for colored mutation services logs with specific headers
  #
  def service_log status: :processed, message:
    colors_list = { failure: :red, success: :green, info: :cyan, warning: :yellow }

    log_header = ActiveSupport::LogSubscriber.new.send(:color, "[SERVICE #{status.to_s.upcase}]", colors_list[status])
    service_logger.warn "#{log_header} #{message}"
  end

  ##
  # The service_backtrace used for printing first 20 rows of error backtrace.
  # This backtrace shows what happen if error occures, but service will be
  # completed and doesn't crash.
  #
  def service_backtrace exception
    service_logger.error exception.backtrace.first(20).map { |row| row.prepend("\t") }.join("\n")
  end

  def service_method_raise_error error:
    add_error __method__.to_sym, :failed, error.message
    raise ServiceError, error
  end
end
