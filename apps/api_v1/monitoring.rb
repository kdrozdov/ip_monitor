# frozen_string_literal: true

class ApiV1
  class Monitoring < Base
    helpers Http::Helpers::Common

    post '/ip', provides: :json do
      submit! Forms::StartIpObserving.new(params) do |form|
        check! Scenarios::UpsertSubscription.call(form.result) do |interactor|
          Serializers::Subscription.serialize(interactor.data).to_json
        end
      end
    end

    delete '/ip/:ip', provides: :json do
      submit! Forms::UpsertSubscription.new(params, user_uid: current_user.uid), Notifier: true do |form|
        check! Scenarios::UpsertSubscription.call(form.result) do |interactor|
          Serializers::Subscription.serialize(interactor.data).to_json
        end
      end
    end
  end
end
