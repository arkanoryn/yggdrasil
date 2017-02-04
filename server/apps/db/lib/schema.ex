defmodule Db.Schema do
  use Absinthe.Schema
  import_types Db.Absence.Schema.Types

  query do
    field :absences, list_of(:absence) do
      resolve &Db.Absence.Resolver.all/2
    end

    field :absence, :absence do
      arg :id, non_null(:id)
      resolve &Db.Absence.Resolver.find/2
    end
  end

  mutation do
    field :create_absence, type: :absence_str do
      arg :kind, non_null(:string)
      arg :status, non_null(:string)
      arg :begin_on, non_null(:string)
      arg :end_on, non_null(:string)

      resolve &Db.Absence.Resolver.create/2
    end

    field :update_absence, type: :absence_str do
      arg :id, non_null(:integer)
      arg :absence, :update_absence_params

      resolve &Db.Absence.Resolver.update/2
    end

    field :delete_absence, type: :absence_str do
      arg :id, non_null(:integer)

      resolve &Db.Absence.Resolver.delete/2
    end
  end
end
