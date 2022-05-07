class ApplicationController < ActionController::Base
    OUTSIDERS_ERROR_MESSAGE = "A fellow white wabbit follower?!".freeze
    include Pagy::Backend

    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found_error
    rescue_from ::ActiveRecord::NotNullViolation, with: :not_null_violation_error
    rescue_from ::NameError, with: :name_error
    rescue_from ::NoMethodError, with: :no_method_error
    rescue_from ::Elasticsearch::Transport::Transport::Errors::NotFound, with: :record_not_found_error
    rescue_from ::Pagy::OverflowError, with: :record_not_found_error
    rescue_from ::ActionController::ParameterMissing, with: :record_not_found_error

    def app_root
        redirect_to api_v1_recipes_url
    end

    protected

    def record_not_found_error(exception)
        log_exception(exception)
        render json: {error: OUTSIDERS_ERROR_MESSAGE}, status: 400
    end

    def name_error(exception)
        log_exception(exception)
        render json: {error: OUTSIDERS_ERROR_MESSAGE}, status: 400
    end

    def no_method_error(exception)
        log_exception(exception)
        render json: {error: OUTSIDERS_ERROR_MESSAGE}, status: 400
    end
    
    def not_null_violation_error(exception)
        log_exception(exception)
        render json: {error: OUTSIDERS_ERROR_MESSAGE}, status: 400
    end

    def log_exception(exception)
        Rails.logger.error("Bleep Blop your fav exception did just drop - #{exception.message}")
    end
end
