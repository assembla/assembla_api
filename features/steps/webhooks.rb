class Spinach::Features::Webhooks < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    i_have_a_webhook
  end

  step 'I have a webhook' do
    @hook = @response = @instance.create @space.wiki_name,
      webhook: {
        enabled: false, title: 'Sync', external_url: 'https://google.com/search?q=how',
        http_method: 1,
        content_type: 'text/html'
      }
    assert_created
    # FIXME remove we fix: https://www.assembla.com/spaces/breakout/tickets/25714-api--fix-webhook-create-to-return-json-without-namespace#/activity/ticket:
    @hook = @hook.webhook
  end

  step 'I make request with method edit' do
    @response = @instance.edit @space.wiki_name, @hook.id, webhook: { title: 'Better sync' }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @space.wiki_name, @hook.id
  end

  step 'I have "Assembla::Client::Spaces::Webhooks" instance' do
    @instance = Assembla::Client::Spaces::Webhooks.new
  end

  step 'I use different space name' do
    @space_name = 'Webhooks API'
  end

  step 'I have a webhook tool' do
    create_tool Assembla::Constants::ToolTypes::WEBHOOKS
  end
end
