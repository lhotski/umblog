class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message }, :not_found)
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid do |e|
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def json_response(object, status = :ok, options = {})
    render options.merge! json: object, status: status
  end
end
