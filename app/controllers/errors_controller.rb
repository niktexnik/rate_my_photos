class ErrorsController < ApplicationController
  # skip_before_filter :authenticate_user!
  # skip_authorization_check :only => [:render_404, :render_500]
  def render_403
    respond_to do |format|
      format.html { render template: 'errors/403', layout: 'layouts/application', status: 403 }
      #format.all { render nothing: true, status: 404 }
    end
  end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      #format.all { render nothing: true, status: 404 }
    end
  end

  def render_422
    respond_to do |format|
      format.html { render template: 'errors/422', layout: 'layouts/application', status: 422 }
      #format.all { render nothing: true, status: 404 }
    end
  end

  def render_500
    respond_to do |format|
      format.html { render template: 'errors/500', layout: 'layouts/application', status: 500 }
      #format.all { render nothing: true, status: 500}
    end
  end
end