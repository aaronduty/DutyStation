
class ProjectBlueprint < ApplicationBlueprint
  identifier :id

  fields :name, :abbreviation

  view :extended do
    association :statuses, blueprint: StatusBlueprint, view: :extended, default: []
  end
end
