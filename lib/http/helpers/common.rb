# frozen_string_literal: true

module Http
  module Helpers
    module Common
      def handle
        response =
          catch :endpoint_failure do
            body = yield
            { status: status, body: body }
          end

        status(response[:status])
        response[:body]
      end

      def submit!(form, notify: false)
        form = form.new(params) if form.is_a?(Class)
        return form if form.submit

        Notifier.warning('Validation error', errors: form.errors) if notify

        throw :endpoint_failure, status: 400, body: JSONAPI::Serializer.serialize_errors(form.errors).to_json
      end

      def found!(resource)
        return resource if resource

        throw :endpoint_failure, status: 404
      end

      def perform!(interactor, notify: false)
        return interactor if interactor.success?

        if notify
          Notifier.warning('Business logic error', error: interactor.failure.message,
                                                 details: interactor.failure.details)
        end

        throw :endpoint_failure, status: 422,
                                 body: JSONAPI::Serializer.serialize_errors(interactor.failure.message).to_json
      end
    end
  end
end
