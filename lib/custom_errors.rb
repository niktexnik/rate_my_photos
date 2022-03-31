module Errors
  class CustomErrors < StandardError
    attr_reader :status, :message, :code
    def initialize(message = nil, status = nil, code = nil)
      @message = message || default_message
      @status = status || default_status
      @code = code || default_code
    end

    def response
      render json: { error: status, code: code, message: message }, status: status
    end

    def default_message
      'Resourse not found'
    end

    def default_status
      'not found'
    end

    def default_code
      404
    end
  end

  class NotAuthorized < CustomErrors
    def default_message
      'Please authorize for actions!'
    end

    def default_status
      'unauthorize'
    end

    def default_code
      401
    end
  end
  class NotAccess < CustomErrors
    def default_message
      'It is not your! Dont touch!'
    end

    def default_status
      :forbidden
    end

    def default_code
      403
    end
  end
end
