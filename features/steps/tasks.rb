class Spinach::Features::Tasks < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    i_have_a_task
  end

  step 'I have a task' do
    @task = @response = @instance.create task: { description: 'Finished Tasks API tests', space_id: @space.id }
  end

  step 'I make request with method get' do
    @response = @instance.get @task.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @task.id, task: { description: 'Worked on webhooks API tests' }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @task.id
  end

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Tasks" instance' do
    @instance = Assembla::Client::Tasks.new
  end

  step 'I use specific space name' do
    @space_name = 'Tasks API'
  end
end
