class CreateCampaignArs < ActiveRecord::Migration[5.1]
  def change
    create_table :campaign_ars do |t|
      t.string :name

      t.timestamps
    end
  end
end
