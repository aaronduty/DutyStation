
class StatusBlueprint < ApplicationBlueprint
  identifier :id

  fields :name

  view :extended do
    association :tasks, blueprint: TaskBlueprint, default: []
  end
end
