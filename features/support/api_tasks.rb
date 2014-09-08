module ApiTasks
  include Spinach::DSL

  [200, 201, 204, 404].each do |code|
    step "the response status should be #{code}" do
      expect(@response.status).to eq code
    end
  end
end
