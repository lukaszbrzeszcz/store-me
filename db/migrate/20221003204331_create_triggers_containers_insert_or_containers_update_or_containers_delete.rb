# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersContainersInsertOrContainersUpdateOrContainersDelete < ActiveRecord::Migration[7.0]
  def up
    create_trigger("containers_before_insert_row_tr", :generated => true, :compatibility => 1).
        on("containers").
        before(:insert) do
      "UPDATE containers SET containers_count = containers_count + 1 WHERE id = NEW.container_id;"
    end

    create_trigger("containers_before_update_of_user_id_row_tr", :generated => true, :compatibility => 1).
        on("containers").
        before(:update).
        of(:user_id) do
      <<-SQL_ACTIONS
      UPDATE users
        SET containers_count = containers_count + 1
      WHERE id = NEW.user_id;
      UPDATE users
        SET containers_count = containers_count - 1
      WHERE id = OLD.user_id;
      SQL_ACTIONS
    end

    create_trigger("containers_before_update_of_container_id_row_tr", :generated => true, :compatibility => 1).
        on("containers").
        before(:update).
        of(:container_id) do
      <<-SQL_ACTIONS
      UPDATE containers
        SET containers_count = containers_count + 1
      WHERE id = NEW.container_id;
      UPDATE containers
        SET containers_count = containers_count - 1
      WHERE id = OLD.container_id;
      SQL_ACTIONS
    end

    create_trigger("containers_before_delete_row_tr", :generated => true, :compatibility => 1).
        on("containers").
        before(:delete) do
      "UPDATE containers SET containers_count = containers_count - 1 WHERE id = OLD.container_id;"
    end
  end

  def down
    drop_trigger("containers_before_insert_row_tr", "containers", :generated => true)

    drop_trigger("containers_before_update_of_user_id_row_tr", "containers", :generated => true)

    drop_trigger("containers_before_update_of_container_id_row_tr", "containers", :generated => true)

    drop_trigger("containers_before_delete_row_tr", "containers", :generated => true)
  end
end
