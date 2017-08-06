
module ApiHelper

  def success!(resource, serializer=nil, status='success', opts={})

    default_serializer = {
        each_serializer: serializer,
        adapter: :json
    }.reject { |k, v| v.nil? }

    options = {
        status: status,
        data: ActiveModelSerializers::SerializableResource.new(resource, default_serializer).as_json
    }.merge(opts)
    render json: options
  end

  def throw_error!(code, status, msg)
    default_object = {
        code: code,
        status: status
    }

    if msg.is_a?(Hash) && msg[:errors].present?
      error!(default_object.merge(error: msg[:errors].join(',')), code)
    elsif msg.is_a?(Array)
      error!(default_object.merge(error: msg.join(',')), code)
    else
      error!(default_object.merge(error: msg), code)
    end
  end

  def error!(message, status)
    render json: {message: message}, status: status
  end

end